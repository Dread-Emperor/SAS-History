libname ALMAUPDL '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\AU\PDL';
libname JACK '\\bcsap0010\sasdata\SAS Data\Jack\SASdata';
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
phone_count_21p22_coeff
phone_count_21p23_coeff
phone_count_21p24_coeff
phone_count_21p25_coeff
lp_amount_31p26_coeff
lp_amount_31p27_coeff
lp_amount_31p28_coeff
lp_amount_31p29_coeff
lp_amount_31p210_coeff
lp_amount_31p211_coeff
lp_amount_31p212_coeff
gender_21p213_coeff
gender_21p214_coeff
post_code_rating_21p215_coeff
post_code_rating_21p216_coeff
post_code_rating_21p217_coeff
portfolio_20p218_coeff
portfolio_20p219_coeff
port_desc_21p220_coeff
port_desc_21p221_coeff
port_desc_21p222_coeff
prod_desc_30p223_coeff
prod_desc_30p224_coeff
age_since_loaded_0_np225_coeff
age_since_loaded_5_np226_coeff
loaded_amount_0_np227_coeff
loaded_amount_800_np228_coeff
loaded_amount_4000_np229_coeff
loaded_amount_10000_p230_coeff
gdp_21p231_coeff
gdp_21p232_coeff
latest_pay_aft_loadp233_coeff
latest_pay_aft_loadp234_coeff
latest_pay_aft_loadp235_coeff
latest_pay_aft_loadp236_coeff
latest_pay_aft_loadp237_coeff
latest_pay_aft_loadp238_coeff
latest_pay_aft_loadp239_coeff
latest_pay_aft_loadp240_coeff
latest_pay_aft_loadp241_coeff
Number_of_Defaults_2p242_coeff
Number_of_Defaults_2p243_coeff
Number_of_Defaults_2p244_coeff
Number_of_Defaults_2p245_coeff
Number_of_Defaults_2p246_coeff
Number_of_Defaults_2p247_coeff
open_n_0p248_coeff
open_n_1p249_coeff
open_n_5p250_coeff

;

proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Jack\Adjustment Files\banking_model_adjustments_nz.xlsx"
out = jack.banking_factors_00 replace
dbms = excel;
sheet = "reforecast proportion";
run;
/*Table name with coefficients goes here*/
%let file = jack.banking_factors_00;

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

phone_count_21p22 = 0;
phone_count_21p23 = 0;
phone_count_21p24 = 0;
phone_count_21p25 = 0;
lp_amount_31p26 = 0;
lp_amount_31p27 = 0;
lp_amount_31p28 = 0;
lp_amount_31p29 = 0;
lp_amount_31p210 = 0;
lp_amount_31p211 = 0;
lp_amount_31p212 = 0;
gender_21p213 = 0;
gender_21p214 = 0;
post_code_rating_21p215 = 0;
post_code_rating_21p216 = 0;
post_code_rating_21p217 = 0;
portfolio_20p218 = 0;
portfolio_20p219 = 0;
port_desc_21p220 = 0;
port_desc_21p221 = 0;
port_desc_21p222 = 0;
prod_desc_30p223 = 0;
prod_desc_30p224 = 0;
gdp_21p231 = 0;
gdp_21p232 = 0;
latest_pay_aft_loadp233 = 0;
latest_pay_aft_loadp234 = 0;
latest_pay_aft_loadp235 = 0;
latest_pay_aft_loadp236 = 0;
latest_pay_aft_loadp237 = 0;
latest_pay_aft_loadp238 = 0;
latest_pay_aft_loadp239 = 0;
latest_pay_aft_loadp240 = 0;
latest_pay_aft_loadp241 = 0;
Number_of_Defaults_2p242 = 0;
Number_of_Defaults_2p243 = 0;
Number_of_Defaults_2p244 = 0;
Number_of_Defaults_2p245 = 0;
Number_of_Defaults_2p246 = 0;
Number_of_Defaults_2p247 = 0;





