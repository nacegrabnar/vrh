-- Add manual difficulty override column to summits table
-- When NULL, the frontend auto-calculates from elevation:
--   >= 2500m → very_hard, >= 1800m → demanding, >= 1200m → moderate, < 1200m → easy
-- Crags are never shown a difficulty badge regardless of this value.

ALTER TABLE summits ADD COLUMN IF NOT EXISTS difficulty VARCHAR(50);

-- Valid values: 'easy', 'moderate', 'demanding', 'very_hard'
-- Example manual override:
-- UPDATE summits SET difficulty = 'very_hard' WHERE name = 'Triglav';
