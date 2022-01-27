/********************************************************************************************/
*0*    loaded_amount - Categorical/Numerical - Base Case = 1000;
/********************************************************************************************/
loaded_amount_20 = loaded_amount;

if missing (loaded_amount_20) then loaded_amount_20 = -99999;

loaded_amount_1 = loaded_amount;
if loaded_amount_1 > 10000 then loaded_amount_1 = 10000;

loaded_amount_0_n = max(loaded_amount_1-0,0)/10000;
loaded_amount_100_n = max(loaded_amount_1-100,0)/10000;
loaded_amount_200_n = max(loaded_amount_1-200,0)/10000;
loaded_amount_300_n = max(loaded_amount_1-300,0)/10000;
loaded_amount_400_n = max(loaded_amount_1-400,0)/10000;
loaded_amount_500_n = max(loaded_amount_1-500,0)/10000;
loaded_amount_600_n = max(loaded_amount_1-600,0)/10000;
loaded_amount_700_n = max(loaded_amount_1-700,0)/10000;
loaded_amount_800_n = max(loaded_amount_1-800,0)/10000;
loaded_amount_900_n = max(loaded_amount_1-900,0)/10000;
loaded_amount_1000_n = max(loaded_amount_1-1000,0)/10000;
loaded_amount_1500_n = max(loaded_amount_1-1500,0)/10000;
loaded_amount_2000_n = max(loaded_amount_1-2000,0)/10000;
loaded_amount_2500_n = max(loaded_amount_1-2500,0)/10000;
loaded_amount_3000_n = max(loaded_amount_1-3000,0)/10000;
loaded_amount_4000_n = max(loaded_amount_1-4000,0)/10000;
loaded_amount_5000_n = max(loaded_amount_1-5000,0)/10000;
loaded_amount_6000_n = max(loaded_amount_1-6000,0)/10000;
loaded_amount_7000_n = max(loaded_amount_1-7000,0)/10000;
loaded_amount_8000_n = max(loaded_amount_1-8000,0)/10000;
loaded_amount_9000_n = max(loaded_amount_1-9000,0)/10000;
loaded_amount_10000_n = max(loaded_amount_1-10000,0)/10000;


/*if missing (loaded_amount_20) then loaded_amount_20 = -99999;*/
/*if loaded_amount_20 > -100 then loaded_amount_20 = max(0,min(10000,ceil(loaded_amount/100)*100));*/
/*if loaded_amount_20 > 1000 then loaded_amount_20 = max(0,min(10000,ceil(loaded_amount/500)*500));*/
/*if loaded_amount_20 > 2000 then loaded_amount_20 = max(0,min(10000,ceil(loaded_amount/1000)*1000));*/
/*if loaded_amount_20 = 3000 then loaded_amount_20 = 99999;*/


/********************************************************************************************/
*0*    age_since_loaded - Categorical/Numerical - Base Case = 8;
/********************************************************************************************/

age_since_loaded_20 = age_since_loaded;
if missing (age_since_loaded_20) then age_since_loaded_20 = -99999; 

/*if age_since_loaded_20 = 8 then age_since_loaded_20 = 99999;*/
/*if age_since_loaded_20 = 9 then age_since_loaded_20 = 10;*/
/*if age_since_loaded_20 = 5 then age_since_loaded_20 = 6;*/
/*if age_since_loaded_20 = 7 then age_since_loaded_20 = 99999;*/
/*if age_since_loaded_20 = 6 then age_since_loaded_20 = 99999;*/

/*Knots*/

age_since_loaded_1 = age_since_loaded;
if age_since_loaded_1 > 12 then age_since_loaded_1 = 12;

age_since_loaded_0_n = max(age_since_loaded_1-0,0);
age_since_loaded_1_n = max(age_since_loaded_1-1,0);
age_since_loaded_2_n = max(age_since_loaded_1-2,0);
age_since_loaded_3_n = max(age_since_loaded_1-3,0);
age_since_loaded_4_n = max(age_since_loaded_1-4,0);
age_since_loaded_5_n = max(age_since_loaded_1-5,0);
age_since_loaded_6_n = max(age_since_loaded_1-6,0);
age_since_loaded_7_n = max(age_since_loaded_1-7,0);
age_since_loaded_8_n = max(age_since_loaded_1-8,0);
age_since_loaded_9_n = max(age_since_loaded_1-9,0);
age_since_loaded_10_n = max(age_since_loaded_1-10,0);
age_since_loaded_11_n = max(age_since_loaded_1-11,0);
age_since_loaded_12_n = max(age_since_loaded_1-12,0);

