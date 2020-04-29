/datum/map/janus
	species_to_job_whitelist = list(
		/datum/species/adherent = list(/datum/job/civilian, /datum/job/contractor, /datum/job/visitor, /datum/job/colony_overseer, /datum/job/executive_overseer, /datum/job/chief_people_officer,
						/datum/job/chief_financial_officer, /datum/job/chief_of_security, /datum/job/chief_of_operations, /datum/job/chief_engineer, /datum/job/workers_representative,
						/datum/job/employers_representative, /datum/job/administration_clerk, /datum/job/colonial_bank_director, /datum/job/colonial_bank_deputy_director,
						/datum/job/colonial_bank_teller, /datum/job/facility_guard, /datum/job/support_technician, /datum/job/physician, /datum/job/supply_technician),
		/datum/species/nabber = list(/datum/job/civilian, /datum/job/contractor, /datum/job/visitor, /datum/job/colony_overseer, /datum/job/executive_overseer, /datum/job/chief_people_officer,
						/datum/job/chief_financial_officer, /datum/job/chief_of_security, /datum/job/chief_of_operations, /datum/job/chief_engineer, /datum/job/workers_representative,
						/datum/job/employers_representative, /datum/job/administration_clerk, /datum/job/colonial_bank_director, /datum/job/colonial_bank_deputy_director,
						/datum/job/colonial_bank_teller, /datum/job/facility_guard, /datum/job/support_technician, /datum/job/physician, /datum/job/supply_technician),
		/datum/species/vox = list(/datum/job/civilian, /datum/job/contractor, /datum/job/visitor, /datum/job/colony_overseer, /datum/job/executive_overseer, /datum/job/chief_people_officer,
						/datum/job/chief_financial_officer, /datum/job/chief_of_security, /datum/job/chief_of_operations, /datum/job/chief_engineer, /datum/job/workers_representative,
						/datum/job/employers_representative, /datum/job/administration_clerk, /datum/job/colonial_bank_director, /datum/job/colonial_bank_deputy_director,
						/datum/job/colonial_bank_teller, /datum/job/facility_guard, /datum/job/support_technician, /datum/job/physician, /datum/job/supply_technician),
		/datum/species/human/mule = list(/datum/job/civilian, /datum/job/contractor, /datum/job/visitor, /datum/job/colony_overseer, /datum/job/executive_overseer, /datum/job/chief_people_officer,
						/datum/job/chief_financial_officer, /datum/job/chief_of_security, /datum/job/chief_of_operations, /datum/job/chief_engineer, /datum/job/workers_representative,
						/datum/job/employers_representative, /datum/job/administration_clerk, /datum/job/colonial_bank_director, /datum/job/colonial_bank_deputy_director,
						/datum/job/colonial_bank_teller, /datum/job/facility_guard, /datum/job/support_technician, /datum/job/physician, /datum/job/supply_technician)
	)

#define HUMAN_ONLY_JOBS /datum/job/captain, /datum/job/hop, /datum/job/cmo, /datum/job/chief_engineer, /datum/job/hos, /datum/job/representative, /datum/job/sea, /datum/job/pathfinder, /datum/job/rd
	species_to_job_blacklist = list(
		/datum/species/unathi  = list(HUMAN_ONLY_JOBS), //Other jobs unavailable via branch restrictions,
		/datum/species/unathi/yeosa = list(HUMAN_ONLY_JOBS),
		/datum/species/skrell  = list(HUMAN_ONLY_JOBS),
		/datum/species/machine = list(HUMAN_ONLY_JOBS),
		/datum/species/diona   = list(HUMAN_ONLY_JOBS),	//Other jobs unavailable via branch restrictions,
	)
#undef HUMAN_ONLY_JOBS

	allowed_jobs = list(/datum/job/civilian, /datum/job/contractor, /datum/job/visitor, /datum/job/colony_overseer, /datum/job/executive_overseer, /datum/job/chief_people_officer,
						/datum/job/chief_financial_officer, /datum/job/chief_of_security, /datum/job/chief_of_operations, /datum/job/chief_engineer, /datum/job/workers_representative,
						/datum/job/employers_representative, /datum/job/administration_clerk, /datum/job/colonial_bank_director, /datum/job/colonial_bank_deputy_director,
						/datum/job/colonial_bank_teller, /datum/job/facility_guard, /datum/job/support_technician, /datum/job/physician, /datum/job/supply_technician)

	access_modify_region = list(
		ACCESS_REGION_SECURITY = list(access_staffmanagement),
		ACCESS_REGION_MEDBAY = list(access_staffmanagement),
		ACCESS_REGION_RESEARCH = list(access_staffmanagement),
		ACCESS_REGION_ENGINEERING = list(access_staffmanagement),
		ACCESS_REGION_COMMAND = list(access_staffmanagement),
		ACCESS_REGION_GENERAL = list(access_staffmanagement),
		ACCESS_REGION_SUPPLY = list(access_staffmanagement),
		ACCESS_REGION_NT = list(access_staffmanagement)
	)

/datum/map/janus/setup_job_lists()
	for(var/job_type in allowed_jobs)
		var/datum/job/job = SSjobs.get_by_path(job_type)
		// Most species are restricted from SCG security and command roles
		if(job && (job.department_flag & COM) && job.allowed_branches.len && !(/datum/mil_branch/civilian in job.allowed_branches))
			for(var/species_name in list(SPECIES_IPC, SPECIES_SKRELL, SPECIES_UNATHI))
				var/datum/species/S = all_species[species_name]
				var/species_blacklist = species_to_job_blacklist[S.type]
				if(!species_blacklist)
					species_blacklist = list()
					species_to_job_blacklist[S.type] = species_blacklist
				species_blacklist |= job.type

// Some jobs for nabber grades defined here due to map-specific job datums.
/decl/cultural_info/culture/nabber/New()
	LAZYADD(valid_jobs, /datum/job/scientist_assistant)
	..()

/decl/cultural_info/culture/nabber/b/New()
	LAZYADD(valid_jobs, /datum/job/cargo_tech)
	..()

/decl/cultural_info/culture/nabber/a/New()
	LAZYADD(valid_jobs, /datum/job/engineer)
	..()

/decl/cultural_info/culture/nabber/a/plus/New()
	LAZYADD(valid_jobs, /datum/job/doctor)
	..()

/datum/job
	allowed_branches = list(
		/datum/mil_branch/civilian
	)
	allowed_ranks = list(
		/datum/mil_rank/civ/civ
	)
	required_language = LANGUAGE_HUMAN_EURO

/datum/map/janus
	default_assistant_title = "Passenger"
