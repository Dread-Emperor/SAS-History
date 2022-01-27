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
Interceptp1_coeff
loaded_amount_band_0p2_coeff
loaded_amount_band_20p3_coeff
loaded_amount_band_12p4_coeff
age_since_loaded_bandp5_coeff
age_since_loaded_bandp6_coeff
age_since_loaded_bandp7_coeff
portfolio_40p8_coeff
portfolio_40p9_coeff
portfolio_40p10_coeff
portfolio_40p11_coeff
portfolio_40p12_coeff
portfolio_40p13_coeff
portfolio_40p14_coeff
portfolio_40p15_coeff
portfolio_40p16_coeff
portfolio_40p17_coeff
debtor_age_at_load_bap18_coeff
debtor_age_at_load_bap19_coeff
c_phone_count_30p20_coeff
c_phone_count_30p21_coeff
c_phone_count_30p22_coeff
c_phone_count_30p23_coeff
c_last_payment_to_loap24_coeff
c_last_payment_to_loap25_coeff
gender_20p26_coeff
gender_20p27_coeff
percentile_ranking_stp28_coeff
percentile_ranking_stp29_coeff
referred_type_4p30_coeff
referred_type_4p31_coeff
open_n_0p32_coeff
open_n_1p33_coeff
open_n_6p34_coeff

;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\banking_model_adjustments_AU_Pricing_new_pc.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\dilan\Not Needed\banking_adjustments_portfolio.xlsx"*/
out = jeff.banking_factors_00 replace
dbms = excel;
sheet = "pricing proportion";
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

portfolio_40p8 = 0;
portfolio_40p9 = 0;
portfolio_40p10 = 0;
portfolio_40p11 = 0;
portfolio_40p12 = 0;
portfolio_40p13 = 0;
portfolio_40p14 = 0;
portfolio_40p15 = 0;
portfolio_40p16 = 0;
portfolio_40p17 = 0;
debtor_age_at_load_bap18 = 0;
debtor_age_at_load_bap19 = 0;
c_phone_count_30p20 = 0;
c_phone_count_30p21 = 0;
c_phone_count_30p22 = 0;
c_phone_count_30p23 = 0;
c_last_payment_to_loap24 = 0;
c_last_payment_to_loap25 = 0;
gender_20p26 = 0;
gender_20p27 = 0;
percentile_ranking_stp28 = 0;
percentile_ranking_stp29 = 0;
referred_type_4p30 = 0;
referred_type_4p31 = 0;


if portfolio_40 = 'ANZ' then portfolio_40p8 = 1;
if portfolio_40 = 'BMW' then portfolio_40p9 = 1;
if portfolio_40 = 'FlexiGroup' then portfolio_40p10 = 1;
if portfolio_40 = 'Ford Credit' then portfolio_40p11 = 1;
if portfolio_40 = 'GE' then portfolio_40p12 = 1;
if portfolio_40 = 'NAB' then portfolio_40p13 = 1;
if portfolio_40 = 'Radio Rentals' then portfolio_40p14 = 1;
if portfolio_40 = 'St George' then portfolio_40p15 = 1;
if portfolio_40 = 'Westpac' then portfolio_40p16 = 1;
if portfolio_40 = 'zCBA/Macq/CF' then portfolio_40p17 = 1;
if debtor_age_at_load_band_10 = '1: 18 - 24 Yrs' then debtor_age_at_load_bap18 = 1;
if debtor_age_at_load_band_10 = 'Base: 25+ Yrs' then debtor_age_at_load_bap19 = 1;
if c_phone_count_30 = '1' then c_phone_count_30p20 = 1;
if c_phone_count_30 = '2' then c_phone_count_30p21 = 1;
if c_phone_count_30 = '3' then c_phone_count_30p22 = 1;
if c_phone_count_30 = 'z0' then c_phone_count_30p23 = 1;
if c_last_payment_to_loaded_30 = '0-5 months' then c_last_payment_to_loap24 = 1;
if c_last_payment_to_loaded_30 = '6+ months' then c_last_payment_to_loap25 = 1;
if gender_20 = 'F' then gender_20p26 = 1;
if gender_20 = 'M' then gender_20p27 = 1;
if percentile_ranking_state_10 = '75-100' then percentile_ranking_stp28 = 1;
if percentile_ranking_state_10 = 'z:0-75' then percentile_ranking_stp29 = 1;
if referred_type_4 = '1+ Referral' then referred_type_4p30 = 1;
if referred_type_4 = 'zNo Referral' then referred_type_4p31 = 1;