/********************************************************************************************/
*0*    gender - Categorical - Base Case = M;
/********************************************************************************************/

gender_20 = gender;
if missing(gender_20) then gender_20 = '?';
if gender_20 in ('?', 'F') then gender_20 = 'F';

length gender_21 $3;
if gender_20 = 'F' then gender_21 = 'F&?';
if gender_20 = 'M' then gender_21 = 'zM';

/********************************************************************************************/
/**0*    phone_count - Categorical - Base Case = 1;*/
/********************************************************************************************/

phone_count_20 = phone_count;
if missing(phone_count_20) then phone_count_20 = 0;
if phone_count_20 = 1 then phone_count_20 = 99999;

length phone_count_21 $2;
if phone_count_20 = 0 then phone_count_21 = '0';
else if phone_count_20 = 99999 then phone_count_21 = 'z1';
else if phone_count_20 = 2 then phone_count_21 = '2';
else if phone_count_20 = 3 then phone_count_21 = '3';
else phone_count_21 = phone_count_20;

/********************************************************************************************/
*0*    loaded_month - Categorical - Base Case = 1;
/********************************************************************************************/

loaded_month_20 = month(loaded_month);
if missing (loaded_month_20) then loaded_month_20 = -99999;
if loaded_month_20 in (2, 3, 4, 5, 6, 7, 9, 10, 11, 12) then loaded_month_20 = 99999;

length loaded_month_21 $14;
if loaded_month_20 = 1 then loaded_month_21 = 'January';
else if loaded_month_20 = 8 then loaded_month_21 = 'August';
else if loaded_month_20 = 99999 then loaded_month_21 = 'zOther Months';
else loaded_month_21 = loaded_month_20;

/********************************************************************************************/
*0*    debtor_age_at_load_band - Categorical - Base Case = 2: 25 - 34 Yrs;
/********************************************************************************************/

debtor_age_20 = debtor_age_at_load_band;
if missing (debtor_age_20) then debtor_age_20 = 'Missing';
if debtor_age_20 in ('2: 25 - 34 Yrs', '3: 35 - 44 Yrs', '4: 45 - 54 Yrs', '5: 55 - 64 Yrs', '6: 65 Yrs +', '7: Missing') then debtor_age_20 = 'z: 25+Yrs & ?';

/********************************************************************************************/
*0*    last_payment_to_loaded - Categorical - Base Case = 12;
/********************************************************************************************/

last_pt20 = last_payment_to_loaded;
if missing(last_pt20) then last_pt20 = -99999;
if last_pt20 > -90000 then last_pt20 = max(0,min(60,ceil(last_pt20/12)*12));
if last_pt20 in (12, 24, 36, 48, -99999) then last_pt20 = 99999;

/********************************************************************************************/
*0*    gdp_index - Categorical - Base Case = 104;
/********************************************************************************************/

gdp_20 = gdp_index;
if missing(gdp_20) then gdp_20 = -99999;
if gdp_20 > -90000 then gdp_20 = max(100,min(114,ceil(gdp_20/2)*2));
if gdp_20 in (-99999, 100, 102, 104, 106, 108) then gdp_20 = 99999;
if gdp_20 in (110, 112, 114) then gdp_20 = 114;

length gdp_21 $9;
if gdp_20 = 114 then gdp_21 = '108+';
else if gdp_20 = 99999 then gdp_21 = 'z108- & ?';
else gdp_21 = gdp_20;

