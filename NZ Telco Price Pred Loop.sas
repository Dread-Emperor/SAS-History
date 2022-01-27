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

%macro telco_proportion_00(x=,y=);
%let var_list =
Interceptp1_coeff
Post_Code_Rating_4p2_coeff
Post_Code_Rating_4p3_coeff
Post_Code_Rating_4p4_coeff
Post_Code_Rating_4p5_coeff
Gender_2p6_coeff
Gender_2p7_coeff
Phone_Count_2p8_coeff
Phone_Count_2p9_coeff
Phone_Count_2p10_coeff
Phone_Count_2p11_coeff
Last_Payment_To_Loadep12_coeff
Last_Payment_To_Loadep13_coeff
Last_Payment_To_Loadep14_coeff
age_since_loaded_0_np15_coeff
age_since_loaded_7_np16_coeff
loaded_amount_0_np17_coeff
loaded_amount_1500_np18_coeff
loaded_amount_2500_np19_coeff
debt_age_at_load_bandp20_coeff
debt_age_at_load_bandp21_coeff
;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\telco_model_adjustments_NZ.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\telco_model_adjustments_nz.xlsx"*/
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

	Post_Code_Rating_4p2 = 0;
	Post_Code_Rating_4p3 = 0;
	Post_Code_Rating_4p4 = 0;
	Post_Code_Rating_4p5 = 0;
	Gender_2p6 = 0;
	Gender_2p7 = 0;
	Phone_Count_2p8 = 0;
	Phone_Count_2p9 = 0;
	Phone_Count_2p10 = 0;
	Phone_Count_2p11 = 0;
	Last_Payment_To_Loadep12 = 0;
	Last_Payment_To_Loadep13 = 0;
	Last_Payment_To_Loadep14 = 0;
	debt_age_at_load_bandp20 = 0;
	debt_age_at_load_bandp21 = 0;


	if Post_Code_Rating_4 = '0-3' then Post_Code_Rating_4p2 = 1;
	if Post_Code_Rating_4 = '3-5' then Post_Code_Rating_4p3 = 1;
	if Post_Code_Rating_4 = 'Overseas/Miss' then Post_Code_Rating_4p4 = 1;
	if Post_Code_Rating_4 = 'z5-10' then Post_Code_Rating_4p5 = 1;
	if Gender_2 = 'M&?' then Gender_2p6 = 1;
	if Gender_2 = 'zF' then Gender_2p7 = 1;
	if Phone_Count_2 = '0' then Phone_Count_2p8 = 1;
	if Phone_Count_2 = '2' then Phone_Count_2p9 = 1;
	if Phone_Count_2 = '3' then Phone_Count_2p10 = 1;
	if Phone_Count_2 = 'z1' then Phone_Count_2p11 = 1;
	if Last_Payment_To_Loaded_band_1 = '0-12' then Last_Payment_To_Loadep12 = 1;
	if Last_Payment_To_Loaded_band_1 = 'Miss' then Last_Payment_To_Loadep13 = 1;
	if Last_Payment_To_Loaded_band_1 = 'z12+' then Last_Payment_To_Loadep14 = 1;
	if debt_age_at_load_band_1 = '1: <=12 Mths' then debt_age_at_load_bandp20 = 1;
	if debt_age_at_load_band_1 = 'z3/4: >13 Mth' then debt_age_at_load_bandp21 = 1;

	xbeta_00 = 
	&Interceptp1_coeff. +
	&Post_Code_Rating_4p2_coeff.*Post_Code_Rating_4p2 +
	&Post_Code_Rating_4p3_coeff.*Post_Code_Rating_4p3 +
	&Post_Code_Rating_4p4_coeff.*Post_Code_Rating_4p4 +
	&Post_Code_Rating_4p5_coeff.*Post_Code_Rating_4p5 +
	&Gender_2p6_coeff.*Gender_2p6 +
	&Gender_2p7_coeff.*Gender_2p7 +
	&Phone_Count_2p8_coeff.*Phone_Count_2p8 +
	&Phone_Count_2p9_coeff.*Phone_Count_2p9 +
	&Phone_Count_2p10_coeff.*Phone_Count_2p10 +
	&Phone_Count_2p11_coeff.*Phone_Count_2p11 +
	&Last_Payment_To_Loadep12_coeff.*Last_Payment_To_Loadep12 +
	&Last_Payment_To_Loadep13_coeff.*Last_Payment_To_Loadep13 +
	&Last_Payment_To_Loadep14_coeff.*Last_Payment_To_Loadep14 +
	&age_since_loaded_0_np15_coeff.*max(0,age_since_loaded-0)/1 +
	&age_since_loaded_7_np16_coeff.*max(0,age_since_loaded-7)/1 +
	&loaded_amount_0_np17_coeff.*max(0,loaded_amount-0)/10000 +
	&loaded_amount_1500_np18_coeff.*max(0,loaded_amount-1500)/10000 +
	&loaded_amount_2500_np19_coeff.*max(0,loaded_amount-2500)/10000 +
	&debt_age_at_load_bandp20_coeff.*debt_age_at_load_bandp20 +
	&debt_age_at_load_bandp21_coeff.*debt_age_at_load_bandp21;

	mu_00 = exp(xbeta_00);
	run;