%put &looped.;


	xbeta_00 = 
	&Interceptp1_coeff. +
&loaded_amount_band_0p2_coeff.*max(0,loaded_amount-0)/10000 +
&loaded_amount_band_20p3_coeff.*max(0,loaded_amount-2000)/10000 +
&loaded_amount_band_12p4_coeff.*max(0,loaded_amount-12000)/10000 +
&age_since_loaded_bandp5_coeff.*max(0,age_since_loaded-0)/1 +
&age_since_loaded_bandp6_coeff.*max(0,age_since_loaded-3)/1 +
&age_since_loaded_bandp7_coeff.*max(0,age_since_loaded-5)/1 +
&portfolio_40p8_coeff.*portfolio_40p8 +
&portfolio_40p9_coeff.*portfolio_40p9 +
&portfolio_40p10_coeff.*portfolio_40p10 +
&portfolio_40p11_coeff.*portfolio_40p11 +
&portfolio_40p12_coeff.*portfolio_40p12 +
&portfolio_40p13_coeff.*portfolio_40p13 +
&portfolio_40p14_coeff.*portfolio_40p14 +
&portfolio_40p15_coeff.*portfolio_40p15 +
&portfolio_40p16_coeff.*portfolio_40p16 +
&portfolio_40p17_coeff.*portfolio_40p17 +
&debtor_age_at_load_bap18_coeff.*debtor_age_at_load_bap18 +
&debtor_age_at_load_bap19_coeff.*debtor_age_at_load_bap19 +
&c_phone_count_30p20_coeff.*c_phone_count_30p20 +
&c_phone_count_30p21_coeff.*c_phone_count_30p21 +
&c_phone_count_30p22_coeff.*c_phone_count_30p22 +
&c_phone_count_30p23_coeff.*c_phone_count_30p23 +
&c_last_payment_to_loap24_coeff.*c_last_payment_to_loap24 +
&c_last_payment_to_loap25_coeff.*c_last_payment_to_loap25 +
&gender_20p26_coeff.*gender_20p26 +
&gender_20p27_coeff.*gender_20p27 +
&percentile_ranking_stp28_coeff.*percentile_ranking_stp28 +
&percentile_ranking_stp29_coeff.*percentile_ranking_stp29 +
&referred_type_4p30_coeff.*referred_type_4p30 +
&referred_type_4p31_coeff.*referred_type_4p31 +
&open_n_0p32_coeff.*max(0,open_to_load-0)/1 +
&open_n_1p33_coeff.*max(0,open_to_load-1)/1 +
&open_n_6p34_coeff.*max(0,open_to_load-6)/1;


	mu_00 = exp(xbeta_00);
	run;
%mend banking_proportion_00;

%macro banking_probability_10(a=,b=);
%let var_list =

Interceptb1_coeff
open_n_0b2_coeff
open_n_1b3_coeff
open_n_3b4_coeff
open_n_14b5_coeff
loaded_n_200b6_coeff
loaded_n_400b7_coeff
loaded_n_2000b8_coeff
age_since_loaded_n_0b9_coeff
age_since_loaded_n_3b10_coeff
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
drivers_licence_1b47_coeff
drivers_licence_1b48_coeff
drivers_licence_1b49_coeff
residential_state_namb50_coeff
residential_state_namb51_coeff
residential_state_namb52_coeff
residential_state_namb53_coeff
residential_state_namb54_coeff
prod_desc_2b55_coeff
prod_desc_2b56_coeff
prod_desc_2b57_coeff
prod_desc_2b58_coeff
gender_2b59_coeff
gender_2b60_coeff
inventory_1b61_coeff
inventory_1b62_coeff
interest_rate_2b63_coeff
interest_rate_2b64_coeff




