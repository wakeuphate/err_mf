class RU {
    class Base {
        facewear[] = {};
		headgear[] = {"rhs_6b27m_green"};
		uniforms[] = {"rhs_uniform_gorka_1_a"};
		vests[] = {"rhs_6b23_rifleman"};
		backpacks[] = {"rhs_assault_umbts"};

		primaryWeapon = "rhs_weap_ak74m";
		primaryWeaponItems[] = {"rhs_acc_pkas", "rhs_acc_2dpzenit"};
		
		secondaryWeapon = "";
		secondaryWeaponItems[] = {};

		handgun = "";
		handgunItems[] = {};

		binoculars = "";

		items[] = {"ItemMap", "ItemCompass", "ItemWatch"};

		radio = RIFLEMAN_RADIO;

		uniformItems[] = {
			{"ACE_fieldDressing", 4},
			{"ACE_morphine", 1},
			{"ACE_epinephrine", 1},
		};

		vestItems[] = {
            {"rhs_30Rnd_545x39_7N10_AK", "50%"},
        };

		backpackItems[] = {
            {"rhs_30Rnd_545x39_7N10_AK", "50%"},
            {"rhs_mag_rgn", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
		};
    };

    class SL: Base {
		headgear[] = {"rhs_fieldcap_khk"};
		backpacks[] = {"tf_mr3000_bwmod"};

		primaryWeapon = "rhs_weap_ak74m_gp25";
		handgun = "rhs_weap_makarov_pm";

		binoculars = "Binocular";

		radio = SHORT_RANGE_RADIO;

		vestItems[] = {
            {"rhs_mag_9x18_8_57N181S", 3},
            {"rhs_30Rnd_545x39_7N10_AK", "75%"},
        };

		backpackItems[] = {
            {"rhs_VOG25", 4},
            {"rhs_VG400P_white", 4},
            {"rhs_VG400P_red", 4},
            {"rhs_mag_rgn", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
            {"rhs_30Rnd_545x39_7N10_AK", 5},
		};
    };

    class FTL: SL {
		headgear[] = {"rhs_6b27m_green"};
		radio = RIFLEMAN_RADIO;
    };

    class Medic: Base {
		radio = SHORT_RANGE_RADIO;

        uniformItems[] = {
			{"SmokeShellGreen", 3},
		};

		vestItems[] = {
            {"rhs_30Rnd_545x39_7N10_AK", "100%"},
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
		primaryWeapon = "rhs_weap_pkp";

		handgun = "rhs_weap_makarov_pm";

		vestItems[] = {
            {"rhs_mag_9x18_8_57N181S", 3},
            {"rhs_100Rnd_762x54mmR", 1},
        };

		backpackItems[] = {
            {"rhs_100Rnd_762x54mmR", 2},
            {"rhs_mag_rgn", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
		};
    };

    class AAR: Base {
		binoculars = "Binocular";

		vestItems[] = {
            {"rhs_30Rnd_545x39_7N10_AK", "75%"},
        };

		backpackItems[] = {
            {"rhs_30Rnd_545x39_7N10_AK", "25%"},
            {"rhs_100Rnd_762x54mmR", 1},
            {"rhs_mag_rgn", 2},
			{"SmokeShellBlue", 2},
			{"SmokeShellYellow", 2},
		};
    };

    class RAT: Base {
        secondaryWeapon = "rhs_weap_rpg26";
    };
};