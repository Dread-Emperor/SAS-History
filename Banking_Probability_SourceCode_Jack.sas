/********************************************************************************************/
*0*    loaded_amount - Categorical/Numerical;
/********************************************************************************************/
loaded_amount_1 = loaded_amount;
loaded_amount_1 = max(0,min(10000,round(loaded_amount/250)*250));
/*else loaded_amount_1 = max(0,min(10000,ceil(loaded_amount/1000)*1000));*/
/*if loaded_amount_1 = 500 then loaded_amount_1 = 99999;*/
loaded_amount_2 = loaded_amount_1/10000;

loaded_amount_3 = loaded_amount;
if loaded_amount_3 > 30000 then loaded_amount_3 = 30000;

loaded_n_0 = loaded_amount_3/10000;
loaded_n_025 = max(0,loaded_amount_3-250)/10000;
loaded_n_05 = max(0,loaded_amount_3-500)/10000;
loaded_n_075 = max(0,loaded_amount_3-750)/10000;
loaded_n_1 = max(0,loaded_amount_3-1000)/10000;
loaded_n_2 = max(0,loaded_amount_3-2000)/10000;
loaded_n_3 = max(0,loaded_amount_3-3000)/10000;
loaded_n_4 = max(0,loaded_amount_3-4000)/10000;
loaded_n_5 = max(0,loaded_amount_3-5000)/10000;
loaded_n_6 = max(0,loaded_amount_3-6000)/10000;
loaded_n_7 = max(0,loaded_amount_3-7000)/10000;
loaded_n_8 = max(0,loaded_amount_3-8000)/10000;
loaded_n_9 = max(0,loaded_amount_3-9000)/10000;
loaded_n_10 = max(0,loaded_amount_3-10000)/10000;
loaded_n_11 = max(0,loaded_amount_3-11000)/10000;
loaded_n_12 = max(0,loaded_amount_3-12000)/10000;
loaded_n_13 = max(0,loaded_amount_3-13000)/10000;
loaded_n_14 = max(0,loaded_amount_3-14000)/10000;
loaded_n_15 = max(0,loaded_amount_3-15000)/10000;

/********************************************************************************************/
*0*    age_since_loaded - Categorical/Numerical;
/********************************************************************************************/
age_since_loaded_1 = age_since_loaded;
if age_since_loaded_1 >= 8 then age_since_loaded_1 = 8;
/*if age_since_loaded_1 = 2 then age_since_loaded_1 = 99999;*/

age_n_0 = max(0,age_since_loaded_1-0);
age_n_1 = max(0,age_since_loaded_1-1);
age_n_2 = max(0,age_since_loaded_1-2);
age_n_3 = max(0,age_since_loaded_1-3);
age_n_4 = max(0,age_since_loaded_1-4);
age_n_5 = max(0,age_since_loaded_1-5);
age_n_6 = max(0,age_since_loaded_1-6);
age_n_7 = max(0,age_since_loaded_1-7);
age_n_8 = max(0,age_since_loaded_1-8);

/********************************************************************************************/
*0*    gender - Categorical;
/********************************************************************************************/

gender_1 = gender;
if missing(gender_1) then gender_1 = '?';
if gender_1 in ('?', 'M') then gender_1 = 'M';

length gender_2 $3;
if gender_1 = 'M' then gender_2 = 'M&?';
else if gender_1 = 'F' then gender_2 = 'F';

/********************************************************************************************/
*0*    phone_count - Categorical;
/********************************************************************************************/
phone_count_1 = phone_count;
if missing(phone_count_1) or phone_count_1 = 0 then phone_count_1 = 99999;

length phone_count_2 $2;
if phone_count_1 = 99999 then phone_count_2 = 'z0';
else if phone_count_1 = 1 then phone_count_2 = '1';
else if phone_count_1 = 2 then phone_count_2 = '2';
else if phone_count_1 = 3 then phone_count_2 = '3';
else phone_count_2 = phone_count_1;

/********************************************************************************************/
*0*    payment count - Categorical;
/********************************************************************************************/

