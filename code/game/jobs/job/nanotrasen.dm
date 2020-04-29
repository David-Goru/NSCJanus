/datum/job/administration_clerk
	title = "Administration Clerk"
	department = ""
	department_flag = CIV

	total_positions = 2
	spawn_positions = 2
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_officeclerks)
	minimal_access = list(access_ntgeneral, access_civilian, access_officeclerks)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/administration_clerk/get_description_blurb()
	return "Description."

/datum/job/colonial_bank_director
	title = "Colonial Bank Director"
	department = ""
	department_flag = CIV

	total_positions = 1
	spawn_positions = 1
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_bankstaff, access_bankhighstaff)
	minimal_access = list(access_ntgeneral, access_civilian, access_bankstaff, access_bankhighstaff)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/colonial_bank_director/get_description_blurb()
	return "Description."

/datum/job/colonial_bank_deputy_director
	title = "Colonial Bank Deputy Director"
	department = ""
	department_flag = CIV

	total_positions = 1
	spawn_positions = 1
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_bankstaff, access_bankhighstaff)
	minimal_access = list(access_ntgeneral, access_civilian, access_bankstaff, access_bankhighstaff)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/colonial_bank_deputy_director/get_description_blurb()
	return "Description."

/datum/job/colonial_bank_teller
	title = "Colonial Bank Teller"
	department = ""
	department_flag = CIV

	total_positions = 2
	spawn_positions = 2
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_bankstaff)
	minimal_access = list(access_ntgeneral, access_civilian, access_bankstaff)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/colonial_bank_teller/get_description_blurb()
	return "Description."

/datum/job/facility_guard
	title = "Facility Guard"
	department = ""
	department_flag = CIV

	total_positions = 3
	spawn_positions = 3
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_security)
	minimal_access = list(access_ntgeneral, access_civilian, access_security)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/facility_guard/get_description_blurb()
	return "Description."

/datum/job/life_support_technician
	title = "Life Support Technician"
	department = ""
	department_flag = CIV

	total_positions = 3
	spawn_positions = 3
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_lifesupport)
	minimal_access = list(access_ntgeneral, access_civilian, access_lifesupport)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/life_support_technician/get_description_blurb()
	return "Description."

/datum/job/pysician
	title = "Physician"
	department = ""
	department_flag = CIV

	total_positions = 2
	spawn_positions = 2
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_medical)
	minimal_access = list(access_ntgeneral, access_civilian, access_medical)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/pysician/get_description_blurb()
	return "Description."

/datum/job/supply_technician
	title = "Supply Technician"
	department = ""
	department_flag = CIV

	total_positions = 2
	spawn_positions = 2
	supervisors = ""
	economic_power = 1
	access = list(access_ntgeneral, access_civilian, access_supply, access_mining)
	minimal_access = list(access_ntgeneral, access_civilian, access_supply, access_mining)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/supply_technician/get_description_blurb()
	return "Description."