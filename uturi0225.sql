--�Ŵ��� ���̵� 200�̸� 100�̻��� �̱��� ��ġ�� �μ���� �μ���ȣ
select d.department_id, d.department_name
from departments d, locations l
where d.manager_id < 200 and d.manager_id >= 100 and l.country_id = 'US'
and d.location_id = l.location_id;

--�����ȣ�� 9�� ���� ������ ��ġ�� �μ����� ���ϸ� �޿��� 7õ �̻��� ������̸�(�μ��� �̸�����������)
select e.first_name||' '||e.last_name name
from locations l, departments d, employees e
where l.postal_code like '%9%' 
and l.location_id = d.location_id
and d.department_id = e.department_id
and e.salary > 7000
order by e.department_id, name;

--�ݿø�, ���ϴ� �ڸ������� �ݿø�
select 1234.5438, round(1234.5438), round(1234.5438, 0), 
                          round(1234.5438, 1), round(1234.5438, -1), 
                          round(1234.5438, 3), round(1234.5438, -3)
from dual;

--����, ���ϴ� �ڸ������� �ڸ�
select 1234.5438, trunc(1234.5438), trunc(1234.5438, 0), 
                          trunc(1234.5438, 1), trunc(1234.5438, -1), 
                          trunc(1234.5438, 3), trunc(1234.5438, -3)
from dual;

--�Ҽ��� ����
select 1234.5438, floor(1234.5438)
from dual;

--mod(a, b) a���� b�� ���� ������
select 5 + 3, 5 - 3, 5 * 3, 5 / 3, mod(5,3)
from dual;

--abs ���밪
select abs(5), abs(-5), abs(+5)
from dual;

--����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
--Ŀ�̼� ���� �޿��� 100�� �ڸ����� ǥ��(�ݿø�)
select employee_id, first_name, salary, round(salary+salary*nvl(commission_pct, 0),-2)
from employees;

--�����Լ� lower �ҹ���  upper �빮��  initcap(initialize cap ù���ڸ� �빮��)  length ���ڿ�����(���ڼ�)
select 'kiTRi', lower('kiTRi'), upper('kiTRi'), initcap('kiTRi') , length('kiTRi')
from dual;

-- full name   concat(a,b) �Լ� a��b ���ļ� ���
select employee_id, first_name || ' ' || last_name AS full_name,
          concat (first_name ,concat(' ', concat ('ff', last_name)))
from employees;

--���α׷����� index�� 0���� ���������� db������ 1������
--substr(���ڿ�, ������, ����) ���������� ��� ���ڿ� ���
--instr(���ڿ�,ã�����ڰ�,��������ġ, ã������Ǽ���) 
select 'hello oracle !!!', substr('hello oracle !!!', 2, 6), substr('hello oracle !!!', 4), instr('hello oracle !!!', 'o'), instr('hello oracle !!!', 'o', 6)
from dual;

-- '123-456' zipcode, 123 zip1, 456 zip2
select '123-456' zipcode, substr('123-456', 1 ,instr('123-456','-')-1) zip1, substr('123-456',instr('123-456','-')+1) zip2
from dual;


--��¥�Լ�
select sysdate, sysdate + 3, sysdate - 3, to_char(sysdate + 3/ 24, 'yyyy-mm-dd hh24:mi:ss')
from dual;

--next_day�� ���尡��� ���� ��ȯ, add_months�� ���� ���ϱ�, months_between�� ��¥����ŭ�� �������� ��ȯ, last_day�� �� ���� ��������
select sysdate, months_between(sysdate, sysdate + 70), next_day(sysdate, 1), next_day(sysdate, 3), add_months(sysdate, 2), last_day(sysdate)
from dual;

--d�Ѱ��� ���� d�ΰ��� �̴��� ��ĥ° d������ �ϳ��� ��ĥ° w�Ѱ��� �̴��� ����° w�ΰ��� �ϳ��� ����° 
select sysdate, to_char(sysdate, 'yyyy yy mm mon month w ww d dd ddd dy day'),
                    to_char(sysdate, 'pm hh hh24 mi ss ')
from dual;

