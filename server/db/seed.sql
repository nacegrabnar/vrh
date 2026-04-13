INSERT INTO areas (name, slug, region, description) VALUES
('Julijske Alpe', 'julijske-alpe', 'Gorenjska', 'Highest mountain range in Slovenia, home of Triglav.'),
('Karavanke', 'karavanke', 'Gorenjska', 'Long mountain range on the border with Austria.'),
('Kamnisko-Savinjske Alpe', 'kamnisko-savinjske-alpe', 'Savinjska', 'Central Slovenian mountain range with dramatic walls.');

INSERT INTO summits (area_id, name, name_sl, elevation_m, description, type)
VALUES
(
  (SELECT id FROM areas WHERE slug = 'julijske-alpe'),
  'Triglav', 'Triglav', 2864,
  'Highest peak in Slovenia and national symbol.',
  'peak'
),
(
  (SELECT id FROM areas WHERE slug = 'julijske-alpe'),
  'Mangart', 'Mangart', 2679,
  'Second highest peak in Slovenia with views into Italy and Austria.',
  'peak'
),
(
  (SELECT id FROM areas WHERE slug = 'julijske-alpe'),
  'Jalovec', 'Jalovec', 2645,
  'One of the most beautiful peaks in the Julian Alps.',
  'peak'
),
(
  (SELECT id FROM areas WHERE slug = 'karavanke'),
  'Stol', 'Stol', 2236,
  'Highest peak of the Karavanke on the Slovenian side.',
  'peak'
),
(
  (SELECT id FROM areas WHERE slug = 'kamnisko-savinjske-alpe'),
  'Grintovec', 'Grintovec', 2558,
  'Highest peak of the Kamnik-Savinja Alps.',
  'peak'
),
(
  (SELECT id FROM areas WHERE slug = 'julijske-alpe'),
  'Osp', 'Osp', 100,
  'World famous sport climbing crag above the village of Osp.',
  'crag'
),
(
  (SELECT id FROM areas WHERE slug = 'julijske-alpe'),
  'Misja Pec', 'Misja Pec', 120,
  'One of the hardest climbing crags in Europe with many 9th grade routes.',
  'crag'
);