*payment_count_1 = payment_count;
*if missing(payment_count_1) then payment_count_1 = 0; 
*else if 1<=payment_count_1<=3 then payment_count_1 = 3;
*else if 4<=payment_count_1<=100 then payment_count_1 = 100;
*else if 10<payment_count_1<=20 then payment_count_1 = max(0,min(30,ceil(payment_count_1/5)*5));
*else if 20<payment_count_1<=50 then payment_count_1 = 50;
*else if /*50*/ 100<payment_count_1<=150 then payment_count_1 = max(0,min(200,ceil(payment_count_1/50)*50));
*else if 100<payment_count_1 then payment_count_1 = 400;
*if payment_count_1 = 0 then payment_count_1 = 99999;

/********************************************************************************************/
*0*    loaded_month - Categorical;
/********************************************************************************************/
loaded_month_1 = month(loaded_month);
if loaded_month_1 in (1, 7, 8, 6, 4, 5) then loaded_month_1 = 99999;
if loaded_month_1 in (9, 11, 12) then loaded_month_1 = 12;
if loaded_month_1 in (2, 3, 10) then loaded_month_1 = 2;

length loaded_month_2 $24;
if loaded_month_1 = 99999 then loaded_month_2 = 'zJan,Apr,May,Jun,Jul,Aug';
else if loaded_month_1 = 12 then loaded_month_2 = 'Sep,Nov,Dec';
else if loaded_month_1 = 2 then loaded_month_2 = 'Feb,Mar,Oct';
else loaded_month_2 = loaded_month_1;

/********************************************************************************************/
*0*    debtor_age_at_load_band - Categorical;
/********************************************************************************************/
debtor_age_1 = debtor_age_at_load_band;
if debtor_age_1 in ('2: 25 - 34 Yrs','3: 35 - 44 Yrs','4: 45 - 54 Yrs') then debtor_age_1 = 'z2: 25-54Yrs';

/********************************************************************************************/
*0*    last_payment_to_loaded - Categorical;
/********************************************************************************************/
last_ptl = last_payment_to_loaded;
if missing(last_ptl) then last_ptl = -99999;
if last_ptl > -90000 then last_ptl = max(0,min(72,ceil(last_ptl/12)*12));
if last_ptl = 12 then last_ptl = 99999;

length last_pt2 $5;
if last_ptl = 99999 then last_pt2 = 'z0-12';
else if last_ptl = 24 then last_pt2 = '12-24';
else if last_ptl = 36 then last_pt2 = '24-36';
else if last_ptl = 48 then last_pt2 = '36-48';
else if last_ptl = 60 then last_pt2 = '48-60';
else if last_ptl = 72 then last_pt2 = '60+';
else if last_ptl = -99999 then last_pt2 = 'Miss';
else last_pt2 = last_ptl;

last_pt3 = last_payment_to_loaded;
if missing(last_pt3) and port_desc in ('ANZ National Bank', 'Dominion TV Rentals', 'Ford Credit') then last_pt3 = -100;
if missing(last_pt3) then last_pt3 = -99999;
if last_pt3 > -5 then last_pt3 = max(0,min(72,ceil(last_pt3/12)*12));
if last_pt3 in (12, 24) then last_pt3 = 99999;

length last_pt4 $9;
if last_pt3 = 99999 then last_pt4 = 'z0-24';
else if last_pt3 = 36 then last_pt4 = '24-36';
else if last_pt3 = 48 then last_pt4 = '36-48';
else if last_pt3 = 60 then last_pt4 = '48-60';
else if last_pt3 = 72 then last_pt4 = '60+';
else if last_pt3 = -99999 then last_pt4 = 'NoPayment';
else if last_pt3 = -100 then last_pt4 = 'Missing';

/********************************************************************************************/
*0*    gdp_index - Categorical;
/********************************************************************************************/
gdp_1 = gdp_index;
if missing(gdp_1) then gdp_1 = -99999;
if gdp_1 > -90000 then gdp_1 = max(99,min(150,ceil(gdp_1/2)*2));