/********************************************************************************************/
*0*    latest_payment_after_load - Categorical - Base Case = 104;
/********************************************************************************************/
/*latest_payment_after_load_1 = latest_payment_after_load;*/
length latest_payment_after_load_1 $8;
if missing(latest_payment_after_load) then latest_payment_after_load_1 = '-99999';
else if 0.5<latest_payment_after_load<=1.5 then latest_payment_after_load_1 = '1.5';
else if 4.5<latest_payment_after_load then latest_payment_after_load_1 = '4.5+';
else if 1.5<latest_payment_after_load<=2 then latest_payment_after_load_1 = '2';
else if 2<latest_payment_after_load<=2.5 then latest_payment_after_load_1 = '2.5';
else if 2.5<latest_payment_after_load<=3 then latest_payment_after_load_1 = '3';
else if 3<latest_payment_after_load<=3.5 then latest_payment_after_load_1 = '3.5';
else if 3.5<latest_payment_after_load<=4 then latest_payment_after_load_1 = '4';
else if 4<latest_payment_after_load<=4.5 then latest_payment_after_load_1 = '4.5';
else if 0<=latest_payment_after_load<=0.5 then latest_payment_after_load_1 = 'z0.5';
/*else if 1.5<latest_payment_after_load_1 then latest_payment_after_load_1 = max(0,ceil(latest_payment_after_load_1/0.5)*0.5);*/


/********************************************************************************************/
*0*    Number_of_Defaults - Categorical - Base Case = 104;
/********************************************************************************************/

Number_of_Defaults_1 = Number_of_Defaults;
if missing(Number_of_Defaults_1) then Number_of_Defaults_1 = -99999;
if Number_of_Defaults_1 = 0 then Number_of_Defaults_1 = 99999;
else if 4<=Number_of_Defaults_1<=5 then Number_of_Defaults_1 = 5;
else if 6<=Number_of_Defaults_1<=20 then Number_of_Defaults_1 = 14;

length Number_of_Defaults_2 $8;
if Number_of_Defaults_1 in (-99999, 99999) then Number_of_Defaults_2 = 'z0';
else if Number_of_Defaults_1 in (1) then Number_of_Defaults_2 = '1';
else if Number_of_Defaults_1 = 2 then Number_of_Defaults_2 = '2';
else if Number_of_Defaults_1 = 3 then Number_of_Defaults_2 = '3';
else if Number_of_Defaults_1 = 5 then Number_of_Defaults_2 = '5';
else if Number_of_Defaults_1 = 14 then Number_of_Defaults_2 = '14';

/********************************************************************************************/
*0*    Dollars_Defaults - Categorical - Base Case = 0;
/********************************************************************************************/
/*Too correlated with Number of defaults which has a greater significance*/

/*length Dollars_Defaults_2 $8;*/
/*Dollars_Defaults_1 = min(1000,max(0,ceil(Dollars_Defaults_1/100)*100));*/
/*if missing(Dollars_Defaults_1) then Dollars_Defaults_2="miss";*/
/*else if Dollars_Defaults_1=0 then Dollars_Defaults_2="z0";*/
/*else if Dollars_Defaults_1<500 then Dollars_Defaults_2="1.0-0.5";*/
/*else if Dollars_Defaults_1<800 then Dollars_Defaults_2="2.0.5-0.8";*/
/*else if Dollars_Defaults_1<500 then Dollars_Defaults_2="1.0-500";*/

/*length Dollars_Defaults_1 $12;*/
/*if missing(Dollars_Defaults) then Dollars_Defaults_1 = "missing";*/
/*else if Dollars_Defaults = 0 then Dollars_Defaults_1 = "z0";*/
/*else if Dollars_Defaults<=200 then Dollars_Defaults_1 = "0-200";*/
/*/*else if Dollars_Defaults<=500 then Dollars_Defaults_1 = "200-500";*/*/
/*else if Dollars_Defaults<=8000 then Dollars_Defaults_1 = "200-8000";*/
/*else if Dollars_Defaults<9000 then Dollars_Defaults_1 = "8000-9000";*/
/*else Dollars_Defaults_1 = "9000+";*/



/********************************************************************************************/
*0*    Number_of_Inquiries - Categorical - Base Case = 6;
/********************************************************************************************/
/*Too correlated with Number of defaults which has a greater significance*/

/*Number_of_Inquiries_1 = Number_of_Inquiries;*/
/*if missing(Number_of_Inquiries_1) then Number_of_Inquiries_1 = -99999;*/
/*if 1<=Number_of_Inquiries_1<=10 then Number_of_Inquiries_1 = min(10,max(1,ceil(Number_of_Inquiries_1/2)*2));*/
/*if Number_of_Inquiries_1 = 6 then Number_of_Inquiries_1 = 99999;*/
/*if 10<Number_of_Inquiries_1<=40 then Number_of_Inquiries_1 = min(40,max(10,ceil(Number_of_Inquiries_1/5)*5));*/
/*if 40<Number_of_Inquiries_1<=99 then Number_of_Inquiries_1 = 99;*/