;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\banking_model_adjustments_AU_Pricing_new_pc.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\dilan\Not Needed\banking_adjustments_portfolio.xlsx"*/
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
drivers_licence_1b47 = 0;
drivers_licence_1b48 = 0;
drivers_licence_1b49 = 0;
residential_state_namb50 = 0;
residential_state_namb51 = 0;
residential_state_namb52 = 0;
residential_state_namb53 = 0;
residential_state_namb54 = 0;
prod_desc_2b55 = 0;
prod_desc_2b56 = 0;
prod_desc_2b57 = 0;
prod_desc_2b58 = 0;
gender_2b59 = 0;
gender_2b60 = 0;
inventory_1b61 = 0;
inventory_1b62 = 0;
interest_rate_2b63 = 0;
interest_rate_2b64 = 0;



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
if debtor_age_at_load_band_1 = 'Base: 25 Yrs +' then debtor_age_at_load_bab46 = 1;
if drivers_licence_1 = 'Mis' then drivers_licence_1b47 = 1;
if drivers_licence_1 = 'No' then drivers_licence_1b48 = 1;
if drivers_licence_1 = 'zYe' then drivers_licence_1b49 = 1;
if residential_state_name_1 = 'ACT' then residential_state_namb50 = 1;
if residential_state_name_1 = 'OTH' then residential_state_namb51 = 1;
if residential_state_name_1 = 'SA' then residential_state_namb52 = 1;
if residential_state_name_1 = 'WA' then residential_state_namb53 = 1;
if residential_state_name_1 = 'zNS' then residential_state_namb54 = 1;
if prod_desc_2 = 'Bank Card' then prod_desc_2b55 = 1;
if prod_desc_2 = 'Business' then prod_desc_2b56 = 1;
if prod_desc_2 = 'Buyers Edge' then prod_desc_2b57 = 1;
if prod_desc_2 = 'zMaster/AMEX/Vis/Rent/?/CLine' then prod_desc_2b58 = 1;
if gender_2 = 'F' then gender_2b59 = 1;
if gender_2 = 'M' then gender_2b60 = 1;
if inventory_1 = 'inventory' then inventory_1b61 = 1;
if inventory_1 = 'zForward Flo' then inventory_1b62 = 1;
if interest_rate_2 = '0-15&?' then interest_rate_2b63 = 1;
if interest_rate_2 = 'z15+' then interest_rate_2b64 = 1;

%put &looped.;

	xbeta_10 = 
&Interceptb1_coeff. +
&open_n_0b2_coeff.*max(0,open_to_load-0)/1 +
&open_n_1b3_coeff.*max(0,open_to_load-1)/1 +
&open_n_3b4_coeff.*max(0,open_to_load-3)/1 +
&open_n_14b5_coeff.*max(0,open_to_load-14)/1 +
&loaded_n_200b6_coeff.*max(0,loaded_amount-200)/10000 +
&loaded_n_400b7_coeff.*max(0,loaded_amount-400)/10000 +
&loaded_n_2000b8_coeff.*max(0,loaded_amount-2000)/10000 +
&age_since_loaded_n_0b9_coeff.*max(0,age_since_loaded-0)/1 +
&age_since_loaded_n_3b10_coeff.*max(0,age_since_loaded-3)/1 +
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
&drivers_licence_1b47_coeff.*drivers_licence_1b47 +
&drivers_licence_1b48_coeff.*drivers_licence_1b48 +
&drivers_licence_1b49_coeff.*drivers_licence_1b49 +
&residential_state_namb50_coeff.*residential_state_namb50 +
&residential_state_namb51_coeff.*residential_state_namb51 +
&residential_state_namb52_coeff.*residential_state_namb52 +
&residential_state_namb53_coeff.*residential_state_namb53 +
&residential_state_namb54_coeff.*residential_state_namb54 +
&prod_desc_2b55_coeff.*prod_desc_2b55 +
&prod_desc_2b56_coeff.*prod_desc_2b56 +
&prod_desc_2b57_coeff.*prod_desc_2b57 +
&prod_desc_2b58_coeff.*prod_desc_2b58 +
&gender_2b59_coeff.*gender_2b59 +
&gender_2b60_coeff.*gender_2b60 +
&inventory_1b61_coeff.*inventory_1b61 +
&inventory_1b62_coeff.*inventory_1b62 +
&interest_rate_2b63_coeff.*interest_rate_2b63 +
&interest_rate_2b64_coeff.*interest_rate_2b64;



	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend banking_probability_10;
