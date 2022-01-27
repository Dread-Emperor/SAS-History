/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    LIBRARIES;
*0*
/********************************************************************************************/
/********************************************************************************************/;
libname ALMAUPDL '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\AU\PDL';
/*libname ALMAUPDL '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\AU\PDL_July14';*/
libname JEFF '\\bcsap0010\sasdata\SAS Data\Jeffrey\SASdata';
libname ATTACH '\\bcsap0010\sasdata\SAS Data\Jeffrey\SASdata';
libname DEBTLOAD '\\bcsap0010\sasdata\SAS Data\Monthly Load\debtload';
libname sdata '\\bcsap0010\sasdata\SAS Data\Monthly Load';
libname dmart odbc Datasrc=datamart schema=dbo;
libname old '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\AU\PDL';

/*data ALMAUPDL.HISTORICAL_ACCOUNTS01_V2;*/
/*set OLD.HISTORICAL_ACCOUNTS01_V2;*/
/*run;*/

/*data ALMAUPDL.HISTORICAL_PAYMENTS04_V2;*/
/*set OLD.HISTORICAL_PAYMENTS04_V2;*/
/*run;*/

/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    MACROS;
*0*
/********************************************************************************************/
/********************************************************************************************/
;


/********************************************************************************************/
*0*
*0*    MACRO 01:  Attach email from debtload file to account file;
*0*
/********************************************************************************************/;

%macro attach_email_from_debtload(dest=);
%let file_list = 
/***List of files goes here***/
agl bmw capital_finance lombard optus_fixed optus_mobile radio_rentals sensis vodafone westpac_ff_cc;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number email);
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_email_from_debtload;


/********************************************************************************************/
*0*
*0*    MACRO 02:  Attach email from debtload file to account file (again, because email is named differently);
*0*
/********************************************************************************************/;
%macro attach_email2_from_debtload(dest=);
%let file_list = 
/***List of files goes here***/
telstra;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number email_flag);
				email = email_flag;
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_email2_from_debtload;


/********************************************************************************************/
*0*
*0*    MACRO 03:  Attach driver_licence from debtload file to account file;
*0*
/********************************************************************************************/;
%macro attach_drivers_from_debtload(dest=);
%let file_list = 
/***List of files goes here***/
capital_finance cba_ff_cc hutchison optus_fixed optus_mobile telstra truenergy vodafone westpac_ff_cc;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number drivers_licence);
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_drivers_from_debtload;


/********************************************************************************************/
*0*
*0*    MACRO 04:  Attach referral_type from debtload file to account file;
*0*
/********************************************************************************************/;
%macro attach_referral_from_debtload(dest=);
%let file_list = 
/***List of files goes here***/
agl;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number referred_type);
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_referral_from_debtload;


/********************************************************************************************/
*0*
*0*    MACRO 05:  Attach referral_type from debtload file to account file (again since it is named differently);
*0*
/********************************************************************************************/;
%macro attach_referral_from_debtload2(dest=);
%let file_list = 
/***List of files goes here***/
bmw;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number agency_type);
				if agency_type = 'Internal' then referred_type = 'No Referral';
				if agency_type = 'Merc Agent' then referred_type = '1st Referral';
				if agency_type = 'Legal' then referred_type = 'Legal';
				run;
			data temp;
				set temp (drop = agency_type);
				run;
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_referral_from_debtload2;


/********************************************************************************************/
*0*
*0*    MACRO 06:  Attach gender from debtload file to account file;
*0*
/********************************************************************************************/;
%macro attach_gender_from_debtload(dest=);
%let file_list = 
/***List of files goes here***/
agl
anz_cc_nz
anz_ex_lit_cc
anz_ex_lit_pl
anz_ff_cc
bmw
capital_finance
cba_ff_cc
cba_ff_pl
ge_ff_nz
ge_pl_nz
home_direct_nz
hutchison
nab_ff_cc
nab_ff_pl
nab_inventory
optus_fixed
optus_mobile
radio_rentals
st_george_cc
telecom_nz
telstra
truenergy
vodafone
westpac_ff_cc
westpac_nz
;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number gender);
				gender1 = gender;
				run;
			data temp;	
				set temp (drop = gender);
				run;
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if gender ne gender1 and  gender1 ne '' then;
				gender = gender1;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_gender_from_debtload;


/********************************************************************************************/
*0*
*0*    MACRO 07:  Attach last_payment_amount from debtload file to account file;
*0*
/********************************************************************************************/;
%macro attach_last_payment_amount(dest=);
%let file_list = 
/***List of files goes here***/
agl
anz_cc_nz
anz_ex_lit_cc
anz_ex_lit_pl
anz_ff_cc
anz_ff_pl
bmw
cba_ff_cc
cba_ff_pl
flexirent_nz
fp_nz
ge_ff
ge_ff_nz
home_direct_nz
lombard
nab_ff_cc
nab_ff_pl
nab_inventory
national_bank_nz
optus_fixed
optus_mobile
sensis
telstra
truenergy
vodafone
westpac_nz
westpac_nz_home_loans
westpac_nz_savings
westpac_nz_trans
;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number last_payment_amount);
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_last_payment_amount;


/********************************************************************************************/
*0*
*0*    MACRO 08:  Attach last_payment_amount from debtload file to account file (again, since it is named differently);
*0*
/********************************************************************************************/;
%macro attach_lastest_payment_amount(dest=);
%let file_list = 
/***List of files goes here***/
st_george_cc
;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data ATTACH.temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number latest_payment_amount);
				last_payment_amount = latest_payment_amount;
				run;
			data ATTACH.temp;
				set ATTACH.temp (keep=client_ledger_number account_number last_payment_amount);
				run;
			data &dest;
				merge &dest (in=t1) ATTACH.temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_lastest_payment_amount;