if gdp_1 in (110, 112, 114) then gdp_1 = 114;
if gdp_1 in (-99999, 100, 102, 104, 106, 108) then gdp_1 = 99999;

length gdp_2 $9;
if gdp_1 = 99999 then gdp_2 = 'z<110 & ?';
else if gdp_1 = 114 then gdp_2 = '>110';
else gdp_2 = gdp_1;

/********************************************************************************************/
*0*    unemployment_rate - Categorical;
/********************************************************************************************/
unemploy_1 = unemployment_rate;
if unemploy_1 in (6.6, 6.7, 6.8, 7, 7.1) then unemploy_1 = 99999;
if unemploy_1 in (5.4, 5.6, 5.8, 5.9, 6.2, 6.3, 6.4, 6.5) then unemploy_1 = 6.5;

/********************************************************************************************/
*0*    debt_age_at_load_band - Categorical;
/********************************************************************************************/
debt_age_1 = debt_age_at_load_band;
if debt_age_1 = '5: >24 Mths' or debt_age_1 = '2: 7-12 Mths' then debt_age_1 = 'z5: >24 Mths';

/********************************************************************************************/
*0*    portfolio - Categorical;
/********************************************************************************************/
portfolio_1 = portfolio;
if portfolio_1 in ('Corporate Account', 'Major Account') then portfolio_1 = 'zCorporate/Major Account';

portfolio_2 = portfolio;

/********************************************************************************************/
*0*    port_desc - Categorical;
/********************************************************************************************/
port_desc_1 = port_desc;
if port_desc_1 in ('Dominion TV Rentals', 'Westpac', 'Moneyshop', 'Home Direct', 'GE') then port_desc_1 = 'zWest/Dom/MS/HD/GE';
if port_desc_1 in ('ANZ National Bank', 'ANZ') then port_desc_1 = 'ANZ';
if port_desc_1 in ('Retail Financial Services', 'Consumer Finance') then port_Desc_1 = 'ConsumerFinance/RetailFS';

port_desc_2 = port_desc;

/********************************************************************************************/
*0*    product - Categorical;
/********************************************************************************************/
product_1 = product;
if product_1 in ('Credit Card', 'Rental', 'Finance', 'Banking') then product_1 = 'zCredit Card/Banking';

product_2 = product;

/********************************************************************************************/
*0*    prod_desc - Categorical;
/********************************************************************************************/
prod_desc_1 = prod_desc;
if prod_desc_1 in ('Other', 'Unknown', 'Retail', 'Personal Loan', 'Car Loan','Creditline') then prod_desc_1 = 'zRetail/Personal/CarLoan/Other';
if prod_desc_1 in ('Gems Visa', 'Home Loan') then prod_desc_1 = 'HL/GEMV';

prod_desc_2 = prod_desc;

/********************************************************************************************/
*0*    last_payment_amount - Categorical;
/********************************************************************************************/
lp_amount_1 = last_payment_amount;
/*These portfolios do not have the variable last_payment_account*/
if missing(lp_amount_1) and port_desc in ('ANZ National Bank','Dominion TV Rentals','Ford Credit','Hopscotch Money') then lp_amount_1 = -99999;
/*All other accounts with missing 'last_payment_amount' will be treated as '0'*/
if missing(lp_amount_1) then lp_amount_1 = 0;
/*The outliers will be treated as '0'*/
if lp_amount_1 < -999999 then lp_amount_1 = 0;
/*Some accounts had their last_payments enterred as negative values*/
if lp_amount_1 > -90000 and lp_amount_1 < 0 then lp_amount_1 = -lp_amount_1;

if 0 <= lp_amount_1 < 100 then lp_amount_1 = max(0,min(100,ceil(last_payment_amount/25)*25));
else if 100 <= lp_amount_1 < 1000 then lp_amount_1 = max(0,min(1000,ceil(last_payment_amount/100)*100));
else if lp_amount_1 >= 1000 then lp_amount_1 = max(0,min(2000,ceil(last_payment_amount/500)*500));