if phone_count_21 = '0' then phone_count_21p22 = 1;
if phone_count_21 = '2' then phone_count_21p23 = 1;
if phone_count_21 = '3' then phone_count_21p24 = 1;
if phone_count_21 = 'z1' then phone_count_21p25 = 1;
if lp_amount_31 = '0-25' then lp_amount_31p26 = 1;
if lp_amount_31 = '100-200' then lp_amount_31p27 = 1;
if lp_amount_31 = '200-500' then lp_amount_31p28 = 1;
if lp_amount_31 = '25-50' then lp_amount_31p29 = 1;
if lp_amount_31 = '500+' then lp_amount_31p210 = 1;
if lp_amount_31 = 'NoPaymt' then lp_amount_31p211 = 1;
if lp_amount_31 = 'z50-100' then lp_amount_31p212 = 1;
if gender_21 = 'F&?' then gender_21p213 = 1;
if gender_21 = 'zM' then gender_21p214 = 1;
if post_code_rating_21 = '0-5' then post_code_rating_21p215 = 1;
if post_code_rating_21 = 'Overseas' then post_code_rating_21p216 = 1;
if post_code_rating_21 = 'z5-10' then post_code_rating_21p217 = 1;
if portfolio_20 = 'Medium Account' then portfolio_20p218 = 1;
if portfolio_20 = 'zCorporate/Major/Large Account' then portfolio_20p219 = 1;
if port_desc_21 = 'ANZ/Retail' then port_desc_21p220 = 1;
if port_desc_21 = 'Westpac/Ford/Home' then port_desc_21p221 = 1;
if port_desc_21 = 'zGE/Hop/Money/Cons/Flexi' then port_desc_21p222 = 1;
if prod_desc_30 = 'Personal/Home/Other' then prod_desc_30p223 = 1;
if prod_desc_30 = 'zCreditline/Retail/CarLoan/Vis' then prod_desc_30p224 = 1;
if gdp_21 = '108+' then gdp_21p231 = 1;
if gdp_21 = 'z108- & ?' then gdp_21p232 = 1;
if latest_pay_aft_load = '1.5' then latest_pay_aft_loadp233 = 1;
if latest_pay_aft_load = '2' then latest_pay_aft_loadp234 = 1;
if latest_pay_aft_load = '2.5' then latest_pay_aft_loadp235 = 1;
if latest_pay_aft_load = '3' then latest_pay_aft_loadp236 = 1;
if latest_pay_aft_load = '3.5' then latest_pay_aft_loadp237 = 1;
if latest_pay_aft_load = '4' then latest_pay_aft_loadp238 = 1;
if latest_pay_aft_load = '4.5' then latest_pay_aft_loadp239 = 1;
if latest_pay_aft_load = '4.5+' then latest_pay_aft_loadp240 = 1;
if latest_pay_aft_load = 'z0.5' then latest_pay_aft_loadp241 = 1;
if Number_of_Defaults_2 = '1' then Number_of_Defaults_2p242 = 1;
if Number_of_Defaults_2 = '14' then Number_of_Defaults_2p243 = 1;
if Number_of_Defaults_2 = '2' then Number_of_Defaults_2p244 = 1;
if Number_of_Defaults_2 = '3' then Number_of_Defaults_2p245 = 1;
if Number_of_Defaults_2 = '5' then Number_of_Defaults_2p246 = 1;
if Number_of_Defaults_2 = 'z0' then Number_of_Defaults_2p247 = 1;








	xbeta_00 = 
