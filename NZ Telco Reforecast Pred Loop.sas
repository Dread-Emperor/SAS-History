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

%macro telco_proportion_00(x=,y=);
%let var_list =
	Interceptp21_coeff
	Post_Code_Rating_4p22_coeff
	Post_Code_Rating_4p23_coeff
	Post_Code_Rating_4p24_coeff
	Post_Code_Rating_4p25_coeff
	Gender_2p26_coeff
	Gender_2p27_coeff
	Phone_Count_2p28_coeff
	Phone_Count_2p29_coeff
	Phone_Count_2p210_coeff
	Phone_Count_2p211_coeff
	Last_Payment_To_Loadep212_coeff
	Last_Payment_To_Loadep213_coeff
	Last_Payment_To_Loadep214_coeff
	age_since_loaded_0_np215_coeff
	age_since_loaded_7_np216_coeff
	loaded_amount_0_np217_coeff
	loaded_amount_1500_np218_coeff
	loaded_amount_2500_np219_coeff
	debt_age_at_load_bandp220_coeff
	debt_age_at_load_bandp221_coeff
	Number_of_Defaults_2p222_coeff
	Number_of_Defaults_2p223_coeff
	Number_of_Defaults_2p224_coeff
	Number_of_Defaults_2p225_coeff
	Number_of_Defaults_2p226_coeff
	load_payt_0_np227_coeff
	load_payt_4_np228_coeff
;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\telco_model_adjustments_NZ.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\telco_model_adjustments_nz.xlsx"*/
out = jeff.telco_factors_00 replace
dbms = excel;
sheet = "reforecast proportion";
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

	Post_Code_Rating_4p22 = 0;
	Post_Code_Rating_4p23 = 0;
	Post_Code_Rating_4p24 = 0;
	Post_Code_Rating_4p25 = 0;
	Gender_2p26 = 0;
	Gender_2p27 = 0;
	Phone_Count_2p28 = 0;
	Phone_Count_2p29 = 0;
	Phone_Count_2p210 = 0;
	Phone_Count_2p211 = 0;
	Last_Payment_To_Loadep212 = 0;
	Last_Payment_To_Loadep213 = 0;
	Last_Payment_To_Loadep214 = 0;
	debt_age_at_load_bandp220 = 0;
	debt_age_at_load_bandp221 = 0;
	Number_of_Defaults_2p222 = 0;
	Number_of_Defaults_2p223 = 0;
	Number_of_Defaults_2p224 = 0;
	Number_of_Defaults_2p225 = 0;
	Number_of_Defaults_2p226 = 0;

	if Post_Code_Rating_4 = '0-3' then Post_Code_Rating_4p22 = 1;
	if Post_Code_Rating_4 = '3-5' then Post_Code_Rating_4p23 = 1;
	if Post_Code_Rating_4 = 'Overseas/Miss' then Post_Code_Rating_4p24 = 1;
	if Post_Code_Rating_4 = 'z5-10' then Post_Code_Rating_4p25 = 1;
	if Gender_2 = 'M&?' then Gender_2p26 = 1;
	if Gender_2 = 'zF' then Gender_2p27 = 1;
	if Phone_Count_2 = '0' then Phone_Count_2p28 = 1;
	if Phone_Count_2 = '2' then Phone_Count_2p29 = 1;
	if Phone_Count_2 = '3' then Phone_Count_2p210 = 1;
	if Phone_Count_2 = 'z1' then Phone_Count_2p211 = 1;
	if Last_Payment_To_Loaded_band_1 = '0-12' then Last_Payment_To_Loadep212 = 1;
	if Last_Payment_To_Loaded_band_1 = 'Miss' then Last_Payment_To_Loadep213 = 1;
	if Last_Payment_To_Loaded_band_1 = 'z12+' then Last_Payment_To_Loadep214 = 1;
	if debt_age_at_load_band_2 = '<=18 Mths' then debt_age_at_load_bandp220 = 1;
	if debt_age_at_load_band_2 = 'z>18 Mths' then debt_age_at_load_bandp221 = 1;
	if Number_of_Defaults_2 = '1' then Number_of_Defaults_2p222 = 1;
	if Number_of_Defaults_2 = '2' then Number_of_Defaults_2p223 = 1;
	if Number_of_Defaults_2 = '3' then Number_of_Defaults_2p224 = 1;
	if Number_of_Defaults_2 = '4+' then Number_of_Defaults_2p225 = 1;
	if Number_of_Defaults_2 = 'z0' then Number_of_Defaults_2p226 = 1;

	xbeta_00 = 
	&Interceptp21_coeff. +
	&Post_Code_Rating_4p22_coeff.*Post_Code_Rating_4p22 +
	&Post_Code_Rating_4p23_coeff.*Post_Code_Rating_4p23 +
	&Post_Code_Rating_4p24_coeff.*Post_Code_Rating_4p24 +
	&Post_Code_Rating_4p25_coeff.*Post_Code_Rating_4p25 +
	&Gender_2p26_coeff.*Gender_2p26 +
	&Gender_2p27_coeff.*Gender_2p27 +
	&Phone_Count_2p28_coeff.*Phone_Count_2p28 +
	&Phone_Count_2p29_coeff.*Phone_Count_2p29 +
	&Phone_Count_2p210_coeff.*Phone_Count_2p210 +
	&Phone_Count_2p211_coeff.*Phone_Count_2p211 +
	&Last_Payment_To_Loadep212_coeff.*Last_Payment_To_Loadep212 +
	&Last_Payment_To_Loadep213_coeff.*Last_Payment_To_Loadep213 +
	&Last_Payment_To_Loadep214_coeff.*Last_Payment_To_Loadep214 +
	&age_since_loaded_0_np215_coeff.*max(0,age_since_loaded-0)/1 +
	&age_since_loaded_7_np216_coeff.*max(0,age_since_loaded-7)/1 +
	&loaded_amount_0_np217_coeff.*max(0,loaded_amount-0)/10000 +
	&loaded_amount_1500_np218_coeff.*max(0,loaded_amount-1500)/10000 +
	&loaded_amount_2500_np219_coeff.*max(0,loaded_amount-2500)/10000 +
	&debt_age_at_load_bandp220_coeff.*debt_age_at_load_bandp220 +
	&debt_age_at_load_bandp221_coeff.*debt_age_at_load_bandp221 +
	&Number_of_Defaults_2p222_coeff.*Number_of_Defaults_2p222 +
	&Number_of_Defaults_2p223_coeff.*Number_of_Defaults_2p223 +
	&Number_of_Defaults_2p224_coeff.*Number_of_Defaults_2p224 +
	&Number_of_Defaults_2p225_coeff.*Number_of_Defaults_2p225 +
	&Number_of_Defaults_2p226_coeff.*Number_of_Defaults_2p226 +
	&load_payt_0_np227_coeff.*max(0,Loaded_to_First_Paymt-0)/1 +
	&load_payt_4_np228_coeff.*max(0,Loaded_to_First_Paymt-4)/1;

	mu_00 = exp(xbeta_00);
	run;
