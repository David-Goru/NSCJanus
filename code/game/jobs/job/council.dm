/datum/job/colony_overseer
	title = "Colony Overseer"
	department = ""
	//head_position = 1
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_lifesupport, access_ntgeneral, access_command, access_medical, access_security, access_supply, access_mining, access_co, access_xo,
					access_ce, access_coo, access_cos, access_cpo, access_workersrep, access_employersrep, access_officeclerks, access_bankstaff, access_bankhighstaff,
					access_civilian, access_businessmanagement, access_staffmanagement, access_accountmanagement)
	minimal_access = list(access_lifesupport, access_ntgeneral, access_command, access_medical, access_security, access_supply, access_mining, access_co, access_xo,
					access_ce, access_coo, access_cos, access_cpo, access_workersrep, access_employersrep, access_officeclerks, access_bankstaff, access_bankhighstaff,
					access_civilian, access_businessmanagement, access_staffmanagement, access_accountmanagement)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain


	min_skill = list(   SKILL_BUREAUCRACY = SKILL_ADEPT,
	                    SKILL_COMPUTER    = SKILL_BASIC,
	                    SKILL_PILOT       = SKILL_BASIC)

	max_skill = list(   SKILL_PILOT       = SKILL_MAX,
	                    SKILL_SCIENCE     = SKILL_MAX)
	skill_points = 30

/datum/job/colony_overseer/get_description_blurb()
	return "Description."


/datum/job/executive_overseer
	title = "Executive Overseer"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_lifesupport, access_ntgeneral, access_command, access_medical, access_security, access_supply,
							access_mining, access_xo, access_officeclerks, access_bankstaff, access_bankhighstaff, access_civilian,
							access_businessmanagement, access_staffmanagement, access_accountmanagement)
	minimal_access = list(access_lifesupport, access_ntgeneral, access_command, access_medical, access_security, access_supply,
							access_mining, access_xo, access_officeclerks, access_bankstaff, access_bankhighstaff, access_civilian,
							access_businessmanagement, access_staffmanagement, access_accountmanagement)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/executive_overseer/get_description_blurb()
	return "Description."

/datum/job/chief_people_officer
	title = "Chief People Officer"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_officeclerks, access_civilian, access_staffmanagement, access_cpo)
	minimal_access = list(access_ntgeneral, access_command, access_officeclerks, access_civilian, access_staffmanagement, access_cpo)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/chief_people_officer/get_description_blurb()
	return "Description."

/datum/job/chief_financial_officer
	title = "Chief Financial Officer"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_officeclerks, access_bankstaff, access_bankhighstaff, access_civilian,
							access_accountmanagement, access_cfo)
	minimal_access = list(access_ntgeneral, access_command, access_officeclerks, access_bankstaff, access_bankhighstaff, access_civilian,
							access_accountmanagement, access_cfo)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/chief_financial_officer/get_description_blurb()
	return "Description."

/datum/job/chief_of_security
	title = "Chief of Security"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_officeclerks, access_civilian, access_security, access_cos)
	minimal_access = list(access_ntgeneral, access_command, access_officeclerks, access_civilian, access_security, access_cos)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/chief_of_security/get_description_blurb()
	return "Description."

/datum/job/chief_of_operations
	title = "Chief of Operations"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_officeclerks, access_civilian, access_businessmanagement, access_coo)
	minimal_access = list(access_ntgeneral, access_command, access_officeclerks, access_civilian, access_businessmanagement, access_coo)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/chief_of_operations/get_description_blurb()
	return "Description."

/datum/job/chief_engineer
	title = "Chief Engineer"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_civilian, access_businessmanagement, access_ce, access_lifesupport)
	minimal_access = list(access_ntgeneral, access_command, access_civilian, access_businessmanagement, access_ce, access_lifesupport)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/chief_engineer/get_description_blurb()
	return "Description."

/datum/job/workers_representative
	title = "Workers' Representative"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_civilian, access_workersrep)
	minimal_access = list(access_ntgeneral, access_command, access_civilian, access_workersrep)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/workers_representative/get_description_blurb()
	return "Description."

/datum/job/employers_representative
	title = "Employer's Representative"
	department = ""
	department_flag = COM

	total_positions = 1
	spawn_positions = 0
	supervisors = ""
	selection_color = "#1d1d4f"
	access = list(access_ntgeneral, access_command, access_civilian, access_employersrep)
	minimal_access = list(access_ntgeneral, access_command, access_civilian, access_employersrep)
	economic_power = 20

	outfit_type = /decl/hierarchy/outfit/job/captain

/datum/job/employers_representative/get_description_blurb()
	return "Description."