/mob/living/basic/construct/harvester
	name = "Harvester"
	real_name = "Harvester"
	desc = "A long, thin construct built to herald Nar'Sie's rise. It'll be all over soon."
	icon_state = "harvester"
	icon_living = "harvester"
	maxHealth = 40
	health = 40
	sight = SEE_MOBS
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "butchers"
	attack_verb_simple = "butcher"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	construct_spells = list(
		/datum/action/cooldown/spell/aoe/area_conversion,
		/datum/action/cooldown/spell/forcewall/cult,
	)
	playstyle_string = "<B>You are a Harvester. You are incapable of directly killing humans, \
		but your attacks will remove their limbs: Bring those who still cling to this world \
		of illusion back to the Geometer so they may know Truth. Your form and any you are \
		pulling can pass through runed walls effortlessly.</B>"
	can_repair = TRUE
	slowed_by_drag = FALSE

/mob/living/basic/construct/harvester/Initialize(mapload)
	. = ..()
	grant_abilities()

/mob/living/basic/construct/harvester/proc/grant_abilities()
	AddElement(/datum/element/wall_walker)
	AddComponent(\
		/datum/component/amputating_limbs,\
		surgery_time = 0,\
		surgery_verb = "slicing",\
		minimum_stat = CONSCIOUS,\
	)
	var/datum/action/innate/seek_prey/seek = new(src)
	seek.Grant(src)
	seek.Activate()

/// If the attack is a limbless carbon, abort the attack, paralyze them, and get a special message from Nar'Sie.
/mob/living/basic/construct/harvester/resolve_unarmed_attack(atom/attack_target, list/modifiers)
	if(!iscarbon(attack_target))
		return ..()
	var/mob/living/carbon/carbon_target = attack_target

	for(var/obj/item/bodypart/limb as anything in carbon_target.bodyparts)
		if(limb.body_part == HEAD || limb.body_part == CHEST)
			continue
		return ..() //if any arms or legs exist, attack

	carbon_target.Paralyze(6 SECONDS)
	visible_message(span_danger("[src] knocks [carbon_target] down!"))
	if(theme == THEME_CULT)
		to_chat(src, span_cult_large("\"Bring [carbon_target.p_them()] to me.\""))

/datum/action/innate/seek_master
	name = "Seek your Master"
	desc = "You and your master share a soul-link that informs you of their location"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	buttontooltipstyle = "cult"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "cult_mark"
	/// Where is nar nar? Are we even looking?
	var/tracking = FALSE
	/// The construct we're attached to
	var/mob/living/basic/construct/the_construct

/datum/action/innate/seek_master/Grant(mob/living/player)
	the_construct = player
	..()

/datum/action/innate/seek_master/Activate()

	if(!the_construct.construct_master)
		to_chat(the_construct, span_cult_italic("You have no master to seek!"))
		the_construct.seeking = FALSE
		return
	if(tracking)
		tracking = FALSE
		the_construct.seeking = FALSE
		to_chat(the_construct, span_cult_italic("You are no longer tracking your master."))
		return
	else
		tracking = TRUE
		the_construct.seeking = TRUE
		to_chat(the_construct, span_cult_italic("You are now tracking your master."))

/datum/action/innate/seek_prey
	name = "Seek the Harvest"
	desc = "None can hide from Nar'Sie, activate to track a survivor attempting to flee the red harvest!"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	buttontooltipstyle = "cult"
	button_icon_state = "cult_mark"

/datum/action/innate/seek_prey/Activate()
	var/mob/living/basic/construct/harvester/the_construct = owner

	if(the_construct.seeking)
		desc = "None can hide from Nar'Sie, activate to track a survivor attempting to flee the red harvest!"
		button_icon_state = "cult_mark"
		the_construct.seeking = FALSE
		to_chat(the_construct, span_cult_italic("You are now tracking Nar'Sie, return to reap the harvest!"))
		return

	var/mob/living/real_target = the_construct.construct_master //We can typecast this way because Narsie only allows /mob/living into the souls list
	to_chat(the_construct, span_cult_italic("You are now tracking your prey, [real_target.real_name] - harvest [real_target.p_them()]!"))
	desc = "Activate to track Nar'Sie!"
	button_icon_state = "sintouch"
	the_construct.seeking = TRUE

// no real reason for most of this weird oldcode
/datum/action/innate/seek_master/Activate()
	return
