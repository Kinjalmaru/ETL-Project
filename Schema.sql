drop table if exists world_happiness_report_2021;
drop table if exists world_happiness_report;
drop table if exists final_table;
create table world_happiness_report_2021("Country name" varchar,
										"Regional indicator" varchar,
 										"Ladder score" float,
 										"Standard error of ladder sc varcharore" float,
 										upperwhisker float,
										lowerwhisker float,
										"Logged GDP per capita" float,
										"Social support" float,
										"Healthy life expectancy" float,
										"Freedom to make life choices" float,
										Generosity float,
										"Perceptions of corruption" float,
										"Ladder score in Dystopia" float,
										"Explained by: Log GDP per capita" float,
										"Explained by: Social support" float,
										"Explained by: Healthy life expectancy" float,
										"Explained by: Freedom to make life choices" float,
										"Explained by: Generosity" float,
										"Explained by: Perceptions of corruption" float,
										"Dystopia + residual" float);

select "Country Name" from world_happiness_report_2021;

create table world_happiness_report("Country name" varchar,
								   year int,
								   "Life Ladder" float,
								   "Log GDP per capita" float,
								   "Social support" float,
								   "Healthy life expectancy at birth" float,
								   "Freedom to make life choices" float,
								   Generosity float,
								   "Perceptions of corruption" float,
								   "Positive affect" float,
								   "Negative affect" float);
								   
select * from world_happiness_report;

create table final_table 	("Country_name" varchar,
							 "Regional_Indicator" varchar,
							 year int,
							 "Life_Ladder" float,
							 "Log GDP per capita" float,
						     "Social support" float,
							 "Healthy life expectancy at birth" float,
							 "Freedom to make life choices" float,
							 Generosity float,
							 "Perceptions of corruption" float);


insert into final_table (
with base as(
select 
a."Country name",
COALESCE(b."Regional indicator",'Unassigned'),
a.year,
a."Life Ladder",
a."Log GDP per capita",
a."Social support",
a."Healthy life expectancy at birth",
a."Freedom to make life choices",
a.Generosity,
a."Perceptions of corruption"
from world_happiness_report a
left join world_happiness_report_2021 b
on a."Country name" = b."Country name"
	
union 
select
"Country name",
"Regional indicator",
'2021' as year,
"Ladder score" as "Life Ladder",
"Logged GDP per capita" as "Log GDP per capita",
"Social support",
"Healthy life expectancy" as "Healthy life expectancy at birth",
"Freedom to make life choices",
Generosity,
"Perceptions of corruption"
from 
world_happiness_report_2021
)	
	
select * from base order by "Country name", year asc);

select * from final_table where "Country_name" = 'Bhutan';