/* Unsure of which bands to use. I really shouldn't use 0-2 as band 0 should be by itself*/
/* Need to find base case*/
/********************************************************************************************/
*0*    legal - Categorical - Base Case = 104;
/********************************************************************************************/
/*length legal_1 $8;*/
/*legal_1 = legal;*/
/*if missing(bankrupt_1) then bankrupt_1 = -99999;*/

/********************************************************************************************/
*0*    bankrupt - Categorical - Base Case = 104;
/********************************************************************************************/
/*length bankrupt_1 $8;*/
/*bankrupt_1 = bankrupt;*/
/*if missing(bankrupt_1) then bankrupt_1 = -99999;*/


/********************************************************************************************/
*0*    debtor_age_at_load_1 - Categorical - Base Case = 104;
/********************************************************************************************/

/*debtor_age_at_load_1 = debtor_age_at_load;*/
/*if missing(debtor_age_at_load_1) then debtor_age_at_load_1 = -99999;*/
/*If 21<=debtor_age_at_load_1<= 25 then debtor_age_at_load_1 = 99999;*/
/*if 18<=debtor_age_at_load_1<=20 then debtor_age_at_load_1 = 20;*/
/*if 46<=debtor_age_at_load_1<=55 tehn debtor_age_at_load_1 = 55;*/
/*else if 21<=debtor_age_at_load_1<=60 then debtor_age_at_load_1 = min(88,max(0,ceil(debtor_age_at_load_1/5)*5));*/
/*else if 61<=debtor_age_at_load_1<=87 then debtor_age_at_load_1 = 87;*/
*18-20, 21-25, 26-30 .... 61-87;



/********************************************************************************************/
*0*    payment_count - Categorical - Base Case = 104;
/********************************************************************************************/

/*payment_count_1 = payment_count;*/
/*if missing(payment_count_1) then payment_count_1 = -99999;*/
/*else if payment_count_1 = 1 then payment_count_1 = 99999;*/
/*else if 5<payment_count_1<=20 then payment_count_1 = max(0,min(20,ceil(payment_count_1/5)*5));*/
/*else if 20<payment_count_1<=40 then payment_count_1 = 40;*/
/*else if 40<payment_count_1<=50 then payment_count_1 = max(0,min(200,ceil(payment_count_1/10)*10));*/
/*else if 50<payment_count_1<=200 then payment_count_1 = max(0,min(200,ceil(payment_count_1/50)*50));*/
/*else if 200<payment_count_1 then payment_count_1 = 400;*/


/********************************************************************************************/
*0*    debt_age_at_load_band - Categorical - Base Case = 1: <= 6 Mths;
/********************************************************************************************/

debt_age_20 = debt_age_at_load_band;
if missing(debt_age_20) then debt_age_20 = 'Missing';
if debt_age_20 in ('1: <= 6 Mths', '2: 7-12 Mths') then debt_age_20 = 'z1/2: <= 12 Mths';
if debt_age_20 in ('3: 13-18 Mths', '4: 19-24 Mths', '5: >24 Mths') then debt_age_20 = '3/4/5: > 13 Mths';

/********************************************************************************************/
*0*    portfolio - Categorical - Base Case = Corporate Account;
/********************************************************************************************/

portfolio_20 = portfolio;
if missing(portfolio_20) then portfolio_20 = 'Missing';
if portfolio_20 in ('Corporate Account', 'Major Account', 'Large Account') then portfolio_20 = 'zCorporate/Major/Large Account';

/********************************************************************************************/
*0*    product - Categorical - Base Case = Credit Card;
/********************************************************************************************/

product_20 = product;
if missing(product_20) then product_20 = 'Missing';
if product_20 in ('Credit Card', 'Rental', 'Finance') then product_20 = 'zCredit Card/Rental/Finance';
if product_20 in ('Banking', 'Loans') then product_20 = 'Banking/Loans';

/********************************************************************************************/
*0*    prod_desc - Categorical - Base Case = Creditline;
/********************************************************************************************/

