class USMC_D {
    class Base {
        facewear[] = {};

		headgear[] = {"rhsusf_lwh_helmet_marpatd"};

		uniforms[] = {"rhs_uniform_FROG01_d"};

		vests[] = {"rhsusf_spcs_ucp_rifleman"};
		
		backpacks[] = {"rhsusf_assault_eagleaiii_ucp"};

		primaryWeapon = "rhs_weap_m4a1";
		primaryWeaponItems[] = {"rhsusf_acc_compm4", "rhs_acc_2dpzenit_ris"};
		
		secondaryWeapon = "";
		secondaryWeaponItems[] = {};

		handgun = "";
		handgunItems[] = {};

		binoculars = "";

		items[] = {"ItemMap", "ItemCompass", "ItemWatch"};

		radios[] = {RIFLEMAN_RADIO};

		uniformItems[] = {
			{"ACE_fieldDressing", 4},
			{"ACE_morphine", 1},
			{"ACE_epinephrine", 1},
		};

		vestItems[] = {
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "50%"},
        };

		backpackItems[] = {
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "50%"},
            {"rhs_mag_m67", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
		};
    };

    class SL: Base {
		headgear[] = {"rhs_8point_marpatd"};

		vests[] = {"rhsusf_spcs_ucp_squadleader"};

		primaryWeapon = "rhs_weap_m4a1_m203";
		handgun = "rhsusf_weap_m9";

		binoculars = "Binocular";

		radios[] = {RIFLEMAN_RADIO, SHORT_RANGE_RADIO};

		vestItems[] = {
            {"rhsusf_mag_15Rnd_9x19_FMJ", 3},
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "75%"},
        };

		backpackItems[] = {
            {"rhs_mag_M433_HEDP", 4},
            {"rhs_mag_m714_white", 4},
            {"rhs_mag_m714_red", 4},
            {"rhs_mag_m67", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "10%"},
		};
    };

    class FTL: SL {
		headgear[] = {"rhsusf_lwh_helmet_marpatd_ess"};

		vests[] = {"rhsusf_spcs_ucp_teamleader"};

		radios[] = {RIFLEMAN_RADIO};
    };

    class Medic: Base {
		vests[] = {"rhsusf_spcs_ucp_medic"};

		radios[] = {RIFLEMAN_RADIO, SHORT_RANGE_RADIO};

        uniformItems[] = {
			{"SmokeShellGreen", 3},
		};

		vestItems[] = {
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "100%"},
        };

		backpackItems[] = {
			{"ACE_fieldDressing", 30},
			{"ACE_morphine", 20},
			{"ACE_epinephrine", 20},
			{"ACE_bloodIV_500", 15},
			{"ACE_splint", 5},
		};
    };

    class AR: Base {
		primaryWeapon = "rhs_weap_m249_pip";

		handgun = "rhsusf_weap_m9";

		vestItems[] = {
            {"rhsusf_mag_15Rnd_9x19_FMJ", 3},
            {"rhsusf_100Rnd_556x45_M855_soft_pouch", "50%"},
        };

		backpackItems[] = {
            {"rhsusf_100Rnd_556x45_M855_soft_pouch", "50%"},
            {"rhs_mag_m67", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
		};
    };

    class AAR: Base {
		binoculars = "Binocular";

		vestItems[] = {
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "75%"},
        };

		backpackItems[] = {
            {"rhs_mag_30Rnd_556x45_M855_Stanag", "25%"},
            {"rhsusf_100Rnd_556x45_M855_soft_pouch", "50%"},
            {"rhs_mag_m67", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
		};
    };

    class RAT: Base {
		primaryWeapon = "rhs_weap_m16a4";
        secondaryWeapon = "rhs_weap_M136";
    };
};