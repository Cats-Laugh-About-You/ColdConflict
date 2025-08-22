#define HERETIC_MOODLET_PRESENT (1<<0)
#define TRAITOR_MOODLET_PRESENT (1<<1)

#define HAS_HERETIC_MOODLET(result) (result & HERETIC_MOODLET_PRESENT)
#define HAS_TRAITOR_MOODLET(result) (result & TRAITOR_MOODLET_PRESENT)

/datum/unit_test/antag_moodlets
	// Saving the typepaths for each type of moodlet we give out here, for ease of access
	var/heretic_moodlet
	var/traitor_moodlet

/datum/unit_test/antag_moodlets/Run()
	var/mob/living/carbon/human/bad_man = allocate(/mob/living/carbon/human/consistent)
	var/datum/antagonist/antag_traitor = /datum/antagonist/traitor
	traitor_moodlet = initial(antag_traitor.antag_moodlet)

	bad_man.mind_initialize()

	var/list/mob_mood_list = bad_man.mob_mood.mood_events
	var/result = NONE

	// Check for heretic and traitor moodlet
	bad_man.mind.add_antag_datum(antag_traitor)
	result = check_moodlets(mob_mood_list)
	TEST_ASSERT(HAS_TRAITOR_MOODLET(result), "Upon becoming a traitor-heretic, the dummy had no traitor antag moodlet.")

	// Remove traitor, nothing left
	bad_man.mind.remove_antag_datum(antag_traitor)
	result = check_moodlets(mob_mood_list)
	TEST_ASSERT(!HAS_HERETIC_MOODLET(result), "After removing all antag datums, the dummy still had their heretic moodlet.")
	TEST_ASSERT(!HAS_TRAITOR_MOODLET(result), "After removing all antag datums, the dummy still had their traitor moodlet.")

/datum/unit_test/antag_moodlets/proc/check_moodlets(list/in_mood_list)
	var/results = NONE
	for(var/category in in_mood_list)
		var/datum/mood_event/moodie = in_mood_list[category]
		if(istype(moodie, traitor_moodlet))
			results |= TRAITOR_MOODLET_PRESENT

	return results

#undef TRAITOR_MOODLET_PRESENT

#undef HAS_TRAITOR_MOODLET
