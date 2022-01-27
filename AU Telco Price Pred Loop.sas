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

/*Insert modified pricing prediction macro here*/

%macro telco_proportion_00(x=,y=);
%let var_list =

Interceptp1_coeff
age_b0p2_coeff
age_b5p3_coeff
age_b6p4_coeff
loaded_amount_band_b0p5_coeff
loaded_amount_band_b5p6_coeff
loaded_amount_band_b1p7_coeff
loaded_amount_band_b1p8_coeff
Portfolio_1p9_coeff
Portfolio_1p10_coeff
Portfolio_1p11_coeff
Portfolio_1p12_coeff
Prod_desc_1p13_coeff
Prod_desc_1p14_coeff
Prod_desc_1p15_coeff
Prod_desc_1p16_coeff
Prod_desc_1p17_coeff
Prod_desc_1p18_coeff
Residential_state_namp19_coeff
Residential_state_namp20_coeff
Residential_state_namp21_coeff
Residential_state_namp22_coeff
gender_1p23_coeff
gender_1p24_coeff
percentile_ranking_stp25_coeff
percentile_ranking_stp26_coeff
percentile_ranking_stp27_coeff
percentile_ranking_stp28_coeff
last_pay_amt_2p29_coeff
last_pay_amt_2p30_coeff
last_pay_amt_2p31_coeff
last_pay_amt_2p32_coeff
last_pay_amt_2p33_coeff
last_pay_amt_2p34_coeff
inventory_1p35_coeff
inventory_1p36_coeff



;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\telco_model_adjustments_AU_new_pc.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\telco_model_adjustments_SplitPortfolio.xlsx"*/
out = jeff.telco_factors_00 replace
dbms = excel;
sheet = "pricing proportion";
run;
/*Table name with coefficients goes here*/
%let file = jeff.telco_factors_00;

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

Portfolio_1p9 = 0;
Portfolio_1p10 = 0;
Portfolio_1p11 = 0;
Portfolio_1p12 = 0;
Prod_desc_1p13 = 0;
Prod_desc_1p14 = 0;
Prod_desc_1p15 = 0;
Prod_desc_1p16 = 0;
Prod_desc_1p17 = 0;
Prod_desc_1p18 = 0;
Residential_state_namp19 = 0;
Residential_state_namp20 = 0;
Residential_state_namp21 = 0;
Residential_state_namp22 = 0;
gender_1p23 = 0;
gender_1p24 = 0;
percentile_ranking_stp25 = 0;
percentile_ranking_stp26 = 0;
percentile_ranking_stp27 = 0;
percentile_ranking_stp28 = 0;
last_pay_amt_2p29 = 0;
last_pay_amt_2p30 = 0;
last_pay_amt_2p31 = 0;
last_pay_amt_2p32 = 0;
last_pay_amt_2p33 = 0;
last_pay_amt_2p34 = 0;
inventory_1p35 = 0;
inventory_1p36 = 0;





