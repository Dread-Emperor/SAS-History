libname ALMAUPDL '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\AU\PDL';
libname JEFF '\\bcsap0010\sasdata\SAS Data\Jeffrey\SASdata';
libname DEBTLOAD '\\bcsap0010\sasdata\SAS Data\Monthly Load\debtload';
libname sdata '\\bcsap0010\sasdata\SAS Data\Monthly Load';
libname dmart odbc Datasrc=datamart schema=dbo;
libname DILAN '\\bcsap0010\sasdata\SAS Data\Dilan\SASdata';




%let Rptdte='31Jan2015'd;

/*option mprint mlogic symbolgen;*/
%let Periods=13;
%let cutoffdate1='31Jan2009'd;
%let cutoffdate2='31Jul2009'd;
%let cutoffdate3='31Jan2010'd;
%let cutoffdate4='31Jul2010'd;
%let cutoffdate5='31Jan2011'd;
%let cutoffdate6='31Jul2011'd;
%let cutoffdate7='31Jan2012'd;
%let cutoffdate8='31Jul2012'd;
%let cutoffdate9='31Jan2013'd;
%let cutoffdate10='31Jul2013'd;
%let cutoffdate11='31Jan2014'd;
%let cutoffdate12='31Jul2014'd;
%let cutoffdate13='31Jan2015'd;


/*Looped Predictions Macro*/

%macro alltime();
%do looped =1 %to &Periods.;
%let cutoffdate=&&cutoffdate&looped..;
/*data &data_set.;*/
/*	set &data_set.;*/
/*	age_since_loaded = ceil(((&cutoffdate. - loaded_date)/365.25)*2);*/
/*	run;*/

/*Insert modified pricing prediction macro here*/


%macro banking_proportion_00(x=,y=);
%let var_list =
	Interceptp21_coeff
	age_since_loaded_bandp22_coeff
	age_since_loaded_bandp23_coeff
	loaded_amount_band_0p24_coeff
	loaded_amount_band_20p25_coeff
	loaded_amount_band_12p26_coeff
	portfolio_50p27_coeff
	portfolio_50p28_coeff
	portfolio_50p29_coeff
	portfolio_50p210_coeff
	portfolio_50p211_coeff
	portfolio_50p212_coeff
	portfolio_50p213_coeff
	portfolio_50p214_coeff
	portfolio_50p215_coeff
	portfolio_50p216_coeff
	portfolio_50p217_coeff
	portfolio_50p218_coeff
	debtor_age_at_load_bap219_coeff
	debtor_age_at_load_bap220_coeff
	phone_count_99p221_coeff
	phone_count_99p222_coeff
	phone_count_99p223_coeff
	phone_count_99p224_coeff
	c_last_payment_to_loap225_coeff
	c_last_payment_to_loap226_coeff
	gender_2p227_coeff
	gender_2p228_coeff
	percentile_ranking_stp229_coeff
	percentile_ranking_stp230_coeff
	latest_payment_after_p231_coeff
	latest_payment_after_p232_coeff
	latest_payment_after_p233_coeff
	latest_payment_after_p234_coeff
	latest_payment_after_p235_coeff
	latest_payment_after_p236_coeff
	latest_payment_after_p237_coeff
	legal_2p238_coeff
	legal_2p239_coeff
	legal_2p240_coeff
	bankrupt_2p241_coeff
	bankrupt_2p242_coeff
	bin_open_to_loadp243_coeff
	bin_open_to_loadp244_coeff
	open_n_1p245_coeff
	open_n_5p246_coeff
;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\banking_model_adjustments_AU_Reforecast.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\banking_model_adjustments_neebucket.xlsx"*/
out = jeff.banking_factors_00 replace
dbms = excel;
sheet = "reforecast proportion";
run;
/*Table name with coefficients goes here*/
%let file = jeff.banking_factors_00;

%let _k = 1;
%do %while (%scan(&var_list.,&_k.,' ') ne);
 	%let var = %scan(&var_list.,&_k.,' ');
	data temp;
		set &file.;
		cvalue = put(value,10.8);
		test = symget('var');
		if factor = test;
		run;
	data _null_;
		set temp;
		call symput(factor,cvalue);
		run;
		%let _k = %eval(&_k.+1);
	%end;
	%put _USER_;


