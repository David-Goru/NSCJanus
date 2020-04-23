//janus ID Cards (they have to be here to make the outfits work, no way around it)

/obj/item/weapon/card/id/janus
	name = "identification card"
	desc = "An identification card issued to personnel aboard the SEV janus."
	job_access_type = DEFAULT_JOB_TYPE

/obj/item/weapon/card/id/janus/silver
	desc = "A silver identification card belonging to heads of staff."
	item_state = "silver_id"
	job_access_type = /datum/job/hop
	extra_details = list("goldstripe")
	color = "#ccecff"

/obj/item/weapon/card/id/janus/gold
	desc = "A golden identification card belonging to the Commanding Officer."
	item_state = "gold_id"
	job_access_type = /datum/job/captain
	color = "#d4c780"
	extra_details = list("goldstripe")

// SolGov Crew and Contractors
/obj/item/weapon/card/id/janus/crew
	desc = "An identification card issued to SolGov crewmembers aboard the SEV janus."
	color = "#d3e3e1"
	job_access_type = /datum/job/crew
	color = "#ccecff"


/obj/item/weapon/card/id/janus/contractor
	desc = "An identification card issued to private contractors aboard the SEV janus."
	job_access_type = DEFAULT_JOB_TYPE
	color = COLOR_GRAY80


/obj/item/weapon/card/id/janus/silver/medical
	job_access_type = /datum/job/cmo
	detail_color = COLOR_PALE_BLUE_GRAY

/obj/item/weapon/card/id/janus/crew/medical
	job_access_type = /datum/job/doctor
	detail_color = COLOR_PALE_BLUE_GRAY

/obj/item/weapon/card/id/janus/crew/medical/senior
	job_access_type = /datum/job/senior_doctor

/obj/item/weapon/card/id/janus/contractor/medical
	job_access_type = /datum/job/doctor
	detail_color = COLOR_PALE_BLUE_GRAY

/obj/item/weapon/card/id/janus/contractor/medical/senior
	job_access_type = /datum/job/senior_doctor

/obj/item/weapon/card/id/janus/contractor/chemist
	job_access_type = /datum/job/chemist
	detail_color = COLOR_PALE_BLUE_GRAY

/obj/item/weapon/card/id/janus/contractor/medical/counselor
	job_access_type = /datum/job/psychiatrist

/obj/item/weapon/card/id/janus/silver/security
	job_access_type = /datum/job/hos
	detail_color = "#e00000"

/obj/item/weapon/card/id/janus/crew/security
	job_access_type = /datum/job/officer
	detail_color = "#e00000"

/obj/item/weapon/card/id/janus/crew/security/brigchief
	job_access_type = /datum/job/warden
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/crew/security/forensic
	job_access_type = /datum/job/detective


/obj/item/weapon/card/id/janus/silver/engineering
	job_access_type = /datum/job/chief_engineer
	detail_color = COLOR_SUN

/obj/item/weapon/card/id/janus/crew/engineering
	job_access_type = /datum/job/engineer
	detail_color = COLOR_SUN

/obj/item/weapon/card/id/janus/crew/engineering/senior
	job_access_type = /datum/job/senior_engineer
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/contractor/engineering
	job_access_type = /datum/job/engineer
	detail_color = COLOR_SUN

/obj/item/weapon/card/id/janus/contractor/engineering/roboticist
	job_access_type = /datum/job/roboticist


/obj/item/weapon/card/id/janus/crew/supply/deckofficer
	job_access_type = /datum/job/qm
	detail_color = COLOR_BROWN
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/crew/supply
	job_access_type = /datum/job/cargo_tech
	detail_color = COLOR_BROWN

/obj/item/weapon/card/id/janus/contractor/supply
	job_access_type = /datum/job/cargo_tech
	detail_color = COLOR_BROWN

/obj/item/weapon/card/id/janus/crew/service //unused
	job_access_type = DEFAULT_JOB_TYPE
	detail_color = COLOR_CIVIE_GREEN

/obj/item/weapon/card/id/janus/crew/service/janitor
	job_access_type = /datum/job/janitor

/obj/item/weapon/card/id/janus/crew/service/chef
	job_access_type = /datum/job/chef

/obj/item/weapon/card/id/janus/crew/service/chaplain
	job_access_type = /datum/job/chaplain

/obj/item/weapon/card/id/janus/contractor/service //unused
	job_access_type = DEFAULT_JOB_TYPE
	detail_color = COLOR_CIVIE_GREEN

/obj/item/weapon/card/id/janus/contractor/service/bartender
	job_access_type = /datum/job/bartender


/obj/item/weapon/card/id/janus/crew/representative
	job_access_type = /datum/job/representative
	detail_color = COLOR_COMMAND_BLUE

/obj/item/weapon/card/id/janus/crew/sea
	job_access_type = /datum/job/sea
	detail_color = COLOR_COMMAND_BLUE
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/crew/bridgeofficer
	job_access_type = /datum/job/bridgeofficer
	detail_color = COLOR_COMMAND_BLUE

/obj/item/weapon/card/id/janus/crew/pathfinder
	job_access_type = /datum/job/pathfinder
	detail_color = COLOR_PURPLE
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/crew/explorer
	job_access_type = /datum/job/explorer
	detail_color = COLOR_PURPLE

/obj/item/weapon/card/id/janus/crew/pilot
	job_access_type = /datum/job/nt_pilot
	detail_color = COLOR_PURPLE

// EC Science
/obj/item/weapon/card/id/janus/silver/research
	job_access_type = /datum/job/rd
	detail_color = COLOR_RESEARCH
	color = COLOR_WHITE

/obj/item/weapon/card/id/janus/crew/research
	desc = "A card issued to science personnel aboard the SEV janus."
	job_access_type = /datum/job/scientist_assistant
	detail_color = COLOR_RESEARCH

/obj/item/weapon/card/id/janus/crew/research/senior_scientist
	job_access_type = /datum/job/senior_scientist
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/crew/research/scientist
	job_access_type = /datum/job/scientist

//NanoTrasen and Passengers

/obj/item/weapon/card/id/janus/passenger
	desc = "A card issued to passengers aboard the SEV janus."
	job_access_type = DEFAULT_JOB_TYPE
	detail_color = COLOR_PAKISTAN_GREEN

/obj/item/weapon/card/id/janus/passenger/research
	desc = "A card issued to corporate personnel aboard the SEV janus."
	job_access_type = /datum/job/scientist_assistant
	detail_color = COLOR_BOTTLE_GREEN

/obj/item/weapon/card/id/janus/passenger/research/senior_scientist
	job_access_type = /datum/job/senior_scientist
	extra_details = list("onegoldstripe")

/obj/item/weapon/card/id/janus/passenger/research/nt_pilot
	job_access_type = /datum/job/nt_pilot

/obj/item/weapon/card/id/janus/passenger/research/scientist
	job_access_type = /datum/job/scientist

/obj/item/weapon/card/id/janus/passenger/research/mining
	job_access_type = /datum/job/mining

/obj/item/weapon/card/id/janus/passenger/corporate
	color = COLOR_BOTTLE_GREEN
	detail_color = COLOR_OFF_WHITE
	job_access_type = /datum/job/bodyguard

/obj/item/weapon/card/id/janus/passenger/corporate/liaison
	job_access_type = /datum/job/liaison
	extra_details = list("onegoldstripe")

//Merchant
/obj/item/weapon/card/id/janus/merchant
	desc = "An identification card issued to Merchants, indicating their right to sell and buy goods."
	job_access_type = /datum/job/merchant
	color = COLOR_OFF_WHITE
	detail_color = COLOR_BEIGE
