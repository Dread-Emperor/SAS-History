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
Interceptp1_coeff
phone_count_21p2_coeff
phone_count_21p3_coeff
phone_count_21p4_coeff
lp_amount_31p5_coeff
lp_amount_31p6_coeff
lp_amount_31p7_coeff
lp_amount_31p8_coeff
lp_amount_31p9_coeff
lp_amount_31p10_coeff
lp_amount_31p11_coeff
gender_21p12_coeff
gender_21p13_coeff
post_code_rating_21p14_coeff
post_code_rating_21p15_coeff
post_code_rating_21p16_coeff
post_code_rating_21p17_coeff
portfolio_20p18_coeff
portfolio_20p19_coeff
port_desc_20p20_coeff
port_desc_20p21_coeff
port_desc_20p22_coeff
port_desc_20p23_coeff
prod_desc_30p24_coeff
prod_desc_30p25_coeff
prod_desc_30p26_coeff
prod_desc_30p27_coeff
prod_desc_30p28_coeff
age_since_loaded_0_np29_coeff
age_since_loaded_5_np30_coeff
loaded_amount_0_np31_coeff
loaded_amount_800_np32_coeff
loaded_amount_4000_np33_coeff
loaded_amount_10000_p34_coeff
gdp_21p35_coeff
gdp_21p36_coeff
open_n_1p37_coeff
open_n_2p38_coeff



;

proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Jack\Adjustment Files\banking_model_adjustments_nz_new_pc.xlsx"
out = jack.banking_factors_00 replace
dbms = excel;
sheet = "pricing proportion";
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

phone_count_21p2 = 0;
phone_count_21p3 = 0;
phone_count_21p4 = 0;
lp_amount_31p5 = 0;
lp_amount_31p6 = 0;
lp_amount_31p7 = 0;
lp_amount_31p8 = 0;
lp_amount_31p9 = 0;
lp_amount_31p10 = 0;
lp_amount_31p11 = 0;
gender_21p12 = 0;
gender_21p13 = 0;
post_code_rating_21p14 = 0;
post_code_rating_21p15 = 0;
post_code_rating_21p16 = 0;
post_code_rating_21p17 = 0;
portfolio_20p18 = 0;
portfolio_20p19 = 0;
port_desc_20p20 = 0;
port_desc_20p21 = 0;
port_desc_20p22 = 0;
port_desc_20p23 = 0;
prod_desc_30p24 = 0;
prod_desc_30p25 = 0;
prod_desc_30p26 = 0;
prod_desc_30p27 = 0;
prod_desc_30p28 = 0;
gdp_21p35 = 0;
gdp_21p36 = 0;








if phone_count_21 = '2' then phone_count_21p2 = 1;
if phone_count_21 = '3' then phone_count_21p3 = 1;
if phone_count_21 = 'z0-1' then phone_count_21p4 = 1;
if lp_amount_31 = '0-25' then lp_amount_31p5 = 1;
if lp_amount_31 = '100-200' then lp_amount_31p6 = 1;
if lp_amount_31 = '200-500' then lp_amount_31p7 = 1;
if lp_amount_31 = '25-50' then lp_amount_31p8 = 1;
if lp_amount_31 = '500+' then lp_amount_31p9 = 1;
if lp_amount_31 = 'NoPaymt' then lp_amount_31p10 = 1;
if lp_amount_31 = 'z50-100' then lp_amount_31p11 = 1;
if gender_21 = 'F' then gender_21p12 = 1;
if gender_21 = 'zM&?' then gender_21p13 = 1;
if post_code_rating_21 = '0-5' then post_code_rating_21p14 = 1;
if post_code_rating_21 = 'Missing' then post_code_rating_21p15 = 1;
if post_code_rating_21 = 'Overseas' then post_code_rating_21p16 = 1;
if post_code_rating_21 = 'z5-10' then post_code_rating_21p17 = 1;
if portfolio_20 = 'Medium Account' then portfolio_20p18 = 1;
if portfolio_20 = 'zCorporate/Major/Large Account' then portfolio_20p19 = 1;
if port_desc_20 = 'ANZ' then port_desc_20p20 = 1;
if port_desc_20 = 'Flexi/Home' then port_desc_20p21 = 1;
if port_desc_20 = 'Ford/Retail' then port_desc_20p22 = 1;
if port_desc_20 = 'zGE/Hop/Money/Cons/West' then port_desc_20p23 = 1;
if prod_desc_30 = 'Car/Other' then prod_desc_30p24 = 1;
if prod_desc_30 = 'Gems Visa' then prod_desc_30p25 = 1;
if prod_desc_30 = 'Personal/Home Loan' then prod_desc_30p26 = 1;
if prod_desc_30 = 'Unknown' then prod_desc_30p27 = 1;
if prod_desc_30 = 'zCreditline/Retail' then prod_desc_30p28 = 1;
if gdp_21 = '108+' then gdp_21p35 = 1;
if gdp_21 = 'z108- & ?' then gdp_21p36 = 1;












	xbeta_00 = 
