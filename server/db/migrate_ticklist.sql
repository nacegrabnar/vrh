CREATE TABLE IF NOT EXISTS ticklist (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  summit_id UUID REFERENCES summits(id) ON DELETE CASCADE,
  trail_id UUID REFERENCES trails(id) ON DELETE CASCADE,
  climbing_route_id UUID REFERENCES climbing_routes(id) ON DELETE CASCADE,
  ascent_date DATE,
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  CONSTRAINT ticklist_one_target CHECK (
    (summit_id IS NOT NULL)::int +
    (trail_id IS NOT NULL)::int +
    (climbing_route_id IS NOT NULL)::int = 1
  )
);

CREATE UNIQUE INDEX IF NOT EXISTS ticklist_user_summit_uniq
  ON ticklist(user_id, summit_id) WHERE summit_id IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS ticklist_user_trail_uniq
  ON ticklist(user_id, trail_id) WHERE trail_id IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS ticklist_user_route_uniq
  ON ticklist(user_id, climbing_route_id) WHERE climbing_route_id IS NOT NULL;
