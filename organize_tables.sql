-- Relevant columns: stop_id, exp_years, date_stop, time_stop, stop_dur, officer_assg_key, beat, beat_name, pid, perceived_age, perceived_lgbt
drop table if exists ps_import.relevant_details;
create table ps_import.relevant_details
as (
	select stop_id, pid, exp_years, date_stop,
		time_stop, stop_dur, officer_assg_key, 
		assignment, beat, beat_name, perceived_age
	from ps_import.stop_details
);

drop table if exists ps_import.full_info;
create table ps_import.full_info 
as (
	select details.*, 
		race.race,
		gender.gender
	from ps_import.relevant_details as details
	left join ps_import.race as race 
	on details.stop_id=race.stop_id
		and details.pid=race.pid
	left join ps_import.gender as gender
	on details.stop_id=gender.stop_id
		and details.pid=gender.pid
);


-- Separating tables into personal info and stop info
create schema police_stop; 

-- Personal cols: stop_id, pid, perceived_ag, race, gender
drop table if exists police_stop.personal;
create table police_stop.personal 
as (
	select stop_id, pid, perceived_age, race, gender
	from ps_import.full_info
);
-- Stop cols: stop_id, pid, date_stop, time_stop, stop_dur
drop table if exists police_stop.stop_info;
create table police_stop.stop_info
as (
	select stop_id, pid, date_stop, time_stop, stop_dur
	from ps_import.full_info
);

-- Officer cols: stop_id, pid, exp_years, officer_assg_key, assignment, beat, beat_name
drop table if exists police_stop.officer_info;
create table police_stop.officer_info 
as (
	select stop_id, pid, exp_years, officer_assg_key, assignment, beat, beat_name
	from ps_import.full_info
);
