--��� ����� ���, �̸�, �޿�, �޿����
select e.employee_id, e.first_name||' '||e.last_name name, e.salary, jg.grade_level
from job_grades jg, employees e
where e.salary >= jg.lowest_sal
and e.salary <= jg.highest_sal
order by jg.grade_level;

select e.employee_id, e.first_name||' '||e.last_name name, e.salary, jg.grade_level
from job_grades jg, employees e
where e.salary between jg.lowest_sal and jg.highest_sal
order by jg.grade_level;

--��� ����� ���, �̸�, �μ���ȣ, �μ��̸�
--��, �μ��� �������� ��� �μ��̸��� '���߷���'���� ���
--outter joiin 
select e.employee_id, e.first_name||' '||e.last_name name, e.department_id, nvl(d.department_name, '���߷���')
from employees e, departments d
where e.department_id = d.department_id(+);

select *
from employees
where department_id is null;

--��� ����� ���, �̸�, ������, ����̸�
--�� ����� ���� ��� ����̸��� '����'���� ���
select e.employee_id ���, e.first_name||' '||e.last_name �̸�, m.employee_id ������, nvl(m.first_name, '����') ||' '||m.last_name ����̸�
from employees e, employees m
where e.manager_id = m.employee_id(+)
order by e.employee_id;

--������� ���, �̸�, ������, ����̸�, �μ��̸�
--�� ����� ���� ��� ����̸��� '����'���� ���
--��, �μ��� �������� ��� �μ��̸��� '���߷���'���� ���

select e.employee_id ���, e.first_name||' '||e.last_name �̸�, m.employee_id ������, nvl(m.first_name, '����')||' '||m.last_name ����̸�, nvl(d.department_name, '���߷�') �μ��̸�
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

-- inner join      ���, �̸�, �μ��̸�
--inner��� �ܾ�� �������� default���̱⶧��
--�̶� join ������ on���� �ؾ��� ���۲�
select e.employee_id, e.first_name, d.department_name
from employees e  inner join  departments d
on e.department_id = d.department_id
where e.department_id = 50;
--using������ Į���� ���̺��̸� �Ⱥ��� ������
select e.employee_id, e.first_name, d.department_name
from employees e join  departments d
using (department_id)
where department_id = 50;
--���� �ΰ� ���������

--natural join (�߾Ⱦ�), ������ ���Į���� ���� �����ع���(���������, and����ó�� depart���̵�� man���̵� �Ѵ� �����ŷ� ��
select e.employee_id, e.first_name, d.department_name
from employees e natural join departments d
where department_id = 50;
-----------------                       ---------------------------------
--'Seattle'�� �ٹ��ϴ� ���, �̸�, �μ��̸�, ����
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
--��� ����� ���, �̸�, �μ���ȣ, �μ��̸�
select e.employee_id, e.first_name, e.department_id, nvl(d.department_name, '���߷���')
from employees e, departments d
where e.department_id = d.department_id(+);

select e.employee_id, e.first_name, e.department_id, nvl(d.department_name, '���߷���')
from employees e left outer join departments d
on e.department_id = d.department_id;

--���μ��� �ٹ��ϴ� ����� ���, �̸�, �μ���ȣ, �μ��̸�
select e.employee_id, nvl(e.first_name, '�������'), e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

select e.employee_id, nvl(e.first_name, '�������'), e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

--��� �μ��� ��� ����� ���, �̸�(�������), �μ���ȣ, �μ��̸�(���߷�)
select e.employee_id, nvl(e.first_name, '�������'), e.department_id, nvl(d.department_name, '���߷�')
from employees e full outer join departments d
on e.department_id = d.department_id;


--inner join ����Ұ�, �Ŵ������̵� 100���� ����� ���, �̸�, �μ��̸�
select e.employee_id, e.first_name, d.department_name
from employees e  inner join  departments d
on e.department_id = d.department_id
where e.manager_id = 100;

--inner join ����Ұ�, Washington �ֿ� ��ġ�� �μ��� �μ���ȣ�� �μ��̸� 
select d.department_id, d.department_name
from locations l  join  departments d
on l.location_id = d.location_id
where l.state_province = 'Washington';



