data &y;
	set &x;	
	
	portfolio_50p27 = 0;
	portfolio_50p28 = 0;
	portfolio_50p29 = 0;
	portfolio_50p210 = 0;
	portfolio_50p211 = 0;
	portfolio_50p212 = 0;
	portfolio_50p213 = 0;
	portfolio_50p214 = 0;
	portfolio_50p215 = 0;
	portfolio_50p216 = 0;
	portfolio_50p217 = 0;
	portfolio_50p218 = 0;
	debtor_age_at_load_bap219 = 0;
	debtor_age_at_load_bap220 = 0;
	phone_count_99p221 = 0;
	phone_count_99p222 = 0;
	phone_count_99p223 = 0;
	phone_count_99p224 = 0;
	c_last_payment_to_loap225 = 0;
	c_last_payment_to_loap226 = 0;
	gender_2p227 = 0;
	gender_2p228 = 0;
	percentile_ranking_stp229 = 0;
	percentile_ranking_stp230 = 0;
	latest_payment_after_p231 = 0;
	latest_payment_after_p232 = 0;
	latest_payment_after_p233 = 0;
	latest_payment_after_p234 = 0;
	latest_payment_after_p235 = 0;
	latest_payment_after_p236 = 0;
	latest_payment_after_p237 = 0;
	legal_2p238 = 0;
	legal_2p239 = 0;
	legal_2p240 = 0;
	bankrupt_2p241 = 0;
	bankrupt_2p242 = 0;
	bin_open_to_loadp243 = 0;
	bin_open_to_loadp244 = 0;

	if portfolio_50 = 'ANZ' then portfolio_50p27 = 1;
	if portfolio_50 = 'BMW' then portfolio_50p28 = 1;
	if portfolio_50 = 'Capital Finance' then portfolio_50p29 = 1;
	if portfolio_50 = 'FlexiGroup' then portfolio_50p210 = 1;
	if portfolio_50 = 'Ford Credit' then portfolio_50p211 = 1;
	if portfolio_50 = 'GE' then portfolio_50p212 = 1;
	if portfolio_50 = 'Macquarie' then portfolio_50p213 = 1;
	if portfolio_50 = 'NAB' then portfolio_50p214 = 1;
	if portfolio_50 = 'Radio Rentals' then portfolio_50p215 = 1;
	if portfolio_50 = 'St George' then portfolio_50p216 = 1;
	if portfolio_50 = 'Westpac' then portfolio_50p217 = 1;
	if portfolio_50 = 'zCBA' then portfolio_50p218 = 1;
	if debtor_age_at_load_band_3 = '2: 25 - 34 Yrs' then debtor_age_at_load_bap219 = 1;
	if debtor_age_at_load_band_3 = 'zAll Other Age' then debtor_age_at_load_bap220 = 1;
	if phone_count_99 = '1' then phone_count_99p221 = 1;
	if phone_count_99 = '2' then phone_count_99p222 = 1;
	if phone_count_99 = '3' then phone_count_99p223 = 1;
	if phone_count_99 = 'z0' then phone_count_99p224 = 1;
	if c_last_payment_to_loaded_3 = '0-5 months' then c_last_payment_to_loap225 = 1;
	if c_last_payment_to_loaded_3 = 'z6+ months' then c_last_payment_to_loap226 = 1;
	if gender_2 = 'F' then gender_2p227 = 1;
	if gender_2 = 'M' then gender_2p228 = 1;
	if percentile_ranking_state_3 = '0-75' then percentile_ranking_stp229 = 1;
	if percentile_ranking_state_3 = '75-100' then percentile_ranking_stp230 = 1;
	if latest_payment_after_load_2 = '1-1.5' then latest_payment_after_p231 = 1;
	if latest_payment_after_load_2 = '1.5-2' then latest_payment_after_p232 = 1;
	if latest_payment_after_load_2 = '2-3.5' then latest_payment_after_p233 = 1;
	if latest_payment_after_load_2 = '3.5-4.5' then latest_payment_after_p234 = 1;
	if latest_payment_after_load_2 = '4.5-5' then latest_payment_after_p235 = 1;
	if latest_payment_after_load_2 = '5+' then latest_payment_after_p236 = 1;
	if latest_payment_after_load_2 = 'z0-1' then latest_payment_after_p237 = 1;
	if legal_2 = '0-0.25' then legal_2p238 = 1;
	if legal_2 = '0.75-1' then legal_2p239 = 1;
	if legal_2 = 'z0.25-0.75' then legal_2p240 = 1;
	if bankrupt_2 = '0-0.5' then bankrupt_2p241 = 1;
	if bankrupt_2 = 'z0 or 0.5-1' then bankrupt_2p242 = 1;
	if bin_open_to_load = 'Missing' then bin_open_to_loadp243 = 1;
	if bin_open_to_load = 'Not Missing' then bin_open_to_loadp244 = 1;

	xbeta_00 = 
	&Interceptp21_coeff. +
	&age_since_loaded_bandp22_coeff.*max(0,age_since_loaded-2)/1 +
	&age_since_loaded_bandp23_coeff.*max(0,age_since_loaded-6)/1 +
	&loaded_amount_band_0p24_coeff.*max(0,loaded_amount-0)/10000 +
	&loaded_amount_band_20p25_coeff.*max(0,loaded_amount-2000)/10000 +
	&loaded_amount_band_12p26_coeff.*max(0,loaded_amount-12000)/10000 +
	&portfolio_50p27_coeff.*portfolio_50p27 +
	&portfolio_50p28_coeff.*portfolio_50p28 +
	&portfolio_50p29_coeff.*portfolio_50p29 +
	&portfolio_50p210_coeff.*portfolio_50p210 +
	&portfolio_50p211_coeff.*portfolio_50p211 +
	&portfolio_50p212_coeff.*portfolio_50p212 +
	&portfolio_50p213_coeff.*portfolio_50p213 +
	&portfolio_50p214_coeff.*portfolio_50p214 +
	&portfolio_50p215_coeff.*portfolio_50p215 +
	&portfolio_50p216_coeff.*portfolio_50p216 +
	&portfolio_50p217_coeff.*portfolio_50p217 +
	&portfolio_50p218_coeff.*portfolio_50p218 +
	&debtor_age_at_load_bap219_coeff.*debtor_age_at_load_bap219 +
	&debtor_age_at_load_bap220_coeff.*debtor_age_at_load_bap220 +
	&phone_count_99p221_coeff.*phone_count_99p221 +
	&phone_count_99p222_coeff.*phone_count_99p222 +
	&phone_count_99p223_coeff.*phone_count_99p223 +
	&phone_count_99p224_coeff.*phone_count_99p224 +
	&c_last_payment_to_loap225_coeff.*c_last_payment_to_loap225 +
	&c_last_payment_to_loap226_coeff.*c_last_payment_to_loap226 +
	&gender_2p227_coeff.*gender_2p227 +
	&gender_2p228_coeff.*gender_2p228 +
	&percentile_ranking_stp229_coeff.*percentile_ranking_stp229 +
	&percentile_ranking_stp230_coeff.*percentile_ranking_stp230 +
	&latest_payment_after_p231_coeff.*latest_payment_after_p231 +
	&latest_payment_after_p232_coeff.*latest_payment_after_p232 +
	&latest_payment_after_p233_coeff.*latest_payment_after_p233 +
	&latest_payment_after_p234_coeff.*latest_payment_after_p234 +
	&latest_payment_after_p235_coeff.*latest_payment_after_p235 +
	&latest_payment_after_p236_coeff.*latest_payment_after_p236 +
	&latest_payment_after_p237_coeff.*latest_payment_after_p237 +
	&legal_2p238_coeff.*legal_2p238 +
	&legal_2p239_coeff.*legal_2p239 +
	&legal_2p240_coeff.*legal_2p240 +
	&bankrupt_2p241_coeff.*bankrupt_2p241 +
	&bankrupt_2p242_coeff.*bankrupt_2p242 +
	&bin_open_to_loadp243_coeff.*bin_open_to_loadp243 +
	&bin_open_to_loadp244_coeff.*bin_open_to_loadp244 +
	&open_n_1p245_coeff.*max(0,open_to_load-1)/1 +
	&open_n_5p246_coeff.*max(0,open_to_load-5)/1;

	mu_00 = exp(xbeta_00);
	run;
