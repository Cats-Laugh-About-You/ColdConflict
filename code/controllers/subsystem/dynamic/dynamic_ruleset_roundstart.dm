/datum/dynamic_ruleset/roundstart
	// We can pick multiple of a roundstart ruleset to "scale up" (spawn more of the same type of antag)
	// Set this to FALSE if you DON'T want this ruleset to "scale up"
	repeatable = TRUE
	/// If TRUE, the ruleset will be the only one selected for roundstart
	var/solo = FALSE

/datum/dynamic_ruleset/roundstart/is_valid_candidate(mob/candidate, client/candidate_client)
	if(isnull(candidate.mind))
		return FALSE
	// Checks that any other roundstart ruleset hasn't already picked this guy
	for(var/datum/dynamic_ruleset/roundstart/ruleset as anything in SSdynamic.queued_rulesets)
		if(candidate.mind in ruleset.selected_minds)
			return FALSE
	return ..()

/// Helpful proc - to use if your ruleset forces a job - which ensures a candidate can play the passed job typepath
/datum/dynamic_ruleset/roundstart/proc/ruleset_forced_job_check(mob/candidate, client/candidate_client, datum/job/job_typepath)
	// Malf AI can only go to people who want to be AI
	if(!candidate_client.prefs.job_preferences[job_typepath::title])
		return FALSE
	// And only to people who can actually be AI this round
	if(SSjob.check_job_eligibility(candidate, SSjob.get_job_type(job_typepath), "[name] Candidacy") != JOB_AVAILABLE)
		return FALSE
	// (Something else forced us to play a job that isn't AI)
	var/forced_job = LAZYACCESS(SSjob.forced_occupations, candidate)
	if(forced_job && forced_job != job_typepath)
		return FALSE
	// (Something else forced us NOT to play AI)
	if(job_typepath::title in LAZYACCESS(SSjob.prevented_occupations, candidate))
		return FALSE
	return TRUE

/datum/dynamic_ruleset/roundstart/traitor
	name = "Traitors"
	config_tag = "Roundstart Traitor"
	preview_antag_datum = /datum/antagonist/traitor
	pref_flag = ROLE_TRAITOR
	weight = 10
	min_pop = 3
	max_antag_cap = list("denominator" = 38)

/datum/dynamic_ruleset/roundstart/traitor/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/traitor)

/datum/dynamic_ruleset/roundstart/malf_ai
	name = "Malfunctioning AI"
	config_tag = "Roundstart Malfunctioning AI"
	pref_flag = ROLE_MALF
	preview_antag_datum = /datum/antagonist/malf_ai
	ruleset_flags = RULESET_HIGH_IMPACT
	weight = list(
		DYNAMIC_TIER_LOW = 0,
		DYNAMIC_TIER_LOWMEDIUM = 1,
		DYNAMIC_TIER_MEDIUMHIGH = 3,
		DYNAMIC_TIER_HIGH = 3,
	)
	min_pop = 30
	max_antag_cap = 1
	repeatable = FALSE

/datum/dynamic_ruleset/roundstart/malf_ai/get_always_blacklisted_roles()
	return list()

/datum/dynamic_ruleset/roundstart/malf_ai/is_valid_candidate(mob/candidate, client/candidate_client)
	return ..() && ruleset_forced_job_check(candidate, candidate_client, /datum/job/ai)

/datum/dynamic_ruleset/roundstart/malf_ai/prepare_for_role(datum/mind/candidate)
	LAZYSET(SSjob.forced_occupations, candidate, /datum/job/ai)

/datum/dynamic_ruleset/roundstart/malf_ai/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/malf_ai)

/datum/dynamic_ruleset/roundstart/malf_ai/can_be_selected()
	return ..() && !HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI)

/datum/dynamic_ruleset/roundstart/changeling
	name = "Changelings"
	config_tag = "Roundstart Changeling"
	preview_antag_datum = /datum/antagonist/changeling
	pref_flag = ROLE_CHANGELING
	weight = 3
	min_pop = 15
	max_antag_cap = list("denominator" = 29)

/datum/dynamic_ruleset/roundstart/changeling/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/changeling)

/datum/dynamic_ruleset/roundstart/wizard
	name = "Wizard"
	config_tag = "Roundstart Wizard"
	preview_antag_datum = /datum/antagonist/wizard
	pref_flag = ROLE_WIZARD
	ruleset_flags = RULESET_INVADER|RULESET_HIGH_IMPACT
	weight = list(
		DYNAMIC_TIER_LOW = 0,
		DYNAMIC_TIER_LOWMEDIUM = 0,
		DYNAMIC_TIER_MEDIUMHIGH = 1,
		DYNAMIC_TIER_HIGH = 2,
	)
	max_antag_cap = 1
	min_pop = 30
	ruleset_lazy_templates = list(LAZY_TEMPLATE_KEY_WIZARDDEN)
	repeatable = FALSE

/datum/dynamic_ruleset/roundstart/wizard/prepare_for_role(datum/mind/candidate)
	LAZYSET(SSjob.forced_occupations, candidate, /datum/job/space_wizard)

/datum/dynamic_ruleset/roundstart/wizard/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/wizard) // moves to lair for us

/datum/dynamic_ruleset/roundstart/wizard/round_result()
	for(var/datum/mind/wiz as anything in selected_minds)
		if(considered_alive(wiz) && !considered_exiled(wiz))
			return FALSE

	SSticker.news_report = WIZARD_KILLED
	return TRUE

/datum/dynamic_ruleset/roundstart/extended
	name = "Extended"
	config_tag = "Extended"
	weight = 0
	min_antag_cap = 0
	repeatable = FALSE
	solo = TRUE

/datum/dynamic_ruleset/roundstart/extended/execute()
	// No midrounds no latejoins
	for(var/category in SSdynamic.rulesets_to_spawn)
		SSdynamic.rulesets_to_spawn[category] = 0

/datum/dynamic_ruleset/roundstart/meteor
	name = "Meteor"
	config_tag = "Meteor"
	weight = 0
	min_antag_cap = 0
	repeatable = FALSE

/datum/dynamic_ruleset/roundstart/meteor/execute()
	GLOB.meteor_mode ||= new()
	GLOB.meteor_mode.start_meteor()
