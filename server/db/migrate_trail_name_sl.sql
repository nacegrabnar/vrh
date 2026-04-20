-- Add Slovenian name column to trails table
-- Allows bilingual trail names matching the pattern used in summits.

ALTER TABLE trails ADD COLUMN IF NOT EXISTS name_sl VARCHAR(255);