%mend banking_proportion_00;

%macro banking_probability_10(a=,b=);
%let var_list =
	Interceptb1_coeff
	open_n_1b2_coeff
	open_n_3b3_coeff
	open_n_14b4_coeff
	loaded_n_200b5_coeff
	loaded_n_400b6_coeff
	loaded_n_2000b7_coeff
	age_since_loaded_n_0b8_coeff
	age_since_loaded_n_3b9_coeff
	age_since_loaded_n_8b10_coeff
	unemployment_rate_2b11_coeff
	unemployment_rate_2b12_coeff
	unemployment_rate_2b13_coeff
	unemployment_rate_2b14_coeff
	phone_count_9b15_coeff
	phone_count_9b16_coeff
	phone_count_9b17_coeff
	phone_count_9b18_coeff
	Product_1b19_coeff
	Product_1b20_coeff
	Product_1b21_coeff
	Portfolio_2b22_coeff
	Portfolio_2b23_coeff
	Portfolio_2b24_coeff
	Portfolio_2b25_coeff
	Portfolio_2b26_coeff
	Portfolio_2b27_coeff
	Portfolio_2b28_coeff
	Portfolio_2b29_coeff
	Portfolio_2b30_coeff
	Portfolio_2b31_coeff
	last_payment_to_loadeb32_coeff
	last_payment_to_loadeb33_coeff
	last_payment_to_loadeb34_coeff
	last_payment_to_loadeb35_coeff
	last_payment_to_loadeb36_coeff
	last_payment_to_loadeb37_coeff
	last_payment_to_loadeb38_coeff
	percentile_ranking_stb39_coeff
	percentile_ranking_stb40_coeff
	percentile_ranking_stb41_coeff
	last_payment_band_2b42_coeff
	last_payment_band_2b43_coeff
	last_payment_band_2b44_coeff
	debtor_age_at_load_bab45_coeff
	debtor_age_at_load_bab46_coeff
	debtor_age_at_load_bab47_coeff
	debtor_age_at_load_bab48_coeff
	drivers_licence_1b49_coeff
	drivers_licence_1b50_coeff
	drivers_licence_1b51_coeff
	residential_state_namb52_coeff
	residential_state_namb53_coeff
	residential_state_namb54_coeff
	residential_state_namb55_coeff
	residential_state_namb56_coeff
	residential_state_namb57_coeff
	prod_desc_2b58_coeff
	prod_desc_2b59_coeff
	prod_desc_2b60_coeff
	prod_desc_2b61_coeff
	gender_2b62_coeff
	gender_2b63_coeff
	inventory_1b64_coeff
	inventory_1b65_coeff
	interest_rate_2b66_coeff
	interest_rate_2b67_coeff
