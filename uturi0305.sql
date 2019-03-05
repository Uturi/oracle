------------------DDL
--회원(필수)                 member
-- 이름                        name                  varchar2(30)
-- 아이디                     id                       varchar2(16)
-- 비밀번호                  pass                    varchar2(16)
-- 나이                        age                     number(3)
-- 이메일아이디            emailid                varchar2(30)
-- 이메일도메인            emaildomain        varchar2(30)
-- 가입일                     joindate               date

--회원 상세정보            member_detail
-- 아이디                     id                       varchar2(16)
-- 우편번호                  zipcode               varchar2(5)
-- 일반주소                  address                varchar2(100)
-- 상세주소                  address_detail       varchar2(100)
-- 전화번호1                tel1                     varchar2(3)
-- 전화번호2                tel2                     varchar2(4)
-- 전화번호3                tel3                     varchar2(4)


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


-- 테이블 복사하기, 구조와 데이터 모두 다가져옴
CREATE table emp_all
as
select * from employees;
--확인
select *
from emp_all;


-- 테이블의 구조만 가져오고싶을때, 조건에 말도안되는 조건 넣으면된다. 맞는게 없으니까 데이터는 안가져옴
create table emp_blank
as
select * from employees
where 1=0;
-- 확인
select *
from emp_blank;


-- join해서 원하는 조건의 원하는데이터와 구조만 가지고 테이블생성하기, 별칭을 주면 그게 칼럼명이 되버림.
create table emp_50
as
select e.employee_id eid, e.first_name name, e.salary sal, d.department_name dname
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 50;
-- 확인
select *
from emp_50;


----------------------DML
--insert 
--id는 primary key 이기 때문에 널값이 들어갈수 없어서 반드시 입력해야한다.
insert into member
values ('이종영', 'uturi', '1234', 25, 'uturi', 'naver.com', sysdate);
--순서대로 맞춰넣어야함 순서 섞이면 원하는 내용 순서대로 안들어가게 될 수 있다.
insert into member 
values ('hong', '홍길동', '25', 123, 'java2', 'naver.com', sysdate);
--insert를 할때 테이블명 옆에 칼럼이름들을 적고 그 순서에 맞추면 원하는 칼럼에 데이터가 들어간다.
insert into member (id, name, age, pass, emailid, emaildomain, joindate)
values ('hong', '홍길동', '25', 123, 'java2', 'naver.com', sysdate);
--insert할때 원하는 칼럼만 적고 데이터를 넣으면 집어넣지 않은부분은 널값이 들어가게 된다.
insert into member (id, name, pass, joindate)
values ('hong2', '홍길동2', 'abcd', sysdate);
-- id가 foreign key이기때문에 참조하는 테이블에 있는 데이터만 입력이 가능하다. 부모키가 있어야만 한다.
insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('uturi', '12345', '서울시 관악구 광신길86', '신림2단지아파트', '010', '9914', '0953');

--insert는 한번에 여러개 테이블에 입력할 수 있다. insert all into values into values 계속가능
--select 문이 필수이다. 문법에 맞게.
insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '오라클', '30', 'a12345678', 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '12345', '서울시 관악구 오라클길63', '오라클연구소', '010', '1234', '5678')
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







