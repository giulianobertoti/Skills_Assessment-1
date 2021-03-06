drop database SkillsAssessment;
create database SkillsAssessment;
use SkillsAssessment;

create table institution(
	ist_code int auto_increment,
    ist_company varchar(250),
    ist_cnpj varchar(50),
    ist_city varchar(250),
    constraint pk_ist primary key (ist_code)
)engine=innodb;

CREATE TABLE user (
    usr_code INT AUTO_INCREMENT,
    usr_userName VARCHAR(250),
    usr_password VARCHAR(100),
    usr_ra VARCHAR(30),
    usr_situation SMALLINT DEFAULT 0,
    usr_verified SMALLINT DEFAULT 0,
    usr_type VARCHAR(50),
    usr_token VARCHAR(500),
    usr_name VARCHAR(100),
    usr_register DATE,
    ist_code INT,
    CONSTRAINT fk_ist FOREIGN KEY (ist_code)
        REFERENCES institution (ist_code),
    CONSTRAINT pk_usr PRIMARY KEY (usr_code)
)  ENGINE=INNODB;


create table course (
	crs_code int auto_increment,
    crs_name varchar (250),
    crs_situation smallint,
    crs_registration_date Date,
    constraint crs_pk primary key (crs_code)
)engine=innodb;

create table enrolls (
	ern_code int auto_increment,
	ern_year int ,
	ern_period int,
    crs_code int,
    usr_code int unique,
	constraint pk_prd primary key (ern_code),
    constraint fk_crs foreign key (crs_code) references course (crs_code),
    constraint fk_usr_enrolls foreign key (usr_code) references user (usr_code)
)engine=innodb;

create table question(
	qst_code int auto_increment,
    qst_question varchar(250) ,
    qst_introduction varchar(250) ,
    qst_situation int,
	qst_type varchar(10),
    constraint pk_qst primary key (qst_code)
)engine=innodb;

create table competence (
	com_code int auto_increment,
    com_type  varchar(250) ,
    com_registration_date Date,
    com_situation smallint default 0,
    constraint pk_com primary key (com_code)
)engine=innodb;

create table alternatives(
	alt_code int auto_increment,
    alt_description varchar(250) ,
    qst_code int ,
    constraint pk_alt primary key (alt_code),
    constraint fk_qst foreign key (qst_code) references question (qst_code)
)engine=innodb;

create table alt_com (
	rsc_code int auto_increment,
    alt_code int,
    com_code int,
    rsc_weight int,
    constraint pf_rsc primary key (rsc_code),
    constraint fk_alt foreign key (alt_code) references alternatives(alt_code),
    constraint fk_cmp foreign key (com_code) references competence (com_code)
);

create table quiz(
	quz_code int auto_increment,
    usr_code int ,
    qst_code int ,
    alt_code int ,
    quz_date Date,
    quz_duration time,
    constraint pk_pro primary key (quz_code),
    constraint fk_usr_quiz foreign key (usr_code) references user (usr_code),
    constraint fk_pgt foreign key (qst_code) references question (qst_code),
    constraint fk_rsp foreign key (alt_code) references alternatives (alt_code)
)engine=innodb;

create table result(
	rst_code int auto_increment,
    usr_code int ,
    rst_date_final Date,
    rst_completed smallint default 0,
    rst_measured smallint default 0,
    rst_comment varchar(500),
    constraint pk_rlt primary key (rst_code),
    constraint fk_usr foreign key (usr_code) references user (usr_code)
)engine=innodb;

create table average(
	avr_code int auto_increment,
    rst_code int,
    com_code int,
    avr_final int,
    constraint pk_avr primary key (avr_code),
    constraint fk_rst foreign key (rst_code) references result (rst_code),
    constraint fk_cpt foreign key (com_code) references competence (com_code)
)engine=innodb;

create table ist_crs(
	itc_code int auto_increment,
    crs_code int,
    ist_code int,
    constraint pk_ist_crs primary key (itc_code,crs_code,ist_code) ,
    constraint fk_course foreign key (crs_code) references course (crs_code),
    constraint fk_institution foreign key (ist_code) references institution (ist_code)
)engine=innodb;

insert into user (
    usr_userName ,usr_password ,usr_situation ,usr_verified ,usr_type,  usr_name) 
    values ('joao','1234',1,1,'employee','joao da silva');  
    
