const express = require('express');
const router  = express.Router();
const xml2js  = require('xml2js');

const ARSO_BASE = 'https://meteo.arso.gov.si/uploads/probase/www/observ/surface/text/sl';

const STATION_LABELS = {
  'KREDA-ICA': 'Kredarica',
  'VOGEL':     'Vogel',
  'RATECE':    'Rateče',
  'LISCA':     'Lisca',
};

// Return first non-null value found under any of the given keys
function pick(obj, ...keys) {
  for (const k of keys) {
    const v = obj?.[k];
    if (v !== undefined && v !== null && v !== '') return v;
  }
  return null;
}

// ARSO XML structure: <data id="..."><metData>flat fields…</metData></data>
function extractArsoMetData(parsed) {
  // xml2js maps the <data> root element to parsed.data
  const xmlRoot = parsed?.data ?? parsed?.ROOT ?? parsed?.root;
  return xmlRoot?.metData ?? xmlRoot?.metdata ?? null;
}

function parseArsoXml(parsed) {
  const m = extractArsoMetData(parsed);
  if (!m) return null;

  const rawTemp = pick(m, 't', 'ta');
  if (rawTemp === null) return null;

  // ARSO provides ff_val_kmh already converted; fall back to ff_val (m/s) * 3.6
  const windKmh = m.ff_val_kmh != null
    ? parseInt(m.ff_val_kmh, 10)
    : m.ff_val != null
      ? Math.round(parseFloat(m.ff_val) * 3.6)
      : null;

  // Prefer the longer weather description when available
  const rawDesc = pick(m, 'wwsyn_longText', 'nn_shortText', 'wwsyn_shortText');
  const rawTime = pick(m, 'tsValid_issued', 'valid', 'tsUpdated');

  return {
    temperature:    parseFloat(rawTemp),
    wind_speed:     windKmh,
    wind_direction: pick(m, 'dd_shortText', 'dd_icon', 'dd_val') ?? null,
    description:    rawDesc ? String(rawDesc) : null,
    humidity:       m.rh   != null ? Math.round(parseFloat(m.rh))  : null,
    pressure:       m.p    != null ? Math.round(parseFloat(m.p))   : null,
    updated_at:     rawTime ? String(rawTime) : null,
    source:         'arso',
  };
}

// GET /weather/arso/:station
router.get('/arso/:station', async (req, res) => {
  const stationParam = req.params.station;
  const stationKey   = stationParam.toUpperCase();
  const label        = STATION_LABELS[stationKey] ?? stationParam;
  const url          = `${ARSO_BASE}/observation_${stationParam}_latest.xml`;

  try {
    const response = await fetch(url, { signal: AbortSignal.timeout(8000) });
    if (!response.ok) {
      return res.status(502).json({
        error: `ARSO returned HTTP ${response.status}`,
        station: stationParam,
      });
    }

    const xml    = await response.text();
    const parsed = await xml2js.parseStringPromise(xml, {
      explicitArray: false,
      mergeAttrs:    true,
      trim:          true,
    });

    const data = parseArsoXml(parsed);
    if (!data) {
      return res.status(502).json({
        error:   'Could not parse ARSO response — unexpected XML structure',
        station: stationParam,
        preview: xml.slice(0, 600),
      });
    }

    return res.json({ ...data, source_label: `ARSO — ${label}` });
  } catch (err) {
    return res.status(502).json({ error: err.message, station: stationParam });
  }
});

// GET /weather/fallback?lat=&lon=
router.get('/fallback', async (req, res) => {
  const { lat, lon } = req.query;
  if (!lat || !lon) {
    return res.status(400).json({ error: 'lat and lon query parameters are required' });
  }

  const url =
    `https://api.open-meteo.com/v1/forecast` +
    `?latitude=${lat}&longitude=${lon}` +
    `&current=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m,winddirection_10m` +
    `&wind_speed_unit=kmh&timezone=auto`;

  try {
    const response = await fetch(url, { signal: AbortSignal.timeout(8000) });
    if (!response.ok) {
      return res.status(502).json({ error: `Open-Meteo returned HTTP ${response.status}` });
    }

    const json    = await response.json();
    const current = json.current ?? json.current_weather;

    if (!current) {
      return res.status(502).json({ error: 'Unexpected Open-Meteo response structure' });
    }

    return res.json({
      temperature:    current.temperature_2m    ?? current.temperature    ?? null,
      wind_speed:     current.windspeed_10m     !== undefined
                        ? Math.round(current.windspeed_10m)
                        : current.windspeed !== undefined
                          ? Math.round(current.windspeed)
                          : null,
      wind_direction: current.winddirection_10m != null
                        ? `${current.winddirection_10m}°`
                        : null,
      description:    null,
      weathercode:    current.weathercode ?? null,
      humidity:       current.relativehumidity_2m ?? null,
      pressure:       null,
      updated_at:     current.time ?? null,
      source:         'openmeteo',
      source_label:   'Open-Meteo',
    });
  } catch (err) {
    return res.status(502).json({ error: err.message });
  }
});

module.exports = router;