&Interceptp21_coeff. +
&phone_count_21p22_coeff.*phone_count_21p22 +
&phone_count_21p23_coeff.*phone_count_21p23 +
&phone_count_21p24_coeff.*phone_count_21p24 +
&phone_count_21p25_coeff.*phone_count_21p25 +
&lp_amount_31p26_coeff.*lp_amount_31p26 +
&lp_amount_31p27_coeff.*lp_amount_31p27 +
&lp_amount_31p28_coeff.*lp_amount_31p28 +
&lp_amount_31p29_coeff.*lp_amount_31p29 +
&lp_amount_31p210_coeff.*lp_amount_31p210 +
&lp_amount_31p211_coeff.*lp_amount_31p211 +
&lp_amount_31p212_coeff.*lp_amount_31p212 +
&gender_21p213_coeff.*gender_21p213 +
&gender_21p214_coeff.*gender_21p214 +
&post_code_rating_21p215_coeff.*post_code_rating_21p215 +
&post_code_rating_21p216_coeff.*post_code_rating_21p216 +
&post_code_rating_21p217_coeff.*post_code_rating_21p217 +
&portfolio_20p218_coeff.*portfolio_20p218 +
&portfolio_20p219_coeff.*portfolio_20p219 +
&port_desc_21p220_coeff.*port_desc_21p220 +
&port_desc_21p221_coeff.*port_desc_21p221 +
&port_desc_21p222_coeff.*port_desc_21p222 +
&prod_desc_30p223_coeff.*prod_desc_30p223 +
&prod_desc_30p224_coeff.*prod_desc_30p224 +
&age_since_loaded_0_np225_coeff.*max(0,age_since_loaded-0)/1 +
&age_since_loaded_5_np226_coeff.*max(0,age_since_loaded-5)/1 +
&loaded_amount_0_np227_coeff.*max(0,loaded_amount-0)/10000 +
&loaded_amount_800_np228_coeff.*max(0,loaded_amount-800)/10000 +
&loaded_amount_4000_np229_coeff.*max(0,loaded_amount-4000)/10000 +
&loaded_amount_10000_p230_coeff.*max(0,loaded_amount-10000)/10000 +
&gdp_21p231_coeff.*gdp_21p231 +
&gdp_21p232_coeff.*gdp_21p232 +
&latest_pay_aft_loadp233_coeff.*latest_pay_aft_loadp233 +
&latest_pay_aft_loadp234_coeff.*latest_pay_aft_loadp234 +
&latest_pay_aft_loadp235_coeff.*latest_pay_aft_loadp235 +
&latest_pay_aft_loadp236_coeff.*latest_pay_aft_loadp236 +
&latest_pay_aft_loadp237_coeff.*latest_pay_aft_loadp237 +
&latest_pay_aft_loadp238_coeff.*latest_pay_aft_loadp238 +
&latest_pay_aft_loadp239_coeff.*latest_pay_aft_loadp239 +
&latest_pay_aft_loadp240_coeff.*latest_pay_aft_loadp240 +
&latest_pay_aft_loadp241_coeff.*latest_pay_aft_loadp241 +
&Number_of_Defaults_2p242_coeff.*Number_of_Defaults_2p242 +
&Number_of_Defaults_2p243_coeff.*Number_of_Defaults_2p243 +
&Number_of_Defaults_2p244_coeff.*Number_of_Defaults_2p244 +
&Number_of_Defaults_2p245_coeff.*Number_of_Defaults_2p245 +
&Number_of_Defaults_2p246_coeff.*Number_of_Defaults_2p246 +
&Number_of_Defaults_2p247_coeff.*Number_of_Defaults_2p247 +
&open_n_0p248_coeff.*max(0,open_to_load-0)/1 +
&open_n_1p249_coeff.*max(0,open_to_load-1)/1 +
&open_n_5p250_coeff.*max(0,open_to_load-5)/1;





	mu_00 = exp(xbeta_00);
	run;
%mend banking_proportion_00;


