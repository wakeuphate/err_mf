err_ai_fnc_printSkills = {
	params ["_unit"];

	private _skills = [
		"aimingAccuracy",
		"aimingShake",
		"aimingSpeed",
		"commanding",
		"courage",
		"spotDistance",
		"spotTime"
	];

	private _output = "";
	{
		_output = _output + format["%1=%2 ", _x, _unit skillFinal _x];
	} forEach _skills;

_output
};

err_ai_fnc_setSkills = {
	params ["_unit"];

	// See https://community.bistudio.com/wiki/Arma_3_AI_Skill#Sub-Skills.

	// aimingAccuracy:
	// Higher value means the AI can lead a target better
	// Higher value means the Ai can estimate range and calculate bullet drop more precicely
	// Higher value means the AI can compensate weapon dispersion better
	// Higher value means the AI can control the recoil better
	// Higher value means the AI needs to now less to open up fire
	// OPINION: Lowering this in combination with aimingShake may make AI dogshit.
	_x setSkill ["aimingAccuracy", 0.1];

	// aimingShake:
	// Higher value means the AI will be more precise
	// OPINION: Keeping this low is probably crucial.
	_x setSkill ["aimingShake", 0.1];

	// aimingSpeed:
	// Higher value means the AI can rotate and stabilize its aim faster
	// OPINION: OK to have high, as long as accuracy is low.
	// May increase in future. Will improve CQC.
	_x setSkill ["aimingSpeed", 0.5];

	// commanding:
	// Higher value means the AI can report targets faster.
	// OPINION: Should be maxed out, creates player-like communication.
	_x setSkill ["commanding", 1];

	// courage:
	// Higher value means the AI has got more courage (NO SHIT).
	// OPINION: No idea what this does but I think brave AI is probably more fun.
	_x setSkill ["courage", 1];

	// general:
	// Distributed to other sub-skills, unclear as to exact function.
	// Affects AI decision making.
	// OPINION: Max value, decrease other values to compensate.
	// NOTE: Measuring other skills with skillFinal doesn't show effect from `general`.
	_x setSkill ["general", 1];

	// reloadSpeed:
	// Higher value means the AI can switch or reload weapons faster.
	// OPINION: Max is probably equal to player speed.
	_x setSkill ["reloadSpeed", 1];

	// spotDistance:
	// Higher value means the AI is better at spotting targets.
	// Higher value means the AI will collect information about targets more precisely.
	// OPINION: Not 1:1 to actual distance.
	_x setSkill ["spotDistance", 0.5];

	// spotTime:
	// Higher value means the AI will react faster to death, damage or enemies.
	// OPINION: Maxed out to create player-like (not really) reactions.
	// With low accuracy should not be deadly, but feel much better to fight.
	_x setSkill ["spotTime", 1];
};

err_ai_fnc_aiSkillInit = {
	waitUntil {
		{
			if (!(_x getVariable ["err_ai_skillInit", false])) then {
				[_x] call err_ai_fnc_setSkills;
				_x setVariable ["err_ai_skillInit", true, true];
			};
		} forEach allUnits;
		sleep 60;

	false
	};
};