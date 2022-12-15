-- How many rows are there in each dataset?

Select count(*) from project.dataset_1;
Select count(*) from project.dataset_2;

-- Show data for selected states (Jharkhand & Bihar)

Select * FROM project.dataset_1 
WHERE state in ('Jharkhand', 'Bihar');

-- Total population of India

Select sum(population) Total_population FROM project.dataset_2;

-- Average Growth% for India

Select avg(growth)*100 Average_growth From project.dataset_1;

-- Average Growth% by State

Select state, avg(growth)*100 Average_growth_state From project.dataset_1
group by state;

-- Average sex_ratio by State

Select state, round(avg(Sex_Ratio),0) Average_sex_ratio From project.dataset_1
group by state
Order by Average_sex_ratio DESC;

-- Average literacy rate by State

Select state, avg(literacy) Average_literacy_rate From project.dataset_1
group by state
Order by Average_literacy_rate DESC;

-- States with Average literacy rate over 85

Select state, round(avg(literacy),0) Average_literacy_rate From project.dataset_1
group by state
having round(avg(literacy),0) > 85
Order by Average_literacy_rate DESC;

-- Top 3 states with highest  growth ratio

Select state, round(avg(growth)*100) Average_growth_state From project.dataset_1
group by state
order by Average_growth_state DESC
LIMIT 3;

-- Bottom 3 states with lowest sex_ratio

Select state, round(avg(Sex_Ratio),0) Average_sex_ratio From project.dataset_1
group by state
Order by Average_sex_ratio asc
limit 3;

-- Top 3 and Bottom 3 States in Average literacy rate

-- Creating top 3

drop table if exists topstates;
create table topstates (state text, topstate float);

insert into topstates
(Select state, avg(literacy) Average_literacy_rate From project.dataset_1
group by state);

select * from topstates order by topstates.topstate DESC
LIMIT 3;


-- Creating bottom 3

drop table if exists bottomstates;
create table bottomstates (state text, bottomstate float);

insert into bottomstates
(Select state, avg(literacy) Average_literacy_rate From project.dataset_1
group by state);

select * from bottomstates order by bottomstates.bottomstate ASC
LIMIT 3;

-- Making Union 

select * from (
select * from topstates order by topstates.topstate DESC
LIMIT 3) a

union

select * from (
select * from bottomstates order by bottomstates.bottomstate ASC
LIMIT 3) b;

-- Show states starting with the letter A

select distinct state from project.dataset_1 where lower(state) like 'a%';

-- Show states starting with the letter A or B

select distinct state from project.dataset_1 where lower(state) like 'a%'
OR lower(state) like 'b%';


-- Show states starting with the letter A and ending with letter M

select distinct state from project.dataset_1 where lower(state) like 'a%'
and lower(state) like '%m';