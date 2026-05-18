-- таблица buildings
create table public.buildings (
    ogc_fid serial primary key,
    geom public.geometry(geometry, 4326) not null,
    "timestamp" timestamptz null,
    "version" varchar null,
    changeset varchar null,
    "user" varchar null,
    uid varchar null,
    "addr:city" varchar null,
    "addr:housenumber" varchar null,
    "addr:municipality" varchar null,
    "addr:place" varchar null,
    "addr:street" varchar null,
    building varchar null,
    "building:levels" varchar null,
    highway varchar null,
    incline varchar null,
    lanes varchar null,
    "name" varchar null,
    sidewalk varchar null,
    smoothness varchar null,
    surface varchar null,
    id varchar null
);

create index if not exists idx_buildings_geom
  on buildings
  using gist (geom);
