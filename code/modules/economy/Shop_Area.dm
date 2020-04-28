var/shop_areas_list = list()

/area/shop
	var/id
	var/institution_name = "Default institution name"
	var/datum/access/business/business_access = null
	var/list/items_prices = list()
	var/item_id_counter = 0
	var/transactions_counter = 0
	var/transactions_list = list()
	var/datum/money_account/linked_account // Shop's owner money account

/area/shop/New()
	id = ++business_id_counter
	business_access = new()
	business_access.business_id = id