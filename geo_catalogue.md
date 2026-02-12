# Geo Data Catalogue: Queenstown Liveability Study

This catalogue documents all geospatial datasets prepared for the Queenstown study area. All files are GeoJSON format (WGS84 / EPSG:4326) and can be opened directly in QGIS, kepler.gl, or any GIS tool.

---

## Quick Reference

| File | Features | Size | Description |
|------|----------|------|-------------|
| `queenstown-boundary.geojson` | 1 | 37 KB | Planning area outline |
| `queenstown-subzones.geojson` | 15 | 106 KB | Subzone boundaries |
| `queenstown-buildings.geojson` | 8,671 | 7.2 MB | All buildings (combined) |
| `queenstown-buildings-osm-only.geojson` | 8,363 | 6.8 MB | Non-HDB buildings |
| `queenstown-buildings-hdb-enriched.geojson` | 308 | 418 KB | HDB blocks with enriched data |
| `queenstown-ura-height-control.geojson` | 7 | 11 KB | URA planning height zones |

All files are in `docs/geo/`. Raw source data is in `data/` (gitignored).

---

## 1. Queenstown Boundary

**File:** `queenstown-boundary.geojson`
**Source:** URA Master Plan 2019 (via data.gov.sg)
**Features:** 1 polygon

The official Queenstown planning area boundary as defined by URA. Use this to clip other island-wide datasets to the study area.

| Property | Description | Example |
|----------|-------------|---------|
| `PLN_AREA_N` | Planning area name | `QUEENSTOWN` |
| `PLN_AREA_C` | Planning area code | `QT` |
| `REGION_N` | Region | `CENTRAL REGION` |
| `SHAPE.AREA` | Area in sq metres | `21683971.24` |

---

## 2. Queenstown Subzones

**File:** `queenstown-subzones.geojson`
**Source:** URA Master Plan 2019 (via data.gov.sg)
**Features:** 15 polygons

The 15 subzones within Queenstown:

| Subzone | Code |
|---------|------|
| Commonwealth | CWSZ |
| Dover | DVSZ |
| Ghim Moh | GMSZ |
| Holland Drive | HDSZ |
| Kent Ridge | KRSZ |
| Margaret Drive | MDSZ |
| Mei Chin | MCSZ |
| National University of S'pore | NUSZ |
| One North | ONSZ |
| Pasir Panjang 1 | PP1Z |
| Pasir Panjang 2 | PP2Z |
| Port | PTSZ |
| Queensway | QWSZ |
| Singapore Polytechnic | SPSZ |
| Tanglin Halt | THSZ |

| Property | Description | Example |
|----------|-------------|---------|
| `SUBZONE_N` | Subzone name | `COMMONWEALTH` |
| `SUBZONE_C` | Subzone code | `CWSZ` |
| `PLN_AREA_N` | Parent planning area | `QUEENSTOWN` |
| `SHAPE.AREA` | Area in sq metres | `1234567.89` |

---

## 3. Building Footprints

### 3a. All Buildings (Combined)

**File:** `queenstown-buildings.geojson`
**Source:** OpenStreetMap (Overpass API) + HDB Property CSV (data.gov.sg)
**Features:** 8,671 polygons
**Coordinate system:** WGS84

Every building footprint within the Queenstown bounding box, with pre-calculated height and data source labels. This is the primary file for 3D visualisation.

#### Properties