/********************************************************************************************/
*0*
*0*    MACRO 09:  Attach last_payment_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro attach_last_payment_date(dest=);
%let file_list = 
/***List of files goes here***/
agl
anz_cc_nz
anz_commercial
anz_ex_lit_cc
anz_ex_lit_pl
anz_ff_cc
anz_ff_pl
bmw
capital_finance
cba_ff_cc
cba_ff_pl
flexirent_nz
ford_credit
fp_nz
ge_ff
ge_ff_nz
ge_pl_nz
home_direct_nz
hopscotch_nz
hutchison
lombard
nab_ff_cc
nab_ff_pl
nab_inventory
national_bank_nz
optus_fixed
optus_mobile
sensis
telecom_nz
telstra
truenergy
vodafone
westpac_ff_cc
westpac_nz
westpac_nz_home_loans
westpac_nz_savings
westpac_nz_trans
;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number last_payment_date);
			data &dest;
				merge &dest (in=t1) temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_last_payment_date;


/********************************************************************************************/
*0*
*0*    MACRO 10:  Attach last_payment_date from debtload file to account file (again, since it is named differently);
*0*
/********************************************************************************************/;
%macro attach_lastest_payment_date(dest=);
%let file_list = 
/***List of files goes here***/
st_george_cc
;
/***File Name goes here**/
%let _k = 1;
	%do %while (%scan(&file_list.,&_k.,' ') ne);
	    %let file = %scan(&file_list.,&_k.,' ');
			data ATTACH.temp;
				set DEBTLOAD.&file. (keep=client_ledger_number account_number latest_payment_date);
				last_payment_date = latest_payment_date;
				run;
			data ATTACH.temp;
				set ATTACH.temp (keep=client_ledger_number account_number last_payment_date);
				run;
			data &dest;
				merge &dest (in=t1) ATTACH.temp (in=t2);
				by client_ledger_number account_number;
				if t1;
				run;
		%let _k = %eval(&_k.+1);
	%end;
%mend attach_lastest_payment_date;


/********************************************************************************************/
*0*
*0*    MACRO 11:  Attach credit_limit from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge5;
%let file_list = nab_ff_cc nab_inventory;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = credit_limit;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge5;


/********************************************************************************************/
*0*
*0*    MACRO 12:  Attach limit from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge6;
%let file_list = cba_ff_cc;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = limit;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge6;


/********************************************************************************************/
*0*
*0*    MACRO 13:  Attach original_amount from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge7;
%let file_list = bmw capital_finance flexirent_nz;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = original_amount;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge7;


/********************************************************************************************/
*0*
*0*    MACRO 14:  Attach original_loan_amount from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge8;
%let file_list = ge_auto;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = original_loan_amount;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge8;


/********************************************************************************************/
*0*
*0*    MACRO 15:  Attach original_balance from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge9;
%let file_list = sensis;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = original_balance;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge9;


/********************************************************************************************/
*0*
*0*    MACRO 16:  Attach original_balance from debtload file to account file;
*0*
/********************************************************************************************/;
/*%macro debtload_merge10;*/
/*%let file_list = sensis;*/
/*%let dest = ATTACH.historical_accounts_banking_1; */
/*%let col4 = original_balance;*/
/*%let _k = 1;*/
/*%do %while (%scan(&file_list.,&_k.,' ') ne);*/
/*    %let file = %scan(&file_list.,&_k.,' ');*/
/*	data temp;*/
/*		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);*/
/*		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/*/
/*	data &dest.;*/
/*		merge &dest. (in=t1) temp (in=t2);*/
/*		by client_ledger_number account_number;*/
/*		if t1;*/
/*		run;*/
/*	%let _k = %eval(&_k.+1);*/
/*%end;*/
/*%mend debtload_merge10;*/;


/********************************************************************************************/
*0*
*0*    MACRO 17:  Attach principle from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge11;
%let file_list = anz_ex_lit_pl anz_ff_pl cba_ff_pl;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = principle;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge11;


/********************************************************************************************/
*0*
*0*    MACRO 18:  Attach amount_financed from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge12;
%let file_list = hopscotch_nz;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = amount_financed;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge12;


/********************************************************************************************/
*0*
*0*    MACRO 19:  Attach interest_rate from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge13;
%let file_list = anz_cc_nz
anz_ex_lit_pl
anz_ff_pl
bmw
capital_finance
cba_ff_cc
cba_ff_pl
ge_ff
ge_ff_nz
hopscotch_nz
lombard
westpac_ff_cc
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = interest_rate;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge13;	


/********************************************************************************************/
*0*
*0*    MACRO 20:  Attach opened_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge14;
%let file_list = anz_ex_lit_pl
anz_ff_pl
cba_ff_cc
hutchison
nab_ff_cc
nab_ff_pl
westpac_ff_cc
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = opened_date;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge14;	


/********************************************************************************************/
*0*
*0*    MACRO 21:  Attach open_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge15;
%let file_list = 
bmw
home_direct_nz
truenergy
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = open_date;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge15;	


/********************************************************************************************/
*0*
*0*    MACRO 22:  Attach opening_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge16;
%let file_list = 
westpac_nz
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = opening_date;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge16;	


/********************************************************************************************/
*0*
*0*    MACRO 23:  Attach date_opened from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge17;
%let file_list = 
nab_inventory
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = date_opened;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge17;	


/********************************************************************************************/
*0*
*0*    MACRO 24:  Attach debtor_opened from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge18;
%let file_list = 
cba_ff_pl
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = debtor_opened;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge18;	


/********************************************************************************************/
*0*
*0*    MACRO 29:  Attach date_in from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge29;
%let file_list = 
agl
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = date_in;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge29;	


/********************************************************************************************/
*0*
*0*    MACRO 30:  Attach start_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge30;
%let file_list = 
capital_finance 
radio_rentals
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = start_date;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge30;	