%mend telco_proportion_00;


%macro telco_probability_10(a=,b=);
%let var_list =
	Interceptb21_coeff
	age_since_loaded_n_0b22_coeff
	age_since_loaded_n_4b23_coeff
	age_since_loaded_n_6b24_coeff
	Phone_Count_11b25_coeff
	Phone_Count_11b26_coeff
	Phone_Count_11b27_coeff
	Phone_Count_11b28_coeff
	Gender_11b29_coeff
	Gender_11b210_coeff
	Debtor_Age_At_Load_Bab211_coeff
	Debtor_Age_At_Load_Bab212_coeff
	Debtor_Age_At_Load_Bab213_coeff
	Debtor_Age_At_Load_Bab214_coeff
	Debtor_Age_At_Load_Bab215_coeff
	Debtor_Age_At_Load_Bab216_coeff
	Debtor_Age_At_Load_Bab217_coeff
	Last_payment_to_loadeb218_coeff
	Last_payment_to_loadeb219_coeff
	Last_payment_to_loadeb220_coeff
	Last_payment_to_loadeb221_coeff
	Last_payment_to_loadeb222_coeff
	Last_payment_to_loadeb223_coeff
	Post_Code_Rating_11b224_coeff
	Post_Code_Rating_11b225_coeff
	Post_Code_Rating_11b226_coeff
	Post_Code_Rating_11b227_coeff
	Phone_Home_Flag_10b228_coeff
	Phone_Home_Flag_10b229_coeff
	Phone_Mobile_Flag_10b230_coeff
	Phone_Mobile_Flag_10b231_coeff
	loaded_amount_0_nb232_coeff
	loaded_amount_800_nb233_coeff
	loaded_amount_1200_nb234_coeff
	loaded_amount_1300_nb235_coeff
	Debt_Age_At_Load_Bandb236_coeff
	Debt_Age_At_Load_Bandb237_coeff
	Debt_Age_At_Load_Bandb238_coeff
