select e.employee_id, e.first_name, ee.employee_id, ee.first_name
from employees e right outer join employees ee
on e.manager_id = ee.employee_id
order by ee.employee_id;

--�μ��̸��� 'IT'�� �ٹ��ϴ� ����� ���, �̸�, �޿�
select e.employee_id, e.first_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
and d.department_name = 'IT';

select employee_id, first_name, salary
from employees
where department_id--Į���̸�
                = (select department_id --���� ��ų ��
                      from departments
                    where department_name = 'IT');
                    
--'Seattle'�� �ٹ��ϴ� ����� ���, �̸�, �޿�
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
 
--������ȣ�� 1700�� �μ����� ���ϴ� �����
--���,�̸�,�μ���ȣ,�μ��̸�
select e.employee_id, e.first_name, e.department_id, d.department_name 
from employees e, departments d
where e.department_id = d.department_id 
and location_id = 1700;

--from���� ���������� ���̺�ó�� �����°�, ���� �Ѵ�. ���̺������ ������ ��������,  �ζ��� �� (���������̺�)
select e.employee_id, e.first_name, e.department_id, d.department_name
from employees e, (select department_id, department_name
                            from departments
                        where location_id = 1700) d
where e.department_id = d.department_id;

--'kevin'���� �޿��� ���� �޴� ����� ���,�̸�,�޿�
select employee_id, first_name, salary
from employees
where salary > (select salary
                        from employees
                        where first_name = 'Kevin');

--50�� �μ��� �ִ� ����麸�� �޿��� ���� �޴� ����� ���,�̸�,�޿�
--�̰� ���� ����. all�Ἥ ���� ��� �����͵麸�� ������ �Ÿ��⶧��
select employee_id, first_name, salary
from employees
where salary > all (select salary
                        from employees 
                        where department_id = 50);
--�����Ͱ��ƴϱ� �׷��Լ���                        
select employee_id, first_name, salary
from employees
where salary > (select max(salary)
                        from employees 
                        where department_id = 50);
                        
--�μ��� �ٹ��ϴ�(�μ��� �ִ�) ��������� ��� �޿����� ���� �޴� �����
--���,�̸�,�޿�
select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
                        from employees
                        where department_id is not null);

--�޿��� �μ���ȣ�� 20���� ������� ��� �޿����� ũ��, 
--�μ���ȣ�� 20�� �ƴ�  �Ŵ����� �������
--���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where department_id !=20
and employee_id in (select manager_id
                            from employees
                            where salary > (select avg(salary)
                                                from employees
                                                where department_id = 20));
 --�������� ���־ ����Ʈ ��                                               
select distinct e.employee_id, e.first_name, e.salary, e.department_id
from employees e, employees m
where e.department_id !=20
and e.employee_id in m.manager_id
and m.salary > (select avg(salary)
                       from employees
                     where department_id = 20);
--�޿��� �μ���ȣ�� 20���� ������� ��� �޿����� ũ��, 
--�μ���ȣ�� 20�� �ƴ�  ������ �μ��� �������
--���, �̸�, �޿�, �μ���ȣ
select distinct e20.employee_id, e20.first_name, e20.salary, d.department_id
from (select employee_id, first_name, salary
        from employees
        where salary > (select avg(salary)
                                from employees
                                where department_id = 20)) e20, departments d
where e20.employee_id = d.manager_id
and d.department_id !=20;
                     
--20�� �μ��� ��ձ޿�
--50�� �μ��� �޿�����
--80�� �μ��� �ο���
select 
    (select avg(salary) from employees where department_id = 20) avg20,
    (select sum(salary) from employees where department_id = 50) sum50,
    (select count(salary) from employees where department_id = 80) count80
from dual;

--��� ����� ���, �̸�, �޿�, ���, �μ��̸�  �������α׳��Ѱ�
--�� A�� 1���, B�� 2���... F�� 6���
select distinct e.employee_id, e.first_name, e.salary, 
case
    when jg.grade_level = 'A'
    then '1���'
    when jg.grade_level = 'B'
    then '2���'
    when jg.grade_level = 'C'
    then '3���'
    when jg.grade_level = 'D'
    then '4���'
    when jg.grade_level = 'E'
    then '5���'
    else '6���'
    end ���,
    nvl(d.department_name, '���߷���')
from job_grades jg, employees e, departments d
where e.department_id = d.department_id(+)
and (e.salary between jg.lowest_sal and jg.highest_sal)
order by e.employee_id;
--��� ����� ���, �̸�, �޿�, ���, �μ��̸�  ���������� Ǫ��
--�� A�� 1���, B�� 2���... F�� 6��� case�� �������
select e.employee_id, e.first_name, e.salary, 
case
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'A'
    then '1���'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'B'
    then '2���'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'C'
    then '3���'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'D'
    then '4���'
    when (select grade_level from job_grades where e.salary between lowest_sal and highest_sal)= 'E'
    then '5���'
    else '6���'    end ���,
d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;

--��� ����� ���, �̸�, �޿�, ���, �μ��̸�  ���������� Ǫ��
--�� A�� 1���, B�� 2���... F�� 6��� decode���
select e.employee_id, e.first_name, e.salary, 
decode ((select grade_level from job_grades where e.salary between lowest_sal and highest_sal),
      'A', '1���',
      'B', '2���',
      'C', '3���',
      'D', '4���',
      'E', '5���',
      '6���') ���,    
d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;













                     
                     















































