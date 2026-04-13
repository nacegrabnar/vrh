CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  username VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  avatar_url VARCHAR(500),
  bio TEXT,
  is_pro BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE areas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  region VARCHAR(255),
  description TEXT,
  location GEOGRAPHY(POINT, 4326),
  elevation_min FLOAT,
  elevation_max FLOAT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE summits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  area_id UUID REFERENCES areas(id) ON DELETE SET NULL,
  name VARCHAR(255) NOT NULL,
  name_sl VARCHAR(255),
  elevation_m FLOAT NOT NULL,
  location GEOGRAPHY(POINT, 4326),
  description TEXT,
  type VARCHAR(50) DEFAULT 'peak',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE trails (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  summit_id UUID REFERENCES summits(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  difficulty VARCHAR(50),
  distance_km FLOAT,
  elevation_gain_m FLOAT,
  activity_type VARCHAR(50) DEFAULT 'hiking',
  path GEOGRAPHY(LINESTRING, 4326),
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE climbing_routes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  summit_id UUID REFERENCES summits(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  grade_french VARCHAR(10),
  grade_uiaa VARCHAR(10),
  grade_alpine VARCHAR(10),
  type VARCHAR(50) DEFAULT 'sport',
  length_m INTEGER,
  num_bolts INTEGER,
  rock_type VARCHAR(100),
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE conditions_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  trail_id UUID REFERENCES trails(id) ON DELETE CASCADE,
  climbing_route_id UUID REFERENCES climbing_routes(id) ON DELETE CASCADE,
  status VARCHAR(50) NOT NULL,
  notes TEXT,
  reported_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  trail_id UUID REFERENCES trails(id) ON DELETE CASCADE,
  climbing_route_id UUID REFERENCES climbing_routes(id) ON DELETE CASCADE,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  body TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  summit_id UUID REFERENCES summits(id) ON DELETE CASCADE,
  trail_id UUID REFERENCES trails(id) ON DELETE CASCADE,
  climbing_route_id UUID REFERENCES climbing_routes(id) ON DELETE CASCADE,
  url VARCHAR(500) NOT NULL,
  caption TEXT,
  location GEOGRAPHY(POINT, 4326),
  taken_at TIMESTAMP DEFAULT NOW()
);