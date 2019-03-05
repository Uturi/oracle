SELECT
    *
FROM
    employees;
    
    
select employee_id, first_name, salary
from employees;

select country_id
from countries;

select department_id, department_name
from departments;

select first_name, last_name
from employees
where job_id like 'IT%';

select distinct department_id
from employees;

select 1+1, 10-5, 2*10, 10/3
from dual;

select employee_id, first_name, last_name, salary, salary+200
from employees
order by salary desc;

select employee_id, first_name, last_name, salary, commission_pct, salary+salary*nvl(commission_pct,0)
from employees
order by salary desc;

select employee_id as sabun, first_name as name, last_name as sung, salary wolgeup, nvl(commission_pct,0)  incen, salary+salary*nvl(commission_pct,0)  "incen poham"
from employees
order by salary desc;

select employee_id, first_name||' '||last_name "Name"
from employees;

select 'number is '||employee_id||' name is '||first_name||' '||last_name info
from employees;


select first_name||' '||last_name || ' ei mail juso nun ' || email||' e go'|| ' handphone bun ho nun ' ||phone_number||' e da'  yunrackcheo
from employees;

select country_id ||' '||state_province||' ju '||city||' si '||street_address||' ei u pyeon bun ho nun '||postal_code||' e da' as "u pyeon bun ho"
from locations;


select state_province||' '||city||' e whichi han jisa ui code nun'||postal_code||' e da' postcode
from locations;

select first_name||' '||last_name||' ui geup yeo 10% insang doe '||salary*1.1||'e da' "geup yeo in sang"
from employees;

select first_name||' '||last_name||'sa one nim ui geup yeo nun'||salary||'ipnida' geupyeonaeyeok
from employees;

select 'sabun is'||employee_id||' in saram jic check is'||job_id||'ibsa is'||start_date||'toesa is'||end_date||'eda' iptoeinfo
from job_history;

select first_name||' '||last_name||' saone - email : ' ||email||' / phonenum : '||phone_number
from employees;

select street_address||','||city||','||state_province||','||country_id as juso
from locations;

select nvl(commission_pct,0)
from employees;

select '19.02.21, ' || employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,nvl(department_id,80)
from employees;


