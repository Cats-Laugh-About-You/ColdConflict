/datum/dynamic_ruleset/latejoin
	min_antag_cap = 1
	max_antag_cap = 1
	repeatable = TRUE

/datum/dynamic_ruleset/latejoin/set_config_value(nvar, nval)
	if(nvar == NAMEOF(src, min_antag_cap) || nvar == NAMEOF(src, max_antag_cap))
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, min_antag_cap) || var_name == NAMEOF(src, max_antag_cap))
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/is_valid_candidate(mob/candidate, client/candidate_client)
	if(isnull(candidate.mind))
		return FALSE
	if(candidate.mind.assigned_role.title in get_blacklisted_roles())
		return FALSE
	return ..()

/datum/dynamic_ruleset/latejoin/traitor
	name = "Traitor"
	config_tag = "Latejoin Traitor"
	preview_antag_datum = /datum/antagonist/traitor
	pref_flag = ROLE_SYNDICATE_INFILTRATOR
	jobban_flag = ROLE_TRAITOR
	weight = 10
	min_pop = 3
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
	)

/datum/dynamic_ruleset/latejoin/traitor/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/traitor)

/datum/dynamic_ruleset/latejoin/changeling
	name = "Changeling"
	config_tag = "Latejoin Changeling"
	preview_antag_datum = /datum/antagonist/changeling
	pref_flag = ROLE_STOWAWAY_CHANGELING
	jobban_flag = ROLE_CHANGELING
	weight = 3
	min_pop = 15
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
	)

/datum/dynamic_ruleset/latejoin/changeling/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/changeling)
