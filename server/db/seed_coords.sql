-- Add real-world coordinates to seed summits.
-- Run once after seed.sql has been applied.
-- Uses ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)

UPDATE summits SET location = ST_SetSRID(ST_MakePoint(13.8378, 46.3794), 4326) WHERE name = 'Triglav';
UPDATE summits SET location = ST_SetSRID(ST_MakePoint(13.6628, 46.4383), 4326) WHERE name = 'Mangart';
UPDATE summits SET location = ST_SetSRID(ST_MakePoint(13.6983, 46.4189), 4326) WHERE name = 'Jalovec';
UPDATE summits SET location = ST_SetSRID(ST_MakePoint(14.1528, 46.4667), 4326) WHERE name = 'Stol';
UPDATE summits SET location = ST_SetSRID(ST_MakePoint(14.5303, 46.3717), 4326) WHERE name = 'Grintovec';
UPDATE summits SET location = ST_SetSRID(ST_MakePoint(13.8667, 45.5750), 4326) WHERE name = 'Osp';
UPDATE summits SET location = ST_SetSRID(ST_MakePoint(13.8583, 45.5722), 4326) WHERE name = 'Misja Pec';