;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\banking_model_adjustments_AU_Reforecast.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\banking_model_adjustments_neebucket.xlsx"*/
out = jeff.banking_factors_10 replace
dbms = excel;
sheet = "pricing-reforecast probability";
run;
/*Table name with coefficients goes here*/
%let file = jeff.banking_factors_10;

%let _k = 1;
%do %while (%scan(&var_list.,&_k.,' ') ne);
 	%let var = %scan(&var_list.,&_k.,' ');
	data temp;
		set &file.;
		cvalue = put(value,10.8);
		test = symget('var');
		if factor = test;
		run;
	data _null_;
		set temp;
		call symput(factor,cvalue);
		run;
		%let _k = %eval(&_k.+1);
	%end;
	%put _USER_;


data &b;
	set &a;		

	unemployment_rate_2b11 = 0;
	unemployment_rate_2b12 = 0;
	unemployment_rate_2b13 = 0;
	unemployment_rate_2b14 = 0;
	phone_count_9b15 = 0;
	phone_count_9b16 = 0;
	phone_count_9b17 = 0;
	phone_count_9b18 = 0;
	Product_1b19 = 0;
	Product_1b20 = 0;
	Product_1b21 = 0;
	Portfolio_2b22 = 0;
	Portfolio_2b23 = 0;
	Portfolio_2b24 = 0;
	Portfolio_2b25 = 0;
	Portfolio_2b26 = 0;
	Portfolio_2b27 = 0;
	Portfolio_2b28 = 0;
	Portfolio_2b29 = 0;
	Portfolio_2b30 = 0;
	Portfolio_2b31 = 0;
	last_payment_to_loadeb32 = 0;
	last_payment_to_loadeb33 = 0;
	last_payment_to_loadeb34 = 0;
	last_payment_to_loadeb35 = 0;
	last_payment_to_loadeb36 = 0;
	last_payment_to_loadeb37 = 0;
	last_payment_to_loadeb38 = 0;
	percentile_ranking_stb39 = 0;
	percentile_ranking_stb40 = 0;
	percentile_ranking_stb41 = 0;
	last_payment_band_2b42 = 0;
	last_payment_band_2b43 = 0;
	last_payment_band_2b44 = 0;
	debtor_age_at_load_bab45 = 0;
	debtor_age_at_load_bab46 = 0;
	debtor_age_at_load_bab47 = 0;
	debtor_age_at_load_bab48 = 0;
	drivers_licence_1b49 = 0;
	drivers_licence_1b50 = 0;
	drivers_licence_1b51 = 0;
	residential_state_namb52 = 0;
	residential_state_namb53 = 0;
	residential_state_namb54 = 0;
	residential_state_namb55 = 0;
	residential_state_namb56 = 0;
	residential_state_namb57 = 0;
	prod_desc_2b58 = 0;
	prod_desc_2b59 = 0;
	prod_desc_2b60 = 0;
	prod_desc_2b61 = 0;
	gender_2b62 = 0;
	gender_2b63 = 0;
	inventory_1b64 = 0;
	inventory_1b65 = 0;
	interest_rate_2b66 = 0;
	interest_rate_2b67 = 0;

	if unemployment_rate_2 = '0.049-0.051' then unemployment_rate_2b11 = 1;
	if unemployment_rate_2 = '0.051-0.056' then unemployment_rate_2b12 = 1;
	if unemployment_rate_2 = '0.06+' then unemployment_rate_2b13 = 1;
	if unemployment_rate_2 = 'z0.056-0.06' then unemployment_rate_2b14 = 1;
	if phone_count_9 = '1' then phone_count_9b15 = 1;
	if phone_count_9 = '2' then phone_count_9b16 = 1;
	if phone_count_9 = '3' then phone_count_9b17 = 1;
	if phone_count_9 = 'z0' then phone_count_9b18 = 1;
	if Product_1 = 'Banking' then Product_1b19 = 1;
	if Product_1 = 'Finance' then Product_1b20 = 1;
	if Product_1 = 'zCredit Card/Car Loan/Personal' then Product_1b21 = 1;
	if Portfolio_2 = 'ANZ' then Portfolio_2b22 = 1;
	if Portfolio_2 = 'BMW' then Portfolio_2b23 = 1;
	if Portfolio_2 = 'Capital Finance' then Portfolio_2b24 = 1;
	if Portfolio_2 = 'FlexiGroup' then Portfolio_2b25 = 1;
	if Portfolio_2 = 'Ford Credit' then Portfolio_2b26 = 1;
	if Portfolio_2 = 'GE' then Portfolio_2b27 = 1;
	if Portfolio_2 = 'Macq/NAB' then Portfolio_2b28 = 1;
	if Portfolio_2 = 'St George' then Portfolio_2b29 = 1;
	if Portfolio_2 = 'Westpac' then Portfolio_2b30 = 1;
	if Portfolio_2 = 'zCBA/RR' then Portfolio_2b31 = 1;
	if last_payment_to_loaded_2 = '0-6' then last_payment_to_loadeb32 = 1;
	if last_payment_to_loaded_2 = '12-24' then last_payment_to_loadeb33 = 1;
	if last_payment_to_loaded_2 = '24-36' then last_payment_to_loadeb34 = 1;
	if last_payment_to_loaded_2 = '36-48' then last_payment_to_loadeb35 = 1;
	if last_payment_to_loaded_2 = '48+' then last_payment_to_loadeb36 = 1;
	if last_payment_to_loaded_2 = 'Miss' then last_payment_to_loadeb37 = 1;
	if last_payment_to_loaded_2 = 'z6-12' then last_payment_to_loadeb38 = 1;
	if percentile_ranking_state_2 = '0-40' then percentile_ranking_stb39 = 1;
	if percentile_ranking_state_2 = '40-60' then percentile_ranking_stb40 = 1;
	if percentile_ranking_state_2 = 'z60-100' then percentile_ranking_stb41 = 1;
	if last_payment_band_2 = '1:0' then last_payment_band_2b42 = 1;
	if last_payment_band_2 = '3:2000+' then last_payment_band_2b43 = 1;
	if last_payment_band_2 = 'z2:0-2000' then last_payment_band_2b44 = 1;
	if debtor_age_at_load_band_1 = '1: 18 - 24 Yrs' then debtor_age_at_load_bab45 = 1;
	if debtor_age_at_load_band_1 = '3: 35 - 44 Yrs' then debtor_age_at_load_bab46 = 1;
	if debtor_age_at_load_band_1 = '4: 45 Yrs +' then debtor_age_at_load_bab47 = 1;
	if debtor_age_at_load_band_1 = 'Base: 25 - 34' then debtor_age_at_load_bab48 = 1;
	if drivers_licence_1 = 'Mis' then drivers_licence_1b49 = 1;
	if drivers_licence_1 = 'No' then drivers_licence_1b50 = 1;
	if drivers_licence_1 = 'zYe' then drivers_licence_1b51 = 1;
	if residential_state_name_1 = 'ACT' then residential_state_namb52 = 1;
	if residential_state_name_1 = 'OTH' then residential_state_namb53 = 1;
	if residential_state_name_1 = 'SA' then residential_state_namb54 = 1;
	if residential_state_name_1 = 'TAS' then residential_state_namb55 = 1;
	if residential_state_name_1 = 'WA' then residential_state_namb56 = 1;
	if residential_state_name_1 = 'zNS' then residential_state_namb57 = 1;
	if prod_desc_2 = 'Bank Card' then prod_desc_2b58 = 1;
	if prod_desc_2 = 'Business' then prod_desc_2b59 = 1;
	if prod_desc_2 = 'Buyers Edge' then prod_desc_2b60 = 1;
	if prod_desc_2 = 'zMaster/AMEX/Vis/Rent/?/CLine' then prod_desc_2b61 = 1;
	if gender_2 = 'F' then gender_2b62 = 1;
	if gender_2 = 'M' then gender_2b63 = 1;
	if inventory_1 = 'inventory' then inventory_1b64 = 1;
	if inventory_1 = 'zForward Flo' then inventory_1b65 = 1;
	if interest_rate_2 = '0-15&?' then interest_rate_2b66 = 1;
	if interest_rate_2 = 'z15+' then interest_rate_2b67 = 1;

	xbeta_10 = 
	&Interceptb1_coeff. +
	&open_n_1b2_coeff.*max(0,open_to_load-1)/1 +
	&open_n_3b3_coeff.*max(0,open_to_load-3)/1 +
	&open_n_14b4_coeff.*max(0,open_to_load-14)/1 +
	&loaded_n_200b5_coeff.*max(0,loaded_amount-200)/10000 +
	&loaded_n_400b6_coeff.*max(0,loaded_amount-400)/10000 +
	&loaded_n_2000b7_coeff.*max(0,loaded_amount-2000)/10000 +
	&age_since_loaded_n_0b8_coeff.*max(0,age_since_loaded-0)/1 +
	&age_since_loaded_n_3b9_coeff.*max(0,age_since_loaded-3)/1 +
	&age_since_loaded_n_8b10_coeff.*max(0,age_since_loaded-8)/1 +
	&unemployment_rate_2b11_coeff.*unemployment_rate_2b11 +
	&unemployment_rate_2b12_coeff.*unemployment_rate_2b12 +
	&unemployment_rate_2b13_coeff.*unemployment_rate_2b13 +
	&unemployment_rate_2b14_coeff.*unemployment_rate_2b14 +
	&phone_count_9b15_coeff.*phone_count_9b15 +
	&phone_count_9b16_coeff.*phone_count_9b16 +
	&phone_count_9b17_coeff.*phone_count_9b17 +
	&phone_count_9b18_coeff.*phone_count_9b18 +
	&Product_1b19_coeff.*Product_1b19 +
	&Product_1b20_coeff.*Product_1b20 +
	&Product_1b21_coeff.*Product_1b21 +
	&Portfolio_2b22_coeff.*Portfolio_2b22 +
	&Portfolio_2b23_coeff.*Portfolio_2b23 +
	&Portfolio_2b24_coeff.*Portfolio_2b24 +
	&Portfolio_2b25_coeff.*Portfolio_2b25 +
	&Portfolio_2b26_coeff.*Portfolio_2b26 +
	&Portfolio_2b27_coeff.*Portfolio_2b27 +
	&Portfolio_2b28_coeff.*Portfolio_2b28 +
	&Portfolio_2b29_coeff.*Portfolio_2b29 +
	&Portfolio_2b30_coeff.*Portfolio_2b30 +
	&Portfolio_2b31_coeff.*Portfolio_2b31 +
	&last_payment_to_loadeb32_coeff.*last_payment_to_loadeb32 +
	&last_payment_to_loadeb33_coeff.*last_payment_to_loadeb33 +
	&last_payment_to_loadeb34_coeff.*last_payment_to_loadeb34 +
	&last_payment_to_loadeb35_coeff.*last_payment_to_loadeb35 +
	&last_payment_to_loadeb36_coeff.*last_payment_to_loadeb36 +
	&last_payment_to_loadeb37_coeff.*last_payment_to_loadeb37 +
	&last_payment_to_loadeb38_coeff.*last_payment_to_loadeb38 +
	&percentile_ranking_stb39_coeff.*percentile_ranking_stb39 +
	&percentile_ranking_stb40_coeff.*percentile_ranking_stb40 +
	&percentile_ranking_stb41_coeff.*percentile_ranking_stb41 +
	&last_payment_band_2b42_coeff.*last_payment_band_2b42 +
	&last_payment_band_2b43_coeff.*last_payment_band_2b43 +
	&last_payment_band_2b44_coeff.*last_payment_band_2b44 +
	&debtor_age_at_load_bab45_coeff.*debtor_age_at_load_bab45 +
	&debtor_age_at_load_bab46_coeff.*debtor_age_at_load_bab46 +
	&debtor_age_at_load_bab47_coeff.*debtor_age_at_load_bab47 +
	&debtor_age_at_load_bab48_coeff.*debtor_age_at_load_bab48 +
	&drivers_licence_1b49_coeff.*drivers_licence_1b49 +
	&drivers_licence_1b50_coeff.*drivers_licence_1b50 +
	&drivers_licence_1b51_coeff.*drivers_licence_1b51 +
	&residential_state_namb52_coeff.*residential_state_namb52 +
	&residential_state_namb53_coeff.*residential_state_namb53 +
	&residential_state_namb54_coeff.*residential_state_namb54 +
	&residential_state_namb55_coeff.*residential_state_namb55 +
	&residential_state_namb56_coeff.*residential_state_namb56 +
	&residential_state_namb57_coeff.*residential_state_namb57 +
	&prod_desc_2b58_coeff.*prod_desc_2b58 +
	&prod_desc_2b59_coeff.*prod_desc_2b59 +
	&prod_desc_2b60_coeff.*prod_desc_2b60 +
	&prod_desc_2b61_coeff.*prod_desc_2b61 +
	&gender_2b62_coeff.*gender_2b62 +
	&gender_2b63_coeff.*gender_2b63 +
	&inventory_1b64_coeff.*inventory_1b64 +
	&inventory_1b65_coeff.*inventory_1b65 +
	&interest_rate_2b66_coeff.*interest_rate_2b66 +
	&interest_rate_2b67_coeff.*interest_rate_2b67;

	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend banking_probability_10;

