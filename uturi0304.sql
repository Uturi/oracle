--부서번호가 50이거나 90인 사원과
--급여가 5000이상인 사원의
--사번,이름,급여,부서번호
--union사용 교집합제외하고 모든결과 출력, or연산한거랑 비슷
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--union all 사용 교집합포함하고 모든결과 출력, 중복데이터도나옴
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union all
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--intersect 사용 교집합만 출력, and연산한거랑 비슷
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
intersect
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--minus사용 차집합만 출력, 위에있는거에서 밑에걸 차집합 A-B 공통적인 부분만 뺌
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
minus
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--minus 순서 바꾼거
select employee_id, first_name, salary, department_id
from employees
where salary >=10000
minus
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90);

--group by
--grouping을 한 column의 같은 데이터들끼리 그룹이짜진다.
--select절에는 group by절에 있는 column만 쓸수있다.
--부서별 급여총합, 평균급여, 사원수, 최대급여, 최소급여
select department_id, sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id
order by department_id;

--부셔벌 급여총합, 평균급여, 사원수, 최대급여, 최소급여
-- 평균급여가 5000이하인 부서
--having 사용 일반조건은 where 그룹조건은 having
select department_id, sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id
having avg(salary) <= 5000;

--각 부서별 평균급여보다 많이 받는 사원의
--사번, 이름, 급여
select employee_id, first_name, salary
from employees 
where salary > all (select avg(salary)
from employees
group by department_id );

--부서별 최고급여를 받는 사원의
--부서이름, 사번, 이름, 급여
select d.department_name, e.employee_id, e.first_name, e.salary
from employees e, ( select department_id, max(salary) msal
                            from employees
                            group by department_id ) m, departments d
where e.department_id = m.department_id
and e.salary = m.msal
and e.department_id = d.department_id;

--행번호 만들기, rownum은 보다작은값만 가져올수있다.
select rownum, employee_id, salary
from employees
where rownum <= 10
and rownum > 5;


--&data
--대체변수 입력하기

--TOP N Query
--순위, 사번, 이름, 급여, 입사년대, 부서이름
--급여순 순위
--한 페이지당 5명씩 출력
--2page 출력
--1980년대, 1990년대, 2000년대
--2페이지
select tt.rnum, tt.사번, tt.이름, tt.급여, tt.입사년대, tt.부서이름
from (select rownum as rnum, 사번, 이름, 급여, 입사년대, 부서이름
        from (select e.employee_id 사번, e.first_name || ' ' || e.last_name AS 이름, e.salary 급여,
                    case
                        when e.hire_date like '8%'
                        then '1980년대'
                        when e.hire_date like '9%'
                        then '1990년대'
                        else '2000년대'
                    end 입사년대,
                    d.department_name 부서이름
                    from employees e, departments d
                    where e.department_id = d.department_id(+)
                    order by salary desc) ) tt
where rnum >= 5 and rnum <= 10;


--대체변수이용 --내가쓴답
select tt.rnum, tt.사번, tt.이름, tt.급여, tt.입사년대, tt.부서이름
from (select rownum as rnum, 사번, 이름, 급여, 입사년대, 부서이름
        from (select e.employee_id 사번, e.first_name || ' ' || e.last_name AS 이름, e.salary 급여,
                    case
                        when e.hire_date like '8%'
                        then '1980년대'
                        when e.hire_date like '9%'
                        then '1990년대'
                        else '2000년대'
                    end 입사년대,
                    d.department_name 부서이름
                    from employees e, departments d
                    where e.department_id = d.department_id(+)
                    order by salary desc) ) tt
where rnum <= &page * 5
and tt.rnum > &page * 5 - 5;

--선생님답 검색속도때문에 내 답이랑 순서를 다르게함, 이게 더 적절
select b.rn ranking, b.employee_id, b.first_name, b.salary,
        case
            when to_char(hire_date, 'yyyy') < '1990'
            then '1980년대'
            when to_char(hire_date, 'yyyy') < '2000'
            then '1990년대'
            else '2000년대'
        end hire, d.department_name
from (
    select rownum rn, a.*
    from (
            select employee_id, first_name, salary, hire_date, department_id
            from employees
            order by salary desc
            ) a
    where rownum <= &page * 5
    ) b, departments d
where b.department_id = d.department_id(+)
and b.rn > &page * 5 -5
order by ranking;










