&Interceptp1_coeff. +
&phone_count_21p2_coeff.*phone_count_21p2 +
&phone_count_21p3_coeff.*phone_count_21p3 +
&phone_count_21p4_coeff.*phone_count_21p4 +
&lp_amount_31p5_coeff.*lp_amount_31p5 +
&lp_amount_31p6_coeff.*lp_amount_31p6 +
&lp_amount_31p7_coeff.*lp_amount_31p7 +
&lp_amount_31p8_coeff.*lp_amount_31p8 +
&lp_amount_31p9_coeff.*lp_amount_31p9 +
&lp_amount_31p10_coeff.*lp_amount_31p10 +
&lp_amount_31p11_coeff.*lp_amount_31p11 +
&gender_21p12_coeff.*gender_21p12 +
&gender_21p13_coeff.*gender_21p13 +
&post_code_rating_21p14_coeff.*post_code_rating_21p14 +
&post_code_rating_21p15_coeff.*post_code_rating_21p15 +
&post_code_rating_21p16_coeff.*post_code_rating_21p16 +
&post_code_rating_21p17_coeff.*post_code_rating_21p17 +
&portfolio_20p18_coeff.*portfolio_20p18 +
&portfolio_20p19_coeff.*portfolio_20p19 +
&port_desc_20p20_coeff.*port_desc_20p20 +
&port_desc_20p21_coeff.*port_desc_20p21 +
&port_desc_20p22_coeff.*port_desc_20p22 +
&port_desc_20p23_coeff.*port_desc_20p23 +
&prod_desc_30p24_coeff.*prod_desc_30p24 +
&prod_desc_30p25_coeff.*prod_desc_30p25 +
&prod_desc_30p26_coeff.*prod_desc_30p26 +
&prod_desc_30p27_coeff.*prod_desc_30p27 +
&prod_desc_30p28_coeff.*prod_desc_30p28 +
&age_since_loaded_0_np29_coeff.*max(0,age_since_loaded-0)/1 +
&age_since_loaded_5_np30_coeff.*max(0,age_since_loaded-5)/1 +
&loaded_amount_0_np31_coeff.*max(0,loaded_amount-0)/10000 +
&loaded_amount_800_np32_coeff.*max(0,loaded_amount-800)/10000 +
&loaded_amount_4000_np33_coeff.*max(0,loaded_amount-4000)/10000 +
&loaded_amount_10000_p34_coeff.*max(0,loaded_amount-10000)/10000 +
&gdp_21p35_coeff.*gdp_21p35 +
&gdp_21p36_coeff.*gdp_21p36 +
&open_n_1p37_coeff.*max(0,open_to_load-1)/1 +
&open_n_2p38_coeff.*max(0,open_to_load-2)/1;




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
unemploy_2b25_coeff
unemploy_2b26_coeff
post_code_rating_8b27_coeff
post_code_rating_8b28_coeff
post_code_rating_8b29_coeff
portfolio_1b30_coeff
portfolio_1b31_coeff
portfolio_1b32_coeff
port_desc_1b33_coeff
port_desc_1b34_coeff
port_desc_1b35_coeff
port_desc_1b36_coeff
product_1b37_coeff
product_1b38_coeff
product_1b39_coeff
prod_desc_1b40_coeff
prod_desc_1b41_coeff
lp_amount_2b42_coeff
lp_amount_2b43_coeff
lp_amount_2b44_coeff
lp_amount_2b45_coeff
referral_typeb46_coeff
referral_typeb47_coeff
open_n_0b48_coeff
open_n_1b49_coeff
open_n_6b50_coeff