prod_desc_20 = prod_desc;
if missing(prod_desc_20) then prod_desc_20 = 'Missing';
if prod_desc_20 in ('Creditline', 'Car Loan', 'Gems Visa') then prod_desc_20 = 'zCreditline/Car Loan/Gems Visa';
if prod_desc_20 in ('Retail', 'Other', 'Unknown', 'Personal Loan') then prod_desc_20 = 'Retail/Other/Unknown/Personal Loan';

prod_desc_30 = prod_desc;
if prod_desc_30 in ('Creditline', 'Gems Visa', 'Retail', 'Unknown', 'Car Loan') then prod_desc_30 = 'zCreditline/Retail/CarLoan/Visa';
if prod_desc_30 in ('Home Loan', 'Personal Loan', 'Other') then prod_desc_30 = 'Personal/Home Loan/Other';

/********************************************************************************************/
*0*    last_payment_amount - Categorical - Base Case = 2500;
/********************************************************************************************/

lp_amount_30 = last_payment_amount;
if missing(lp_amount_30) and port_desc in ('ANZ National Bank', 'Ford Credit', 'Hopscotch Money') then lp_amount_30 = -99999;
if missing(lp_amount_30) then lp_amount_30 = 0;
if lp_amount_30 < -99999 then lp_amount_30 = -99999;
if lp_amount_30 > -90000 and lp_amount_30 < 0 then lp_amount_30 = -lp_amount_30;
if 0 <= lp_amount_30 < 100 then lp_amount_30 = max(0,min(100,ceil(last_payment_amount/25)*25));
else if 100 <= lp_amount_30 < 500 then lp_amount_30 = max(0,min(500,ceil(last_payment_amount/100)*100));
else if lp_amount_30 >= 500 then lp_amount_30 = max(0,min(2000,ceil(last_payment_amount/1000)*1000));

if lp_amount_30 in (75, 100) then lp_amount_30 = 99999;
if lp_amount_30 in (300, 400, 500) then lp_amount_30 = 500;
if lp_amount_30 in (1000, 2000) then lp_amount_30 = 2000;

length lp_amount_31 $7;
if lp_amount_30 = -99999 then lp_amount_31 = 'z50-100 & Miss';
else if lp_amount_30 = 0 then lp_amount_31 = 'NoPaymt';
else if lp_amount_30 = 25 then lp_amount_31 = '0-25';
else if lp_amount_30 = 50 then lp_amount_31 = '25-50';
else if lp_amount_30 = 99999 then lp_amount_31 = 'z50-100 & Miss';
else if lp_amount_30 = 200 then lp_amount_31 = '100-200';
else if lp_amount_30 = 500 then lp_amount_31 = '200-500';
else if lp_amount_30 = 2000 then lp_amount_31 = '500+';

/********************************************************************************************/
*0*    post_code_rating - Categorical - Base Case = 7;
/********************************************************************************************/
post_code_rating_20 = post_code_rating_1;
if missing(post_code_rating_20) and residential_post_code = 9999 then post_code_rating_20 = -1000;
if missing(post_code_rating_20) and residential_post_code ne 9999 then post_code_rating_20 = -99999;
if post_code_rating_20 > -1 then post_code_rating_20 = min(10,max(1,ceil(post_code_rating_20)));

if post_code_rating_20 in (1, 2, 3, 4) then post_code_rating_20 = 4;
if post_code_rating_20 in (6, 7, 8, 9, 10) then post_code_rating_20 = 99999;

length post_code_rating_21 $10;
if post_code_rating_20 = -99999 then post_code_rating_21 = 'Missing';
else if post_code_rating_20 = -1000 then post_code_rating_21 = 'Overseas';
else if post_code_rating_20 in (4, 5) then post_code_rating_21 = '0-5';
else if post_code_rating_20 = 99999 then post_code_rating_21 = 'z5-10';
else post_code_rating_21 = post_code_rating_20;

/********************************************************************************************/
*0*    referral_type - Categorical - Base Case = 0;
/********************************************************************************************/

referral_type_20 = referral_type;
if missing(referral_type_20) then referral_type_20 = 'Missing';
if referral_type_20 in ('1 (Baycorp was the first referral agency for the majority of the debt)', '1 (Baycorp was the first referral agency)') then referral_type_20 = '1 (Baycorp was first for all or majority)';
if referral_type_20 in ('1 (Baycorp was not the agency)', '0') then referral_type_20 = 'z0/1 (Baycorp was not the agency)';