/********************************************************************************************/
*0*
*0*    MACRO 31:  Attach customer_since from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge31;
%let file_list = 
optus_fixed
optus_mobile
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = customer_since;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge31;	


/********************************************************************************************/
*0*
*0*    MACRO 32:  Attach account_open_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge32;
%let file_list = 
telstra
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = account_open_date;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge32;	


/********************************************************************************************/
*0*
*0*    MACRO 33:  Attach from_date from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge33;
%let file_list = 
ge_ff
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = from_date;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge33;	


/********************************************************************************************/
*0*
*0*    MACRO 25:  Attach prod_type from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge19;
%let file_list = 
nab_ff_cc
nab_ff_pl
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = prod_type;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge19;

/********************************************************************************************/
*0*
*0*    MACRO 26:  Attach product_type from debtload file to account file;
*0*
/********************************************************************************************/;
%macro debtload_merge20;
%let file_list = 
nab_inventory
;
%let dest = ATTACH.historical_accounts_banking_1; 
%let col4 = product_type;
%let _k = 1;
%do %while (%scan(&file_list.,&_k.,' ') ne);
    %let file = %scan(&file_list.,&_k.,' ');
	data temp;
		set DEBTLOAD.&file. (keep=client_ledger_number account_number &col4.);
		if missing(&col4.) then &col4. = -99999; /*assign value to missing, when column exists*/
	data &dest.;
		merge &dest. (in=t1) temp (in=t2);
		by client_ledger_number account_number;
		if t1;
		run;
	data &dest.;
		set &dest.;
		if missing(prod_type) and not missing(product_type) then prod_type = product_type;
		run;
	%let _k = %eval(&_k.+1);
%end;
%mend debtload_merge20;


/********************************************************************************************/
*0*
*0*    MACRO 27:  Produces one way summary for a list of factors;
*0*
/********************************************************************************************/;
%macro summary_account(input=,dest=);
/*List of factors goes here*/
%let var_list =

;
  %let _k = 1;
  %do %while (%scan(&var_list.,&_k.,' ') ne);
    %let var = %scan(&var_list.,&_k.,' ');
proc summary data = &input. nway missing;
	class &var.;
/*	var Payment;*/
	var Payments_total loaded_amount;
/*	var difference;*/
	output out = &var. (rename=(_freq_=Exposure)) sum =;
	run;
data temp;
	set &var.;
	proportion_paid = Payments_total/loaded_amount;
/*	probability_of_payment = Payment/Exposure;*/
	run;
%let _k = %eval(&_k.+1);
proc export data = temp
/*	%let dest = "\\bcsap0010\sasdata\SAS Data\Jeffrey\banking_nz_13.xlsx";*/
	outfile = &dest.
	DBMS = excel replace;
	SHEET = &var.;
	run;
%end;
%mend summary_account;

/*Uncomment next line and run for one way*/
%summary_account(input=jeff.banking_proportion_reforecast_20,dest="\\bcsap0010\sasdata\SAS Data\Jeffrey\banking_au_20.xlsx");


/********************************************************************************************/
*0*
*0*    MACRO 28:  Checks if a factor exists in a given data set;
*0*
/********************************************************************************************/;
%macro hasvar (data, var, type);
  * check if a variable of a given type exists in a dataset;
  *
  * data - name of data set to check;
  * var  - name of variable in data set to check for;
  * type - type of variable in data set to check for, C, N or X;
  *
  * 0 no such variable or such data set;
  * 1 variable of indicated type exists in data set;
  *
  * Richard A. DeVenezia 08/04/99;
  * Note: if option NOTES is on and the data has a where clause
  *       that returns no rows, then there will be a note in the log
  *       NOTE: No observations were selected from data set abc.xyz.
  *       There is currently no way to circumvent this.
  * mod
  *  8/10/99 rad process type X as do not care;
  *;
  %local hasvar dsid varnum vartype chektype ;
  %let chektype = %upcase (%substr (&type, 1, 1));
  %let hasvar = 0;
  %let dsid = %sysfunc (open (&DATA));
  %if &dsid %then %do;
    %let varnum = %sysfunc (varnum (&dsid, &var));
    %if &varnum %then %do;
       %let vartype = %sysfunc (vartype (&dsid, &varnum));
       %if (&vartype = &chektype) or (X = &chektype) %then
           %let hasvar = 1;
    %end;
    %let dsid = %sysfunc (close (&dsid));
  %end;
  %if &hasvar = 1 %then %do;
  	proc sort data = &data;
	by residential_post_code;
  	data &data; 
	merge &data (in=t1) ATTACH.postcodeabs (in=t2);
	by Residential_Post_Code;
	if t1;
	run;
  %end;
%mend hasvar;








/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    DATA PREPARATION (full);
*0*
/********************************************************************************************/
/********************************************************************************************/
;

/*Start with setting to default file*/


%macro attach_new_columns_common(data_set=,original=,original1=);
/*Attach Post Code*/
%hasvar(&data_set., Residential_Post_Code, N);

/*Attach various factors from debtload file*/
proc sort data = &data_set.;
	by client_ledger_number account_number;
	run;

%attach_email_from_debtload(dest=&data_set.);
%attach_email2_from_debtload(dest=&data_set.);
%attach_drivers_from_debtload(dest=&data_set.);
%attach_referral_from_debtload(dest=&data_set.);
%attach_gender_from_debtload(dest=&data_set.);
%attach_last_payment_amount(dest=&data_set.);
%attach_last_payment_date(dest=&data_set.);
%attach_lastest_payment_amount(dest=&data_set.);
%attach_lastest_payment_date(dest=&data_set.);

