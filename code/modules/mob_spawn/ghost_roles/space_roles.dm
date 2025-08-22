
//Ancient cryogenic sleepers. Players become NT crewmen from a hundred year old space station, now on the verge of collapse.
/obj/effect/mob_spawn/ghost_role/human/oldsec
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a security uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	prompt_name = "a security officer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are a security officer working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_text = "Work as a team with your fellow survivors and do not abandon them."
	outfit = /datum/outfit/oldsec
	spawner_job_path = /datum/job/ancient_crew

/obj/effect/mob_spawn/ghost_role/human/oldsec/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/outfit/oldsec
	name = "Ancient Security"
	id = /obj/item/card/id/away/old/sec
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/assembly/flash/handheld
	r_pocket = /obj/item/restraints/handcuffs

/obj/effect/mob_spawn/ghost_role/human/oldeng
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an engineering uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	prompt_name = "an engineer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are an engineer working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. The last thing \
	you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_text = "Work as a team with your fellow survivors and do not abandon them."
	outfit = /datum/outfit/oldeng
	spawner_job_path = /datum/job/ancient_crew

/obj/effect/mob_spawn/ghost_role/human/oldeng/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/outfit/oldeng
	name = "Ancient Engineer"
	id = /obj/item/card/id/away/old/eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	gloves = /obj/item/clothing/gloves/color/fyellow/old
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/tank/internals/emergency_oxygen

/datum/outfit/oldeng/mod
	name = "Ancient Engineer (MODsuit)"
	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/prototype
	mask = /obj/item/clothing/mask/breath
	internals_slot = ITEM_SLOT_SUITSTORE

/obj/effect/mob_spawn/ghost_role/human/oldsci
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a science uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	prompt_name = "a scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are a scientist working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_text = "Work as a team with your fellow survivors and do not abandon them."
	outfit = /datum/outfit/oldsci
	spawner_job_path = /datum/job/ancient_crew

/obj/effect/mob_spawn/ghost_role/human/oldsci/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/outfit/oldsci
	name = "Ancient Scientist"
	id = /obj/item/card/id/away/old/sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/stack/medical/bruise_pack

///asteroid comms agent

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	you_are_text = "You are a syndicate agent, assigned to a small listening post station situated near your hated enemy's top secret research facility: Space Station 13."
	flavour_text = "Monitor enemy activity as best you can, and try to keep a low profile. Use the communication equipment to provide support to any field agents, and sow disinformation to throw Nanotrasen off your trail. Do not let the base fall into enemy hands!"
	important_text = "DO NOT abandon the base."

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space/Initialize(mapload)
	. = ..()
	if(prob(85)) //only has a 15% chance of existing, otherwise it'll just be a NPC syndie.
		new /mob/living/basic/trooper/syndicate/ranged(get_turf(src))
		return INITIALIZE_HINT_QDEL

//film studio space ruins, actors and such.
/obj/effect/mob_spawn/ghost_role/human/actor
	name = "cryogenics pod"
	desc = "A humming cryo pod. You recognize the person inside as a local celebrity of sort."
	prompt_name = "a actor"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are an actor/actress working for Sophronia Broadcasting Inc., stationed onboard the local TV studio."
	flavour_text = "You last remember corporate told everyone to go to cryosleep for whatever reason, where did everyone else go?"
	important_text = "Work as a team with your fellow actors and the director to make entertainment for the masses."
	outfit = /datum/outfit/actor
	spawner_job_path = /datum/job/ghost_role

/datum/outfit/actor
	name = "Actor"
	id = /obj/item/card/id/away/filmstudio
	id_trim= /datum/id_trim/away/actor
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/suit/charcoal
	back = /obj/item/storage/backpack/satchel
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/clothing/mask/chameleon
	r_pocket = /obj/item/card/id/advanced/chameleon

/obj/effect/mob_spawn/ghost_role/human/director
	name = "cryogenics pod"
	desc = "A humming cryo pod. You recognize the person inside as a local celebrity of sort."
	prompt_name = "a director"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are a director working for Sophronia Broadcasting Inc., stationed onboard the local TV studio."
	flavour_text = "You just got hired to direct shows and entertainment for a local tv studio, make do with your team and produce something!"
	important_text = "Work as a team with your fellow actors and the director to make entertainment for the masses."
	outfit = /datum/outfit/actor/director
	spawner_job_path = /datum/job/ghost_role

/datum/outfit/actor/director
	name = "Director"
	id_trim = /datum/id_trim/away/director
	uniform = /obj/item/clothing/under/suit/red
	head = /obj/item/clothing/head/beret/frenchberet