if Portfolio_1 = 'AGL/Optus/Vodafone' then Portfolio_1p9 = 1;
if Portfolio_1 = 'Simply Energy' then Portfolio_1p10 = 1;
if Portfolio_1 = 'TrueEnergy' then Portfolio_1p11 = 1;
if Portfolio_1 = 'zTelstra' then Portfolio_1p12 = 1;
if Prod_desc_1 = 'Electricity' then Prod_desc_1p13 = 1;
if Prod_desc_1 = 'Fixed_L/Bus' then Prod_desc_1p14 = 1;
if Prod_desc_1 = 'Gas' then Prod_desc_1p15 = 1;
if Prod_desc_1 = 'Internet' then Prod_desc_1p16 = 1;
if Prod_desc_1 = 'Missing' then Prod_desc_1p17 = 1;
if Prod_desc_1 = 'zKenan/Mobile' then Prod_desc_1p18 = 1;
if Residential_state_name_1 = 'NSW' then Residential_state_namp19 = 1;
if Residential_state_name_1 = 'VIC/ACT' then Residential_state_namp20 = 1;
if Residential_state_name_1 = 'WA/NT' then Residential_state_namp21 = 1;
if Residential_state_name_1 = 'zQLD/SA/TAS' then Residential_state_namp22 = 1;
if gender_1 = 'F' then gender_1p23 = 1;
if gender_1 = 'z' then gender_1p24 = 1;
if percentile_ranking_state_2 = '0-20' then percentile_ranking_stp25 = 1;
if percentile_ranking_state_2 = '60-80' then percentile_ranking_stp26 = 1;
if percentile_ranking_state_2 = '80-100' then percentile_ranking_stp27 = 1;
if percentile_ranking_state_2 = 'z20-60&m' then percentile_ranking_stp28 = 1;
if last_pay_amt_2 = '0.2-0.4' then last_pay_amt_2p29 = 1;
if last_pay_amt_2 = '0.4-0.8' then last_pay_amt_2p30 = 1;
if last_pay_amt_2 = '0.8-1k' then last_pay_amt_2p31 = 1;
if last_pay_amt_2 = '1k+' then last_pay_amt_2p32 = 1;
if last_pay_amt_2 = 'Miss' then last_pay_amt_2p33 = 1;
if last_pay_amt_2 = 'z0-0.2k' then last_pay_amt_2p34 = 1;
if inventory_1 = 'missing' then inventory_1p35 = 1;
if inventory_1 = 'zinventory' then inventory_1p36 = 1;






	xbeta_00 = 
&Interceptp1_coeff. +
&age_b0p2_coeff.*max(0,age_since_loaded-0)/1 +
&age_b5p3_coeff.*max(0,age_since_loaded-5)/1 +
&age_b6p4_coeff.*max(0,age_since_loaded-6)/1 +
&loaded_amount_band_b0p5_coeff.*max(0,loaded_amount-0)/10000 +
&loaded_amount_band_b5p6_coeff.*max(0,loaded_amount-500)/10000 +
&loaded_amount_band_b1p7_coeff.*max(0,loaded_amount-1000)/10000 +
&loaded_amount_band_b1p8_coeff.*max(0,loaded_amount-1500)/10000 +
&Portfolio_1p9_coeff.*Portfolio_1p9 +
&Portfolio_1p10_coeff.*Portfolio_1p10 +
&Portfolio_1p11_coeff.*Portfolio_1p11 +
&Portfolio_1p12_coeff.*Portfolio_1p12 +
&Prod_desc_1p13_coeff.*Prod_desc_1p13 +
&Prod_desc_1p14_coeff.*Prod_desc_1p14 +
&Prod_desc_1p15_coeff.*Prod_desc_1p15 +
&Prod_desc_1p16_coeff.*Prod_desc_1p16 +
&Prod_desc_1p17_coeff.*Prod_desc_1p17 +
&Prod_desc_1p18_coeff.*Prod_desc_1p18 +
&Residential_state_namp19_coeff.*Residential_state_namp19 +
&Residential_state_namp20_coeff.*Residential_state_namp20 +
&Residential_state_namp21_coeff.*Residential_state_namp21 +
&Residential_state_namp22_coeff.*Residential_state_namp22 +
&gender_1p23_coeff.*gender_1p23 +
&gender_1p24_coeff.*gender_1p24 +
&percentile_ranking_stp25_coeff.*percentile_ranking_stp25 +
&percentile_ranking_stp26_coeff.*percentile_ranking_stp26 +
&percentile_ranking_stp27_coeff.*percentile_ranking_stp27 +
&percentile_ranking_stp28_coeff.*percentile_ranking_stp28 +
&last_pay_amt_2p29_coeff.*last_pay_amt_2p29 +
&last_pay_amt_2p30_coeff.*last_pay_amt_2p30 +
&last_pay_amt_2p31_coeff.*last_pay_amt_2p31 +
&last_pay_amt_2p32_coeff.*last_pay_amt_2p32 +
&last_pay_amt_2p33_coeff.*last_pay_amt_2p33 +
&last_pay_amt_2p34_coeff.*last_pay_amt_2p34 +
&inventory_1p35_coeff.*inventory_1p35 +
&inventory_1p36_coeff.*inventory_1p36;





	mu_00 = exp(xbeta_00);
	run;