| Property | Type | Description | Example |
|----------|------|-------------|---------|
| `osm_id` | int | OpenStreetMap way ID | `12345678` |
| `building` | string | Building type | `residential`, `office`, `house` |
| `name` | string | Building name (1,001 named) | `mTower` |
| `height` | string | OSM height tag (metres) | `183` |
| `building_levels` | string | Storey count | `47` |
| `height_m` | float | **Pre-calculated height in metres** — ready for 3D extrusion | `141.0` |
| `height_source` | string | How height was derived | See below |
| `data_source` | string | `osm` or `osm+hdb` — for filtering by origin | `osm+hdb` |
| `addr_housenumber` | string | Block/house number | `86` |
| `addr_street` | string | Street name | `Dawson Road` |
| `addr_postcode` | string | Postal code | `142086` |
| `hdb_match` | bool | Whether matched to HDB data | `true` |
| `hdb_max_floor_lvl` | string | HDB max floor level | `47` |
| `hdb_year_completed` | string | Year HDB block was completed | `2015` |
| `hdb_total_dwelling_units` | string | Total dwelling units in block | `758` |
| `hdb_residential` | string | Has residential use | `Y` |
| `hdb_commercial` | string | Has commercial use | `Y` |
| `hdb_market_hawker` | string | Has market/hawker centre | `N` |

#### Height Source Values

| `height_source` | Count | % | Method |
|-----------------|-------|---|--------|
| `measured` | 232 | 2.7% | OSM `height` tag — most reliable |
| `levels` | 2,284 | 26.3% | OSM `building:levels` × 3m per storey |
| `hdb_levels` | 258 | 3.0% | HDB `max_floor_lvl` × 3m per storey |
| `estimated` | 5,897 | 68.0% | Default by building type (see below) |

#### Estimated Height Defaults (where no data available)

| Building Type | Default Height |
|---------------|---------------|
| `house`, `detached`, `terrace`, `semidetached_house` | 9m |
| `bungalow` | 6m |
| `residential` | 12m |
| `apartments` | 36m |
| `commercial`, `school` | 15m |
| `office`, `hospital` | 18m |
| `hotel` | 30m |
| `university` | 15m |
| `industrial`, `retail` | 12m |
| `garage` | 4m |
| `roof`, `shelter`, `shed`, `hut` | 3–4m |
| Other / unknown | 10m |

#### Building Type Breakdown

| Type | Count |
|------|-------|
| `yes` (unspecified) | 5,417 |
| `residential` | 996 |
| `house` | 655 |
| `apartments` | 306 |
| `roof` | 232 |
| `terrace` | 209 |
| `detached` | 164 |
| `commercial` | 121 |
| `retail` | 76 |
| `garage` | 60 |
| `office` | 48 |
| `school` | 40 |
| Others | 347 |

#### Notable Buildings (Tallest)

| Building | Height | Storeys | Source |
|----------|--------|---------|--------|
| mTower | 183m | — | measured |
| Blk 86 Dawson Road (SkyVille @ Dawson) | 141m | 47 | hdb_levels |
| Blk 30–37 Margaret Drive | 141m | 47 | hdb_levels |
| Blk 74A Commonwealth Drive | 141m | 47 | levels |
| Blk 208A Berlayar Street | 138m | 46 | levels |

#### Height Statistics

| Stat | Value |
|------|-------|
| Min | 3m |
| Max | 183m |
| Mean | 14.2m |
| Median | 10.0m |

### 3b. HDB-Enriched Buildings

**File:** `queenstown-buildings-hdb-enriched.geojson`
**Source:** OSM footprints + HDB Property CSV cross-reference
**Features:** 308 polygons

A subset of the combined file containing only buildings matched to HDB property records. Matched by block number + street name (with normalisation for abbreviations like `C'WEALTH` → `COMMONWEALTH`). Covers **308 out of 341** Queenstown HDB blocks (90%).

36 HDB blocks remain unmatched — they exist in OSM but lack address tags (mostly in Tanglin Halt, Mei Ling St, Dawson Rd areas).

Includes all properties from the combined file, with HDB-specific fields populated.

### 3c. OSM-Only Buildings

**File:** `queenstown-buildings-osm-only.geojson`
**Source:** OpenStreetMap only
**Features:** 8,363 polygons

All non-HDB-matched buildings — commercial, landed housing, institutional, industrial, etc. HDB fields are empty strings.

---

## 4. URA Height Control Zones

**File:** `queenstown-ura-height-control.geojson`
**Source:** URA Master Plan 2019 (via data.gov.sg), clipped to Queenstown
**Features:** 7 polygons