%mend telco_proportion_00;

%macro telco_probability_10(a=,b=);
%let var_list =
	Interceptb1_coeff
	age_since_loaded_n_0b2_coeff
	age_since_loaded_n_4b3_coeff
	age_since_loaded_n_6b4_coeff
	Phone_Count_11b5_coeff
	Phone_Count_11b6_coeff
	Phone_Count_11b7_coeff
	Phone_Count_11b8_coeff
	Gender_11b9_coeff
	Gender_11b10_coeff
	Debtor_Age_At_Load_Bab11_coeff
	Debtor_Age_At_Load_Bab12_coeff
	Debtor_Age_At_Load_Bab13_coeff
	Debtor_Age_At_Load_Bab14_coeff
	Debtor_Age_At_Load_Bab15_coeff
	Debtor_Age_At_Load_Bab16_coeff
	Debtor_Age_At_Load_Bab17_coeff
	Last_payment_to_loadeb18_coeff
	Last_payment_to_loadeb19_coeff
	Last_payment_to_loadeb20_coeff
	Last_payment_to_loadeb21_coeff
	Last_payment_to_loadeb22_coeff
	Last_payment_to_loadeb23_coeff
	Post_Code_Rating_11b24_coeff
	Post_Code_Rating_11b25_coeff
	Post_Code_Rating_11b26_coeff
	Post_Code_Rating_11b27_coeff
	Phone_Home_Flag_10b28_coeff
	Phone_Home_Flag_10b29_coeff
	Phone_Mobile_Flag_10b30_coeff
	Phone_Mobile_Flag_10b31_coeff
	loaded_amount_0_nb32_coeff
	loaded_amount_800_nb33_coeff
	loaded_amount_1200_nb34_coeff
	loaded_amount_1300_nb35_coeff
	Debt_Age_At_Load_Bandb36_coeff
	Debt_Age_At_Load_Bandb37_coeff
	Debt_Age_At_Load_Bandb38_coeff