%mend telco_proportion_00;


%macro telco_probability_10(a=,b=);
%let var_list =
Interceptb1_coeff
Portfolio_1b2_coeff
Portfolio_1b3_coeff
Portfolio_1b4_coeff
Portfolio_1b5_coeff
Portfolio_1b6_coeff
Portfolio_1b7_coeff
Portfolio_1b8_coeff
Prod_desc_1b9_coeff
Prod_desc_1b10_coeff
Prod_desc_1b11_coeff
Prod_desc_1b12_coeff
Prod_desc_1b13_coeff
Prod_desc_1b14_coeff
Residential_State_Namb15_coeff
Residential_State_Namb16_coeff
Residential_State_Namb17_coeff
Residential_State_Namb18_coeff
Residential_State_Namb19_coeff
Residential_State_Namb20_coeff
Residential_State_Namb21_coeff
gender_1b22_coeff
gender_1b23_coeff
phone_count_1b24_coeff
phone_count_1b25_coeff
phone_count_1b26_coeff
phone_count_1b27_coeff
Debtor_age_at_load_bab28_coeff
Debtor_age_at_load_bab29_coeff
Debtor_age_at_load_bab30_coeff
Debtor_age_at_load_bab31_coeff
Debtor_age_at_load_bab32_coeff
Debtor_age_at_load_bab33_coeff
percentile_ranking_stb34_coeff
percentile_ranking_stb35_coeff
percentile_ranking_stb36_coeff
percentile_ranking_stb37_coeff
percentile_ranking_stb38_coeff
percentile_ranking_stb39_coeff
percentile_ranking_stb40_coeff
percentile_ranking_stb41_coeff
percentile_ranking_stb42_coeff
referred_type_1b43_coeff
referred_type_1b44_coeff
referred_type_1b45_coeff
referred_type_1b46_coeff
Last_Payment_2b47_coeff
Last_Payment_2b48_coeff
Last_payment_to_loadeb49_coeff
Last_payment_to_loadeb50_coeff
Last_payment_to_loadeb51_coeff
Last_payment_to_loadeb52_coeff
Last_payment_to_loadeb53_coeff
Last_payment_to_loadeb54_coeff
Last_payment_to_loadeb55_coeff
drivers_licence_1b56_coeff
drivers_licence_1b57_coeff
age_since_loaded_b0b58_coeff
age_since_loaded_b3b59_coeff
age_since_loaded_b5b60_coeff
age_since_loaded_b9b61_coeff
loaded_amount_b0b62_coeff
loaded_amount_b500b63_coeff
loaded_amount_b1000b64_coeff
loaded_amount_b5000b65_coeff



;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\telco_model_adjustments_AU_new_pc.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\telco_model_adjustments_SplitPortfolio.xlsx"*/
out = jeff.telco_factors_10 replace
dbms = excel;
sheet = "pricing probability";
run;
/*Table name with coefficients goes here*/
%let file = jeff.telco_factors_10;

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

