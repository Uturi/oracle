------------------DDL
--ȸ��(�ʼ�)                 member
-- �̸�                        name                  varchar2(30)
-- ���̵�                     id                       varchar2(16)
-- ��й�ȣ                  pass                    varchar2(16)
-- ����                        age                     number(3)
-- �̸��Ͼ��̵�            emailid                varchar2(30)
-- �̸��ϵ�����            emaildomain        varchar2(30)
-- ������                     joindate               date

--ȸ�� ������            member_detail
-- ���̵�                     id                       varchar2(16)
-- �����ȣ                  zipcode               varchar2(5)
-- �Ϲ��ּ�                  address                varchar2(100)
-- ���ּ�                  address_detail       varchar2(100)
-- ��ȭ��ȣ1                tel1                     varchar2(3)
-- ��ȭ��ȣ2                tel2                     varchar2(4)
-- ��ȭ��ȣ3                tel3                     varchar2(4)


create table member
(
    name varchar2(30) not null,
    id varchar2(16),
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,
    constraint member_id_pk primary key (id)
);

create table member_detail
(
    id varchar2(30),
    zipcode varchar2(5),
    address varchar2(100),
    address_detail varchar2(100),
    tel1 varchar2(3),
    tel2 varchar2(4),
    tel3 varchar2(4),
    constraint member_detail_id_fk foreign key (id) references member (id)
);


drop table member;

drop table member_detail;


-- ���̺� �����ϱ�, ������ ������ ��� �ٰ�����
CREATE table emp_all
as
select * from employees;
--Ȯ��
select *
from emp_all;


-- ���̺��� ������ �������������, ���ǿ� �����ȵǴ� ���� ������ȴ�. �´°� �����ϱ� �����ʹ� �Ȱ�����
create table emp_blank
as
select * from employees
where 1=0;
-- Ȯ��
select *
from emp_blank;


-- join�ؼ� ���ϴ� ������ ���ϴµ����Ϳ� ������ ������ ���̺�����ϱ�, ��Ī�� �ָ� �װ� Į������ �ǹ���.
create table emp_50
as
select e.employee_id eid, e.first_name name, e.salary sal, d.department_name dname
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 50;
-- Ȯ��
select *
from emp_50;


----------------------DML
--insert 
--id�� primary key �̱� ������ �ΰ��� ���� ��� �ݵ�� �Է��ؾ��Ѵ�.
insert into member
values ('������', 'uturi', '1234', 25, 'uturi', 'naver.com', sysdate);
--������� ����־���� ���� ���̸� ���ϴ� ���� ������� �ȵ��� �� �� �ִ�.
insert into member 
values ('hong', 'ȫ�浿', '25', 123, 'java2', 'naver.com', sysdate);
--insert�� �Ҷ� ���̺�� ���� Į���̸����� ���� �� ������ ���߸� ���ϴ� Į���� �����Ͱ� ����.
insert into member (id, name, age, pass, emailid, emaildomain, joindate)
values ('hong', 'ȫ�浿', '25', 123, 'java2', 'naver.com', sysdate);
--insert�Ҷ� ���ϴ� Į���� ���� �����͸� ������ ������� �����κ��� �ΰ��� ���� �ȴ�.
insert into member (id, name, pass, joindate)
values ('hong2', 'ȫ�浿2', 'abcd', sysdate);
-- id�� foreign key�̱⶧���� �����ϴ� ���̺� �ִ� �����͸� �Է��� �����ϴ�. �θ�Ű�� �־�߸� �Ѵ�.
insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('uturi', '12345', '����� ���Ǳ� ���ű�86', '�Ÿ�2��������Ʈ', '010', '9914', '0953');

--insert�� �ѹ��� ������ ���̺� �Է��� �� �ִ�. insert all into values into values ��Ӱ���
--select ���� �ʼ��̴�. ������ �°�.
insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '����Ŭ', '30', 'a12345678', 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '12345', '����� ���Ǳ� ����Ŭ��63', '����Ŭ������', '010', '1234', '5678')
select *  from dual;

select *
from member;

select *
from member m, member_detail d
where m.id = d.id;


--update








--delete









--merge











commit;