%macro banking_forecast (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
/*	where Loaded_Date < '1Jan2009'd;*/
/*	where Loaded_Date <= '1Jan2009'd and status = 'Open';*/
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\AU\PDL\Reforecast\Banking_Proportion_Reforecast_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded+12;*/
/*	age_since_loaded = max(0,stat_bar);*/
/*	age_since_loaded = min(max(0,stat_bar),12);*/
/*	age_since_loaded = min(max(0,stat_bar),age_since_loaded+12);*/
/*	age_since_loaded = 12;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

/*%banking_proportion_00(x=dilan.bank_buck_fore_pred,y=dilan.bank_buck_fore_pred_1)*/
/*%banking_proportion_00(x=dilan.bank_buck_fore_pred_12,y=dilan.bank_buck_fore_pred_1_12)*/
/*%banking_proportion_00(x=dilan.bank_buck_fore_pred_a12,y=dilan.bank_buck_fore_pred_1_a12)*/
/*%banking_proportion_00(x=dilan.bank_buck_fore_pred_sbar,y=dilan.bank_buck_fore_pred_1_sbar)*/
/*%banking_proportion_00(x=dilan.bank_buck_fore_pred_new,y=dilan.bank_buck_fore_pred_1_new)*/
/*%banking_proportion_00(x=dilan.bank_buck_fore_pred_cap,y=dilan.bank_buck_fore_pred_1_cap)*/
%banking_proportion_00(x=dilan.bnfp,y=dilan.bnfp_1)

data &a;
	set &infile;
/*	where Loaded_Date < '1Jan2009'd;*/
/*	where Loaded_Date <= '1Jan2009'd and status = 'Open';*/
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\AU\PDL\Reforecast\Banking_Probability_Pricing&Reforecast_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded+12;*/
/*	age_since_loaded = max(0,stat_bar);*/
/*	age_since_loaded = min(max(0,stat_bar),12);*/
/*	age_since_loaded = min(max(0,stat_bar),age_since_loaded+12);*/
/*	age_since_loaded = 11;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

/*%banking_probability_10(a=dilan.bank_buck_fore_pred_2,b=dilan.bank_buck_fore_pred_3)*/
/*%banking_probability_10(a=dilan.bank_buck_fore_pred_2_12,b=dilan.bank_buck_fore_pred_3_12)*/
/*%banking_probability_10(a=dilan.bank_buck_fore_pred_2_a12,b=dilan.bank_buck_fore_pred_3_a12)*/
/*%banking_probability_10(a=dilan.bank_buck_fore_pred_2_sbar,b=dilan.bank_buck_fore_pred_3_sbar)*/
/*%banking_probability_10(a=dilan.bank_buck_fore_pred_2_new,b=dilan.bank_buck_fore_pred_3_new)*/
/*%banking_probability_10(a=dilan.bank_buck_fore_pred_2_cap,b=dilan.bank_buck_fore_pred_3_cap)*/
%banking_probability_10(a=dilan.bnfp_2,b=dilan.bnfp_3)

data &d;
	set &b (keep = client_ledger_number account_number p_10);
	run;

proc sort data = &d;
	by client_ledger_number account_number;
	run;

proc sort data = &y;
	by client_ledger_number account_number;
	run;

data &e;
	merge &d (in=t1) &y (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

data &f;
	set &e (keep = client_ledger_number account_number loaded_date loaded_amount payments_total current_balance pdl status portfolio mu_00 p_10 age_since_loaded_1 portfolio port_desc product debtor_age_at_load_band prod_desc Gender Phone_Count Residential_State_Name Latest_Payment_After_Load Decile Legal Bankrupt Stat_Bar/* Statue_Barred_Calc*/);
	predicted_payments = mu_00*p_10*loaded_amount;
/*	new_forecast = predicted_payments - payments_total;*/
	run;

proc sql;
	create table &outfile as
	select avg(p_10), Loaded_Amount, Status, Portfolio,	PDL, Payments_Total, Current_Balance, mu_00, predicted_payments, age_since_loaded_1
 	from &f
	group by client_ledger_number, account_number;
	quit
	run;

%mend banking_forecast;



/*%banking_forecast (infile=jeff.historical_accounts_banking_25,x=dilan.bank_buck_fore_pred,y=dilan.bank_buck_fore_pred_1,a=dilan.bank_buck_fore_pred_2,b=dilan.bank_buck_fore_pred_3,d=dilan.bank_buck_fore_pred_4,e=dilan.bank_buck_fore_pred_5,f=dilan.bank_buck_fore_pred_6,outfile=dilan.bank_buck_fore_pred_7);*/
/*%banking_forecast (infile=jeff.historical_accounts_banking_25,x=dilan.bank_buck_fore_pred_12,y=dilan.bank_buck_fore_pred_1_12,a=dilan.bank_buck_fore_pred_2_12,b=dilan.bank_buck_fore_pred_3_12,d=dilan.bank_buck_fore_pred_4_12,e=dilan.bank_buck_fore_pred_5_12,f=dilan.bank_buck_fore_pred_6_12,outfile=dilan.bank_buck_fore_pred_7_12);*/
/*%banking_forecast (infile=jeff.historical_accounts_banking_25,x=dilan.bank_buck_fore_pred_a12,y=dilan.bank_buck_fore_pred_1_a12,a=dilan.bank_buck_fore_pred_2_a12,b=dilan.bank_buck_fore_pred_3_a12,d=dilan.bank_buck_fore_pred_4_a12,e=dilan.bank_buck_fore_pred_5_a12,f=dilan.bank_buck_fore_pred_6_a12,outfile=dilan.bank_buck_fore_pred_7_a12);*/
/*%banking_forecast (infile=jeff.historical_accounts_banking_25,x=dilan.bank_buck_fore_pred_sbar,y=dilan.bank_buck_fore_pred_1_sbar,a=dilan.bank_buck_fore_pred_2_sbar,b=dilan.bank_buck_fore_pred_3_sbar,d=dilan.bank_buck_fore_pred_4_sbar,e=dilan.bank_buck_fore_pred_5_sbar,f=dilan.bank_buck_fore_pred_6_sbar,outfile=dilan.bank_buck_fore_pred_7_sbar);*/
/*%banking_forecast (infile=jeff.historical_accounts_banking_25,x=dilan.bank_buck_fore_pred_new,y=dilan.bank_buck_fore_pred_1_new,a=dilan.bank_buck_fore_pred_2_new,b=dilan.bank_buck_fore_pred_3_new,d=dilan.bank_buck_fore_pred_4_new,e=dilan.bank_buck_fore_pred_5_new,f=dilan.bank_buck_fore_pred_6_new,outfile=dilan.bank_buck_fore_pred_7_new);*/
%banking_forecast (infile=jeff.historical_accounts_banking_15,x=dilan.bnfp,y=dilan.bnfp_1,a=dilan.bnfp_2,b=dilan.bnfp_3,d=dilan.bnfp_4,e=dilan.bnfp_5,f=dilan.bank_nfp_6_&looped.,outfile=dilan.bnfp_7);
/*%banking_forecast (infile=dilan.delete4,x=dilan.bank_new_fore_pred,y=dilan.bank_new_fore_pred_1,a=dilan.bank_new_fore_pred_2,b=dilan.bank_new_fore_pred_3,d=dilan.bank_new_fore_pred_4,e=dilan.bank_new_fore_pred_5,f=dilan.delete5,outfile=dilan.delete6);*/




%end;

%mend alltime;

%alltime;