if lp_amount_1 in (75, 100) then lp_amount_1 = 99999;
if lp_amount_1 in (0, -99999, 25, 50) then lp_amount_1 = 50;
if lp_amount_1 in (300, 400) then lp_amount_1 = 400;
if lp_amount_1 in (500, 600, 700, 800, 900, 1000, 1500, 2000) then lp_amount_1 = 2000;

length lp_amount_2 $8;
if lp_amount_1 = 50 then lp_amount_2 = '0-50 + ?';
else if lp_amount_1 = 99999 then lp_amount_2 = 'z50-100';
else if lp_amount_1 = 200 then lp_amount_2 = '100-400';
else if lp_amount_1 = 400 then lp_amount_2 = '100-400';
else if lp_amount_1 = 2000 then lp_amount_2 = '400+';

/********************************************************************************************/
*0*    post_code_rating - Categorical;
/********************************************************************************************/

post_code_rating_7 = post_code_rating_1;
/*This is for overseas accounts*/
if missing(post_code_rating_7) and residential_post_code = 9999 then post_code_rating_7 = -100; 
/*This is for accounts with missing post codes*/
if missing(post_code_rating_7) and missing(residential_post_code) then post_code_rating_7 = -99999;
/*This is for accounts that have post codes, but we couldn't match a ranking*/
if missing(post_code_rating_7) and 1 < residential_post_code < 9999 then post_code_rating_7 = -99999;

if post_code_rating_7 > -1 then post_code_rating_7 = min(10,max(1,ceil(post_code_rating_7)));
if post_code_rating_7 in (2, 3, 4, 5, 6, 7, 8, 9, 10) then post_code_rating_7 = 99999;

length post_code_rating_8 $10;
if post_code_rating_7 = -100 then post_code_rating_8 = 'Overseas';
else if post_code_rating_7 = -99999 then post_code_rating_8 = 'Missing';
else if post_code_rating_7 = 1 then post_code_rating_8 = '0-1';
else if post_code_rating_7 = 99999 then post_code_rating_8 = 'z1-10';
else post_code_rating_8 = post_code_rating_7;

/********************************************************************************************/
*0*    referral_type - Categorical;
/********************************************************************************************/
length referral_type_1 $10;
if missing(referral_type) then referral_type_1 = 'Missing';
if referral_type = '0' then referral_type_1= 'z0';
if referral_type in ('1 (Baycorp was not the agency)','1 (Baycorp was the first referral agency for the majority of the debt)','1 (Baycorp was the first referral agency)','') then referral_type_1 = '1 & ?';

/********************************************************************************************/
*0*    inventory__forward_flow - Categorical;
/********************************************************************************************/
if missing(inventory__forward_flow) then inventory__forward_flow = 'Missing';
inventory_ff = inventory__forward_flow;
if inventory_ff in ('Forward Flow', 'Missing') then inventory_ff = 'zForward Flow/?';
/*if inventory_ff in ('Missing', 'Inventory') then inventory_ff = 'Inv & ?';*/

/********************************************************************************************/
*0*    interactions;
/********************************************************************************************/
if portfolio ne 'Corporate Account' then other_port = 1;
else other_port = 0;

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
/*if open_to_load = 3 then open_to_load = 99999;*/

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


/********************************************************************************************/
*0*    Interest_rate - Numerical;
/********************************************************************************************/

interest_rate_1 = interest_rate;
if missing(interest_rate_1) then interest_rate_1 = -99999;
if interest_rate_1 > 0 and interest_rate_1 < 1 then interest_rate_1 = 100*interest_rate_1;
if interest_rate_1 > -1 then interest_rate_1 = ceil(interest_rate_1/5)*5;
if interest_rate_1 in (0, 5, 15, 20) then interest_rate_1 = 20;
if interest_rate_1 in (-99999, 25, 30, 35, 40, 45) then interest_rate_1 = 45;

/********************************************************************************************/
*0*  	Interactions;
/********************************************************************************************/

if port_desc = 'GE' and product = 'Credit Card' then GE_CC = 1;
else GE_CC = 0;

