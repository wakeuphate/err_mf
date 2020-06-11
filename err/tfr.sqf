// SR: 30 - 512, 8 channels
// LR: 30 - 87, 9 channels

ERR_TFR_WEST_FREQUENCIES_SR = [
	100, // Starting frequency.
	10, // Gap between frequencies.
	8	// Number of channels.
];

ERR_TFR_WEST_FREQUENCIES_LR = [
	30, // Starting frequency.
	1,  // Gap between frequencies.
	9	// Number of channels.
];

ERR_TFR_EAST_FREQUENCIES_SR = [
	200, // Starting frequency.
	10, // Gap between frequencies.
	8	// Number of channels.
];

ERR_TFR_EAST_FREQUENCIES_LR = [
	50, // Starting frequency.
	1,  // Gap between frequencies.
	9	// Number of channels.
];

ERR_TFR_INDEPENDENT_FREQUENCIES_SR = [
	300, // Starting frequency.
	10, // Gap between frequencies.
	8	// Number of channels.
];

ERR_TFR_INDEPENDENT_FREQUENCIES_LR = [
	70, // Starting frequency.
	1,  // Gap between frequencies.
	9	// Number of channels.
];

err_tfr_fnc_generateFrequencies = {
	params ["_startFreq", "_gap", "_nChannels"];

	private _frequencies = [];
	for "_n" from 0 to (_nChannels - 1) do {
		private _baseFreq = _startFreq + (_n * _gap);
		private _randomDecimal = parseNumber ((random 1) toFixed 1);
		private _actualFreq = format["%1", _baseFreq + _randomDecimal];
		_frequencies pushBack _actualFreq;
	};

_frequencies
};

err_tfr_fnc_constructSettings = {
	params ["_srFreqs", "_lrFreqs"];

	private _srSettings = false call TFAR_fnc_generateSwSettings;
	_srSettings set [2, _srFreqs];

	private _lrSettings = false call TFAR_fnc_generateLrSettings;
	_lrSettings set [2, _lrFreqs];

[_srSettings, _lrSettings]
};

err_tfr_fnc_serverInit = {
	// WEST.
	private _westSrFreqs = ERR_TFR_WEST_FREQUENCIES_SR call err_tfr_fnc_generateFrequencies;
	private _westLrFreqs = ERR_TFR_WEST_FREQUENCIES_LR call err_tfr_fnc_generateFrequencies;
	private _westSettings = [_westSrFreqs, _westLrFreqs] call err_tfr_fnc_constructSettings;

	tf_freq_west = _westSettings #0;
	publicVariable "tf_freq_west";
	tf_freq_west_lr = _westSettings #1;
	publicVariable "tf_freq_west_lr";

	// EAST.
	private _eastSrFreqs = ERR_TFR_EAST_FREQUENCIES_SR call err_tfr_fnc_generateFrequencies;
	private _eastLrFreqs = ERR_TFR_EAST_FREQUENCIES_LR call err_tfr_fnc_generateFrequencies;
	private _eastSettings = [_eastSrFreqs, _eastLrFreqs] call err_tfr_fnc_constructSettings;

	tf_freq_east = _eastSettings #0;
	publicVariable "tf_freq_east";
	tf_freq_east_lr = _eastSettings #1;
	publicVariable "tf_freq_east_lr";

	// GUER.
	private _indepSrFreqs = ERR_TFR_INDEPENDENT_FREQUENCIES_SR call err_tfr_fnc_generateFrequencies;
	private _indepLrFreqs = ERR_TFR_INDEPENDENT_FREQUENCIES_LR call err_tfr_fnc_generateFrequencies;
	private _indepSettings = [_indepSrFreqs, _indepLrFreqs] call err_tfr_fnc_constructSettings;

	tf_freq_guer = _indepSettings #0;
	publicVariable "tf_freq_guer";
	tf_freq_guer_lr = _indepSettings #1;
	publicVariable "tf_freq_guer_lr";
};