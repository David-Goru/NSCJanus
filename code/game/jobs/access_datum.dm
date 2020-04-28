/datum/access
	var/id = ""
	var/desc = ""
	var/region = ACCESS_REGION_NONE

/*****************
* Council access *
*****************/

/var/const/access_co = "ACCESS_CO"
/datum/access/co
	id = access_co
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_xo = "ACCESS_XO"
/datum/access/xo
	id = access_xo
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_ce = "ACCESS_CE"
/datum/access/ce
	id = access_ce
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_coo = "ACCESS_COO"
/datum/access/coo
	id = access_coo
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_cos = "ACCESS_COS"
/datum/access/cos
	id = access_cos
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_cpo = "ACCESS_CPO"
/datum/access/cpo
	id = access_cpo
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_cfo = "ACCESS_CFO"
/datum/access/cfo
	id = access_cfo
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_command = "ACCESS_COMMAND"
/datum/access/command
	id = access_command
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_accountmanagement = "ACCESS_ACCOUNTMANAGEMENT"
/datum/access/accountmanagement
	id = access_accountmanagement
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_businessmanagement = "ACCESS_BUSINESSMANAGEMENT"
/datum/access/businessmanagement
	id = access_businessmanagement
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_staffmanagement = "ACCESS_STAFFMANAGEMENT"
/datum/access/staffmanagement
	id = access_staffmanagement
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_workersrep = "ACCESS_WORKERSREP"
/datum/access/workersrep
	id = access_workersrep
	desc = ""
	region = ACCESS_REGION_COUNCIL

/var/const/access_employersrep = "ACCESS_EMPLOYERSREP"
/datum/access/employersrep
	id = access_employersrep
	desc = ""
	region = ACCESS_REGION_COUNCIL

/**************
* Bank access *
**************/

/var/const/access_bankstaff = "ACCESS_BANKSTAFF"
/datum/access/bankstaff
	id = access_bankstaff
	desc = ""
	region = ACCESS_REGION_BANK

/var/const/access_bankhighstaff = "ACCESS_BANKHIGHSTAFF"
/datum/access/bankhighstaff
	id = access_bankhighstaff
	desc = ""
	region = ACCESS_REGION_BANK

/********************
* Nanotrasen access *
********************/

/var/const/access_ntgeneral = "ACCESS_NTGENERAL"
/datum/access/ntgeneral
	id = access_ntgeneral
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/var/const/access_officeclerks = "ACCESS_OFFICECLERKS"
/datum/access/officeclerks
	id = access_officeclerks
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/var/const/access_lifesupport = "ACCESS_LIFESUPPORT"
/datum/access/lifesupport
	id = access_lifesupport
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/var/const/access_medical = "ACCESS_MEDICAL"
/datum/access/medical
	id = access_medical
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/var/const/access_security = "ACCESS_SECURITY"
/datum/access/security
	id = access_security
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/var/const/access_supply = "ACCESS_SUPPLY"
/datum/access/supply
	id = access_supply
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/var/const/access_mining = "ACCESS_MINING"
/datum/access/mining
	id = access_mining
	desc = ""
	region = ACCESS_REGION_NANOTRASEN

/******************
* Civilian access *
******************/

/var/const/access_civilian = "ACCESS_CIVILIAN"
/datum/access/civilian
	id = access_civilian
	desc = ""
	region = ACCESS_REGION_CIVILIAN

var/business_id_counter = 0
/var/const/access_business = "ACCESS_BUSINESS"
/datum/access/business
	id = access_business
	desc = ""
	region = ACCESS_REGION_CIVILIAN
	var/business_id = null