;

proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Jack\Adjustment Files\banking_model_adjustments_nz_new_pc.xlsx"
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
unemploy_2b25 = 0;
unemploy_2b26 = 0;
post_code_rating_8b27 = 0;
post_code_rating_8b28 = 0;
post_code_rating_8b29 = 0;
portfolio_1b30 = 0;
portfolio_1b31 = 0;
portfolio_1b32 = 0;
port_desc_1b33 = 0;
port_desc_1b34 = 0;
port_desc_1b35 = 0;
port_desc_1b36 = 0;
product_1b37 = 0;
product_1b38 = 0;
product_1b39 = 0;
prod_desc_1b40 = 0;
prod_desc_1b41 = 0;
lp_amount_2b42 = 0;
lp_amount_2b43 = 0;
lp_amount_2b44 = 0;
lp_amount_2b45 = 0;
referral_typeb46 = 0;
referral_typeb47 = 0;









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
if last_pt4 = 'NoPayment' then last_pt4b23 = 1;
if last_pt4 = 'z0-24' then last_pt4b24 = 1;
if unemploy_2 = '5.4 - 5.8' then unemploy_2b25 = 1;
if unemploy_2 = 'z5.9+' then unemploy_2b26 = 1;
if post_code_rating_8 = '0-1' then post_code_rating_8b27 = 1;
if post_code_rating_8 = 'Miss/Overseas' then post_code_rating_8b28 = 1;
if post_code_rating_8 = 'z1-10' then post_code_rating_8b29 = 1;
if portfolio_1 = 'Large Account' then portfolio_1b30 = 1;
if portfolio_1 = 'Medium Account' then portfolio_1b31 = 1;
if portfolio_1 = 'zCorporate/Major Account' then portfolio_1b32 = 1;
if port_desc_1 = 'ANZ' then port_desc_1b33 = 1;
if port_desc_1 = 'Ford/Flexi' then port_desc_1b34 = 1;
if port_desc_1 = 'GE/Money/Dom' then port_desc_1b35 = 1;
if port_desc_1 = 'zWest/HD/MS/HM/ANZ' then port_desc_1b36 = 1;
if product_1 = 'Banking/Rental' then product_1b37 = 1;
if product_1 = 'Finance' then product_1b38 = 1;
if product_1 = 'zCredit Card/Loans' then product_1b39 = 1;
if prod_desc_1 = 'Personal Loan' then prod_desc_1b40 = 1;
if prod_desc_1 = 'zRetail/GV/Home/CarLoan/Other' then prod_desc_1b41 = 1;
if lp_amount_2 = '0-50 + ?' then lp_amount_2b42 = 1;
if lp_amount_2 = '100-400' then lp_amount_2b43 = 1;
if lp_amount_2 = '400+' then lp_amount_2b44 = 1;
if lp_amount_2 = 'z50-100' then lp_amount_2b45 = 1;
if referral_type = '1 & ?' then referral_typeb46 = 1;
if referral_type = 'z0' then referral_typeb47 = 1;





	


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
&unemploy_2b25_coeff.*unemploy_2b25 +
&unemploy_2b26_coeff.*unemploy_2b26 +
&post_code_rating_8b27_coeff.*post_code_rating_8b27 +
&post_code_rating_8b28_coeff.*post_code_rating_8b28 +
&post_code_rating_8b29_coeff.*post_code_rating_8b29 +
&portfolio_1b30_coeff.*portfolio_1b30 +
&portfolio_1b31_coeff.*portfolio_1b31 +
&portfolio_1b32_coeff.*portfolio_1b32 +
&port_desc_1b33_coeff.*port_desc_1b33 +
&port_desc_1b34_coeff.*port_desc_1b34 +
&port_desc_1b35_coeff.*port_desc_1b35 +
&port_desc_1b36_coeff.*port_desc_1b36 +
&product_1b37_coeff.*product_1b37 +
&product_1b38_coeff.*product_1b38 +
&product_1b39_coeff.*product_1b39 +
&prod_desc_1b40_coeff.*prod_desc_1b40 +
&prod_desc_1b41_coeff.*prod_desc_1b41 +
&lp_amount_2b42_coeff.*lp_amount_2b42 +
&lp_amount_2b43_coeff.*lp_amount_2b43 +
&lp_amount_2b44_coeff.*lp_amount_2b44 +
&lp_amount_2b45_coeff.*lp_amount_2b45 +
&referral_typeb46_coeff.*referral_typeb46 +
&referral_typeb47_coeff.*referral_typeb47 +
&open_n_0b48_coeff.*max(0,open_to_load-0)/1 +
&open_n_1b49_coeff.*max(0,open_to_load-1)/1 +
&open_n_6b50_coeff.*max(0,open_to_load-6)/1;





	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend banking_probability_10;