referral_type_21 = referral_type;
if missing(referral_type_21) then referral_type_21 = 'Missing';
if referral_type_21 in ('0', '1 (Baycorp was the first referral agency for the majority of the debt)', '1 (Baycorp was the first referral agency)', '1 (Baycorp was not the agency)') then referral_type_21 = 'zNot Missing';

/********************************************************************************************/
*0*    inventory__forward_flow - Categorical - Base Case = Forward Flow;
/********************************************************************************************/

inventory_forward_flow_20 = inventory__forward_flow;
if missing(inventory_forward_flow_20) then inventory_forward_flow_20 = 'Missing';
if inventory_forward_flow_20 in ('Forward Flow', 'Inventory') then inventory_forward_flow_20 = 'zForw.Flow/Inv';

/********************************************************************************************/
*0*    unemployment_rate - Categorical - Base Case = 7;
/********************************************************************************************/

unemploy_20 = unemployment_rate;
if missing(unemploy_20) then unemploy_20 = -99999;
if unemploy_20 in (5.6, 5.8, 5.9, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 7, 7.1) then unemploy_20 = 99999;

/********************************************************************************************/
*0*    port_desc - Categorical - Base Case = GE;
/********************************************************************************************/

port_desc_20 = port_desc;
if missing(port_desc_20) then port_desc_20 = 'Missing';

if port_desc_20 in ('GE', 'Consumer Finance', 'Moneyshop', 'Home Direct') then port_desc_20 = 'zGE/Consumer Finance/Moneyshop/Home Direct';
if port_desc_20 in ('Flexigroup', 'Ford Credit', 'Hopscotch Money', 'Retail Financial Services') then port_desc_20 = 'Flexi/Ford/HopM/RFS/ANZ/Wpac';
if port_desc_20 in ('ANZ National Bank', 'ANZ', 'Westpac') then port_desc_20 = 'Flexi/Ford/HopM/RFS/ANZ/Wpac';


/********************************************************************************************/
*0*    opened_date - Numerical;
/********************************************************************************************/

opened_date_20 = opened_date;
if missing(opened_date_20) and not missing(open_date) then opened_date_20 = open_date;
if missing(opened_date_20) and not missing(opening_date) then opened_date_20 = opening_date;
if missing(opened_date_20) and not missing(date_opened) then opened_date_20 = date_opened;
if missing(opened_date_20) and not missing(debtor_opened) then opened_date_20 = debtor_opened;
if missing(opened_date_20) and not missing(date_in) then opened_date_20 = date_in;
if missing(opened_date_20) and not missing(start_date) then opened_date_20 = start_date;
if missing(opened_date_20) and not missing(customer_since) then opened_date_20 = customer_since;
if missing(opened_date_20) and not missing(date_in) then opened_date_20 = date_in;
if missing(opened_date_20) and not missing(account_open_date) then opened_date_20 = account_open_date;
if missing(opened_date_20) and not missing(from_date) then opened_date_20 = from_date;

if missing(opened_date_20) then opened_date_20 = -99999;

loaded_date_20 = loaded_date;
open_to_load = loaded_date_20 - opened_date_20;
if opened_date_20 = -99999 then open_to_load = -99999;
if open_to_load > -99998 then open_to_load = ceil(open_to_load/365)*365;
if open_to_load > -99998 then open_to_load = open_to_load/365;

if open_to_load > 14 then open_to_load = 14;
/*if open_to_load in (3) then open_to_load = 99999;*/

open_n_0 = max(0,open_to_load-0);
open_n_1 = max(0,open_to_load-1);
open_n_2 = max(0,open_to_load-2);
open_n_3 = max(0,open_to_load-3);
open_n_4 = max(0,open_to_load-4);
open_n_5 = max(0,open_to_load-5);
open_n_6 = max(0,open_to_load-6);
open_n_7 = max(0,open_to_load-7);
open_n_8 = max(0,open_to_load-8);
open_n_9 = max(0,open_to_load-9);
open_n_10 = max(0,open_to_load-10);
open_n_11 = max(0,open_to_load-11);
open_n_12 = max(0,open_to_load-12);
open_n_13 = max(0,open_to_load-13);
open_n_14 = max(0,open_to_load-14);
