select e.employee_id, e.first_name, ee.employee_id, ee.first_name
from employees e right outer join employees ee
on e.manager_id = ee.employee_id
order by ee.employee_id;

--부서이름이 'IT'에 근무하는 사원의 사번, 이름, 급여
select e.employee_id, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
and d.department_name = 'IT';

select employee_id, first_name, salary
from employees
where department_id--칼럼이름
                = (select department_id --대응 시킬 값
                      from departments
                    where department_name = 'IT');
                    
--'Seattle'에 근무하는 사원의 사번, 이름, 급여
select employee_id, first_name, salary
from employees
where department_id in (select d.department_id
                                    from departments d, locations l
                                    where d.location_id = l.location_id
                                    and l.city = 'Seattle');

select employee_id, first_name, salary
from employees
where department_id in (select department_id
                                    from departments
                                    where location_id = (select location_id
                                                                    from locations
                                                                    where city = 'Seattle'));
 
--지역번호가 1700인 부서에서 일하는 사원의
--사번,이름,부서번호,부서이름
select e.employee_id, e.first_name, e.department_id, d.department_name 
from employees e, departments d
where e.department_id = d.department_id 
and location_id = 1700;

--from에서 서브쿼리로 테이블처럼 만들어쓰는것, 뷰라고 한다. 테이블단위에 나오는 서브쿼리,  인라인 뷰 (가상의테이블)
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e, (select department_id, department_name
                            from departments
                        where location_id = 1700) d
where e.department_id = d.department_id;

--'kevin'보다 급여를 많이 받는 사원의 사번,이름,급여
select employee_id, first_name, salary
from employees
where salary > (select salary
                        from employees
                        where first_name = 'Kevin');

--50번 부서에 있는 사원들보다 급여를 많이 받는 사원의 사번,이름,급여
--이게 좀더 적합. all써서 안의 모든 데이터들보다 높은걸 거르기때문
select employee_id, first_name, salary
from employees
where salary > all (select salary
                        from employees 
                        where department_id = 50);
--데이터값아니깐 그룹함수씀                        
select employee_id, first_name, salary
from employees
where salary > (select max(salary)
                        from employees 
                        where department_id = 50);
                        
--부서에 근무하는(부서가 있는) 모든사원들의 평균 급여보다 많이 받는 사원의
--사번,이름,급여
select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
                        from employees
                        where department_id is not null);

--급여가 부서번호가 20번인 사원들의 평균 급여보다 크며, 
--부서번호가 20이 아닌  매니저인 사원들의
--사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where department_id !=20
and employee_id in (select manager_id
                            from employees
                            where salary > (select avg(salary)
                                                from employees
                                                where department_id = 20));
 --셀프조인 ㄴ넣어서 디스팅트 씀                                               
select distinct e.employee_id, e.first_name, e.salary, e.department_id
from employees e, employees m
where e.department_id !=20
and e.employee_id in m.manager_id
and m.salary > (select avg(salary)
                       from employees
                     where department_id = 20);
--급여가 부서번호가 20번인 사원들의 평균 급여보다 크며, 
--부서번호가 20이 아닌  직급이 부서장 사원들의
--사번, 이름, 급여, 부서번호
select distinct e20.employee_id, e20.first_name, e20.salary, d.department_id
from (select employee_id, first_name, salary
        from employees
        where salary > (select avg(salary)
                                from employees
                                where department_id = 20)) e20, departments d
where e20.employee_id = d.manager_id
and d.department_id !=20;
                     
--20번 부서의 평균급여
--50번 부서의 급여총합
--80번 부서의 인원수
select 
    (select avg(salary) from employees where department_id = 20) avg20,
    (select sum(salary) from employees where department_id = 50) sum50,
    (select count(salary) from employees where department_id = 80) count80
from dual;

--모든 사원의 사번, 이름, 급여, 등급, 부서이름  조인으로그냥한거
--단 A는 1등급, B는 2등급... F는 6등급
select distinct e.employee_id, e.first_name, e.salary, 
case
    when jg.grade_level = 'A'
    then '1등급'
    when jg.grade_level = 'B'
    then '2등급'
    when jg.grade_level = 'C'
    then '3등급'
    when jg.grade_level = 'D'
    then '4등급'
    when jg.grade_level = 'E'
    then '5등급'
    else '6등급'
    end 등급,
    nvl(d.department_name, '대기발령중')
from job_grades jg, employees e, departments d
where e.department_id = d.department_id(+)
and (e.salary between jg.lowest_sal and jg.highest_sal)
order by e.employee_id;
--모든 사원의 사번, 이름, 급여, 등급, 부서이름  서브쿼리로 푸삼
--단 A는 1등급, B는 2등급... F는 6등급 case문 사용했음
select e.employee_id, e.first_name, e.salary, 
case
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'A'
    then '1등급'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'B'
    then '2등급'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'C'
    then '3등급'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'D'
    then '4등급'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'E'
    then '5등급'
    else '6등급'    end 등급,
d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;

--모든 사원의 사번, 이름, 급여, 등급, 부서이름  서브쿼리로 푸삼
--단 A는 1등급, B는 2등급... F는 6등급 decode사용
select e.employee_id, e.first_name, e.salary, 
decode ((select grade_level from job_grades where e.salary between lowest_sal and highest_sal),
      'A', '1등급',
      'B', '2등급',
      'C', '3등급',
      'D', '4등급',
      'E', '5등급',
      '6등급') 등급,    
d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;













                     
                     















