%macro banking_pricing (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Pricing\Banking_Pricing_Proportion_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded+12;*/
/*	age_since_loaded = 12;*/
/*	age_since_loaded = min(max(12 - round(Last_Payment_To_Loaded/6,1),0),12);*/
/*	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);*/
	age_since_loaded = max(round((((&cutoffdate. - loaded_date)/365.25)*2),1),0);
	run;

%banking_proportion_00(x=jack.bpp,y=jack.bpp_1)

data &a;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Pricing\Banking_Pricing&Reforecast_Probability_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded+12;*/
/*	age_since_loaded = 8;*/
/*	age_since_loaded = min(max(12 - round(Last_Payment_To_Loaded/6,1),0),12);*/
/*	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);*/
	age_since_loaded = max(round((((&cutoffdate. - loaded_date)/365.25)*2),1),0);
	run;

%banking_probability_10(a=jack.bpp_2,b=jack.bpp_3)

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
	set &e (keep = client_ledger_number account_number loaded_amount payments_total current_balance pdl status portfolio mu_00 p_10 age_since_loaded_1 portfolio port_desc product debtor_age_at_load_band prod_desc Gender Phone_Count phone_count_price);
	predicted_payments = mu_00*p_10*loaded_amount;
	run;

proc sql;
	create table &outfile as
	select avg(p_10), Loaded_Amount, Status, Portfolio,	PDL, Payments_Total, Current_Balance, mu_00, predicted_payments, age_since_loaded_1
 	from &f
	group by client_ledger_number, account_number;
	quit
	run;

%mend banking_pricing;



%banking_pricing (infile=jeff.hist_accts_banking_15_nz_2,x=jack.bpp,y=jack.bpp_1,a=jack.bpp_2,b=jack.bpp_3,d=jack.bpp_4,e=jack.bpp_5,f=jack.bpp_6_&looped.,outfile=jack.bpp_7);
/*%banking_forecast (infile=jeff.historical_accounts_bank_50_nz,x=dilan.banking_prediction_nz_cap,y=dilan.banking_prediction_nz_1_cap,a=dilan.banking_prediction_nz_2_cap,b=dilan.banking_prediction_nz_3_cap,d=dilan.banking_prediction_nz_4_cap,e=dilan.banking_prediction_nz_5_cap,f=dilan.banking_prediction_nz_6_cap,outfile=dilan.banking_prediction_nz_7_cap);*/





%end;

%mend alltime;

%alltime;




