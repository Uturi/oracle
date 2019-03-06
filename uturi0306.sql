--������̺� �ҷ�����
select * from tab;
--���������
purge recyclebin;


select * from emp_blank;

--����ִ� ���̺� �ٸ����̺��� �����͸� ���ǿ� �´� �Ϻθ� �ְ� ������.
--sub query�� �̿��� insert, ���� ������ ���̺��� �ҷ����°Ŷ� * ��� ����
insert into emp_blank
select *
from employees
where department_id = 80;

--100�� ����� ���, �̸�, ��å, �μ���ȣ
--emp_blank ����
insert into emp_blank (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
select employee_id, first_name, last_name, email, hire_date, job_id, department_id
from employees
where employee_id = 100;


----------------------------------------------
insert into member
values ('uturi', '������', '1234', 25, 'uturi', 'naver.com', sysdate);
insert into member (id, name, age, pass, emailid, emaildomain, joindate)
values ('hong', 'ȫ�浿', '25', 123, 'java2', 'naver.com', sysdate);

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('uturi', '12345', '����� ���Ǳ� ���ű�86', '�Ÿ�2��������Ʈ', '010', '9914', '0953');

insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '����Ŭ', '30', 'a12345678', 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '12345', '����� ���Ǳ� ����Ŭ��63', '����Ŭ������', '010', '1234', '5678')
select *  from dual;
-----------------------------------------------

commit;

--update
--�̷����ϸ� ��� pass�� 9876���� �ٲ�
update member
set pass = 9876;

--�߸������� �ǵ����� ���� �ѹ�
rollback;

--where�� ��� ���ϴ� ������ �Ἥ ���ϴ� ���븸 �ٲ۴�.
--id�� hong�λ���� ��й�ȣ�� 9876���� �ٲ۴�.
update member
set pass = 9876
where id = 'hong';

--'hong'�� ����� 1234�� ���� 33���� ����
update member
set pass = 1234, age = 33
where id = 'hong';
--update���� �������� ��밡�� �ٸ����̺��� ���ǵ� ����
--'hong'�� ����� 5678�� ���̴� ���̵� oracle�� ����� ���� ����
update member
set pass = 5678, age = (select age from member where id = 'oracle')
where id = 'hong';

update member
set id ='java2', name = '������'
where id = '������';

commit;

--delete
--�����Ҷ� ������ �ִ�. �θ���� ����� ����. �����ϰ��ִ� �ڽĺ��� ��������.
--���̺� ��ü ����������. �����ʿ�
--delete ���̺��̸� �Ҷ� from�ᵵ�ǰ� �Ƚᵵ�ǰ�
--all�� insert�� ���� delete�� update�� all����
delete member_detail;
delete member;
--rollback�� Ŀ���� �������� ��.
rollback;

--��������������, ������Ʈ�� ���
--���̵� oracle�λ�� �����ϱ�
--�ڽ����̺� ����
delete member_detail
where id = 'oracle';
--�θ����̺��� ����
delete member
where id = 'oracle';

select *
from member;
select *
from member_detail;

--merge
---------------------------------------------------����
create table product
(
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key (pid)
);

insert into product (pid, pname, cnt, price)
values (100, '�����', 100, 1500);
insert into product (pid, pname, cnt, price)
values (200, '����Ĩ', 80, 2700);
insert into product (pid, pname, cnt, price)
values (300, '������', 120, 1000);

update product
set price = 1000
where pid = 300;
-----------------------------------------------���ó�
--merge ���� �� ����

--merge into ���̺��̸�
--using (���̺��̸�, ��������, ��)�˸��ƽ�
--on ���� ����
--when matched then
--update set (on���ǿ� �´°� ������ ������ ����)
--when not matched then
--insert (on���ǿ� �´°� ������ ������ ����)
--into �� ���̺��̸��� ���� �߰��� �ʿ䰡����, �������� �����Ҷ� � ���̺����� ���߱⶧����.
--select insert update�� �ѹ��� �� �� �� ����. �׷��� ���� �������� ����.

--��ǰ�ڵ尡 400�� �ڰ�ġ(1200��) 150���԰�
merge into product
using dual
on (pid = 400)
when matched then
update set cnt = cnt+150 
when not matched then
insert (pid, pname, cnt, price)
values (400, '�ڰ�ġ', 150, 1200);

--��ǰ�ڵ尡 100�� �����(1500��) 50���԰�
merge into product
using dual
on (pid = 100)
when matched then
update set cnt = cnt+50 
when not matched then
insert (pid, pname, cnt, price)
values (100, '�����', 50, 1500);

--Ȯ��
select *
from product;

commit;

insert into product
values (101, '���ڱ�', 150, 1500);

insert into product
values (102, '������', 70, 1500);

insert into product
values (103, '��¡����', 250, 1500);

savepoint a;

insert into product
values (104, '����', 25, 1500);

insert into product
values (105, '��īĨ', 63, 1500);

savepoint b;

insert into product
values (106, '����Ĩ', 84, 1500);

insert into product
values (107, '���ı�', 99, 1500);

rollback to a;
rollback to b;

select * from product;
rollback;


--------------------------------
--sequence
--�������� �����Ͱ� �ƴ϶� ������Ʈ��. ������ �־ ����������. �ѹ� ����Ȱ� ��.
--�ѹ��ؔf�� �ҿ����.
create SEQUENCE product_pid_seq
start with 1 INCREMENT BY 1;

delete product;

commit;

insert into product (pid, pname, cnt, price)
values (PRODUCT_PID_SEQ.nextval, '�̸�', 10, 1000);

select * from product;
--sequence Ȯ���ϱ�, Ȯ���ϴ°͵� �ൿ �ϴ°��̱⶧���� nextval���� �ϳ� �ö󰡸鼭 �����̵ȴ�.
select PRODUCT_PID_SEQ.nextval
from dual;
--��ſ� �����Ѱ�, ������ �Ⱦ��� ��ȣ ������ �̷��� �ؾߵ� 
select max(pid) + 1 from product;
--���� ������ ��
select product_pid_seq.currval
from dual;