/*stat bar date attach*/
proc sql; 
  connect to odbc(UID=sasadm pwd={sas001}JGFzYWRtUFcx dsn=datamart);
  create table sbar as select * from connection to odbc( 
      select client as client_ledger_number,
               account as account_number,
               Expiry_Date
    from expiry_dates
    where country = 'A' and latest=1
    order by client,account
  ); 
  disconnect from odbc; 
quit;

data &data_set.;
  merge &data_set. (in=in1) sbar(in=in2);
  by client_ledger_number account_number;
  format sbar_date ddmmyy10.;
  drop Expiry_Date;
  sbar_date = input(Expiry_Date, yymmdd10.);
  if in1 then output;
run;

data &data_set.;
  merge &data_set. (in=t1) sdata.au_account (keep = client_ledger_number account_number judgment_date debt_to_date);
  by client_ledger_number account_number;
  if t1;
  run;

data &data_set.;
  set &data_set.;
  format sb_start judgement_date Stat_Barred ddmmyy10.;
  drop sb_start Judgment_date sb_year;
  if upcase(Residential_State_Name) = 'NT' then sb_year = 3; else sb_year = 6;
  sb_start = max(Debt_to_date,Last_Payment_date);
  Stat_Barred = intnx('year',sb_start,sb_year,'S');
  if Judgment_date ne 0 then do;
    judgement_date = input(put(Judgment_date, z8.), yymmdd8.);
    if upcase(Residential_State_Name) in ('SA','VIC') then stat_Barred = intnx('year',judgement_date,15,'S');
    else stat_Barred = intnx('year',judgement_date,12,'S');
  end;
run;

/*Define phone_flag factor*/
data &data_set.;
	set &data_set.;
	if Phone_Home_Flag = 1 or Phone_Mobile_Flag = 1 or Phone_Work_Flag = 1 then Phone_Flag =1;
	else Phone_Flag = 0;
	run;

/*Define last_payment_to_loaded factor*/
data &data_set.;
	set &data_set.;
	Last_Payment_To_Loaded = month(Loaded_Date) - month(last_payment_date) + (year(Loaded_Date) - year(last_payment_date))*12 + 1;
	run;

