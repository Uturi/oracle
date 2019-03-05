--���, �̸�, �μ���ȣ, ��������
-- ��������
--�μ���ȣ 60������ 90 �ӿ��� ������ �񰳹���
select employee_id, first_name || ' ' || last_name AS full_name, department_id, 
case
    when department_id = 60
    then '������'
    when department_id = 90
    then '�ӿ���'
    else '�񰳹���'
end ��������
from employees
order by department_id;

--decode �Լ� case���� ��������� �ٸ�, ����ġ��������, =�񱳸� ����
select employee_id, first_name, department_id,
        decode(department_id,
                        60, '������',
                        90, '�ӿ���',
                        '�񰳹���') ��������
from employees
order by department_id;

--�׷��Լ�
--ȸ���� �ѻ����, �޿�����, �޿����, �ְ�޿�, �����޿�
--count�Լ� Į���� ���� ī����, sum�Լ� Į���� �ִµ����� ����, avg�Լ� Į���� �ִ� �����������
--max�Լ� Į������ ���� ū ������ ǥ��, min�Լ� Į������ ���� ���� ������ ǥ��
--���� ���������� ����� ����
select count(employee_id) �ѻ����, sum(salary) �޿�����, avg(salary) �޿����, max(salary) �ְ�޿�, min(salary) �����޿�
from employees;

--��ձ޿����� ���� �޴»���� ���, �̸�, �޿�
select employee_id, first_name || ' ' || last_name AS full_name, salary
from employees
where salary > (select avg(salary) from employees);


--���, �̸�, �μ���ȣ, �μ��̸�
select e.employee_id, e.first_name || ' ' || e.last_name AS full_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

select *
from employees, departments; 


--�þ�Ʋ�� �ٹ��ϴ� ����� ��� �̸� �μ��̸� �����̸�
select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and lower(l.city) = lower('seattle');

 
--asia���� �ٹ��ϴ� ����� ���, �̸�, �μ��̸�, �����̸�
select e.employee_id, e.first_name, d.department_name, l.city
from regions r, employees e, departments d, locations l, countries c
where nvl(e.department_id, 80) = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and lower(r.region_name) = lower('americas');

--10 80 90�� �μ��� �ٹ����� �����
--���, �̸� ��å�̸�,�μ��̸�

select e.employee_id, e.first_name, j.job_title, d.department_name
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.department_id in (10, 80, 90);

--����� 200�� ����� �ٹ� �̷� join ������ ����� ���� ������ �ϴ°� �ƴϰ� �����ذῡ �ʿ��� ������ �ɾ���Ѵ�.
--�ٹ� �̷�, �� ������ ������ ���ϴ� ���̱⶧����, job history�� ���������� �ɾ�� �����Ͱ� �����ϰ� ���´�.
--���, �̸�, ��å�̸�, �μ��̸�, �ٹ�����(�Ҽ���2�ڸ�)
select e.employee_id , e.first_name, j.job_title, d.department_name, to_char(months_between(jh.end_date , jh.start_date), '00.00') �ٹ�����
from employees e, departments d, jobs j, job_history jh
where d.department_id = jh.department_id
and jh.job_id = j.job_id
and e.employee_id = jh.employee_id
and jh.employee_id = 200;

--��� ����� �μ��̸�, ���, �̸�, �Ŵ������, �Ŵ����̸�
--self join ���� ���̺��� �ٸ����̺�� �����ϴ°�ó�� �ϴ°�
select d.department_name �μ��̸�, e.employee_id ���, e.first_name||' '||e.last_name �̸�, ee.employee_id �Ŵ������ , ee.first_name||' '||ee.last_name �Ŵ����̸�
from employees e, departments d, employees ee
where d.department_id = e.department_id
and e.manager_id = ee.employee_id
order by e.manager_id;

--������
--�������� ����ؼ� ������� ���, �̸�, �޿�, ���ӻ���̸�, ���ӻ��(�Ŵ���)�Ǳ޿� ���
select e.employee_id ���, e.first_name||' '||e.last_name �̸�, e.salary �޿�, ee.first_name||' '||ee.last_name "�Ŵ��� �̸�", ee.salary "�Ŵ��� �޿�"
from employees e, employees ee
where e.manager_id = ee.employee_id;
--99�⵵�� ������Ʈ ������ ���������� �ִ� �μ����� ���� ��ġ�� �ּҿ� �����ȣ
select l.street_address, l.postal_code
from departments d, job_history jh, locations l
where d.department_id = jh.department_id
and d.location_id = l.location_id
and jh.start_date like '99%';


























--��å���̵� 'SA_REP'�� �����
--���, �̸� ��å�̸�, �μ��̸�
--�� �μ��� ���� ��� ' ���߷�'���� ���
select e.employee_id, e.first_name, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and lower(e.job_id) = lower('sa_rep')
and d.department_name e.department_id is null;






















