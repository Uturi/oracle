--매니저 아이디가 200미만 100이상인 미국에 위치한 부서명과 부서번호
select d.department_id, d.department_name
from departments d, locations l
where d.manager_id < 200 and d.manager_id >= 100 and l.country_id = 'US'
and d.location_id = l.location_id;

--우편번호가 9가 들어가는 지역에 위치한 부서에서 일하며 급여가 7천 이상인 사원의이름(부서별 이름순으로정렬)
select e.first_name||' '||e.last_name name
from locations l, departments d, employees e
where l.postal_code like '%9%' 
and l.location_id = d.location_id
and d.department_id = e.department_id
and e.salary > 7000
order by e.department_id, name;

--반올림, 원하는 자리수에서 반올림
select 1234.5438, round(1234.5438), round(1234.5438, 0), 
                          round(1234.5438, 1), round(1234.5438, -1), 
                          round(1234.5438, 3), round(1234.5438, -3)
from dual;

--내림, 원하는 자리수에서 자름
select 1234.5438, trunc(1234.5438), trunc(1234.5438, 0), 
                          trunc(1234.5438, 1), trunc(1234.5438, -1), 
                          trunc(1234.5438, 3), trunc(1234.5438, -3)
from dual;

--소수점 제거
select 1234.5438, floor(1234.5438)
from dual;

--mod(a, b) a에서 b를 나눈 나머지
select 5 + 3, 5 - 3, 5 * 3, 5 / 3, mod(5,3)
from dual;

--abs 절대값
select abs(5), abs(-5), abs(+5)
from dual;

--사원의 사번, 이름, 급여, 커미션포함급여
--커미션 포함 급여는 100의 자리수로 표현(반올림)
select employee_id, first_name, salary, round(salary+salary*nvl(commission_pct, 0),-2)
from employees;

--문자함수 lower 소문자  upper 대문자  initcap(initialize cap 첫글자만 대문자)  length 문자열길이(글자수)
select 'kiTRi', lower('kiTRi'), upper('kiTRi'), initcap('kiTRi') , length('kiTRi')
from dual;

-- full name   concat(a,b) 함수 a와b 합쳐서 출력
select employee_id, first_name || ' ' || last_name AS full_name,
          concat (first_name ,concat(' ', concat ('ff', last_name)))
from employees;

--프로그램에선 index가 0부터 시작이지만 db에서는 1부터임
--substr(문자열, 시작점, 개수) 시작점부터 몇개의 문자열 출력
--instr(문자열,찾을문자값,시작할위치, 찾은결과의순번) 
select 'hello oracle !!!', substr('hello oracle !!!', 2, 6), substr('hello oracle !!!', 4), instr('hello oracle !!!', 'o'), instr('hello oracle !!!', 'o', 6)
from dual;

-- '123-456' zipcode, 123 zip1, 456 zip2
select '123-456' zipcode, substr('123-456', 1 ,instr('123-456','-')-1) zip1, substr('123-456',instr('123-456','-')+1) zip2
from dual;


--날짜함수
select sysdate, sysdate + 3, sysdate - 3, to_char(sysdate + 3/ 24, 'yyyy-mm-dd hh24:mi:ss')
from dual;

--next_day는 가장가까운 요일 반환, add_months는 개월 더하기, months_between은 날짜수만큼의 개월차이 반환, last_day는 그 달의 마지막날
select sysdate, months_between(sysdate, sysdate + 70), next_day(sysdate, 1), next_day(sysdate, 3), add_months(sysdate, 2), last_day(sysdate)
from dual;

--d한개는 요일 d두개는 이달의 며칠째 d세개는 일년의 며칠째 w한개는 이달의 몇주째 w두개는 일년의 몇주째 
select sysdate, to_char(sysdate, 'yyyy yy mm mon month w ww d dd ddd dy day'),
                    to_char(sysdate, 'pm hh hh24 mi ss ')
from dual;

