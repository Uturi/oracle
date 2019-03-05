--where ������
--�޿��� 5000�̻� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where salary >= 5000;

--����� 100�� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where employee_id = 100;


--�ٹ����ð� Seattle�� ������ ������ȣ, �����ȣ
select location_id, postal_code
from locations
where city = 'Seattle';

--�޿��� 5õ�̻� 1��2õ �̸��� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where 5000 <= salary and salary < 12000;


--�μ���ȣ�� 50�� ��� �� �޿��� 1���̻� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where department_id = 50 and salary >= 5000;

--�޿��� 5õ�̻� 1��2õ �̸��� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where salary >= 5000
and salary <= 12000;

--�޿��� 5õ�̻� 1��2õ �̸��� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where salary between 5000 and 12000;

--Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
select employee_id, first_name, salary, (salary+salary*commission_pct)
from employees
where commission_pct is not null;

--�ٹ��μ��� 50, 60, 80�� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id = 50 
or department_id = 60 
or department_id = 80;

--�ٹ��μ��� 50, 60, 80�� �ƴ� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id != 50
and department_id != 60 
and department_id != 80
or department_id is null;

--�ٹ��μ��� 50, 60, 80�� ����� ���, �̸�, �μ���ȣ in���
select employee_id, first_name, department_id
from employees
where department_id in(50, 60,  80);

--�ٹ��μ��� 50, 60, 80�� �ƴ� ����� ���, �̸�, �μ���ȣ in���
select employee_id, first_name, department_id
from employees
where department_id not in(50, 60,  80);

--�޿��� 3õ�̻��̰ų� 8õ�̻��̰ų� 5õ�̻��� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary >= 3000
or salary >= 8000
or salary >= 5000;

--�޿��� 3õ�̻��̰ų� 8õ�̻��̰ų� 5õ�̻��� ����� ���, �̸�, �޿� any���
select employee_id, first_name, salary
from employees
where salary >= any(3000, 8000, 5000);

--�޿��� 3õ�̻��̰� 8õ�̻��̰� 5õ�̻��� ����� ���, �̸�, �޿�
select employee_id, first_name, salary
from employees
where salary >= 3000
and salary >= 8000
and salary >= 5000;

--�޿��� 3õ�̻��̰� 8õ�̻��̰� 5õ�̻��� ����� ���, �̸�, �޿� all���
select employee_id, first_name, salary
from employees
where salary >= all( 3000,  8000, 5000);

--���� �ð�, 3����, 3�ð���
select SYSDATE, to_char(sysdate, 'yy.mm.dd hh24:mi:ss') as "���� �ð�", 
           to_char(sysdate+3, 'yy.mm.dd hh24:mi:ss') as "3����", 
           to_char(sysdate-3, 'yy.mm.dd hh24:mi:ss') as "3����", 
           to_char(sysdate+3/24, 'yy.mm.dd hh24:mi:ss') as "3�ð���"
from dual;

--�̸��� Steven�� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name = 'Steven';

--�̸��� S�� �����ϴ� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like 'S%';

----�̸���  y�� ������ ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like '%y';

--�̸� �߰��� e�� ���� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like '%e%';

--�̸����� ������ �ι�°�� 'e'�� ����� ���, �̸�
select employee_id, first_name
from employees
where first_name like '%e_';

--�μ���ȣ�� 50�� �ƴ� ����� ���, �̸�, �μ���ȣ not ���� ������ !=, <>, ^=
select employee_id, first_name, department_id
from employees
where department_id != 50;

select employee_id, first_name, department_id
from employees
where department_id <> 50;

select employee_id, first_name, department_id
from employees
where department_id ^= 50;

--��� ��� ���,�̸�,�޿� 
--��, �޿��� ����
select employee_id, first_name, salary
from employees
order by salary desc;

--�μ���ȣ, ���, �̸�, �޿�
--�μ���  �޿������� ����
select department_id, employee_id, first_name, salary
from employees
order by department_id, salary desc;

--alias�ε� ���İ��� order by�� select���� ���߿� ����Ǽ� �׷� ����
select department_id did, employee_id, first_name, salary sal
from employees
order by did, sal desc;

--�ٹ����ð� 'Seattle'�� ����� ���, �̸�, �μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id in (10, 90, 110, 190);

--�������
select location_id
from locations
where city = 'Seattle';

select department_id
from departments
where location_id = 1700;

--sub query ����
select employee_id, first_name, department_id
from employees
where department_id in (select department_id
            from departments
            where location_id = ( select location_id
                        from locations
                        where city = 'Seattle'))
                        order by employee_id;


--join ����
select e.employee_id, e.first_name, e.department_id
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle';




--���� �ð�, 3�� ��, 3�ð� ��, 3�� ��, 3�� �ĸ� ����ϼ��� *������ ��Ī ����(���� �ð�, 3�� �� ~)
-- ��, ��� ������ '�⵵-��-�� ��:��:��'

select SYSDATE, to_char(sysdate, 'yy-mm-dd hh24:mi:ss') as "���� �ð�",
                     to_char(sysdate+3, 'yy-mm-dd hh24:mi:ss') as "3�� ��",
                     to_char(sysdate+3/24, 'yy-mm-dd hh24:mi:ss') as "3�ð� ��",
                     to_char(sysdate+3/24/60, 'yy-mm-dd hh24:mi:ss') as "3�� ��",
                     to_char(sysdate+3/24/60/60, 'yy-mm-dd hh24:mi:ss') as "3�� ��"
from dual;



--1. ������ �μ��� ��ġ�� ������ �����ȣ�� ã���ÿ�.
select postal_code
from locations
where location_id =( select location_id
                    from departments
                    where department_name = 'Marketing');


--2. it�μ��� ��ġ�� ������ �ּҸ� ã���ÿ�.
select street_address
from locations
where  location_id =( select location_id
                    from departments
                    where department_name = 'IT');

--3. Steven King ������ ������ ���� �ִ� �ְ����� ã���ÿ�.
select max_salary
from jobs
where job_id = ( select job_id
                        from employees
                        where first_name = 'Steven');









