--사번, 이름, 부서번호, 직원유형
-- 직원유형
--부서번호 60개발자 90 임원진 나머지 비개발자
select employee_id, first_name || ' ' || last_name AS full_name, department_id, 
case
    when department_id = 60
    then '개발자'
    when department_id = 90
    then '임원진'
    else '비개발자'
end 직원유형
from employees
order by department_id;

--decode 함수 case문과 비슷하지만 다름, 스위치문같은거, =비교만 가능
select employee_id, first_name, department_id,
        decode(department_id,
                        60, '개발자',
                        90, '임원진',
                        '비개발자') 직원유형
from employees
order by department_id;

--그룹함수
--회사의 총사원수, 급여총합, 급여평균, 최고급여, 최저급여
--count함수 칼럼의 개수 카운팅, sum함수 칼럼에 있는데이터 총합, avg함수 칼럼에 있는 데이터의평균
--max함수 칼럼안의 가장 큰 데이터 표시, min함수 칼럼안의 가장 작은 데이터 표시
--전부 단일행으로 결과가 나옴
select count(employee_id) 총사원수, sum(salary) 급여총합, avg(salary) 급여평균, max(salary) 최고급여, min(salary) 최저급여
from employees;

--평균급여보다 많이 받는사원의 사번, 이름, 급여
select employee_id, first_name || ' ' || last_name AS full_name, salary
from employees
where salary > (select avg(salary) from employees);


--사번, 이름, 부서번호, 부서이름
select e.employee_id, e.first_name || ' ' || e.last_name AS full_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

select *
from employees, departments; 


--시애틀에 근무하는 사원의 사번 이름 부서이름 도시이름
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and lower(l.city) = lower('seattle');

 
--asia에서 근무하는 사원싀 사번, 이름, 부서이름, 도시이름
select e.employee_id, e.first_name, d.department_name, l.city
from regions r, employees e, departments d, locations l, countries c
where nvl(e.department_id, 80) = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and lower(r.region_name) = lower('americas');

--10 80 90번 부서에 근무중인 사원의
--사번, 이름 직책이름,부서이름

select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.department_id in (10, 80, 90);

--사번이 200인 사원의 근무 이력 join 조건을 연결고리 끼리 무조건 하는게 아니고 문제해결에 필요한 조건을 걸어야한다.
--근무 이력, 즉 옛날의 정보를 원하는 것이기때문에, job history로 조인조건을 걸어야 데이터가 적합하게 나온다.
--사번, 이름, 직책이름, 부서이름, 근무개월(소수점2자리)
select e.employee_id , e.first_name, j.job_title, d.department_name, to_char(months_between(jh.end_date , jh.start_date), '00.00') 근무개월
from employees e, departments d, jobs j, job_history jh
where d.department_id = jh.department_id
and jh.job_id = j.job_id
and e.employee_id = jh.employee_id
and jh.employee_id = 200;

--모든 사원의 부서이름, 사번, 이름, 매니저사번, 매니저이름
--self join 같은 테이블을 다른테이블과 조인하는것처럼 하는것
select d.department_name 부서이름, e.employee_id 사번, e.first_name||' '||e.last_name 이름, ee.employee_id 매니저사번 , ee.first_name||' '||ee.last_name 매니저이름
from employees e, departments d, employees ee
where d.department_id = e.department_id
and e.manager_id = ee.employee_id
order by e.manager_id;

--내문제
--셀프조인 사용해서 모든사원의 사번, 이름, 급여, 직속상관이름, 직속상관(매니저)의급여 출력
select e.employee_id 사번, e.first_name||' '||e.last_name 이름, e.salary 급여, ee.first_name||' '||ee.last_name "매니저 이름", ee.salary "매니저 급여"
from employees e, employees ee
where e.manager_id = ee.employee_id;
--99년도에 프로젝트 진행을 시작한적이 있는 부서들이 현재 위치한 주소와 우편번호
select l.street_address, l.postal_code
from departments d, job_history jh, locations l
where d.department_id = jh.department_id
and d.location_id = l.location_id
and jh.start_date like '99%';


























--직책아이디가 'SA_REP'인 사원의
--사번, 이름 직책이름, 부서이름
--단 부서가 없는 경우 ' 대기발령'으로 출력
select e.employee_id, e.first_name, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and lower(e.job_id) = lower('sa_rep')
and d.department_name e.department_id is null;






