--시간 반올림
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss')"date",
            to_char(round(sysdate), 'yyyy.mm.dd hh24:mi:ss') round,
            to_char(round(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss') "round dd",
            to_char(round(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss')"round mm",
            to_char(round(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss')"round yy",
            to_char(round(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss')"round hh",
            to_char(round(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')"round mi"
from dual
union --위아래 결과 합쳐버리기, 대신 순서는 뒤죽박죽임 ㅅㄱ
--시간 버림
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
from dual;
--숫자형은 오른쪽정렬, 문자형은 왼쪽정렬
--문자열 더하는건 || 숫자는 +
--자동형변환, 따옴표 안에다 넣어도 숫자면 숫자형으로 됨
--변환함수
select 'a', 3, '3', 3+5, '3'+5
from dual;

select to_char('1123456.789', 'L000,000,000.00'), to_char('1123456.789', '$999,999,999.99')
from dual;

select '123,456.98', to_number('123,456.98', '999000.99') +3
from dual;

select sysdate, to_char(sysdate, 'yy.mm.dd'),
          to_char(sysdate, 'am hh:mi:ss'),
          to_char(sysdate, 'hh24:mi:ss')
from dual;
--20190225142154 >>날짜 >> 3일후
--먼저 숫자를 문자형태로 변환 to_char써서 숫자개수만큼 0이나 9써서 문자형태로 바꾸고 그 바꾼걸 to_date로 날짜로 변환햇다가 다시 to_char써서 문자로 
select to_char(to_date(to_char(20190225142154, '00000000000000'), 'yyyymmddhh24miss')+3, 'yyyy.mm.dd hh24:mi:ss')
from dual;

--일반함수
select commission_pct, nvl(commission_pct, 0), nvl2(commission_pct, 1, 0)
from employees;

--  연봉등급
--급여가 4000미만인 사원은 박봉                    case 함수 
--급여가 10000미만인 사원은 평균연봉
--급여가 10000이상인 사원은 고연봉
--사번, 이름, 급여, 연봉등급
select employee_id, first_name||' '||last_name name, salary,
        case 
            when salary < 4000
            then '박봉'
            when salary < 10000
            then '평균연봉'
            else '고연봉'
        end 연봉등급
from employees
order by salary desc;

--사원구분
--1980년도 입사 임원, 90년도 입사는 평사원 00년도 입사는 신입사원
--사번, 이름, 입사일 , 사원구분
select employee_id, first_name || ' ' || last_name AS full_name, hire_date, 
    case
        when hire_date like '8%'
        then '임원'
        when hire_date like '9%'
        then '평사원'
        else '신입사원'
    end 사원구분
from employees
order by hire_date asc;

select employee_id, first_name || ' ' || last_name AS full_name, hire_date, 
    case
        when to_char(hire_date, 'yy') between 80 and 89 
        then '임원'
        when to_char(hire_date, 'yy') between 90 and 99
        then '평사원'
        else '신입사원'
    end 사원구분
from employees
order by hire_date asc;




--아스키코드 값 숫자0은 48, 대문자 A는  65, 소문자 a는 97
select ascii('0'), ascii('A'), ascii('a'), chr(48), chr(65), chr(97)
from dual;

--아스키 코드값이 있기때문에 문자도 크고작음 구분가능함
select case when 's' < 'b' then '작다'
                else '크다'
         end
from dual;



--직책이름, 최대급여, 직무별 소득분류를 출력하시오.-
--이때 최대급여가 10000이하인 직무는 저소득, 10000은 초과하지만20000이하인 직무는 중간소득, 20000을 초과하는 직무는 고소득으로
--직책분류를 만들고, 직책이름을 기준으로 정렬하시오. 이때, 직책이름은 모두 대문자로 표기하시오.
select upper(job_title), max_salary, 
    case
        when max_salary <= 10000
        then '저소득'
        when max_salary <=20000
        then '중간소득'
        else '고소득'
    end "직무별 소득분류"
from jobs
order by job_title;


--오늘날짜를 yymmdd형식으로 문자로 바꾼후 숫자로 다시바꿔 123456을 더한값을 출력하라.
select to_number(to_char(sysdate, 'yymmdd'), '000000')+123456 날짜더하기123456
from dual;


-- 김의연
-- 부서명(department_name)의 마지막 글자를 제외하고 출력하라.
-- 부서명, 마지막글자를 제외한 부서명 출력 및 정렬
select department_name, substr(department_name, 1, length(department_name)-1)
from departments
order by department_id;


-- emp테이블에서 sal이 3000미만 이면 c등급, 3000에서 3900이하 B등급
-- 4000 이상이면 A등급으로 등급을 나타내어라
-- 사번, 이름(풀네임), 급여, 등급별로 정렬
select employee_id, first_name||' '||last_name, salary,
case
    when salary < 3000
    then 'c등급'
    when salary < 3900
    then 'b등급'
    else 'a등급'
end 등급
from employees
order by 등급;


--박광규
--사원들의 '이름 성'(concat함수 사용), 연봉, 연봉*커미션 값
--(단, 커미션이 있을 경우 일괄적으로 5%적용, 없을 경우 0으로 일괄 적용할 것)
select concat(first_name, concat(' ', last_name)) name, salary, salary*nvl2(commission_pct, 5, 0)
from employees;
--Q2. 사원들의 전화번호에 '.'과 '.'사이에 있는 4자리 수를 출력하라
select substr(phone_number ,instr(phone_number, '.', 1,2)+1 ,4)
from employees;
--노정탁
--사번,이름, job_id, 근무상황(별칭)
--미국에서 일하는 부서일 경우 "본사근무"
--캐나다에서 일하는 부서일 경우 "파견근무"
--영국에서 일하는 부서일 경우 "해외출장"
--본사, 파견, 해외 순으로 정렬
select e.employee_id, e.first_name, e.job_id,
case 
    when country_id = 'US'
    then '본사근무'
    when country_id = 'CA'
    then '파견근무'
    else '해외출장'
end 근무상황
from employees e, departments d, locations l
where l.location_id = d.location_id
and d.department_id = nvl(e.department_id, 80)
order by 근무상황;

--아래와 같이 출력되게 코드를 작성하시오.
--'풀네임'의 부서번호와 부서코드는 '90''AD'이다. 
--부서를 명시할때는 job_id의 앞 두글자(ex)sST,IT,AD)로 명시. 별칭 부서번호와 코드
select department_id || ' ' ||substr(job_id, 1, 2) "부서번호와 코드"
from employees
order by department_id asc;

-- 신지영
--  Q1. 각 사원의 이름, 부서번호, 급여, 급여별 레벨을 출력하기
-- 단, 레벨의 종류와 기준은 Job_Grades 테이블을 참고한다.
-- 단, 레벨을 기준으로 오름차순 정렬한다.
-- 단, 레벨에 별칭을 준다(급여별 레벨).
select first_name||' '||last_name "Name", department_id, salary, 
case
    when salary between 1000 and 2999
    then 'A'
    when salary between 3000 and 5999
    then 'B'
    when salary between 6000 and 9999
    then 'C'
    when salary between 10000 and 14999
    then 'D'
    when salary between 15000 and 24999
    then 'E'
    else 'F'
end "급여별 레벨"
from employees
order by "급여별 레벨";

--  Q2. 강의 A가 2019년02월20일부터 2019년07월16일까지 실행될 때, 총 기간이 며칠인지 구하시오
-- 단, 날짜는 20190220, 20190716 형태의 숫자로부터 시작한다.
-- 단, 주말도 포함한다
-- 단, 별칭은 수강기간
select  to_date(to_char(20190220, '00000000'), 'yyyymmdd') as "시작날" , 
            to_date(to_char(20190716, '00000000'), 'yyyymmdd') as "끝나는날",
            (to_date(to_char(20190716, '00000000'), 'yyyymmdd') - to_date(to_char(20190220, '00000000'), 'yyyymmdd')) as "수강기간"
from dual;

--김형섭
--시스템시간기준 144일후를 yyyy mm dd day 형태로 나타내주세요. 별칭은 "수료일"
select to_char(sysdate+144, 'yyyy mm dd day')
from dual;

--2019/07/21 은 2019년도로부터 몇 번째 날일까?
select to_char(to_date(to_char(20190721, '00000000'), 'yyyy/mm/dd'), 'ddd') as "올해의 몇번째날일까요?"
from dual;








