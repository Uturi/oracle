--모든 사원의 사번, 이름, 급여, 급여등급
select e.employee_id, e.first_name||' '||e.last_name name, e.salary, jg.grade_level
from job_grades jg, employees e
where e.salary >= jg.lowest_sal
and e.salary <= jg.highest_sal
order by jg.grade_level;

select e.employee_id, e.first_name||' '||e.last_name name, e.salary, jg.grade_level
from job_grades jg, employees e
where e.salary between jg.lowest_sal and jg.highest_sal
order by jg.grade_level;

--모든 사원의 사번, 이름, 부서번호, 부서이름
--단, 부서가 미지정일 경우 부서이름을 '대기발령중'으로 출력
--outter joiin 
select e.employee_id, e.first_name||' '||e.last_name name, e.department_id, nvl(d.department_name, '대기발령중')
from employees e, departments d
where e.department_id = d.department_id(+);

select *
from employees
where department_id is null;

--모든 사원의 사번, 이름, 상관사번, 상관이름
--단 상관이 없을 경우 상관이름에 '사장'으로 출력
select e.employee_id 사번, e.first_name||' '||e.last_name 이름, m.employee_id 상관사번, nvl(m.first_name, '사장') ||' '||m.last_name 상관이름
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

--모든사원의 사번, 이름, 상관사번, 상관이름, 부서이름
--단 상관이 없을 경우 상관이름에 '사장'으로 출력
--단, 부서가 미지정일 경우 부서이름을 '대기발령중'으로 출력

select e.employee_id 사번, e.first_name||' '||e.last_name 이름, m.employee_id 상관사번, nvl(m.first_name, '사장')||' '||m.last_name 상관이름, nvl(d.department_name, '대기발령') 부서이름
from employees e, departments d, employees m
where e.manager_id = m.employee_id(+)
and e.department_id = d.department_id(+)
order by e.employee_id;


--------              ANSI join       --------------------
select *
from employees, departments;
--cross join
select *
from employees cross join departments;

-- inner join      사번, 이름, 부서이름
--inner라는 단어는 생략가능 default값이기때문
--이때 join 조건은 on으로 해야함 무작껀
select e.employee_id, e.first_name, d.department_name
from employees e  inner join  departments d
on e.department_id = d.department_id
where e.department_id = 50;
--using을쓰면 칼럼에 테이블이름 안붙임 무적권
select e.employee_id, e.first_name, d.department_name
from employees e join  departments d
using (department_id)
where department_id = 50;
--위에 두개 같은결과뜸

--natural join (잘안씀), 동일한 모든칼럼을 전부 조인해버림(묶어버리기, and조건처럼 depart아이디랑 man아이디 둘다 같은거로 함
select e.employee_id, e.first_name, d.department_name
from employees e natural join departments d
where department_id = 50;
-----------------                       ---------------------------------
--'Seattle'에 근무하는 사번, 이름, 부서이름, 도시
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d,  locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle';

select e.employee_id, e.first_name, d.department_name, l.city
from employees e join departments d 
on e.department_id = d.department_id
join  locations l
on d.location_id = l.location_id
where l.city = 'Seattle';


--outter join
--모든 사원의 사번, 이름, 부서번호, 부서이름
select e.employee_id, e.first_name, e.department_id, nvl(d.department_name, '대기발령중')
from employees e, departments d
where e.department_id = d.department_id(+);

select e.employee_id, e.first_name, e.department_id, nvl(d.department_name, '대기발령중')
from employees e left outer join departments d
on e.department_id = d.department_id;

--모든부서에 근무하는 사원의 사번, 이름, 부서번호, 부서이름
select e.employee_id, nvl(e.first_name, '사원없음'), e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

select e.employee_id, nvl(e.first_name, '사원없음'), e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

--모든 부서에 모든 사원의 사번, 이름(사원없음), 부서번호, 부서이름(대기발령)
select e.employee_id, nvl(e.first_name, '사원없음'), e.department_id, nvl(d.department_name, '대기발령')
from employees e full outer join departments d
on e.department_id = d.department_id;


--inner join 사용할것, 매니저아이디가 100번인 사원의 사번, 이름, 부서이름
select e.employee_id, e.first_name, d.department_name
from employees e  inner join  departments d
on e.department_id = d.department_id
where e.manager_id = 100;

--inner join 사용할것, Washington 주에 위치한 부서의 부서번호와 부서이름 
select d.department_id, d.department_name
from locations l  join  departments d
on l.location_id = d.location_id
where l.state_province = 'Washington';



































