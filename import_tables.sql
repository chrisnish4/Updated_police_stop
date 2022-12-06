create schema ps_import; 

-- Creating and loading Stop details table
drop table if exists ps_import.stop_details;
create table ps_import.stop_details (
	stop_id int,
    ori varchar(15),
    agency varchar(5),
    exp_years int,
    date_stop date, 
    time_stop time,
    stop_dur int,
    stop_response_to_cfs int,
    officer_assg_key int,
    assignment varchar(100),
    intersection varchar(100),
    address_block varchar(50),
    land_mark varchar(100),
    address_street varchar(100),
    highway_exit varchar(100),
    is_school varchar(50),
    school_name varchar(100),
    address_city varchar(100),
    beat varchar(5),
    beat_name varchar(100),
    pid int,
    is_student int,
    perceived_limited_english varchar(50), 
    perceived_age int,
    perceived_gender varchar(100),
    gend_non_conform varchar(10),
    gender varchar(10),
    gend_nc varchar(10),
    perceived_lgbt varchar(5)
);

load data
	infile "/Users/chris/portfolio/police_stop/data/ripa_stops_datasd.csv"
    into table ps_import.stop_details
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
;
    
-- Creating and loading result table
drop table if exists ps_import.result;
create table ps_import.result (
	stop_id int,
    pid int,
    result_key int,
    result varchar(100),
    code_num varchar(5),
    result_text varchar(250)
); 

load data
	infile '/Users/chris/portfolio/police_stop/data/ripa_stop_result_datasd.csv'
    into table ps_import.result
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
; 

-- Create and loading race table
drop table if exists ps_import.race;
create table ps_import.race (
	stop_id int,
    pid int,
    race varchar(50)
); 

load data
	infile '/Users/chris/portfolio/police_stop/data/ripa_race_datasd.csv'
    into table ps_import.race
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
;

-- Create and loading gender table
drop table if exists ps_import.gender;
create table ps_import.gender (
	stop_id int,
    pid int,
    gender varchar(25)
);

load data
	infile '/Users/chris/portfolio/police_stop/data/ripa_gender_datasd.csv'
    into table ps_import.gender
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
;

-- Create and loading actions taken table 
drop table if exists ps_import.actions;
create table ps_import.actions (
	stop_id int,
    pid int,
    action_taken varchar(100),
    consented varchar(10)
);

load data
	infile '/Users/chris/portfolio/police_stop/data/ripa_actions_taken_datasd.csv'
    into table ps_import.actions
    fields terminated by ',' enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
;