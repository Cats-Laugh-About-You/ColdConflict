
///basic bow, used for medieval sim
/obj/item/gun/ballistic/bow/longbow
	name = "longbow"
	desc = "While pretty finely crafted, surely you can find something better to use in the current year."

/// Shortbow, made via the crafting recipe
/obj/item/gun/ballistic/bow/shortbow
	name = "shortbow"
	desc = "A simple homemade shortbow. Great for LARPing. Or poking out someones eye."
	projectile_damage_multiplier = 0.36

///chaplain's divine archer bow
/obj/item/gun/ballistic/bow/divine
	name = "divine bow"
	desc = "Holy armament to pierce the souls of sinners."
	icon_state = "holybow"
	inhand_icon_state = "holybow"
	base_icon_state = "holybow"
	worn_icon_state = "holybow"
	slot_flags = ITEM_SLOT_BACK
	obj_flags = UNIQUE_RENAME
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/bow/holy
	projectile_damage_multiplier = 0.4

/obj/item/ammo_box/magazine/internal/bow/holy
	name = "divine bowstring"
	ammo_type = /obj/item/ammo_casing/arrow/holy

/obj/item/gun/ballistic/bow/divine/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY)
	AddElement(/datum/element/bane, mob_biotypes = MOB_SPIRIT, damage_multiplier = 0, added_damage = 25, requires_combat_mode = FALSE)

/obj/item/gun/ballistic/bow/divine/with_quiver/Initialize(mapload)
	. = ..()
	new /obj/item/storage/bag/quiver/holy(loc)