;
proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Excel\Final Excel Files (Dilan)\Model Adjustment Files\telco_model_adjustments_NZ.xlsx"
/*proc import datafile = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\jeffreylee\Project\Programs\telco_model_adjustments_nz.xlsx"*/
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

	Phone_Count_11b5 = 0;
	Phone_Count_11b6 = 0;
	Phone_Count_11b7 = 0;
	Phone_Count_11b8 = 0;
	Gender_11b9 = 0;
	Gender_11b10 = 0;
	Debtor_Age_At_Load_Bab11 = 0;
	Debtor_Age_At_Load_Bab12 = 0;
	Debtor_Age_At_Load_Bab13 = 0;
	Debtor_Age_At_Load_Bab14 = 0;
	Debtor_Age_At_Load_Bab15 = 0;
	Debtor_Age_At_Load_Bab16 = 0;
	Debtor_Age_At_Load_Bab17 = 0;
	Last_payment_to_loadeb18 = 0;
	Last_payment_to_loadeb19 = 0;
	Last_payment_to_loadeb20 = 0;
	Last_payment_to_loadeb21 = 0;
	Last_payment_to_loadeb22 = 0;
	Last_payment_to_loadeb23 = 0;
	Post_Code_Rating_11b24 = 0;
	Post_Code_Rating_11b25 = 0;
	Post_Code_Rating_11b26 = 0;
	Post_Code_Rating_11b27 = 0;
	Phone_Home_Flag_10b28 = 0;
	Phone_Home_Flag_10b29 = 0;
	Phone_Mobile_Flag_10b30 = 0;
	Phone_Mobile_Flag_10b31 = 0;
	Debt_Age_At_Load_Bandb36 = 0;
	Debt_Age_At_Load_Bandb37 = 0;
	Debt_Age_At_Load_Bandb38 = 0;



	if Phone_Count_11 = '1' then Phone_Count_11b5 = 1;
	if Phone_Count_11 = '2' then Phone_Count_11b6 = 1;
	if Phone_Count_11 = '3' then Phone_Count_11b7 = 1;
	if Phone_Count_11 = 'z0' then Phone_Count_11b8 = 1;
	if Gender_11 = 'F&?' then Gender_11b9 = 1;
	if Gender_11 = 'zM' then Gender_11b10 = 1;
	if Debtor_Age_At_Load_Band_10 = '1: 18 - 24 Yrs' then Debtor_Age_At_Load_Bab11 = 1;
	if Debtor_Age_At_Load_Band_10 = '3: 35 - 44 Yrs' then Debtor_Age_At_Load_Bab12 = 1;
	if Debtor_Age_At_Load_Band_10 = '4: 45 - 54 Yrs' then Debtor_Age_At_Load_Bab13 = 1;
	if Debtor_Age_At_Load_Band_10 = '5: 55 - 64 Yrs' then Debtor_Age_At_Load_Bab14 = 1;
	if Debtor_Age_At_Load_Band_10 = '6: 65 Yrs +' then Debtor_Age_At_Load_Bab15 = 1;
	if Debtor_Age_At_Load_Band_10 = '7: Missing' then Debtor_Age_At_Load_Bab16 = 1;
	if Debtor_Age_At_Load_Band_10 = 'z2:25-34Yrs' then Debtor_Age_At_Load_Bab17 = 1;
	if Last_payment_to_loaded_band_11 = '0-8' then Last_payment_to_loadeb18 = 1;
	if Last_payment_to_loaded_band_11 = '08-12' then Last_payment_to_loadeb19 = 1;
	if Last_payment_to_loaded_band_11 = '12-16' then Last_payment_to_loadeb20 = 1;
	if Last_payment_to_loaded_band_11 = '16-20' then Last_payment_to_loadeb21 = 1;
	if Last_payment_to_loaded_band_11 = 'Miss' then Last_payment_to_loadeb22 = 1;
	if Last_payment_to_loaded_band_11 = 'z20+' then Last_payment_to_loadeb23 = 1;
	if Post_Code_Rating_11 = '0-2' then Post_Code_Rating_11b24 = 1;
	if Post_Code_Rating_11 = 'Missing' then Post_Code_Rating_11b25 = 1;
	if Post_Code_Rating_11 = 'Overseas' then Post_Code_Rating_11b26 = 1;
	if Post_Code_Rating_11 = 'z2-10' then Post_Code_Rating_11b27 = 1;
	if Phone_Home_Flag_10 = '1' then Phone_Home_Flag_10b28 = 1;
	if Phone_Home_Flag_10 = 'z0' then Phone_Home_Flag_10b29 = 1;
	if Phone_Mobile_Flag_10 = '1' then Phone_Mobile_Flag_10b30 = 1;
	if Phone_Mobile_Flag_10 = 'z0' then Phone_Mobile_Flag_10b31 = 1;
	if Debt_Age_At_Load_Band_10 = '<=12 Mths' then Debt_Age_At_Load_Bandb36 = 1;
	if Debt_Age_At_Load_Band_10 = '>24 Mths' then Debt_Age_At_Load_Bandb37 = 1;
	if Debt_Age_At_Load_Band_10 = 'z13-24 Mths' then Debt_Age_At_Load_Bandb38 = 1;


