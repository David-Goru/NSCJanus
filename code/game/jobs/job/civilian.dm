/datum/job/civilian
	title = "Civilian"
	department = ""
	department_flag = CIV

	total_positions = -1
	spawn_positions = -1
	supervisors = ""
	economic_power = 1
	access = list(access_civilian)
	minimal_access = list(access_civilian)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/contractor
	title = "Contractor"
	department = ""
	department_flag = CIV

	total_positions = -1
	spawn_positions = 0
	supervisors = ""
	economic_power = 1
	access = list(access_civilian, access_ntgeneral)
	minimal_access = list(access_civilian, access_ntgeneral)
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/visitor
	title = "Visitor"
	department = ""
	department_flag = CIV

	total_positions = -1
	spawn_positions = -1
	supervisors = ""
	economic_power = 1
	access = list()
	minimal_access = list()
	//alt_titles = list()
	outfit_type = /decl/hierarchy/outfit/job/assistant