--�ð� �ݿø�
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss')"date",
            to_char(round(sysdate), 'yyyy.mm.dd hh24:mi:ss') round,
            to_char(round(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss') "round dd",
            to_char(round(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss')"round mm",
            to_char(round(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss')"round yy",
            to_char(round(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss')"round hh",
            to_char(round(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')"round mi"
from dual
union --���Ʒ� ��� ���Ĺ�����, ��� ������ ���׹����� ����
--�ð� ����
select to_char(sysdate, 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'dd'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'mm'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'yy'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'hh'), 'yyyy.mm.dd hh24:mi:ss'),
            to_char(trunc(sysdate, 'mi'), 'yyyy.mm.dd hh24:mi:ss')
from dual;
--�������� ����������, �������� ��������
--���ڿ� ���ϴ°� || ���ڴ� +
--�ڵ�����ȯ, ����ǥ �ȿ��� �־ ���ڸ� ���������� ��
--��ȯ�Լ�
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
--20190225142154 >>��¥ >> 3����
--���� ���ڸ� �������·� ��ȯ to_char�Ἥ ���ڰ�����ŭ 0�̳� 9�Ἥ �������·� �ٲٰ� �� �ٲ۰� to_date�� ��¥�� ��ȯ�޴ٰ� �ٽ� to_char�Ἥ ���ڷ� 
select to_char(to_date(to_char(20190225142154, '00000000000000'), 'yyyymmddhh24miss')+3, 'yyyy.mm.dd hh24:mi:ss')
from dual;

--�Ϲ��Լ�
select commission_pct, nvl(commission_pct, 0), nvl2(commission_pct, 1, 0)
from employees;

--  �������
--�޿��� 4000�̸��� ����� �ں�                    case �Լ� 
--�޿��� 10000�̸��� ����� ��տ���
--�޿��� 10000�̻��� ����� ����
--���, �̸�, �޿�, �������
select employee_id, first_name||' '||last_name name, salary,
        case 
            when salary < 4000
            then '�ں�'
            when salary < 10000
            then '��տ���'
            else '����'
        end �������
from employees
order by salary desc;

--�������
--1980�⵵ �Ի� �ӿ�, 90�⵵ �Ի�� ���� 00�⵵ �Ի�� ���Ի��
--���, �̸�, �Ի��� , �������
select employee_id, first_name || ' ' || last_name AS full_name, hire_date, 
    case
        when hire_date like '8%'
        then '�ӿ�'
        when hire_date like '9%'
        then '����'
        else '���Ի��'
    end �������
from employees
order by hire_date asc;

select employee_id, first_name || ' ' || last_name AS full_name, hire_date, 
    case
        when to_char(hire_date, 'yy') between 80 and 89 
        then '�ӿ�'
        when to_char(hire_date, 'yy') between 90 and 99
        then '����'
        else '���Ի��'
    end �������
from employees
order by hire_date asc;




--�ƽ�Ű�ڵ� �� ����0�� 48, �빮�� A��  65, �ҹ��� a�� 97
select ascii('0'), ascii('A'), ascii('a'), chr(48), chr(65), chr(97)
from dual;

--�ƽ�Ű �ڵ尪�� �ֱ⶧���� ���ڵ� ũ������ ���а�����
select case when 's' < 'b' then '�۴�'
                else 'ũ��'
         end
from dual;



--��å�̸�, �ִ�޿�, ������ �ҵ�з��� ����Ͻÿ�.-
--�̶� �ִ�޿��� 10000������ ������ ���ҵ�, 10000�� �ʰ�������20000������ ������ �߰��ҵ�, 20000�� �ʰ��ϴ� ������ ��ҵ�����
--��å�з��� �����, ��å�̸��� �������� �����Ͻÿ�. �̶�, ��å�̸��� ��� �빮�ڷ� ǥ���Ͻÿ�.
select upper(job_title), max_salary, 
    case
        when max_salary <= 10000
        then '���ҵ�'
        when max_salary <=20000
        then '�߰��ҵ�'
        else '��ҵ�'
    end "������ �ҵ�з�"
from jobs
order by job_title;


--���ó�¥�� yymmdd�������� ���ڷ� �ٲ��� ���ڷ� �ٽùٲ� 123456�� ���Ѱ��� ����϶�.
select to_number(to_char(sysdate, 'yymmdd'), '000000')+123456 ��¥���ϱ�123456
from dual;


-- ���ǿ�
-- �μ���(department_name)�� ������ ���ڸ� �����ϰ� ����϶�.
-- �μ���, ���������ڸ� ������ �μ��� ��� �� ����
select department_name, substr(department_name, 1, length(department_name)-1)
from departments
order by department_id;


-- emp���̺��� sal�� 3000�̸� �̸� c���, 3000���� 3900���� B���
-- 4000 �̻��̸� A������� ����� ��Ÿ�����
-- ���, �̸�(Ǯ����), �޿�, ��޺��� ����
select employee_id, first_name||' '||last_name, salary,
case
    when salary < 3000
    then 'c���'
    when salary < 3900
    then 'b���'
    else 'a���'
end ���
from employees
order by ���;


--�ڱ���
--������� '�̸� ��'(concat�Լ� ���), ����, ����*Ŀ�̼� ��
--(��, Ŀ�̼��� ���� ��� �ϰ������� 5%����, ���� ��� 0���� �ϰ� ������ ��)
select concat(first_name, concat(' ', last_name)) name, salary, salary*nvl2(commission_pct, 5, 0)
from employees;
--Q2. ������� ��ȭ��ȣ�� '.'�� '.'���̿� �ִ� 4�ڸ� ���� ����϶�
select substr(phone_number ,instr(phone_number, '.', 1,2)+1 ,4)
from employees;
--����Ź
--���,�̸�, job_id, �ٹ���Ȳ(��Ī)
--�̱����� ���ϴ� �μ��� ��� "����ٹ�"
--ĳ���ٿ��� ���ϴ� �μ��� ��� "�İ߱ٹ�"
--�������� ���ϴ� �μ��� ��� "�ؿ�����"
--����, �İ�, �ؿ� ������ ����
select e.employee_id, e.first_name, e.job_id,
case 
    when country_id = 'US'
    then '����ٹ�'
    when country_id = 'CA'
    then '�İ߱ٹ�'
    else '�ؿ�����'
end �ٹ���Ȳ
from employees e, departments d, locations l
where l.location_id = d.location_id
and d.department_id = nvl(e.department_id, 80)
order by �ٹ���Ȳ;

--�Ʒ��� ���� ��µǰ� �ڵ带 �ۼ��Ͻÿ�.
--'Ǯ����'�� �μ���ȣ�� �μ��ڵ�� '90''AD'�̴�. 
--�μ��� ����Ҷ��� job_id�� �� �α���(ex)sST,IT,AD)�� ���. ��Ī �μ���ȣ�� �ڵ�
select department_id || ' ' ||substr(job_id, 1, 2) "�μ���ȣ�� �ڵ�"
from employees
order by department_id asc;

-- ������
--  Q1. �� ����� �̸�, �μ���ȣ, �޿�, �޿��� ������ ����ϱ�
-- ��, ������ ������ ������ Job_Grades ���̺��� �����Ѵ�.
-- ��, ������ �������� �������� �����Ѵ�.
-- ��, ������ ��Ī�� �ش�(�޿��� ����).
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
end "�޿��� ����"
from employees
order by "�޿��� ����";

--  Q2. ���� A�� 2019��02��20�Ϻ��� 2019��07��16�ϱ��� ����� ��, �� �Ⱓ�� ��ĥ���� ���Ͻÿ�
-- ��, ��¥�� 20190220, 20190716 ������ ���ڷκ��� �����Ѵ�.
-- ��, �ָ��� �����Ѵ�
-- ��, ��Ī�� �����Ⱓ
select  to_date(to_char(20190220, '00000000'), 'yyyymmdd') as "���۳�" , 
            to_date(to_char(20190716, '00000000'), 'yyyymmdd') as "�����³�",
            (to_date(to_char(20190716, '00000000'), 'yyyymmdd') - to_date(to_char(20190220, '00000000'), 'yyyymmdd')) as "�����Ⱓ"
from dual;

--������
--�ý��۽ð����� 144���ĸ� yyyy mm dd day ���·� ��Ÿ���ּ���. ��Ī�� "������"
select to_char(sysdate+144, 'yyyy mm dd day')
from dual;

--2019/07/21 �� 2019�⵵�κ��� �� ��° ���ϱ�?
select to_char(to_date(to_char(20190721, '00000000'), 'yyyy/mm/dd'), 'ddd') as "������ ���°���ϱ��?"
from dual;








