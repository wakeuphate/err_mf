// Custom gear configs.
class Gear {
	#define SHORT_RANGE_RADIO "tf_anprc148jem"
	#define RIFLEMAN_RADIO "tf_anprc154"

	#include "gear\configs\RU.h"
	#include "gear\configs\USMC_WD.h"
	#include "gear\configs\USMC_D.h"
};

// Functions in cfgFunctions are loaded before the game begins, and can be used in unit init fields.
class cfgFunctions {
	class err_gear {
		class Assign {
			file = "err\gear";
			class assignGear {};
		};
	};
};