;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\telco_model_adjustments_NZ.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\telco_model_adjustments_nz.xlsx"*/
out = jeff.telco_factors_10 replace
dbms = excel;
sheet = "reforecast probability";
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

	Phone_Count_11b25 = 0;
	Phone_Count_11b26 = 0;
	Phone_Count_11b27 = 0;
	Phone_Count_11b28 = 0;
	Gender_11b29 = 0;
	Gender_11b210 = 0;
	Debtor_Age_At_Load_Bab211 = 0;
	Debtor_Age_At_Load_Bab212 = 0;
	Debtor_Age_At_Load_Bab213 = 0;
	Debtor_Age_At_Load_Bab214 = 0;
	Debtor_Age_At_Load_Bab215 = 0;
	Debtor_Age_At_Load_Bab216 = 0;
	Debtor_Age_At_Load_Bab217 = 0;
	Last_payment_to_loadeb218 = 0;
	Last_payment_to_loadeb219 = 0;
	Last_payment_to_loadeb220 = 0;
	Last_payment_to_loadeb221 = 0;
	Last_payment_to_loadeb222 = 0;
	Last_payment_to_loadeb223 = 0;
	Post_Code_Rating_11b224 = 0;
	Post_Code_Rating_11b225 = 0;
	Post_Code_Rating_11b226 = 0;
	Post_Code_Rating_11b227 = 0;
	Phone_Home_Flag_10b228 = 0;
	Phone_Home_Flag_10b229 = 0;
	Phone_Mobile_Flag_10b230 = 0;
	Phone_Mobile_Flag_10b231 = 0;
	Debt_Age_At_Load_Bandb236 = 0;
	Debt_Age_At_Load_Bandb237 = 0;
	Debt_Age_At_Load_Bandb238 = 0;

	if Phone_Count_11 = '1' then Phone_Count_11b25 = 1;
	if Phone_Count_11 = '2' then Phone_Count_11b26 = 1;
	if Phone_Count_11 = '3' then Phone_Count_11b27 = 1;
	if Phone_Count_11 = 'z0' then Phone_Count_11b28 = 1;
	if Gender_11 = 'F&?' then Gender_11b29 = 1;
	if Gender_11 = 'zM' then Gender_11b210 = 1;
	if Debtor_Age_At_Load_Band_10 = '1: 18 - 24 Yrs' then Debtor_Age_At_Load_Bab211 = 1;
	if Debtor_Age_At_Load_Band_10 = '3: 35 - 44 Yrs' then Debtor_Age_At_Load_Bab212 = 1;
	if Debtor_Age_At_Load_Band_10 = '4: 45 - 54 Yrs' then Debtor_Age_At_Load_Bab213 = 1;
	if Debtor_Age_At_Load_Band_10 = '5: 55 - 64 Yrs' then Debtor_Age_At_Load_Bab214 = 1;
	if Debtor_Age_At_Load_Band_10 = '6: 65 Yrs +' then Debtor_Age_At_Load_Bab215 = 1;
	if Debtor_Age_At_Load_Band_10 = '7: Missing' then Debtor_Age_At_Load_Bab216 = 1;
	if Debtor_Age_At_Load_Band_10 = 'z2:25-34Yrs' then Debtor_Age_At_Load_Bab217 = 1;
	if Last_payment_to_loaded_band_11 = '0-8' then Last_payment_to_loadeb218 = 1;
	if Last_payment_to_loaded_band_11 = '08-12' then Last_payment_to_loadeb219 = 1;
	if Last_payment_to_loaded_band_11 = '12-16' then Last_payment_to_loadeb220 = 1;
	if Last_payment_to_loaded_band_11 = '16-20' then Last_payment_to_loadeb221 = 1;
	if Last_payment_to_loaded_band_11 = 'Miss' then Last_payment_to_loadeb222 = 1;
	if Last_payment_to_loaded_band_11 = 'z20+' then Last_payment_to_loadeb223 = 1;
	if Post_Code_Rating_11 = '0-2' then Post_Code_Rating_11b224 = 1;
	if Post_Code_Rating_11 = 'Missing' then Post_Code_Rating_11b225 = 1;
	if Post_Code_Rating_11 = 'Overseas' then Post_Code_Rating_11b226 = 1;
	if Post_Code_Rating_11 = 'z2-10' then Post_Code_Rating_11b227 = 1;
	if Phone_Home_Flag_10 = '1' then Phone_Home_Flag_10b228 = 1;
	if Phone_Home_Flag_10 = 'z0' then Phone_Home_Flag_10b229 = 1;
	if Phone_Mobile_Flag_10 = '1' then Phone_Mobile_Flag_10b230 = 1;
	if Phone_Mobile_Flag_10 = 'z0' then Phone_Mobile_Flag_10b231 = 1;
	if Debt_Age_At_Load_Band_10 = '<=12 Mths' then Debt_Age_At_Load_Bandb236 = 1;
	if Debt_Age_At_Load_Band_10 = '>24 Mths' then Debt_Age_At_Load_Bandb237 = 1;
	if Debt_Age_At_Load_Band_10 = 'z13-24 Mths' then Debt_Age_At_Load_Bandb238 = 1;