Portfolio_1b2 = 0;
Portfolio_1b3 = 0;
Portfolio_1b4 = 0;
Portfolio_1b5 = 0;
Portfolio_1b6 = 0;
Portfolio_1b7 = 0;
Portfolio_1b8 = 0;
Prod_desc_1b9 = 0;
Prod_desc_1b10 = 0;
Prod_desc_1b11 = 0;
Prod_desc_1b12 = 0;
Prod_desc_1b13 = 0;
Prod_desc_1b14 = 0;
Residential_State_Namb15 = 0;
Residential_State_Namb16 = 0;
Residential_State_Namb17 = 0;
Residential_State_Namb18 = 0;
Residential_State_Namb19 = 0;
Residential_State_Namb20 = 0;
Residential_State_Namb21 = 0;
gender_1b22 = 0;
gender_1b23 = 0;
phone_count_1b24 = 0;
phone_count_1b25 = 0;
phone_count_1b26 = 0;
phone_count_1b27 = 0;
Debtor_age_at_load_bab28 = 0;
Debtor_age_at_load_bab29 = 0;
Debtor_age_at_load_bab30 = 0;
Debtor_age_at_load_bab31 = 0;
Debtor_age_at_load_bab32 = 0;
Debtor_age_at_load_bab33 = 0;
percentile_ranking_stb34 = 0;
percentile_ranking_stb35 = 0;
percentile_ranking_stb36 = 0;
percentile_ranking_stb37 = 0;
percentile_ranking_stb38 = 0;
percentile_ranking_stb39 = 0;
percentile_ranking_stb40 = 0;
percentile_ranking_stb41 = 0;
percentile_ranking_stb42 = 0;
referred_type_1b43 = 0;
referred_type_1b44 = 0;
referred_type_1b45 = 0;
referred_type_1b46 = 0;
Last_Payment_2b47 = 0;
Last_Payment_2b48 = 0;
Last_payment_to_loadeb49 = 0;
Last_payment_to_loadeb50 = 0;
Last_payment_to_loadeb51 = 0;
Last_payment_to_loadeb52 = 0;
Last_payment_to_loadeb53 = 0;
Last_payment_to_loadeb54 = 0;
Last_payment_to_loadeb55 = 0;
drivers_licence_1b56 = 0;
drivers_licence_1b57 = 0;




if Portfolio_1 = 'AGL' then Portfolio_1b2 = 1;
if Portfolio_1 = 'Optus' then Portfolio_1b3 = 1;
if Portfolio_1 = 'Simply Energy' then Portfolio_1b4 = 1;
if Portfolio_1 = 'TrueEnergy' then Portfolio_1b5 = 1;
if Portfolio_1 = 'Virgin' then Portfolio_1b6 = 1;
if Portfolio_1 = 'Vodafone' then Portfolio_1b7 = 1;
if Portfolio_1 = 'zTelstra' then Portfolio_1b8 = 1;
if Prod_desc_1 = 'Business' then Prod_desc_1b9 = 1;
if Prod_desc_1 = 'Electricity' then Prod_desc_1b10 = 1;
if Prod_desc_1 = 'Fixed Line' then Prod_desc_1b11 = 1;
if Prod_desc_1 = 'Missing' then Prod_desc_1b12 = 1;
if Prod_desc_1 = 'Mobile Phone' then Prod_desc_1b13 = 1;
if Prod_desc_1 = 'zKenan\Gas\Internet' then Prod_desc_1b14 = 1;
if Residential_State_Name_1 = 'ACT' then Residential_State_Namb15 = 1;
if Residential_State_Name_1 = 'NSW' then Residential_State_Namb16 = 1;
if Residential_State_Name_1 = 'QLD' then Residential_State_Namb17 = 1;
if Residential_State_Name_1 = 'SA' then Residential_State_Namb18 = 1;
if Residential_State_Name_1 = 'UNK' then Residential_State_Namb19 = 1;
if Residential_State_Name_1 = 'WA' then Residential_State_Namb20 = 1;
if Residential_State_Name_1 = 'zVI' then Residential_State_Namb21 = 1;
if gender_1 = 'F' then gender_1b22 = 1;
if gender_1 = 'z' then gender_1b23 = 1;
if phone_count_1 = '0' then phone_count_1b24 = 1;
if phone_count_1 = '2' then phone_count_1b25 = 1;
if phone_count_1 = '3' then phone_count_1b26 = 1;
if phone_count_1 = 'z1' then phone_count_1b27 = 1;
if Debtor_age_at_load_band_1 = '1: 18 - 24 Yrs' then Debtor_age_at_load_bab28 = 1;
if Debtor_age_at_load_band_1 = '3: 35 - 44 Yrs' then Debtor_age_at_load_bab29 = 1;
if Debtor_age_at_load_band_1 = '4: 45 - 64 Yrs' then Debtor_age_at_load_bab30 = 1;
if Debtor_age_at_load_band_1 = '6: 65 Yrs +' then Debtor_age_at_load_bab31 = 1;
if Debtor_age_at_load_band_1 = '7: Missing' then Debtor_age_at_load_bab32 = 1;
if Debtor_age_at_load_band_1 = 'z2: 25 - 34 Yr' then Debtor_age_at_load_bab33 = 1;
if percentile_ranking_state_2 = '10-20&m' then percentile_ranking_stb34 = 1;
if percentile_ranking_state_2 = '20-40' then percentile_ranking_stb35 = 1;
if percentile_ranking_state_2 = '40-50' then percentile_ranking_stb36 = 1;
if percentile_ranking_state_2 = '50-60' then percentile_ranking_stb37 = 1;
if percentile_ranking_state_2 = '60-70' then percentile_ranking_stb38 = 1;
if percentile_ranking_state_2 = '70-80' then percentile_ranking_stb39 = 1;
if percentile_ranking_state_2 = '80-90' then percentile_ranking_stb40 = 1;
if percentile_ranking_state_2 = '90-100' then percentile_ranking_stb41 = 1;
if percentile_ranking_state_2 = 'z0-10' then percentile_ranking_stb42 = 1;
if referred_type_1 = '2nd Referral' then referred_type_1b43 = 1;
if referred_type_1 = 'One referral' then referred_type_1b44 = 1;
if referred_type_1 = 'missing' then referred_type_1b45 = 1;
if referred_type_1 = 'no referral' then referred_type_1b46 = 1;
if Last_Payment_2 = 'NoPaymentsMade' then Last_Payment_2b47 = 1;
if Last_Payment_2 = 'PastPaymentMade' then Last_Payment_2b48 = 1;
if Last_payment_to_loaded_2 = '0-6' then Last_payment_to_loadeb49 = 1;
if Last_payment_to_loaded_2 = '12-24' then Last_payment_to_loadeb50 = 1;
if Last_payment_to_loaded_2 = '24-36' then Last_payment_to_loadeb51 = 1;
if Last_payment_to_loaded_2 = '36-48' then Last_payment_to_loadeb52 = 1;
if Last_payment_to_loaded_2 = '48+' then Last_payment_to_loadeb53 = 1;
if Last_payment_to_loaded_2 = 'Miss' then Last_payment_to_loadeb54 = 1;
if Last_payment_to_loaded_2 = 'z6-12' then Last_payment_to_loadeb55 = 1;
if drivers_licence_1 = 'Yes' then drivers_licence_1b56 = 1;
if drivers_licence_1 = 'zNo' then drivers_licence_1b57 = 1;