/*Attach veda score data (decile)*/
data &data_set.;
	merge &data_set. (in=t1) ATTACH.veda_score1 (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

/*Define first_payment factor*/
data &data_set.;
	set &data_set.;
	if payment_count = 1 then first_payment = 1;
	else first_payment = 0;
	run;

/*Attach data about ref, days_sold, inventory etc (from simon)*/
data ATTACH.latest_pd;
	set ATTACH.au_pdls_2014_08_18V2 (keep = PDL client_ledger_number referral_type days_sold inventory_ secured_insecured);
	run;

proc sort data = ATTACH.latest_pd;
	by client_ledger_number PDL;

proc sort data = &data_set.;
	by client_ledger_number PDL;
	run;

data &data_set.;
	merge &data_set. (in = t1) ATTACH.latest_pd (in=t2);
	by client_ledger_number PDL;
	if t1;
	run;

data &data_set.;
	set &data_set.;
	referred_type = referral_type;
	run;

/*Attach Payment_description factor*/

proc sql;
	create table ATTACH.pmt_desc as
	select distinct client_ledger_number, account_number, payment_description
/*	from almaupdl.historical_payments04_V2;*/
	from &original.;
	run;

/*extract all payments that have multiple descriptions*/
proc sql;
	create table ATTACH.pmt1 as 
	select distinct client_ledger_number, account_number
	from ATTACH.pmt_desc
	group by client_ledger_number, account_number
	having count(payment_description)>1;
	run;

data ATTACH.pmt1;
	set ATTACH.pmt1;
	payment_description = 'MULTIPLE';
	run;

proc sort data = &data_set.;
	by client_ledger_number account_number;
	run;

/*extract all single description payments*/
proc sql;
	create table ATTACH.pmt2 as 
	select client_ledger_number, account_number, payment_description
	from ATTACH.pmt_desc
	group by client_ledger_number, account_number
	having count(payment_description)=1;
	run;

data &data_set.;
	merge &data_set. (in=t1) ATTACH.pmt2 (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

data &data_set.;
	merge &data_set. (in=t1) ATTACH.pmt1 (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

/*Remove data that has no loaded_amount*/
data &data_set.;
	set &data_set.;
	if not missing(loaded_amount);
	run;

/*Obtain data on gdp and unemployment_rate (actual attachment is later)*/
data ATTACH.historical_payments_b1;
	set &original1.;
	year = year(loaded_date);
	month = month(loaded_date);
	run;

proc sort data = ATTACH.historical_payments_b1;
	by year month;
	run;

data ATTACH.historical_payments_b2;
	merge ATTACH.historical_payments_b1 (in=t1) ATTACH.gdp (in=t2);
	by year month;
	if t1;
	run;

data ATTACH.historical_payments_b3;
	merge ATTACH.historical_payments_b2 (in=t1) ATTACH.unemployment_rate (in=t2);
	by year month;
	if t1;
	run;

proc summary data = ATTACH.historical_payments_b3 nway missing;
	var unemployment_rate gdp_index;
	class client_ledger_number account_number;
	output out = ATTACH.employment_all_summary
	mean = unemployment_rate gdp_index;
	run;

data ATTACH.employment_gdp_all_proportion;
	set ATTACH.employment_all_summary (keep = client_ledger_number account_number unemployment_rate gdp_index);
	run;

/*Define factor age_since_loaded*/
%let Rptdte='31Jul2014'd;
data &data_set.;
	set &data_set.;
	age_since_loaded = ceil(((&Rptdte. - loaded_date)/365.25)*2);
	run;

data ATTACH.duration_data_prep;
/*	set almaupdl.historical_payments04_V2;*/
	set &original.;
	duration = month(Payment_Month) - month(Loaded_Date) + (year(Payment_Month) - year(Loaded_Date))*12 + 1;
	run;

data ATTACH.duration_data;
	set ATTACH.duration_data_prep (keep = client_ledger_number account_number duration);
	duration = duration/12;
	run;

proc summary data = ATTACH.duration_data nway missing;
	class client_ledger_number account_number;
	var duration;
	output out = ATTACH.duration_collapsed (rename=(_freq_=NumOfPayments)) mean=;
	run;

proc summary data = ATTACH.duration_data nway missing;
	class client_ledger_number account_number;
	var duration;
	output out = ATTACH.latest_pay_after_load (rename=(duration=years_latest_pay_after_load)) max=;
	run;

data ATTACH.duration_collapsed;
	set ATTACH.duration_collapsed;
	duration = round(duration,0.5);
	run;

data ATTACH.temp;
	set &data_set. (keep = client_ledger_number account_number loaded_date);
	run;

data ATTACH.latest_pay_after_load;
	merge ATTACH.latest_pay_after_load (in=t1) ATTACH.temp (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

data ATTACH.latest_pay_after_load;
	set ATTACH.latest_pay_after_load;
	latest_payment_after_load = ((&Rptdte. - loaded_date)/365.25 - years_latest_pay_after_load);
	run;

data &data_set.;
	merge &data_set. (in=t1) ATTACH.duration_collapsed (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;


data ATTACH.latest_pay_after_load;
	set ATTACH.latest_pay_after_load (keep = client_ledger_number account_number latest_payment_after_load);
	run;

data &data_set.;
	merge &data_set. (in=t1) ATTACH.latest_pay_after_load (in=t2);
	by client_ledger_number account_number;
	if latest_payment_after_load > 0 then latest_payment_after_load = ceil(latest_payment_after_load*2)/2;
	else latest_payment_after_load = 0.5;
	if t1;
	run;


/*Divide data into telco and banking*/
data ATTACH.historical_accounts_telco;
	set &data_set.;
	if product in ('Telco','Utility','Other');
	run;

data ATTACH.historical_accounts_banking;
	set &data_set.;
	if product not in ('Telco','Utility','Other');
	run;
%mend attach_new_columns_common;


%macro attach_more_factors(data_set_banking=,data_set_telco=);
/*Set a back up copy*/
/*AFTER THIS POINT, DATA UPDATE IS ONLY APPLIED TO BANKING. THIS WILL HAVE TO BE REATTACHED FOR TELCO.*/
/*REASON IS THAT DEBTLOAD ATTACHES DO NOT APPLY FOR TELCO (NOT THE SAME FILES AT LEAST)*/
data ATTACH.historical_accounts_banking_1;
	set &data_set_banking;
	run;

data ATTACH.historical_accounts_telco_1;
	set &data_set_telco;
	run;

proc sort data = ATTACH.historical_accounts_banking_1;
	by client_ledger_number account_number;
	run;

proc sort data = ATTACH.historical_accounts_telco_1;
	by client_ledger_number account_number;
	run;

/*Attach all the factors discussed in the debtload files*/
%debtload_merge5;
%debtload_merge6;
%debtload_merge7;
/*%debtload_merge8;*/
%debtload_merge9;
/*%debtload_merge10;*/
%debtload_merge11;
%debtload_merge12;
%debtload_merge13;
%debtload_merge14;
%debtload_merge15;
%debtload_merge16;
%debtload_merge17;
%debtload_merge18;
%debtload_merge19;
%debtload_merge20;

%debtload_merge29;
%debtload_merge30;
%debtload_merge31;
%debtload_merge32;
%debtload_merge33;

/*Merge with experian data*/
proc sort data = ATTACH._20140605_Baycorp_credit_append;
	by client_ledger_number account_number;
	run;
/*NOTE: Input data set is already sorted, no sorting done.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.01 seconds*/

proc sort data = ATTACH.historical_accounts_banking_1;
	by client_ledger_number account_number;
	run;

proc sort data = ATTACH.historical_accounts_telco_1;
	by client_ledger_number account_number;
	run;
/*NOTE: Input data set is already sorted, no sorting done.*/
/*NOTE: PROCE-E SORT used (Total process time):*/
/*      real time           0.00 seconds*/
/*      cpu time            0.00 seconds*/


/*Code below is to remove duplicates from the experian data*/
proc sql;
	create table ATTACH.temp3 as 
	select *, count(*)
	from ATTACH._20140605_Baycorp_credit_append
	group by client_ledger_number, account_number
	having count(*) > 1;
	quit;
/*NOTE: The query requires remerging summary statistics back with the original data.*/
/*NOTE: Table ATTACH.TEMP3 created, with 5607 rows and 5 columns.*/


data ATTACH.credit_score_dup;
	set ATTACH.temp3 (keep = client_ledger_number account_number credit_score);
	if not missing(credit_score);
	run;
/*NOTE: There were 5607 observations read from the data set ATTACH.TEMP3.*/
/*NOTE: The data set ATTACH.CREDIT_SCORE_DUP has 5607 observations and 3 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.06 seconds*/
/*      cpu time            0.00 seconds*/

data ATTACH.geo_score_dup;
	set ATTACH.temp3 (keep = client_ledger_number account_number geo_score);
	length geo_score_1 8;
	geo_score_1 = geo_score;
	if not missing(geo_score_1);
	run;
/*NOTE: There were 5607 observations read from the data set ATTACH.TEMP3.*/
/*NOTE: The data set ATTACH.GEO_SCORE_DUP has 4605 observations and 4 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.03 seconds*/
/*      cpu time            0.01 seconds*/

proc summary data = ATTACH.geo_score_dup nway missing;
	class client_ledger_number account_number;
	var geo_score_1;
	output out = ATTACH.geo_summary;
	run;
/*NOTE: There were 4605 observations read from the data set ATTACH.GEO_SCORE_DUP.*/
/*NOTE: The data set ATTACH.GEO_SUMMARY has 2655 observations and 5 variables.*/
/*NOTE: PROCEDURE SUMMARY used (Total process time):*/
/*      real time           0.03 seconds*/
/*      cpu time            0.00 seconds*/

proc summary data = ATTACH.credit_score_dup nway missing;
	class client_ledger_number account_number;
	var credit_score;
	output out = ATTACH.credit_summary mean = ;
	run;
/*NOTE: There were 5607 observations read from the data set ATTACH.CREDIT_SCORE_DUP.*/
/*NOTE: The data set ATTACH.CREDIT_SUMMARY has 2777 observations and 5 variables.*/
/*NOTE: PROCEDURE SUMMARY used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.03 seconds*/

data ATTACH.geo;
	set ATTACH.geo_summary (keep = client_ledger_number account_number geo_score_1);
	run;
/*NOTE: There were 2655 observations read from the data set ATTACH.GEO_SUMMARY.*/
/*NOTE: The data set ATTACH.GEO has 2655 observations and 3 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.00 seconds*/

data ATTACH.credit;
	set ATTACH.credit_summary (keep = client_ledger_number account_number credit_score);
	run;
/*NOTE: There were 2777 observations read from the data set ATTACH.CREDIT_SUMMARY.*/
/*NOTE: The data set ATTACH.CREDIT has 2777 observations and 3 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.00 seconds*/

data ATTACH.credit;
	set ATTACH.credit;
	credit_score_1 = credit_score;
	run;
/*NOTE: There were 2777 observations read from the data set ATTACH.CREDIT.*/
/*NOTE: The data set ATTACH.CREDIT has 2777 observations and 4 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.00 seconds*/
/*      cpu time            0.00 seconds*/

data ATTACH.credit;
	set ATTACH.credit (keep = client_ledger_number account_number credit_score_1);
	run;
/*NOTE: There were 2777 observations read from the data set ATTACH.CREDIT.*/
/*NOTE: The data set ATTACH.CREDIT has 2777 observations and 3 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.00 seconds*/

data ATTACH.credit_geo_all;
	set ATTACH._20140605_Baycorp_credit_append;
	run;
/*NOTE: There were 675412 observations read from the data set ATTACH._20140605_BAYCORP_CREDIT_APPEND.*/
/*NOTE: The data set ATTACH.CREDIT_GEO_ALL has 675412 observations and 4 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.17 seconds*/
/*      cpu time            0.12 seconds*/

proc sql;
	create table ATTACH.credit_geo_all_1 as
	select * 
	from ATTACH.credit_geo_all as a left join ATTACH.credit as b 
	on a.client_ledger_number = b.client_ledger_number and a.account_number = b.account_number;
	quit;
/*NOTE: Table ATTACH.CREDIT_GEO_ALL_1 created, with 675412 rows and 5 columns.*/
/*NOTE: PROCEDURE SQL used (Total process time):*/
/*      real time           0.37 seconds*/
/*      cpu time            0.50 seconds*/

proc sql;
	create table ATTACH.credit_geo_all_1 as
	select * 
	from ATTACH.credit_geo_all_1 as a left join ATTACH.geo as b 
	on a.client_ledger_number = b.client_ledger_number and a.account_number = b.account_number;
	quit;
/*NOTE: Table ATTACH.CREDIT_GEO_ALL_1 created, with 675412 rows and 6 columns.*/
/*NOTE: PROCEDURE SQL used (Total process time):*/
/*      real time           0.29 seconds*/
/*      cpu time            0.25 seconds*/

data ATTACH.credit_geo_all_2;
	set ATTACH.credit_geo_all_1;
	if not missing(credit_score_1) then credit_score = credit_score_1;
	if not missing(geo_score_1) then geo_score = geo_score_1;
	run;
/*NOTE: Numeric values have been converted to character values at the places given by: (Line):(Column).*/
/*      86:46   */
/*NOTE: There were 675412 observations read from the data set ATTACH.CREDIT_GEO_ALL_1.*/
/*NOTE: The data set ATTACH.CREDIT_GEO_ALL_2 has 675412 observations and 6 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.20 seconds*/
/*      cpu time            0.17 seconds*/

data ATTACH.credit_geo_all_2;
	set ATTACH.credit_geo_all_2 (keep = client_ledger_number account_number credit_score geo_score);
	run;
/*NOTE: There were 675412 observations read from the data set ATTACH.CREDIT_GEO_ALL_2.*/
/*NOTE: The data set ATTACH.CREDIT_GEO_ALL_2 has 675412 observations and 4 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.15 seconds*/
/*      cpu time            0.14 seconds*/

proc sql;
	create table ATTACH.credit_geo_all_3 as
	select distinct * from ATTACH.credit_geo_all_2;
	quit;
/*NOTE: Table ATTACH.CREDIT_GEO_ALL_3 created, with 672582 rows and 4 columns.*/
/*NOTE: PROCEDURE SQL used (Total process time):*/
/*      real time           0.35 seconds*/
/*      cpu time            0.43 seconds*/

/*All duplicates have been removed. The average was taken instead*/


data ATTACH.historical_accounts_banking_1;
	merge ATTACH.credit_geo_all_3 (in=t1) ATTACH.historical_accounts_banking_1 (in=t2);
	by client_ledger_number account_number;
	if t2;
	run;

data ATTACH.historical_accounts_telco_1;
	merge ATTACH.credit_geo_all_3 (in=t1) ATTACH.historical_accounts_telco_1 (in=t2);
	by client_ledger_number account_number;
	if t2;
	run;

/*NOTE: There were 672582 observations read from the data set ATTACH.CREDIT_GEO_ALL_3.*/
/*NOTE: There were 115271 observations read from the data set ATTACH.HISTORICAL_ACCOUNTS_BANKING_1.*/
/*NOTE: The data set ATTACH.BANKING_PROPORTION_PRICING_1 has 115271 observations and 90 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.82 seconds*/
/*      cpu time            0.76 seconds*/


/*Merging data with employment rate and gdp*/
proc sort data = ATTACH.employment_gdp_all_proportion;
	by client_ledger_number account_number;
	run;
/*NOTE: Input data set is already sorted, no sorting done.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.00 seconds*/
/*      cpu time            0.00 seconds*/

proc sort data = ATTACH.historical_accounts_banking_1;
	by client_ledger_number account_number;
	run;

proc sort data = ATTACH.historical_accounts_telco_1;
	by client_ledger_number account_number;
	run;

/*NOTE: There were 115271 observations read from the data set ATTACH.BANKING_PROPORTION_PRICING_1.*/
/*NOTE: The data set ATTACH.BANKING_PROPORTION_PRICING_1 has 115271 observations and 90 variables.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.50 seconds*/
/*      cpu time            0.53 seconds*/

data ATTACH.historical_accounts_banking_1;
	merge ATTACH.historical_accounts_banking_1 (in=t1) ATTACH.employment_gdp_all_proportion (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

data ATTACH.historical_accounts_telco_1;
	merge ATTACH.historical_accounts_telco_1 (in=t1) ATTACH.employment_gdp_all_proportion (in=t2);
	by client_ledger_number account_number;
	if t1;
	run;

/*NOTE: There were 115271 observations read from the data set ATTACH.BANKING_PROPORTION_PRICING_1.*/
/*NOTE: There were 115273 observations read from the data set ATTACH.EMPLOYMENT_GDP_ALL_PROPORTION.*/
/*NOTE: The data set ATTACH.BANKING_PROPORTION_PRICING_1 has 115271 observations and 92 variables.*/
/*NOTE: DATA statement used (Total process time):*/
/*      real time           0.36 seconds*/
/*      cpu time            0.31 seconds*/

/*Merging data with NAB interest rates*/
proc sort data = ATTACH.historical_accounts_banking_1;
	by prod_type;
	run;
/*NOTE: There were 115271 observations read from the data set ATTACH.BANKING_PROPORTION_PRICING_1.*/
/*NOTE: The data set ATTACH.BANKING_PROPORTION_PRICING_1 has 115271 observations and 92 variables.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.59 seconds*/
/*      cpu time            0.53 seconds*/

proc sort data = ATTACH.nab_interest_rates;
	by prod_type;
	run;
/*NOTE: Input data set is already sorted, no sorting done.*/
/*NOTE: PROCEDURE SORT used (Total process time):*/
/*      real time           0.01 seconds*/
/*      cpu time            0.01 seconds*/

data ATTACH.historical_accounts_banking_1;
	merge ATTACH.historical_accounts_banking_1 (in=t1) ATTACH.nab_interest_rates (in=t2);
	by prod_type;
	if t1;
	run;



%mend %attach_more_factors;

%macro pa_legal_attach(original=);
/********************************************************************************************/
*0*
*0*    PAYMENT ARRANGEMENT;
*0*
/********************************************************************************************/

/*assign payment arrangement flag to dmart file*/;
/*data jeff.dmart_rm_account_pa;*/
/*set dmart.rm_account (keep = client_ledger_number account_number agreement_start_date_current agreement_operator_id agreement_amount Next_expected_event_date Next_payment_date  Dimension_record_valid_from_date*/
/*dimension_record_valid_from_date dimension_record_valid_to_date loaded_amount);*/
/*if Next_expected_event_date>0 and Next_payment_date > Dimension_record_valid_from_date;*/
/*pay_arr="1";*/
/*run;*/

/*change date format*/
data jeff.dmart_rm_account_pa_1;
set jeff.dmart_rm_account_pa (keep = client_ledger_number account_number dimension_record_valid_from_date dimension_record_valid_to_date pay_arr);
if dimension_record_valid_to_date = 0 then dimension_record_valid_to_date = 20990101;
dimension_record_valid_from_1 = input(put(dimension_record_valid_from_date,z8.),YYMMDD10.);
dimension_record_valid_to_1 = input(put(dimension_record_valid_to_date,z8.),YYMMDD10.);
format dimension_record_valid_from_1 dimension_record_valid_to_1 ddmmyy10.;
run;

proc sort data = jeff.dmart_rm_account_pa_1;
by client_ledger_number account_number;
run;

/*attach pa file to payment file*/
proc sql;
create table jeff.merged_pa as
select *
from jeff.dmart_rm_account_pa_1 as a right join &original. as b
on a.client_ledger_number = b.client_ledger_number and a.account_number = b.account_number
where dimension_record_valid_from_1 <= payment_date <= dimension_record_valid_to_1;
quit;

/*add column balance_before_payment*/
data jeff.merged_pa;
set jeff.merged_pa;
balance_before_payment = balance_after_payment + client_paid;
if missing(balance_before_payment) then balance_before_payment = client_paid;
run;

/*collpase payments to account level*/
proc sql;
create table jeff.pa_accounts as 
select client_ledger_number, account_number, sum(client_paid), max(balance_before_payment)
from jeff.merged_pa
group by client_ledger_number, account_number;
quit;

data jeff.pa_accounts;
set jeff.pa_accounts;
payment_arrangement = _TEMG001/_TEMG002;
run;

data jeff.pa_accounts;
set jeff.pa_accounts (keep = client_ledger_number account_number payment_arrangement);
run;



/********************************************************************************************/
*0*
*0*    LEGAL AND BANKRUPT;
*0*
/********************************************************************************************/

/*extract legal and bankrupt accounts*/;
/*This is commented out since it takes a long time to run it. It will need to be uncommented */
/*if that dataset here is lost.*/

/*data ATTACH.dmart_rm_account;*/
/*set dmart.rm_account (keep = client_ledger_number account_number agreement_operator_id agreement_amount */
/*dimension_record_valid_from_date dimension_record_valid_to_date);*/
/*if agreement_operator_id in (5914,5917);*/
/*run;*/

/*change to date format*/
data ATTACH.dmart_rm_account_1;
set ATTACH.dmart_rm_account (keep = client_ledger_number account_number Agreement_operator_ID dimension_record_valid_from_date dimension_record_valid_to_date);
if dimension_record_valid_to_date = 0 then dimension_record_valid_to_date = 20990101;
dimension_record_valid_from_1 = input(put(dimension_record_valid_from_date,z8.),YYMMDD10.);
dimension_record_valid_to_1 = input(put(dimension_record_valid_to_date,z8.),YYMMDD10.);
format dimension_record_valid_from_1 dimension_record_valid_to_1 ddmmyy10.;
run;

/*attach legal/bankrupt flag to payment file*/
proc sql;
create table jeff.payments_under_legal_bankrupt as
select *
from attach.dmart_rm_account_1 as a right join &original. as b
on a.client_ledger_number = b.client_ledger_number and a.account_number = b.account_number
where dimension_record_valid_from_1 <= payment_date <= dimension_record_valid_to_1;
quit;

/*create balance before payment*/
data jeff.payments_under_legal_bankrupt_1;
set jeff.payments_under_legal_bankrupt;
balance_before_payment = balance_after_payment+client_paid;
if missing(balance_before_payment) then balance_before_payment = client_paid;
run;

/*collapse file to account level*/
proc sql;
create table jeff.max_legal_bankrupt as
select distinct client_ledger_number, account_number, agreement_operator_id, sum(client_paid), max(balance_before_payment) 
from jeff.payments_under_legal_bankrupt_1
group by client_ledger_number, account_number;
quit;

/*make legal and bankrupt payments as a proportion*/
data jeff.max_legal_bankrupt_1;
set jeff.max_legal_bankrupt;
x_proportion = _TEMG001/_TEMG002;
run;

/*merge data with telco file*/
proc sql;
create table jeff.legal_bakrupt_pay_1 as
select * 
from jeff.historical_accounts_telco_1 as a left join jeff.max_legal_bankrupt_1 as b
on a.client_ledger_number = b.client_ledger_number and a.account_number = b.account_number;
quit;

data jeff.legal_bankrupt_pay_1;
set jeff.legal_bakrupt_pay_1 
/*(keep = client_ledger_number account_number agreement_operator_id x_proportion)*/
;
if agreement_operator_id = 5914 then legal = x_proportion;
if missing(legal) then legal = 0;
if agreement_operator_id = 5917 then bankrupt = x_proportion;
if missing(bankrupt) then bankrupt = 0;
run;

data jeff.historical_accounts_telco_2;
merge jeff.legal_bankrupt_pay_1 (in=t1) jeff.pa_accounts (in=t2);
by client_ledger_number account_number;
if missing(payment_arrangement) then payment_arrangement = 0;
if t1;
run;

/*merge data with banking file*/
proc sql;
create table jeff.legal_bakrupt_pay_2 as
select * 
from jeff.historical_accounts_banking_1 as a left join jeff.max_legal_bankrupt_1 as b
on a.client_ledger_number = b.client_ledger_number and a.account_number = b.account_number;
quit;

data jeff.legal_bankrupt_pay_2;
set jeff.legal_bakrupt_pay_2 
/*(keep = client_ledger_number account_number agreement_operator_id x_proportion)*/
;
if agreement_operator_id = 5914 then legal = x_proportion;
if missing(legal) then legal = 0;
if agreement_operator_id = 5917 then bankrupt = x_proportion;
if missing(bankrupt) then bankrupt = 0;
run;

data jeff.historical_accounts_banking_2;
merge jeff.legal_bankrupt_pay_2 (in=t1) jeff.pa_accounts (in=t2);
by client_ledger_number account_number;
if missing(payment_arrangement) then payment_arrangement = 0;
if t1;
run;

%mend pa_legal_attach;





%macro FULL_DATA_PREP(data_set=, output_telco=, output_banking=, original=);
data ATTACH.historical_accounts_updated; 
	set &data_set.;
	run;
/*This macro attaches lots of factors to the data set passed as a parameter.*/
/*It outputs two files; historical_accounts_banking and historical_accounts_telco.*/
%attach_new_columns_common(data_set=ATTACH.historical_accounts_updated, original=&original., original1=&data_set.);
/*This macro attaches more factors, from debt_load files*/
/*It outputs two files; historical_accounts_banking_1 and historical_accounts_telco_1.*/
%attach_more_factors(data_set_banking=ATTACH.historical_accounts_banking,data_set_telco=ATTACH.historical_accounts_telco);
/*This macro attaches legal/bankrupt and payment arrangement data from dmart*/
%pa_legal_attach(original=&original.);
data &output_banking.;
	set jeff.historical_accounts_banking_2;
	stat_bar = month(stat_barred) - month(loaded_date) + (year(stat_barred) - year(loaded_date))*12 + 1;
	stat_bar = ceil(stat_bar/6);
	run;
data &output_telco.;
	set jeff.historical_accounts_telco_2;
	stat_bar = month(stat_barred) - month(loaded_date) + (year(stat_barred) - year(loaded_date))*12 + 1;
	stat_bar = ceil(stat_bar/6);
	run;
%mend FULL_DATA_PREP;

/*TIME TAKEN TO RUN: 18mins*/
%FULL_DATA_PREP(data_set=ALMAUPDL.historical_accounts01_V2, output_telco=jeff.historical_accounts_telco_10, output_banking=jeff.historical_accounts_banking_10, original=ALMAUPDL.HISTORICAL_PAYMENTS04_V2);