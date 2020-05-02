#define Z_LEVEL_FIRST_JANUS						1
#define Z_LEVEL_SECOND_JANUS					2
#define Z_LEVEL_THIRD_JANUS						3
#define Z_LEVEL_FOURTH_JANUS					4
#define Z_LEVEL_FIFTH_JANUS						5
#define Z_LEVEL_SIXTH_JANUS						6
#define Z_LEVEL_SEVENTH_JANUS					7
#define Z_LEVEL_EIGHTH_JANUS					8

/datum/map/janus
	name = "Janus"
	full_name = "NSC Janus"
	path = "janus"
	flags = MAP_HAS_BRANCH | MAP_HAS_RANK

	holomap_smoosh = list(list(
		Z_LEVEL_FIRST_JANUS,
		Z_LEVEL_SECOND_JANUS,
		Z_LEVEL_THIRD_JANUS,
		Z_LEVEL_FOURTH_JANUS,
		Z_LEVEL_FIFTH_JANUS,
		Z_LEVEL_SIXTH_JANUS,
		Z_LEVEL_SEVENTH_JANUS,
		Z_LEVEL_EIGHTH_JANUS))

	admin_levels = list(8,9)
	empty_levels = list(10)
	accessible_z_levels = list("1"=1,"2"=1,"3"=1,"4"=1,"5"=1,"6"=1, "7" = 1, "8" = 1, "10"=30)
	overmap_size = 35
	overmap_event_areas = 34
	usable_email_tlds = list("janus.nt", "nanotrasen.com", "nanotrasen.nt", "freemail.net")

	allowed_spawns = list("Cryogenic Storage", "Cyborg Storage", "Arrivals Shuttle")
	default_spawn = "Cryogenic Storage"

	station_name  = "NSC Janus"
	station_short = "Janus"
	dock_name     = "TBD"
	boss_name     = "Nanotrasen Colonial Branch Command"
	boss_short    = "Colonial Command"
	company_name  = "Nanotrasen"
	company_short = "NT"

	map_admin_faxes = list("Corporate Central Office")

	//These should probably be moved into the evac controller...
	shuttle_docked_message = "Attention all hands: Jump preparation complete. The bluespace drive is now spooling up, secure all stations for departure. Time to jump: approximately %ETD%."
	shuttle_leaving_dock = "Attention all hands: Jump initiated, exiting bluespace in %ETA%."
	shuttle_called_message = "Attention all hands: Jump sequence initiated. Transit procedures are now in effect. Jump in %ETA%."
	shuttle_recall_message = "Attention all hands: Jump sequence aborted, return to normal operating conditions."

	evac_controller_type = /datum/evacuation_controller/starship

	default_law_type = /datum/ai_laws/solgov
	use_overmap = 1
	num_exoplanets = 1

	away_site_budget = 3
	id_hud_icons = 'maps/janus/icons/assignment_hud.dmi'

// For making the 6-in-1 holomap, we calculate some offsets
#define JANUS_MAP_SIZE 177 // Width and height of compiled in Southern Cross z levels.
#define JANUS_HOLOMAP_CENTER_GUTTER 40 // 40px central gutter between columns
#define JANUS_HOLOMAP_MARGIN_X ((HOLOMAP_ICON_SIZE - (2*JANUS_MAP_SIZE) - JANUS_HOLOMAP_CENTER_GUTTER) / 2) // 100
#define JANUS_HOLOMAP_MARGIN_Y ((HOLOMAP_ICON_SIZE - (3*JANUS_MAP_SIZE)) / 2) // 60

/datum/map_z_level/janus/first
	z = Z_LEVEL_FIRST_JANUS
	name = "Floor 1"

/datum/map_z_level/janus/second
	z = Z_LEVEL_SECOND_JANUS
	name = "Floor 2"

/datum/map_z_level/janus/third
	z = Z_LEVEL_THIRD_JANUS
	name = "Floor 3"

/datum/map_z_level/janus/fourth
	z = Z_LEVEL_FOURTH_JANUS
	name = "Floor 4"


/datum/map_z_level/janus/fifth
	z = Z_LEVEL_FIFTH_JANUS
	name = "Floor 5"


/datum/map_z_level/janus/sixth
	z = Z_LEVEL_SIXTH_JANUS
	name = "Floor 6"


/datum/map_z_level/janus/seventh
	z = Z_LEVEL_SEVENTH_JANUS
	name = "Floor 7"


/datum/map_z_level/janus/eighth
	z = Z_LEVEL_EIGHTH_JANUS
	name = "Floor 8"
