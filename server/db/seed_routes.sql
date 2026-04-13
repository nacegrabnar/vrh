INSERT INTO climbing_routes (summit_id, name, grade_french, grade_uiaa, type, length_m, num_bolts, description)
VALUES
(
  (SELECT id FROM summits WHERE name = 'Osp'),
  'Obsesija', '8a', 'IX+', 'sport', 30, 12,
  'One of the classic hard routes at Osp, powerful moves on perfect limestone.'
),
(
  (SELECT id FROM summits WHERE name = 'Osp'),
  'Picnik', '6c', 'VII+', 'sport', 25, 10,
  'A popular moderate route, great for intermediate climbers.'
),
(
  (SELECT id FROM summits WHERE name = 'Osp'),
  'Strelovod', '7b', 'VIII+', 'sport', 28, 11,
  'Technical face climbing on small holds, a Osp classic.'
),
(
  (SELECT id FROM summits WHERE name = 'Osp'),
  'Valter', '7a', 'VIII', 'sport', 22, 9,
  'Sustained climbing with a crux near the top.'
),
(
  (SELECT id FROM summits WHERE name = 'Misja Pec'),
  'Bala', '9a', 'XI', 'sport', 35, 14,
  'One of the hardest routes in Slovenia, requiring exceptional strength.'
),
(
  (SELECT id FROM summits WHERE name = 'Misja Pec'),
  'Sanjski par', '8b+', 'X+', 'sport', 32, 13,
  'Dream route with continuous technical climbing on steep limestone.'
),
(
  (SELECT id FROM summits WHERE name = 'Misja Pec'),
  'Charge', '8a+', 'X', 'sport', 30, 12,
  'Powerful moves on an overhanging wall, a must-do for strong climbers.'
),
(
  (SELECT id FROM summits WHERE name = 'Misja Pec'),
  'Mala Misja', '7c', 'IX', 'sport', 26, 10,
  'Excellent climbing for advanced sport climbers, technical and sustained.'
);