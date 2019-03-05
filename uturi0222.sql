--where 조건절
--급여를 5000이상 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where salary >= 5000;

--사번이 100인 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where employee_id = 100;


--근무도시가 Seattle인 지역의 지역번호, 우편번호
select location_id, postal_code
from locations
where city = 'Seattle';

--급여를 5천이상 1만2천 미만을 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where 5000 <= salary and salary < 12000;


--부서번호가 50인 사원 중 급여를 1만이상 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where department_id = 50 and salary >= 5000;

--급여를 5천이상 1만2천 미만을 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where salary >= 5000
and salary <= 12000;

--급여를 5천이상 1만2천 미만을 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where salary between 5000 and 12000;

--커미션을 받는 사원의 사번, 이름, 급여, 커미션포함급여
select employee_id, first_name, salary, (salary+salary*commission_pct)
from employees
where commission_pct is not null;

--근무부서가 50, 60, 80인 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where department_id = 50 
or department_id = 60 
or department_id = 80;

--근무부서가 50, 60, 80이 아닌 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where department_id != 50
and department_id != 60 
and department_id != 80
or department_id is null;

--근무부서가 50, 60, 80인 사원의 사번, 이름, 부서번호 in사용
select employee_id, first_name, department_id
from employees
where department_id in(50, 60,  80);

--근무부서가 50, 60, 80이 아닌 사원의 사번, 이름, 부서번호 in사용
select employee_id, first_name, department_id
from employees
where department_id not in(50, 60,  80);

--급여가 3천이상이거나 8천이상이거나 5천이상인 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary >= 3000
or salary >= 8000
or salary >= 5000;

--급여가 3천이상이거나 8천이상이거나 5천이상인 사원의 사번, 이름, 급여 any사용
select employee_id, first_name, salary
from employees
where salary >= any(3000, 8000, 5000);

--급여가 3천이상이고 8천이상이고 5천이상인 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where salary >= 3000
and salary >= 8000
and salary >= 5000;

--급여가 3천이상이고 8천이상이고 5천이상인 사원의 사번, 이름, 급여 all사용
select employee_id, first_name, salary
from employees
where salary >= all( 3000,  8000, 5000);

--현재 시간, 3일후, 3시간후
select SYSDATE, to_char(sysdate, 'yy.mm.dd hh24:mi:ss') as "현재 시간", 
           to_char(sysdate+3, 'yy.mm.dd hh24:mi:ss') as "3일후", 
           to_char(sysdate-3, 'yy.mm.dd hh24:mi:ss') as "3일전", 
           to_char(sysdate+3/24, 'yy.mm.dd hh24:mi:ss') as "3시간후"
from dual;

--이름이 Steven인 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name = 'Steven';

--이름이 S로 시작하는 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like 'S%';

----이름이  y로 끝나는 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like '%y';

--이름 중간에 e가 들어가는 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like '%e%';

--이름에서 끝에서 두번째가 'e'인 사원의 사번, 이름
select employee_id, first_name
from employees
where first_name like '%e_';

--부서번호가 50이 아닌 사원의 사번, 이름, 부서번호 not 연산 세가지 !=, <>, ^=
select employee_id, first_name, department_id
from employees
where department_id != 50;

select employee_id, first_name, department_id
from employees
where department_id <> 50;

select employee_id, first_name, department_id
from employees
where department_id ^= 50;

--모든 사원 사번,이름,급여 
--단, 급여순 정렬
select employee_id, first_name, salary
from employees
order by salary desc;

--부서번호, 사번, 이름, 급여
--부서별  급여순으로 정렬
select department_id, employee_id, first_name, salary
from employees
order by department_id, salary desc;

--alias로도 정렬가능 order by가 select보다 나중에 실행되서 그럼 ㅅㄱ
select department_id did, employee_id, first_name, salary sal
from employees
order by did, sal desc;

--근무도시가 'Seattle'인 사원의 사번, 이름, 부서번호
select employee_id, first_name, department_id
from employees
where department_id in (10, 90, 110, 190);

--도출과정
select location_id
from locations
where city = 'Seattle';

select department_id
from departments
where location_id = 1700;

--sub query 사용시
select employee_id, first_name, department_id
from employees
where department_id in (select department_id
            from departments
            where location_id = ( select location_id
                        from locations
                        where city = 'Seattle'))
                        order by employee_id;


--join 사용시
select e.employee_id, e.first_name, e.department_id
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle';




--현재 시간, 3일 후, 3시간 후, 3분 후, 3초 후를 출력하세요 *각각에 별칭 지정(현재 시간, 3일 후 ~)
-- 단, 출력 형식은 '년도-월-일 시:분:초'

select SYSDATE, to_char(sysdate, 'yy-mm-dd hh24:mi:ss') as "현재 시간",
                     to_char(sysdate+3, 'yy-mm-dd hh24:mi:ss') as "3일 후",
                     to_char(sysdate+3/24, 'yy-mm-dd hh24:mi:ss') as "3시간 후",
                     to_char(sysdate+3/24/60, 'yy-mm-dd hh24:mi:ss') as "3분 후",
                     to_char(sysdate+3/24/60/60, 'yy-mm-dd hh24:mi:ss') as "3초 후"
from dual;



--1. 마케팅 부서가 위치한 지역의 우편번호를 찾으시오.
select postal_code
from locations
where location_id =( select location_id
                    from departments
                    where department_name = 'Marketing');


--2. it부서가 위치한 지역의 주소를 찾으시오.
select street_address
from locations
where  location_id =( select location_id
                    from departments
                    where department_name = 'IT');

--3. Steven King 직원의 직급이 벌수 있는 최고연봉을 찾으시오.
select max_salary
from jobs
where job_id = ( select job_id
                        from employees
                        where first_name = 'Steven');