**Important:** These represent *planning control zones* (maximum permitted heights), **not actual building heights**. Most of Queenstown falls under "subject to detailed control" (case-by-case) and is not represented here. Only 7 low-rise control zones exist within Queenstown, all capped at 4–5 storeys — likely covering landed housing / conservation areas (e.g. Holland/Chip Bee Gardens).

| Property | Description | Example |
|----------|-------------|---------|
| `HT_CTL_TXT` | Height limit value | `4`, `5` |
| `HT_CTL_TYP` | Type of control | `NUMBER OF STOREYS` |
| `SHAPE.AREA` | Zone area in sq metres | `30883.71` |

For actual building heights, use the `height_m` field in the buildings files.

---

## Data Processing Notes

### Sources and Methods

1. **Building footprints** were downloaded from OpenStreetMap via the Overpass API using the Queenstown bounding box (S=1.2550, W=103.7502, N=1.3187, E=103.8166)
2. **HDB enrichment** was done by matching OSM `addr:housenumber` + `addr:street` to HDB property CSV `blk_no` + `street`. Street name normalisation handles abbreviations (e.g. `C'WEALTH` → `COMMONWEALTH`, `RD` → `ROAD`, `ST` → `STREET`, etc.)
3. **Height calculation** uses a priority chain: OSM `height` tag → OSM `building:levels` × 3m → HDB `max_floor_lvl` × 3m → type-based default estimate
4. **URA height control** was spatially clipped using centroid-in-polygon against the Queenstown boundary
5. **Boundary and subzone** files were extracted by filtering `PLN_AREA_N = 'QUEENSTOWN'` from island-wide URA datasets

### Coordinate System

All files use **WGS84 (EPSG:4326)** — standard lat/lon. The original URA data uses SVY21 (EPSG:3414) but was converted to WGS84 by data.gov.sg.

### Limitations

- **Height coverage:** 68% of buildings have estimated (default) heights — only 32% have measured or level-based heights
- **OSM completeness:** Building footprints may be incomplete; some structures may be missing or have outdated geometries
- **HDB matching:** 36 of 341 HDB blocks (10%) are unmatched due to missing address tags in OSM
- **Bounding box vs boundary:** Buildings were downloaded using a rectangular bounding box, so some buildings just outside the Queenstown boundary may be included
- **Height estimates:** The 3m-per-storey assumption is approximate; actual floor-to-floor heights vary (HDB is typically ~2.8m, commercial ~3.5–4m)

### Recommended Visualisation Tools

| Tool | Use Case |
|------|----------|
| **kepler.gl** | Drag-and-drop 3D extrusion — set Height to `height_m`. Best for quick exploration and report figures |
| **QGIS** | Full GIS analysis — use 3D Map View with extrusion expression. Best for spatial joins and overlay analysis |
| **QGIS 3D View** | Set altitude clamping + extrusion by `height_m` for 3D rendering |
| **Mapbox GL / MapLibre** | Web-based `fill-extrusion` layer for interactive maps |
| **pydeck** (Python) | Jupyter notebook 3D viz via deck.gl |

### Relationship to Other Downloaded Data

The building footprints can be spatially joined with other datasets in `data/`:

| Dataset | Join Method | Purpose |
|---------|-------------|---------|
| `data/ura/land-use-mp2019.geojson` | Spatial intersection | Land use zoning per building |
| `data/data-gov-sg/hawker-centres.geojson` | Proximity / buffer | Nearest hawker centre analysis |
| `data/data-gov-sg/parks.geojson` | Proximity / buffer | Green space accessibility |
| `data/data-gov-sg/mrt-station-exits.geojson` | Proximity / buffer | Transit accessibility |
| `data/lta/BusStopLocation_Aug2025/` | Proximity / buffer | Bus stop coverage |
| `data/lta/CyclingPath_Aug2025/` | Proximity / buffer | Active mobility network |
| `data/data-gov-sg/resale-flat-prices.csv` | Block + street match | Property values per building |
