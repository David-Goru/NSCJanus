var/shops_counter = 0
var/shop_areas_list = list()

/var/const/access_shop = "ACCESS_SHOP"
/datum/access/shop
	id = access_shop
	desc = "Shop access"
	region = ACCESS_REGION_SECURITY
	var/shop_id = null // 0 for all shops

/area/shop
	var/id
	var/institution_name = "Default institution name"
	var/datum/access/shop/shop_access = null
	var/list/items_prices = list()
	var/item_id_counter = 0
	var/transactions_counter = 0
	var/transactions_list = list()
	var/datum/money_account/linked_account // Shop's owner money account

/area/shop/New()
	id = ++shops_counter
	shop_access = new()
	shop_access.shop_id = id