xbeta_10 = 
	&Interceptb1_coeff. +
	&age_since_loaded_n_0b2_coeff.*max(0,age_since_loaded-0)/1 +
	&age_since_loaded_n_4b3_coeff.*max(0,age_since_loaded-4)/1 +
	&age_since_loaded_n_6b4_coeff.*max(0,age_since_loaded-6)/1 +
	&Phone_Count_11b5_coeff.*Phone_Count_11b5 +
	&Phone_Count_11b6_coeff.*Phone_Count_11b6 +
	&Phone_Count_11b7_coeff.*Phone_Count_11b7 +
	&Phone_Count_11b8_coeff.*Phone_Count_11b8 +
	&Gender_11b9_coeff.*Gender_11b9 +
	&Gender_11b10_coeff.*Gender_11b10 +
	&Debtor_Age_At_Load_Bab11_coeff.*Debtor_Age_At_Load_Bab11 +
	&Debtor_Age_At_Load_Bab12_coeff.*Debtor_Age_At_Load_Bab12 +
	&Debtor_Age_At_Load_Bab13_coeff.*Debtor_Age_At_Load_Bab13 +
	&Debtor_Age_At_Load_Bab14_coeff.*Debtor_Age_At_Load_Bab14 +
	&Debtor_Age_At_Load_Bab15_coeff.*Debtor_Age_At_Load_Bab15 +
	&Debtor_Age_At_Load_Bab16_coeff.*Debtor_Age_At_Load_Bab16 +
	&Debtor_Age_At_Load_Bab17_coeff.*Debtor_Age_At_Load_Bab17 +
	&Last_payment_to_loadeb18_coeff.*Last_payment_to_loadeb18 +
	&Last_payment_to_loadeb19_coeff.*Last_payment_to_loadeb19 +
	&Last_payment_to_loadeb20_coeff.*Last_payment_to_loadeb20 +
	&Last_payment_to_loadeb21_coeff.*Last_payment_to_loadeb21 +
	&Last_payment_to_loadeb22_coeff.*Last_payment_to_loadeb22 +
	&Last_payment_to_loadeb23_coeff.*Last_payment_to_loadeb23 +
	&Post_Code_Rating_11b24_coeff.*Post_Code_Rating_11b24 +
	&Post_Code_Rating_11b25_coeff.*Post_Code_Rating_11b25 +
	&Post_Code_Rating_11b26_coeff.*Post_Code_Rating_11b26 +
	&Post_Code_Rating_11b27_coeff.*Post_Code_Rating_11b27 +
	&Phone_Home_Flag_10b28_coeff.*Phone_Home_Flag_10b28 +
	&Phone_Home_Flag_10b29_coeff.*Phone_Home_Flag_10b29 +
	&Phone_Mobile_Flag_10b30_coeff.*Phone_Mobile_Flag_10b30 +
	&Phone_Mobile_Flag_10b31_coeff.*Phone_Mobile_Flag_10b31 +
	&loaded_amount_0_nb32_coeff.*max(0,loaded_amount-0)/10000 +
	&loaded_amount_800_nb33_coeff.*max(0,loaded_amount-800)/10000 +
	&loaded_amount_1200_nb34_coeff.*max(0,loaded_amount-1200)/10000 +
	&loaded_amount_1300_nb35_coeff.*max(0,loaded_amount-1300)/10000 +
	&Debt_Age_At_Load_Bandb36_coeff.*Debt_Age_At_Load_Bandb36 +
	&Debt_Age_At_Load_Bandb37_coeff.*Debt_Age_At_Load_Bandb37 +
	&Debt_Age_At_Load_Bandb38_coeff.*Debt_Age_At_Load_Bandb38;



	p_10 = exp(xbeta_10)/(1+exp(xbeta_10));
	run;