%macro banking_probability_10(a=,b=);
%let var_list =
Interceptb1_coeff
age_n_2b2_coeff
age_n_3b3_coeff
age_n_6b4_coeff
loaded_n_0b5_coeff
loaded_n_075b6_coeff
loaded_n_1b7_coeff
gender_2b8_coeff
gender_2b9_coeff
phone_count_2b10_coeff
phone_count_2b11_coeff
phone_count_2b12_coeff
phone_count_2b13_coeff
debtor_age_1b14_coeff
debtor_age_1b15_coeff
debtor_age_1b16_coeff
debtor_age_1b17_coeff
debtor_age_1b18_coeff
last_pt4b19_coeff
last_pt4b20_coeff
last_pt4b21_coeff
last_pt4b22_coeff
last_pt4b23_coeff
last_pt4b24_coeff
last_pt4b25_coeff
gdp_2b26_coeff
gdp_2b27_coeff
post_code_rating_8b28_coeff
post_code_rating_8b29_coeff
post_code_rating_8b30_coeff
post_code_rating_8b31_coeff
portfolio_1b32_coeff
portfolio_1b33_coeff
portfolio_1b34_coeff
port_desc_1b35_coeff
port_desc_1b36_coeff
port_desc_1b37_coeff
port_desc_1b38_coeff
port_desc_1b39_coeff
port_desc_1b40_coeff
product_1b41_coeff
product_1b42_coeff
prod_desc_1b43_coeff
prod_desc_1b44_coeff
lp_amount_2b45_coeff
lp_amount_2b46_coeff
lp_amount_2b47_coeff
lp_amount_2b48_coeff
referral_typeb49_coeff
referral_typeb50_coeff
open_n_0b51_coeff
open_n_1b52_coeff
open_n_6b53_coeff

;



proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Jack\Adjustment Files\banking_model_adjustments_nz.xlsx"
out = jack.banking_factors_10 replace
dbms = excel;
sheet = "pricing-reforecast probability";
run;
/*Table name with coefficients goes here*/
%let file = jack.banking_factors_10;

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
gender_2b8 = 0;
gender_2b9 = 0;
phone_count_2b10 = 0;
phone_count_2b11 = 0;
phone_count_2b12 = 0;
phone_count_2b13 = 0;
debtor_age_1b14 = 0;
debtor_age_1b15 = 0;
debtor_age_1b16 = 0;
debtor_age_1b17 = 0;
debtor_age_1b18 = 0;
last_pt4b19 = 0;
last_pt4b20 = 0;
last_pt4b21 = 0;
last_pt4b22 = 0;
last_pt4b23 = 0;
last_pt4b24 = 0;
last_pt4b25 = 0;
gdp_2b26 = 0;
gdp_2b27 = 0;
post_code_rating_8b28 = 0;
post_code_rating_8b29 = 0;
post_code_rating_8b30 = 0;
post_code_rating_8b31 = 0;
portfolio_1b32 = 0;
portfolio_1b33 = 0;
portfolio_1b34 = 0;
port_desc_1b35 = 0;
port_desc_1b36 = 0;
port_desc_1b37 = 0;
port_desc_1b38 = 0;
port_desc_1b39 = 0;
port_desc_1b40 = 0;
product_1b41 = 0;
product_1b42 = 0;
prod_desc_1b43 = 0;
prod_desc_1b44 = 0;
lp_amount_2b45 = 0;
lp_amount_2b46 = 0;
lp_amount_2b47 = 0;
lp_amount_2b48 = 0;
referral_typeb49 = 0;
referral_typeb50 = 0;