xbeta_10 = 
	&Interceptb21_coeff. +
	&age_since_loaded_n_0b22_coeff.*max(0,age_since_loaded-0)/1 +
	&age_since_loaded_n_4b23_coeff.*max(0,age_since_loaded-4)/1 +
	&age_since_loaded_n_6b24_coeff.*max(0,age_since_loaded-6)/1 +
	&Phone_Count_11b25_coeff.*Phone_Count_11b25 +
	&Phone_Count_11b26_coeff.*Phone_Count_11b26 +
	&Phone_Count_11b27_coeff.*Phone_Count_11b27 +
	&Phone_Count_11b28_coeff.*Phone_Count_11b28 +
	&Gender_11b29_coeff.*Gender_11b29 +
	&Gender_11b210_coeff.*Gender_11b210 +
	&Debtor_Age_At_Load_Bab211_coeff.*Debtor_Age_At_Load_Bab211 +
	&Debtor_Age_At_Load_Bab212_coeff.*Debtor_Age_At_Load_Bab212 +
	&Debtor_Age_At_Load_Bab213_coeff.*Debtor_Age_At_Load_Bab213 +
	&Debtor_Age_At_Load_Bab214_coeff.*Debtor_Age_At_Load_Bab214 +
	&Debtor_Age_At_Load_Bab215_coeff.*Debtor_Age_At_Load_Bab215 +
	&Debtor_Age_At_Load_Bab216_coeff.*Debtor_Age_At_Load_Bab216 +
	&Debtor_Age_At_Load_Bab217_coeff.*Debtor_Age_At_Load_Bab217 +
	&Last_payment_to_loadeb218_coeff.*Last_payment_to_loadeb218 +
	&Last_payment_to_loadeb219_coeff.*Last_payment_to_loadeb219 +
	&Last_payment_to_loadeb220_coeff.*Last_payment_to_loadeb220 +
	&Last_payment_to_loadeb221_coeff.*Last_payment_to_loadeb221 +
	&Last_payment_to_loadeb222_coeff.*Last_payment_to_loadeb222 +
	&Last_payment_to_loadeb223_coeff.*Last_payment_to_loadeb223 +
	&Post_Code_Rating_11b224_coeff.*Post_Code_Rating_11b224 +
	&Post_Code_Rating_11b225_coeff.*Post_Code_Rating_11b225 +
	&Post_Code_Rating_11b226_coeff.*Post_Code_Rating_11b226 +
	&Post_Code_Rating_11b227_coeff.*Post_Code_Rating_11b227 +
	&Phone_Home_Flag_10b228_coeff.*Phone_Home_Flag_10b228 +
	&Phone_Home_Flag_10b229_coeff.*Phone_Home_Flag_10b229 +
	&Phone_Mobile_Flag_10b230_coeff.*Phone_Mobile_Flag_10b230 +
	&Phone_Mobile_Flag_10b231_coeff.*Phone_Mobile_Flag_10b231 +
	&loaded_amount_0_nb232_coeff.*max(0,loaded_amount-0)/10000 +
	&loaded_amount_800_nb233_coeff.*max(0,loaded_amount-800)/10000 +
	&loaded_amount_1200_nb234_coeff.*max(0,loaded_amount-1200)/10000 +
	&loaded_amount_1300_nb235_coeff.*max(0,loaded_amount-1300)/10000 +
	&Debt_Age_At_Load_Bandb236_coeff.*Debt_Age_At_Load_Bandb236 +
	&Debt_Age_At_Load_Bandb237_coeff.*Debt_Age_At_Load_Bandb237 +
	&Debt_Age_At_Load_Bandb238_coeff.*Debt_Age_At_Load_Bandb238;

	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend telco_probability_10;