xbeta_10 = 
	&Interceptb1_coeff. +
&Portfolio_1b2_coeff.*Portfolio_1b2 +
&Portfolio_1b3_coeff.*Portfolio_1b3 +
&Portfolio_1b4_coeff.*Portfolio_1b4 +
&Portfolio_1b5_coeff.*Portfolio_1b5 +
&Portfolio_1b6_coeff.*Portfolio_1b6 +
&Portfolio_1b7_coeff.*Portfolio_1b7 +
&Portfolio_1b8_coeff.*Portfolio_1b8 +
&Prod_desc_1b9_coeff.*Prod_desc_1b9 +
&Prod_desc_1b10_coeff.*Prod_desc_1b10 +
&Prod_desc_1b11_coeff.*Prod_desc_1b11 +
&Prod_desc_1b12_coeff.*Prod_desc_1b12 +
&Prod_desc_1b13_coeff.*Prod_desc_1b13 +
&Prod_desc_1b14_coeff.*Prod_desc_1b14 +
&Residential_State_Namb15_coeff.*Residential_State_Namb15 +
&Residential_State_Namb16_coeff.*Residential_State_Namb16 +
&Residential_State_Namb17_coeff.*Residential_State_Namb17 +
&Residential_State_Namb18_coeff.*Residential_State_Namb18 +
&Residential_State_Namb19_coeff.*Residential_State_Namb19 +
&Residential_State_Namb20_coeff.*Residential_State_Namb20 +
&Residential_State_Namb21_coeff.*Residential_State_Namb21 +
&gender_1b22_coeff.*gender_1b22 +
&gender_1b23_coeff.*gender_1b23 +
&phone_count_1b24_coeff.*phone_count_1b24 +
&phone_count_1b25_coeff.*phone_count_1b25 +
&phone_count_1b26_coeff.*phone_count_1b26 +
&phone_count_1b27_coeff.*phone_count_1b27 +
&Debtor_age_at_load_bab28_coeff.*Debtor_age_at_load_bab28 +
&Debtor_age_at_load_bab29_coeff.*Debtor_age_at_load_bab29 +
&Debtor_age_at_load_bab30_coeff.*Debtor_age_at_load_bab30 +
&Debtor_age_at_load_bab31_coeff.*Debtor_age_at_load_bab31 +
&Debtor_age_at_load_bab32_coeff.*Debtor_age_at_load_bab32 +
&Debtor_age_at_load_bab33_coeff.*Debtor_age_at_load_bab33 +
&percentile_ranking_stb34_coeff.*percentile_ranking_stb34 +
&percentile_ranking_stb35_coeff.*percentile_ranking_stb35 +
&percentile_ranking_stb36_coeff.*percentile_ranking_stb36 +
&percentile_ranking_stb37_coeff.*percentile_ranking_stb37 +
&percentile_ranking_stb38_coeff.*percentile_ranking_stb38 +
&percentile_ranking_stb39_coeff.*percentile_ranking_stb39 +
&percentile_ranking_stb40_coeff.*percentile_ranking_stb40 +
&percentile_ranking_stb41_coeff.*percentile_ranking_stb41 +
&percentile_ranking_stb42_coeff.*percentile_ranking_stb42 +
&referred_type_1b43_coeff.*referred_type_1b43 +
&referred_type_1b44_coeff.*referred_type_1b44 +
&referred_type_1b45_coeff.*referred_type_1b45 +
&referred_type_1b46_coeff.*referred_type_1b46 +
&Last_Payment_2b47_coeff.*Last_Payment_2b47 +
&Last_Payment_2b48_coeff.*Last_Payment_2b48 +
&Last_payment_to_loadeb49_coeff.*Last_payment_to_loadeb49 +
&Last_payment_to_loadeb50_coeff.*Last_payment_to_loadeb50 +
&Last_payment_to_loadeb51_coeff.*Last_payment_to_loadeb51 +
&Last_payment_to_loadeb52_coeff.*Last_payment_to_loadeb52 +
&Last_payment_to_loadeb53_coeff.*Last_payment_to_loadeb53 +
&Last_payment_to_loadeb54_coeff.*Last_payment_to_loadeb54 +
&Last_payment_to_loadeb55_coeff.*Last_payment_to_loadeb55 +
&drivers_licence_1b56_coeff.*drivers_licence_1b56 +
&drivers_licence_1b57_coeff.*drivers_licence_1b57 +
&age_since_loaded_b0b58_coeff.*max(0,age_since_loaded-0)/1 +
&age_since_loaded_b3b59_coeff.*max(0,age_since_loaded-3)/1 +
&age_since_loaded_b5b60_coeff.*max(0,age_since_loaded-5)/1 +
&age_since_loaded_b9b61_coeff.*max(0,age_since_loaded-9)/1 +
&loaded_amount_b0b62_coeff.*max(0,loaded_amount-0)/10000 +
&loaded_amount_b500b63_coeff.*max(0,loaded_amount-500)/10000 +
&loaded_amount_b1000b64_coeff.*max(0,loaded_amount-1000)/10000 +
&loaded_amount_b5000b65_coeff.*max(0,loaded_amount-5000)/10000;



	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend telco_probability_10;


