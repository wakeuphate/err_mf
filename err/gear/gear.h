class Gear {
	#define SHORT_RANGE_RADIO 1
	#define RIFLEMAN_RADIO 2

	#include "configs\RU.h"
	#include "configs\USMC_WD.h"
	#include "configs\USMC_D.h"
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