/*There are 5 Different Versions for Age_Since_Loaded Below*/

%macro telco_forecast (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Reforecast\Telco_Reforecast_Proportion_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
	age_since_loaded = 12;
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = max(stat_bar,0);*/
/*	if Missing(Duration) then age_since_loaded = 12;*/
/*	else age_since_loaded = (2*duration) + 12;*/
/*	age_since_loaded = 9;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

/*%telco_proportion_00(x=dilan.telco_fore_nz,y=dilan.telco_fore_nz_1)*/
/*%telco_proportion_00(x=dilan.telco_fore_nz_12,y=dilan.telco_fore_nz_1_12)*/
/*%telco_proportion_00(x=dilan.telco_fore_nz_a12,y=dilan.telco_fore_nz_1_a12)*/
/*%telco_proportion_00(x=dilan.telco_fore_nz_sbar,y=dilan.telco_fore_nz_1_sbar)*/
/*%telco_proportion_00(x=dilan.telco_fore_nz_dur,y=dilan.telco_fore_nz_1_dur)*/
%telco_proportion_00(x=jack.tpnz,y=jack.tpnz_1)

data &a;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Reforecast\Telco_Pricing&Reforecast_Probability_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded = 12;
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = max(stat_bar,0);*/
/*	if Missing(Duration) then age_since_loaded = 12;*/
/*	else age_since_loaded = (2*duration) + 12;*/
/*	age_since_loaded = 11;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

/*%telco_probability_10(a=dilan.telco_fore_nz_2,b=dilan.telco_fore_nz_3)*/
/*%telco_probability_10(a=dilan.telco_fore_nz_2_12,b=dilan.telco_fore_nz_3_12)*/
/*%telco_probability_10(a=dilan.telco_fore_nz_2_a12,b=dilan.telco_fore_nz_3_a12)*/
/*%telco_probability_10(a=dilan.telco_fore_nz_2_sbar,b=dilan.telco_fore_nz_3_sbar)*/
/*%telco_probability_10(a=dilan.telco_fore_nz_2_dur,b=dilan.telco_fore_nz_3_dur)*/
%telco_probability_10(a=jack.tpnz_2,b=jack.tpnz_3)

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

%mend telco_forecast;



/*%telco_forecast (infile=jeff.historical_accounts_telco_51_nz,x=dilan.telco_fore_nz,y=dilan.telco_fore_nz_1,a=dilan.telco_fore_nz_2,b=dilan.telco_fore_nz_3,d=dilan.telco_fore_nz_4,e=dilan.telco_fore_nz_5,f=dilan.telco_fore_nz_6,outfile=dilan.telco_fore_nz_7);*/
/*%telco_forecast (infile=jeff.historical_accounts_telco_51_nz,x=dilan.telco_fore_nz_12,y=dilan.telco_fore_nz_1_12,a=dilan.telco_fore_nz_2_12,b=dilan.telco_fore_nz_3_12,d=dilan.telco_fore_nz_4_12,e=dilan.telco_fore_nz_5_12,f=dilan.telco_fore_nz_6_12,outfile=dilan.telco_fore_nz_7_12);*/
/*%telco_forecast (infile=jeff.historical_accounts_telco_51_nz,x=dilan.telco_fore_nz_a12,y=dilan.telco_fore_nz_1_a12,a=dilan.telco_fore_nz_2_a12,b=dilan.telco_fore_nz_3_a12,d=dilan.telco_fore_nz_4_a12,e=dilan.telco_fore_nz_5_a12,f=dilan.telco_fore_nz_6_a12,outfile=dilan.telco_fore_nz_7_a12);*/
/*%telco_forecast (infile=jeff.historical_accounts_telco_51_nz,x=dilan.telco_fore_nz_sbar,y=dilan.telco_fore_nz_1_sbar,a=dilan.telco_fore_nz_2_sbar,b=dilan.telco_fore_nz_3_sbar,d=dilan.telco_fore_nz_4_sbar,e=dilan.telco_fore_nz_5_sbar,f=dilan.telco_fore_nz_6_sbar,outfile=dilan.telco_fore_nz_7_sbar);*/
%telco_forecast (infile=jeff.hist_accts_telco_15_nz,x=jack.tpnz,y=jack.tpnz_1,a=jack.tpnz_2,b=jack.tpnz_3,d=jack.tpnz_4,e=jack.tpnz_5,f=jack.tpnz_6_&looped.,outfile=jack.tpnz_7);







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