if gender_2 = 'F' then gender_2b8 = 1;
if gender_2 = 'M&?' then gender_2b9 = 1;
if phone_count_2 = '1' then phone_count_2b10 = 1;
if phone_count_2 = '2' then phone_count_2b11 = 1;
if phone_count_2 = '3' then phone_count_2b12 = 1;
if phone_count_2 = 'z0' then phone_count_2b13 = 1;
if debtor_age_1 = '1: 18 - 24 Yrs' then debtor_age_1b14 = 1;
if debtor_age_1 = '5: 55 - 64 Yrs' then debtor_age_1b15 = 1;
if debtor_age_1 = '6: 65 Yrs +' then debtor_age_1b16 = 1;
if debtor_age_1 = '7: Missing' then debtor_age_1b17 = 1;
if debtor_age_1 = 'z2: 25-54Yrs' then debtor_age_1b18 = 1;
if last_pt4 = '24-36' then last_pt4b19 = 1;
if last_pt4 = '36-48' then last_pt4b20 = 1;
if last_pt4 = '48-60' then last_pt4b21 = 1;
if last_pt4 = '60+' then last_pt4b22 = 1;
if last_pt4 = 'Missing' then last_pt4b23 = 1;
if last_pt4 = 'NoPayment' then last_pt4b24 = 1;
if last_pt4 = 'z0-24' then last_pt4b25 = 1;
if gdp_2 = '>110' then gdp_2b26 = 1;
if gdp_2 = 'z' then gdp_2b27 = 1;
if post_code_rating_8 = '0-1' then post_code_rating_8b28 = 1;
if post_code_rating_8 = 'Missing' then post_code_rating_8b29 = 1;
if post_code_rating_8 = 'Overseas' then post_code_rating_8b30 = 1;
if post_code_rating_8 = 'z1-10' then post_code_rating_8b31 = 1;
if portfolio_1 = 'Large Account' then portfolio_1b32 = 1;
if portfolio_1 = 'Medium Account' then portfolio_1b33 = 1;
if portfolio_1 = 'zCorporate/Major Account' then portfolio_1b34 = 1;
if port_desc_1 = 'ANZ' then port_desc_1b35 = 1;
if port_desc_1 = 'ConsumerFinance/RetailFS' then port_desc_1b36 = 1;
if port_desc_1 = 'Flexigroup' then port_desc_1b37 = 1;
if port_desc_1 = 'Ford Credit' then port_desc_1b38 = 1;
if port_desc_1 = 'Hopscotch Money' then port_desc_1b39 = 1;
if port_desc_1 = 'zWest/Dom/MS/HD/GE' then port_desc_1b40 = 1;
if product_1 = 'Loans' then product_1b41 = 1;
if product_1 = 'zCredit Card/Banking' then product_1b42 = 1;
if prod_desc_1 = 'HL/GEMV' then prod_desc_1b43 = 1;
if prod_desc_1 = 'zRetail/Personal/CarLoan/Other' then prod_desc_1b44 = 1;
if lp_amount_2 = '0-50 + ?' then lp_amount_2b45 = 1;
if lp_amount_2 = '100-400' then lp_amount_2b46 = 1;
if lp_amount_2 = '400+' then lp_amount_2b47 = 1;
if lp_amount_2 = 'z50-100' then lp_amount_2b48 = 1;
if referral_type = '1 & ?' then referral_typeb49 = 1;
if referral_type = 'z0' then referral_typeb50 = 1;




xbeta_10 =
&Interceptb1_coeff. +
&age_n_2b2_coeff.*max(0,age_since_loaded-2)/1 +
&age_n_3b3_coeff.*max(0,age_since_loaded-3)/1 +
&age_n_6b4_coeff.*max(0,age_since_loaded-6)/1 +
&loaded_n_0b5_coeff.*max(0,loaded_amount-0)/10000 +
&loaded_n_075b6_coeff.*max(0,loaded_amount-750)/10000 +
&loaded_n_1b7_coeff.*max(0,loaded_amount-1000)/10000 +
&gender_2b8_coeff.*gender_2b8 +
&gender_2b9_coeff.*gender_2b9 +
&phone_count_2b10_coeff.*phone_count_2b10 +
&phone_count_2b11_coeff.*phone_count_2b11 +
&phone_count_2b12_coeff.*phone_count_2b12 +
&phone_count_2b13_coeff.*phone_count_2b13 +
&debtor_age_1b14_coeff.*debtor_age_1b14 +
&debtor_age_1b15_coeff.*debtor_age_1b15 +
&debtor_age_1b16_coeff.*debtor_age_1b16 +
&debtor_age_1b17_coeff.*debtor_age_1b17 +
&debtor_age_1b18_coeff.*debtor_age_1b18 +
&last_pt4b19_coeff.*last_pt4b19 +
&last_pt4b20_coeff.*last_pt4b20 +
&last_pt4b21_coeff.*last_pt4b21 +
&last_pt4b22_coeff.*last_pt4b22 +
&last_pt4b23_coeff.*last_pt4b23 +
&last_pt4b24_coeff.*last_pt4b24 +
&last_pt4b25_coeff.*last_pt4b25 +
&gdp_2b26_coeff.*gdp_2b26 +
&gdp_2b27_coeff.*gdp_2b27 +
&post_code_rating_8b28_coeff.*post_code_rating_8b28 +
&post_code_rating_8b29_coeff.*post_code_rating_8b29 +
&post_code_rating_8b30_coeff.*post_code_rating_8b30 +
&post_code_rating_8b31_coeff.*post_code_rating_8b31 +
&portfolio_1b32_coeff.*portfolio_1b32 +
&portfolio_1b33_coeff.*portfolio_1b33 +
&portfolio_1b34_coeff.*portfolio_1b34 +
&port_desc_1b35_coeff.*port_desc_1b35 +
&port_desc_1b36_coeff.*port_desc_1b36 +
&port_desc_1b37_coeff.*port_desc_1b37 +
&port_desc_1b38_coeff.*port_desc_1b38 +
&port_desc_1b39_coeff.*port_desc_1b39 +
&port_desc_1b40_coeff.*port_desc_1b40 +
&product_1b41_coeff.*product_1b41 +
&product_1b42_coeff.*product_1b42 +
&prod_desc_1b43_coeff.*prod_desc_1b43 +
&prod_desc_1b44_coeff.*prod_desc_1b44 +
&lp_amount_2b45_coeff.*lp_amount_2b45 +
&lp_amount_2b46_coeff.*lp_amount_2b46 +
&lp_amount_2b47_coeff.*lp_amount_2b47 +
&lp_amount_2b48_coeff.*lp_amount_2b48 +
&referral_typeb49_coeff.*referral_typeb49 +
&referral_typeb50_coeff.*referral_typeb50 +
&open_n_0b51_coeff.*max(0,open_to_load-0)/1 +
&open_n_1b52_coeff.*max(0,open_to_load-1)/1 +
&open_n_6b53_coeff.*max(0,open_to_load-6)/1;

	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend banking_probability_10;

