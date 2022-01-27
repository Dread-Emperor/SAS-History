/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    LIBRARIES;
*0*
/********************************************************************************************/
/********************************************************************************************/;
libname ALMNZPDL '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\NZ\PDL';
libname DILAN '\\bcsap0010\sasdata\SAS Data\Dilan\SASdata';
libname JEFF '\\bcsap0010\sasdata\SAS Data\Jeffrey\SASdata';
libname DEBTLOAD '\\bcsap0010\sasdata\SAS Data\Monthly Load\debtload';
libname sdata '\\bcsap0010\sasdata\SAS Data\Monthly Load';
libname dmart odbc Datasrc=datamart schema=dbo; 


/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    MODEL BUILDING;
*0*
/********************************************************************************************/
/********************************************************************************************/;

/*Link data set to source code*/
data dilan.jacktest3;
      set  jeff.historical_accounts_bank_50_nz;
      %include '\\bcsap0010\sasdata\SAS Data\Monthly Load\test\Banking_Pricing_Proportion_SourceCode_Jack.sas';
      proportion = payments_total/loaded_amount;
/*      if payments_total > 0 then payments = 1;*/
/*      else payments = 0;*/
    if proportion > 5 then proportion = .;
    if proportion <= 0 then proportion = .;
      if proportion > 0;
      run;




ods graphics on;
proc genmod data = dilan.jacktest3 
/*Uncomment line below for plot of residuals*/
/*plots = all*/
;
class 
phone_count_21 
lp_amount_31 
gender_21
post_code_rating_21
/*referral_type_21 */
port_desc_20 
prod_desc_30 
portfolio_20 
gdp_21
/*debtor_age_at_load_1*/
/*bankrupt_1*/
/*legal_1*/
/*decile*/
latest_payment_after_load_1
Number_of_Defaults_2
;
model proportion = 
phone_count_21 
lp_amount_31
gender_21
post_code_rating_21 
/*referral_type_21 */
port_desc_20 
prod_desc_30 
portfolio_20 
age_since_loaded_0_n 
age_since_loaded_5_n 
loaded_amount_0_n 
loaded_amount_800_n 
loaded_amount_4000_n 
loaded_amount_10000_n
gdp_21 
open_n_1
open_n_5 
/*debtor_age_at_load_1*/
/*bankrupt_1*/
/*legal_1*/
/*decile*/
latest_payment_after_load_1
Number_of_Defaults_2
/ dist = gamma
link = log
type1
type3

/*Uncomment the next 2 lines to check for overdispersion (by looking at scale parameter. Should be close to 1*/
/*scale = deviance*/
/*aggregate*/     
;
run;
ods graphics off;