insert into user (
    usr_userName ,usr_password ,usr_situation ,usr_verified ,usr_type, usr_name) 
    values ('edu','1234',1,1,'student','eduardo alves');
    
insert into user (
    usr_userName ,usr_password ,usr_situation ,usr_verified ,usr_type, usr_name) 
    values ('pedro','1234',1,1,'student','pedro da silva'); 
    

insert into competence (com_type,com_registration_date) values ('Determinação',date_format(now(), '%Y-%m-%d'));
insert into competence (com_type,com_registration_date) values ('Individualismo',date_format(now(), '%Y-%m-%d'));
insert into competence (com_type,com_registration_date) values ('Persuasão',date_format(now(), '%Y-%m-%d'));
insert into competence (com_type,com_registration_date) values ('Persistência',date_format(now(), '%Y-%m-%d'));
insert into competence (com_type,com_registration_date) values ('Obediência',date_format(now(), '%Y-%m-%d'));

insert into course values (1,'Banco de Dados',1, date_format(now(), '%Y-%m-%d'));
insert into course values (2,'Estrutura Leves',1, date_format(now(), '%Y-%m-%d'));
insert into course values (3,'Logistica',1, date_format(now(), '%Y-%m-%d'));
insert into course values (4,'Manutenção de Aeronaves',1, date_format(now(), '%Y-%m-%d'));
insert into course values (5,'Gestão de Produção Industrial',1, date_format(now(), '%Y-%m-%d'));

insert into enrolls (ern_year,ern_period,crs_code,usr_code)  values (date_format(now(), '%Y'), 1,1,3);
insert into enrolls (ern_year,ern_period,crs_code,usr_code)  values (date_format(now(), '%Y'), 1,2,2);

insert into institution (ist_company, ist_cnpj, ist_city) values ('Fatec-SJC', '12.345.678/0001-00', 'São José dos Campos');
insert into institution (ist_company, ist_cnpj, ist_city) values ('Fatec-Jacareí', '12.345.690/0001-10', 'Jacareí');
insert into institution (ist_company, ist_cnpj, ist_city) values ('Fatec-São Paulo', '12.345.800/0001-20', 'São Paulo');

insert into ist_crs (itc_code, ist_code, crs_code) values (1,1,1);
insert into ist_crs (ist_code, crs_code) values (2,2);
insert into ist_crs (ist_code, crs_code) values (3,3);

select * from course;
select * from enrolls;
select * from institution;
select * from ist_crs;
select * from user;
select * from competence;
select * from question;
select * from quiz;

select institution.ist_company, course.CRS_CODE, CRS_NAME from course join ist_crs on (course.crs_code = ist_crs.crs_code) join institution on (institution.ist_code = ist_crs.crs_code) where ist_crs.itc_code = 3;

select user.usr_code, usr_type, usr_name, crs_name, ern_year, ern_period from enrolls
join user on (enrolls.usr_code = user.usr_code) 
join course on (enrolls.crs_code = course.crs_code) where user.usr_type = 'student';

select question.qst_code as qst_code,question.qst_question,qst_introduction,alternatives.alt_code,alt_description,
competence.com_code,competence.com_kind
from question inner join alternatives on alternatives.qst_code = question.qst_code 
inner join alt_com on alt_com.alt_code = alternatives.alt_code
inner join competence on alt_com.com_code = competence.com_code
where question.qst_situation <> 1 and question.qst_code not in (select quiz.qst_code from quiz where std_code = 1) order by question.qst_code ;

select e.ern_code, u.usr_code, u.usr_userName, u.usr_password, u.usr_ra, u.usr_name, c.crs_name, i.ist_company, e.ern_period, e.ern_year
from user u join enrolls e on (u.usr_code = e.usr_code)
join course c on (e.crs_code = c.crs_code)
join ist_crs itc on (c.crs_code = itc.crs_code)
join institution i on (itc.ist_code = i.ist_code)
where u.usr_code = 4;

select competence.com_code, competence.com_type, date_format(competence.com_registration_date, '%d-%m-%Y') from competence;

select date_format(now(), '%d-%m-%Y') from dual;
select date_format(now(), '%Y') from dual;
select now(), sysdate() from dual;

select competence.com_code, competence.com_type, date_format(competence.com_registration_date, '%d-%m-%Y') 
from competence;