%macro banking_forecast (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Reforecast\Banking_Reforecast_Proportion_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded+12;*/
/*	age_since_loaded = 12;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

%banking_proportion_00(x=jack.bpnz,y=jack.bpnz_1)
/*%banking_proportion_00(x=dilan.bank_prediction_nz_cap,y=dilan.bank_prediction_nz_1_cap)*/

data &a;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Reforecast\Banking_Pricing&Reforecast_Probability_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded+12;*/
/*	age_since_loaded = 8;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

%banking_probability_10(a=jack.bpnz_2,b=jack.bpnz_3)
/*%banking_probability_10(a=dilan.bank_prediction_nz_2_cap,b=dilan.bank_prediction_nz_3_cap)*/

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
	set &e (keep = client_ledger_number account_number loaded_amount payments_total current_balance pdl status portfolio mu_00 p_10 age_since_loaded_1 portfolio port_desc product debtor_age_at_load_band prod_desc Gender Phone_Count);
	predicted_payments = mu_00*p_10*loaded_amount;
	run;

proc sql;
	create table &outfile as
	select avg(p_10), Loaded_Amount, Status, Portfolio,	PDL, Payments_Total, Current_Balance, mu_00, predicted_payments, age_since_loaded_1
 	from &f
	group by client_ledger_number, account_number;
	quit
	run;

%mend banking_forecast;



%banking_forecast (infile=jeff.hist_accts_banking_15_nz,x=jack.bpnz,y=jack.bpnz_1,a=jack.bpnz_2,b=jack.bpnz_3,d=jack.bpnz_4,e=jack.bpnz_5,f=jack.bpnz_6_&looped.,outfile=jack.bpnz_7);
/*%banking_forecast (infile=jeff.historical_accounts_bank_50_nz,x=dilan.banking_prediction_nz_cap,y=dilan.banking_prediction_nz_1_cap,a=dilan.banking_prediction_nz_2_cap,b=dilan.banking_prediction_nz_3_cap,d=dilan.banking_prediction_nz_4_cap,e=dilan.banking_prediction_nz_5_cap,f=dilan.banking_prediction_nz_6_cap,outfile=dilan.banking_prediction_nz_7_cap);*/








%end;

%mend alltime;

%alltime;