%macro banking_pricing (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
/*	where Loaded_Date < '1Jan2009'd and Status = 'Open';*/
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\AU\PDL\Pricing\Banking_Proportion_Pricing_SourceCode.sas';
/*	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\dilan\Not Needed\banking_proportion_pricing_final_sourcecode.sas';*/
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = max(stat_bar,0);*/
/*	age_since_loaded = min(max(0,stat_bar),12);*/
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = 12;*/
/*	age_since_loaded = min(max(12 - round(Last_Payment_To_Loaded/6,1),0),12);*/
/*	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);*/
	age_since_loaded = max(round((((&cutoffdate. - loaded_date)/365.25)*2),1),0);
	run;

%put &looped.;

/*%banking_proportion_00(x=dilan.banking_pred_port,y=dilan.banking_pred_1_port)*/
/*%banking_proportion_00(x=dilan.bank_pred_port_12,y=dilan.bank_pred_1_port_12)*/
/*%banking_proportion_00(x=dilan.bank_pred_port_sbar,y=dilan.bank_pred_1_port_sbar)*/
/*%banking_proportion_00(x=dilan.bank_pred_port_a12,y=dilan.bank_pred_1_port_a12)*/
%banking_proportion_00(x=dilan.bnpp,y=dilan.bnpp_1)

%put &looped.;

data &a;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
/*	where Loaded_Date < '1Jan2009'd and Status = 'Open';*/
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\AU\PDL\Pricing\Banking_Probability_Pricing&Reforecast_SourceCode.sas';
/*	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\dilan\Not Needed\banking_probability_pricing_final_sourcecode.sas';*/
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = max(stat_bar,0);*/
/*	age_since_loaded = min(max(0,stat_bar),12);*/
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = 11;*/
/*	age_since_loaded = min(max(12 - round(Last_Payment_To_Loaded/6,1),0),12);*/
/*	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);*/
	age_since_loaded = max(round((((&cutoffdate. - loaded_date)/365.25)*2),1),0);
	run;

%put &looped.;

/*%banking_probability_10(a=dilan.banking_pred_2_port,b=dilan.banking_pred_3_port)*/
/*%banking_probability_10(a=dilan.bank_pred_2_port_12,b=dilan.bank_pred_3_port_12)*/
/*%banking_probability_10(a=dilan.bank_pred_2_port_sbar,b=dilan.bank_pred_3_port_sbar)*/
/*%banking_probability_10(a=dilan.bank_pred_2_port_a12,b=dilan.bank_pred_3_port_a12)*/
%banking_probability_10(a=dilan.bnpp_2,b=dilan.bnpp_3)

%put &looped.;

data &d;
	set &b (keep = client_ledger_number account_number p_10);
	run;

%put &looped.;

proc sort data = &d;
	by client_ledger_number account_number;
	run;

%put &looped.;

proc sort data = &y;
	by client_ledger_number account_number;
	run;

%put &looped.;

data &e;
	merge &d (in=t1) &y (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

%put &looped.;

data &f;
	set &e (keep = client_ledger_number account_number loaded_amount payments_total current_balance pdl status portfolio mu_00 p_10 age_since_loaded_1 portfolio port_desc product debtor_age_at_load_band prod_desc Gender Phone_Count Residential_State_Name);
	predicted_payments = mu_00*p_10*loaded_amount;
/*	new_forecast = predicted_payments - payments_total;*/
	run;

%put &looped.;

proc sql;
	create table &outfile as
	select avg(p_10), Loaded_Amount, Status, Portfolio,	PDL, Payments_Total, Current_Balance, mu_00, predicted_payments, age_since_loaded_1
 	from &f
	group by client_ledger_number, account_number;
	quit
	run;

%put &looped.;

%mend banking_pricing;



/*%banking_pricing (infile=jeff.historical_accounts_banking_20,x=dilan.banking_pred_port,y=dilan.banking_pred_1_port,a=dilan.banking_pred_2_port,b=dilan.banking_pred_3_port,d=dilan.banking_pred_4_port,e=dilan.banking_pred_5_port,f=dilan.banking_pred_6_port,outfile=dilan.banking_pred_7_port);*/
/*%banking_pricing (infile=jeff.historical_accounts_banking_20,x=dilan.bank_pred_port_12,y=dilan.bank_pred_1_port_12,a=dilan.bank_pred_2_port_12,b=dilan.bank_pred_3_port_12,d=dilan.bank_pred_4_port_12,e=dilan.bank_pred_5_port_12,f=dilan.bank_pred_6_port_12,outfile=dilan.bank_pred_7_port_12);*/
/*%banking_pricing (infile=jeff.historical_accounts_banking_20,x=dilan.bank_pred_port_sbar,y=dilan.bank_pred_1_port_sbar,a=dilan.bank_pred_2_port_sbar,b=dilan.bank_pred_3_port_sbar,d=dilan.bank_pred_4_port_sbar,e=dilan.bank_pred_5_port_sbar,f=dilan.bank_pred_6_port_sbar,outfile=dilan.bank_pred_7_port_sbar);*/
/*%banking_pricing (infile=jeff.historical_accounts_banking_20,x=dilan.bank_pred_port_a12,y=dilan.bank_pred_1_port_a12,a=dilan.bank_pred_2_port_a12,b=dilan.bank_pred_3_port_a12,d=dilan.bank_pred_4_port_a12,e=dilan.bank_pred_5_port_a12,f=dilan.bank_pred_6_port_a12,outfile=dilan.bank_pred_7_port_a12);*/
%banking_pricing (infile=jeff.historical_accounts_banking_15,x=dilan.bnpp,y=dilan.bnpp_1,a=dilan.bnpp_2,b=dilan.bnpp_3,d=dilan.bnpp_4,e=dilan.bnpp_5,f=dilan.bank_npp_6_&looped.,outfile=dilan.bnpp_7);

%end;

%mend alltime;

%alltime;









































/*data &d;*/
/*	set &b (keep = client_ledger_number account_number p_10);*/
/*	run;*/
/**/
/*%put &looped.; /*put this statement after each step in the prediction process e.g. after a is created or b is created*/*/




/* Not part of the code*/



/*Not part of the code*/








/*this is only for reference*/

/*proc summary data=temp2_1.triangle_test_all12 nway missing noprint;*/
/*/*checked and confirmed that recovery is the same as cal_recovery when status = actual for cutoffdate 31dec2012*/*/
/*var Recovery cal_recovery Cum_cal_recovery cal_recoveryA Cum_cal_recoveryA cal_recoveryA2 cal_recoveryB Cum_cal_recoveryB cal_recoveryC Cum_cal_recoveryC cal_recoveryC2;*/
/*/*var cal_recovery Cum_cal_recovery;*/*/
/*class cutoffdate PDL_1 port_desc_1 Payment_month_1 Status;*/
/*output out= temp2_1.triangle_test_all13_loop_&looped. sum=;*/
/*/*output out= triangle_test_all13_loop_1 sum=;*/*/
/*run;*/

/*this is only for reference*/








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
/*%end;*/