%macro telco_pricing (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
/*	where Loaded_Date < '1Jan2009'd and Status = 'Open';*/
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\AU\PDL\Pricing\Telco_Proportion_Pricing_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = max(0,stat_bar);*/
/*	age_since_loaded = min(max(0,stat_bar),12);*/
/*	age_since_loaded = 9;*/
/*	age_since_loaded = min(max(12 - round(Last_Payment_To_Loaded/6,1),0),12);*/
	age_since_loaded = ceil(((&cutoffdate. - loaded_date)/365.25)*2);
	run;

/*%telco_proportion_00(x=dilan.telco_pred_age,y=dilan.telco_pred_1_age)*/
/*%telco_proportion_00(x=dilan.telco_pred_12,y=dilan.telco_pred_1_12)*/
%telco_proportion_00(x=dilan.tnpp,y=dilan.tnpp_1)

data &a;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
/*	where Loaded_Date < '1Jan2009'd and Status = 'Open';*/
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\AU\PDL\Pricing\Telco_Probability_Pricing_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = max(0,stat_bar);*/
/*	age_since_loaded = min(max(0,stat_bar),12);*/
/*	age_since_loaded = 12;*/
/*	age_since_loaded = min(max(12 - round(Last_Payment_To_Loaded/6,1),0),12);*/
	age_since_loaded = ceil(((&cutoffdate. - loaded_date)/365.25)*2);
	run;

/*%telco_probability_10(a=dilan.telco_pred_2_age,b=dilan.telco_pred_3_age)*/
/*%telco_probability_10(a=dilan.telco_pred_2_12,b=dilan.telco_pred_3_12)*/
%telco_probability_10(a=dilan.tnpp_2,b=dilan.tnpp_3)

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
	set &e (keep = client_ledger_number account_number loaded_amount payments_total current_balance pdl status portfolio mu_00 p_10 age_since_loaded_1 portfolio port_desc product debtor_age_at_load_band prod_desc Gender Phone_Count Residential_State_Name);
	predicted_payments = mu_00*p_10*loaded_amount;
/*	new_forecast = predicted_payments - payments_total;*/
/*	what does the fox say?*/
	run;

proc sql;
	create table &outfile as
	select avg(p_10), Loaded_Amount, Status, Portfolio,	PDL, Payments_Total, Current_Balance, mu_00, predicted_payments, age_since_loaded_1
 	from &f
	group by client_ledger_number, account_number;
	quit
	run;

%mend telco_pricing;



/*%telco_pricing (infile=jeff.historical_accounts_telco_3,x=dilan.telco_pred_12,y=dilan.telco_pred_1_12,a=dilan.telco_pred_2_12,b=dilan.telco_pred_3_12,d=dilan.telco_pred_4_12,e=dilan.telco_pred_5_12,f=dilan.telco_pred_6_12,outfile=dilan.telco_pred_7_12);*/
/*%telco_pricing (infile=jeff.historical_accounts_telco_20,x=dilan.telco_pred_age,y=dilan.telco_pred_1_age,a=dilan.telco_pred_2_age,b=dilan.telco_pred_3_age,d=dilan.telco_pred_4_age,e=dilan.telco_pred_5_age,f=dilan.telco_pred_6_age,outfile=dilan.telco_pred_7_age);*/
%telco_pricing (infile=jeff.historical_accounts_telco_15,x=dilan.tnpp,y=dilan.tnpp_1,a=dilan.tnpp_2,b=dilan.tnpp_3,d=dilan.tnpp_4,e=dilan.tnpp_5,f=dilan.tnpp_6,outfile=dilan.tnpp_7_&looped.);



%end;

%mend alltime;

%alltime;





/*data &d;*/
/*	set &b (keep = client_ledger_number account_number p_10);*/
/*	run;*/
/**/
/*%put &looped.; /*put this statement after each step in the prediction process e.g. after a is created or b is created*/*/


/*Payment macro loop*/


/*%macro payment();*/
/*%do looped =1 %to &Periods.;*/
/*%let cutoffdate=&&cutoffdate&looped..;*/
/*data &data_set.;*/
/*	set &data_set.;*/
/*	payment_date<= &cutoffdate.;*/
/**/
/**/
/*	run;*/
/**/
/*proc summary data = lib.historical_payments04;*/
/*where payment_date <= &cutoffdate.;*/
/*output out= actual_pay_&looped. sum=;*/
/*run;*/
/**/
/*%end;*/
/**/
/*data temp2_1.triangle_test_all14;*/
/*set */
/*%do looped =1 %to &Periods.;*/
/*temp2_1.triangle_test_all13_loop_&looped.*/
/*%end;*/;
