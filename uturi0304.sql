--�μ���ȣ�� 50�̰ų� 90�� �����
--�޿��� 5000�̻��� �����
--���,�̸�,�޿�,�μ���ȣ
--union��� �����������ϰ� ����� ���, or�����ѰŶ� ���
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--union all ��� �����������ϰ� ����� ���, �ߺ������͵�����
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
union all
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--intersect ��� �����ո� ���, and�����ѰŶ� ���
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
intersect
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--minus��� �����ո� ���, �����ִ°ſ��� �ؿ��� ������ A-B �������� �κи� ��
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90)
minus
select employee_id, first_name, salary, department_id
from employees
where salary >=10000;

--minus ���� �ٲ۰�
select employee_id, first_name, salary, department_id
from employees
where salary >=10000
minus
select employee_id, first_name, salary, department_id
from employees
where department_id in (50, 90);

--group by
--grouping�� �� column�� ���� �����͵鳢�� �׷���¥����.
--select������ group by���� �ִ� column�� �����ִ�.
--�μ��� �޿�����, ��ձ޿�, �����, �ִ�޿�, �ּұ޿�
select department_id, sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id
order by department_id;

--�μŹ� �޿�����, ��ձ޿�, �����, �ִ�޿�, �ּұ޿�
-- ��ձ޿��� 5000������ �μ�
--having ��� �Ϲ������� where �׷������� having
select department_id, sum(salary), avg(salary), count(employee_id), max(salary), min(salary)
from employees
group by department_id
having avg(salary) <= 5000;

--�� �μ��� ��ձ޿����� ���� �޴� �����
--���, �̸�, �޿�
select employee_id, first_name, salary
from employees 
where salary > all (select avg(salary)
from employees
group by department_id );

--�μ��� �ְ�޿��� �޴� �����
--�μ��̸�, ���, �̸�, �޿�
select d.department_name, e.employee_id, e.first_name, e.salary
from employees e, ( select department_id, max(salary) msal
                            from employees
                            group by department_id ) m, departments d
where e.department_id = m.department_id
and e.salary = m.msal
and e.department_id = d.department_id;

--���ȣ �����, rownum�� ������������ �����ü��ִ�.
select rownum, employee_id, salary
from employees
where rownum <= 10
and rownum > 5;


--&data
--��ü���� �Է��ϱ�

--TOP N Query
--����, ���, �̸�, �޿�, �Ի���, �μ��̸�
--�޿��� ����
--�� �������� 5�� ���
--2page ���
--1980���, 1990���, 2000���
--2������
select tt.rnum, tt.���, tt.�̸�, tt.�޿�, tt.�Ի���, tt.�μ��̸�
from (select rownum as rnum, ���, �̸�, �޿�, �Ի���, �μ��̸�
        from (select e.employee_id ���, e.first_name || ' ' || e.last_name AS �̸�, e.salary �޿�,
                    case
                        when e.hire_date like '8%'
                        then '1980���'
                        when e.hire_date like '9%'
                        then '1990���'
                        else '2000���'
                    end �Ի���,
                    d.department_name �μ��̸�
                    from employees e, departments d
                    where e.department_id = d.department_id(+)
                    order by salary desc) ) tt
where rnum >= 5 and rnum <= 10;


--��ü�����̿� --��������
select tt.rnum, tt.���, tt.�̸�, tt.�޿�, tt.�Ի���, tt.�μ��̸�
from (select rownum as rnum, ���, �̸�, �޿�, �Ի���, �μ��̸�
        from (select e.employee_id ���, e.first_name || ' ' || e.last_name AS �̸�, e.salary �޿�,
                    case
                        when e.hire_date like '8%'
                        then '1980���'
                        when e.hire_date like '9%'
                        then '1990���'
                        else '2000���'
                    end �Ի���,
                    d.department_name �μ��̸�
                    from employees e, departments d
                    where e.department_id = d.department_id(+)
                    order by salary desc) ) tt
where rnum <= &page * 5
and tt.rnum > &page * 5 - 5;

--�����Դ� �˻��ӵ������� �� ���̶� ������ �ٸ�����, �̰� �� ����
select b.rn ranking, b.employee_id, b.first_name, b.salary,
        case
            when to_char(hire_date, 'yyyy') < '1990'
            then '1980���'
            when to_char(hire_date, 'yyyy') < '2000'
            then '1990���'
            else '2000���'
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










































