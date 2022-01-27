/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    LIBRARIES;
*0*
/********************************************************************************************/
/********************************************************************************************/;
libname ALMAUPDL '\\bcsap0010\sasdata\SAS Data\Monthly Load\ALM\AU\PDL';
libname JACK '\\bcsap0010\sasdata\SAS Data\Jack\SASdata';
libname JEFF '\\bcsap0010\sasdata\SAS Data\Jeffrey\SASdata';
libname DEBTLOAD '\\bcsap0010\sasdata\SAS Data\Monthly Load\debtload';
libname sdata '\\bcsap0010\sasdata\SAS Data\Monthly Load';
libname dmart odbc Datasrc=datamart schema=dbo; 
libname DILAN '\\bcsap0010\sasdata\SAS Data\Dilan\SASdata';


/********************************************************************************************/
/********************************************************************************************/
*0*
*0*    MODEL BUILDING;
*0*
/********************************************************************************************/
/********************************************************************************************/;

/*Link data set to source code*/
data jack.Genmod_Output;
	set jeff.historical_accounts_banking_5_nz;
	%include '\\bcsap0010\sasdata\SAS Data\Monthly Load\test\Banking_Probability_SourceCode_Jack.sas';
	proportion = payments_total/loaded_amount;
/*	if proportion > 5 then proportion = .;*/
/*	if proportion <= 0 then proportion = .;*/
/*	if proportion;*/
	if missing(payments_total) then payments_total = 0;
	if payments_total > 0 then payments = 1;
	else payments = 0;
	run;


ods graphics on;
proc genmod data = dilan.jacktest descending
/*Uncomment line below for plot of residuals*/
/*plots = all*/
;
class 
Gender_2
Phone_Count_2
Debtor_Age_1
Last_pt4
gdp_2
post_code_rating_8
Portfolio_1
Port_Desc_1
Product_1
Prod_Desc_1
lp_amount_2
referral_type

;
model payments = 
age_n_2
age_n_3
age_n_6
loaded_n_0 
loaded_n_075
loaded_n_1
Gender_2
Phone_Count_2
Debtor_Age_1
Last_pt4
gdp_2
post_code_rating_8
Portfolio_1
Port_Desc_1
Product_1
Prod_Desc_1
lp_amount_2
referral_type
open_n_0 
open_n_1 
open_n_6 

/ dist = bin
link = logit
type1
type3
/*Uncomment the next 2 lines to check for overdispersion (by looking at scale parameter. Should be close to 1*/
/*scale = deviance*/
/*aggregate*/
;
run;
ods graphics off;


/*options locale=en_US;*/
/*ods graphics on;*/
/*ods pdf file = "\\bcssydfs01\shared\Finance\05. PDL\03. PDL Reforecasting\AUTO FORECAST\PROJECTS\ALM\dilan\NZ_Pricing_Banking_Probability_ROC_1.pdf";*/
/**/
/*proc logistic data = jeff.banking_probability_pricing_3_nz plots (only) = (roc(ID=prob) EFFECT) descending;*/
/*class */
/*Gender_2*/
/*Phone_Count_2*/
/*Debtor_Age_1*/
/*Last_pt4*/
/*gdp_2*/
/*post_code_rating_8*/
/*Portfolio_1*/
/*Port_Desc_1*/
/*Product_1*/
/*Prod_Desc_1*/
/*lp_amount_2*/
/*referral_type*/
/*/ PARAM = glm;*/
/*;*/
/*model payments = */
/*age_n_2*/
/*age_n_3*/
/*age_n_6*/
/*loaded_n_025*/
/*loaded_n_075 */
/*loaded_n_1*/
/*loaded_n_2 */
/*loaded_n_10*/
/*Gender_2*/
/*Phone_Count_2*/
/*Debtor_Age_1*/
/*Last_pt4*/
/*gdp_2*/
/*post_code_rating_8*/
/*Portfolio_1*/
/*Port_Desc_1*/
/*Product_1*/
/*Prod_Desc_1*/
/*lp_amount_2*/
/*referral_type*/
/*open_n_0 */
/*open_n_1 */
/*open_n_6*/
/*/*/
/*outroc = roc*/
/*;*/
/*run;*/
/*ods graphics off;*/
/*ods pdf close;*/