%mend telco_probability_10;



%macro telco_pricing (infile=,x=,y=,a=,b=,d=,e=,f=,outfile=);
data &x;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Pricing\Telco_Pricing_Proportion_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = 9;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

/*%telco_proportion_00(x=dilan.telco_prediction_nz,y=dilan.telco_prediction_nz_1)*/
/*%telco_proportion_00(x=dilan.telco_prediction_nz_12,y=dilan.telco_prediction_nz_1_12)*/
/*%telco_proportion_00(x=dilan.telco_prediction_nz_a12,y=dilan.telco_prediction_nz_1_a12)*/
%telco_proportion_00(x=jack.tpp,y=jack.tpp_1)

data &a;
	set &infile;
	where Loaded_Date >= '1Jan2009'd and Loaded_Date <=&cutoffdate.;
	%include '\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\Programs\NZ\PDL\Pricing\Telco_Pricing&Reforecast_Probability_SourceCode.sas';
	proportion = payments_total/loaded_amount;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	if proportion > 5 then proportion = .;
	if proportion <= 0 then proportion = .;
	age_since_loaded_1 = age_since_loaded;
/*	age_since_loaded = 12;*/
/*	age_since_loaded = age_since_loaded + 12;*/
/*	age_since_loaded = 11;*/
	age_since_loaded = max(ceil(((&cutoffdate. - loaded_date)/365.25)*2),0);
	run;

/*%telco_probability_10(a=dilan.telco_prediction_nz_2,b=dilan.telco_prediction_nz_3)*/
/*%telco_probability_10(a=dilan.telco_prediction_nz_2_12,b=dilan.telco_prediction_nz_3_12)*/
/*%telco_probability_10(a=dilan.telco_prediction_nz_2_a12,b=dilan.telco_prediction_nz_3_a12)*/
%telco_probability_10(a=jack.tpp_2,b=jack.tpp_3)

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

%mend telco_pricing;



/*%telco_pricing (infile=jeff.historical_accounts_telco_5_nz,x=dilan.telco_prediction_nz,y=dilan.telco_prediction_nz_1,a=dilan.telco_prediction_nz_2,b=dilan.telco_prediction_nz_3,d=dilan.telco_prediction_nz_4,e=dilan.telco_prediction_nz_5,f=dilan.telco_prediction_nz_6,outfile=dilan.telco_prediction_nz_7);*/
/*%telco_pricing (infile=jeff.historical_accounts_telco_5_nz,x=dilan.telco_prediction_nz_12,y=dilan.telco_prediction_nz_1_12,a=dilan.telco_prediction_nz_2_12,b=dilan.telco_prediction_nz_3_12,d=dilan.telco_prediction_nz_4_12,e=dilan.telco_prediction_nz_5_12,f=dilan.telco_prediction_nz_6_12,outfile=dilan.telco_prediction_nz_7_12);*/
/*%telco_pricing (infile=jeff.historical_accounts_telco_5_nz,x=dilan.telco_prediction_nz_a12,y=dilan.telco_prediction_nz_1_a12,a=dilan.telco_prediction_nz_2_a12,b=dilan.telco_prediction_nz_3_a12,d=dilan.telco_prediction_nz_4_a12,e=dilan.telco_prediction_nz_5_a12,f=dilan.telco_prediction_nz_6_a12,outfile=dilan.telco_prediction_nz_7_a12);*/
%telco_pricing (infile=jeff.hist_accts_telco_15_nz,x=jack.tpp,y=jack.tpp_1,a=jack.tpp_2,b=jack.tpp_3,d=jack.tpp_4,e=jack.tpp_5,f=jack.tpp_6_&looped.,outfile=jack.tpp_7);






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


