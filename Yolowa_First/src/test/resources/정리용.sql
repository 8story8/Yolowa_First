drop table y_member;
drop table y_board;
drop table funding;
drop table board_opt;
drop table reply;
drop table bookmark;
drop table contentlike;
drop table paticipant;
drop table log;
drop table point;
drop table grade;
drop table follow;
drop table message;
drop table category;
drop table interest;
drop table rank;


-- 쪽지 테이블 시퀀스
create sequence seq_message;
drop sequence seq_message

--카테고리 시퀀스
create sequence seq_category
drop sequence seq_category

-- board table sequence
create sequence seq_yboard;
drop sequence seq_yboard;


--board 옵션 시퀀스
create sequence seq_opt;
drop sequence seq_opt;

-- funding table sequence
create sequence seq_funding;
drop sequence seq_funding;

-- reply sequence table
create sequence seq_reply;
drop sequence seq_reply;
create sequence seq_reply_group;
drop sequence seq_reply_group;

-- board_opt sequence table
create sequence seq_opt;
drop sequence seq_opt;

-- log sequence 
create sequence seq_log;
drop sequence seq_log;

-- member table
create table y_member(
   id varchar2(30) primary key,
   password varchar2(100) not null,
   name varchar2(30) not null,
   address varchar2(100) not null,
   phone varchar2(100) not null,
   filepath varchar2(100) not null
)

select * from y_member
insert into y_member values('jdbc','1234','정우성','한남','010','string');
insert into y_member values('java','1234','임경수','구미','010','string');
insert into y_member values('spring','1234','아이유','판교','010','string');
insert into y_member values('javaking','1234','김경수','구미','010','resources/asset/img/ky.png')
insert into y_member values('lks','1234','박경수','구미','010','resources/asset/img/ky.png')
select * from Y_MEMBER;


--글쓰기파일업로드
insert into board_opt(bNo,filepath) values(2,'ssss');
select b.bno,b.bcontent,b.bpostdate,b.btype,b.id,o.local,o.filepath from Y_BOARD b, BOARD_OPT o where b.bno=o.bno
select * from Y_BOARD

-- funding table
create table funding(
   fTitle varchar2(30) not null,
   fPoint number default 0,
   fDeadLine date not null,
   fPeople number default 0,
   bNo number constraint fk_board_no references y_board ON DELETE CASCADE,
   constraint pk_fund primary key(bNo)
)

-- paticipant table
create table paticipant(
   id varchar2(30),
   bNo number,
   fPoint number default 0,
   constraint fk_pid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bno foreign key(bNo) references funding ON DELETE CASCADE,
   constraint pk_funding primary key(id,bNo)
)


-- like table
create table contentlike(
   bNo number,
   id varchar2(30),
   constraint fk_contentid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_contentno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_contentlike primary key(id,bNo)
)

-- bookmark table
create table bookmark(
   bNo number,
   id varchar2(30),
   constraint fk_bid foreign key(id) references y_member ON DELETE CASCADE,
   constraint fk_bookno foreign key(bNo) references y_board ON DELETE CASCADE,
   constraint pk_bookmark primary key(id,bNo)
)

-- reply table
create table reply(
   rNo number primary key,
   rContent clob not null,
   groupNo number not null,
   parentsNo number not null,
   depth number not null,
   rOrder number not null,
   id varchar2(30) constraint fk_reply_id references y_member ON DELETE CASCADE,
   bNo number constraint fk_reply_bno references y_board ON DELETE CASCADE
)


-- Log table
create table log(
   lNo number primary key,
   lContent clob not null,
   point number default 0,
   lDate date not null,
   id varchar2(30) constraint fk_log_id references y_member ON DELETE CASCADE
)

-- Point Table
create table point(
   id varchar2(30) primary key,
   point number not null,
   constraint p_id foreign key(id) references y_member(id) ON DELETE CASCADE
)


-- 친구 테이블
create table follow(
   sendId varchar2(30),
   receiveId varchar2(30),
   fcheck varchar2(30) default 'false',
   primary key(sendId,receiveId),
   constraint f_sid foreign key(sendId) references y_member(id) ON DELETE CASCADE,
    constraint f_rid foreign key(receiveId) references y_member(id) ON DELETE CASCADE
);

-- 메세지 테이블
create table message(
   mNo number primary key,
   rId varchar2(30) not null,
   sId varchar2(30) not null,
   message clob,
   mPostdate date not null,
   mCheck varchar2(30) default 'SM',
   constraint r_id foreign key(rId) references y_member(id) ON DELETE CASCADE,
    constraint s_id foreign key(sId) references y_member(id) ON DELETE CASCADE
);

--카테고리 테이블
create table category(
   cNo number primary key,
   cType varchar2(100) not null
);


insert into category(cNo,cType) values(seq_category.nextval,'영화');
insert into category(cNo,cType) values(seq_category.nextval,'여행');
insert into category(cNo,cType) values(seq_category.nextval,'스포츠');
insert into category(cNo,cType) values(seq_category.nextval,'도서');
insert into category(cNo,cType) values(seq_category.nextval,'게임');
insert into category(cNo,cType) values(seq_category.nextval,'인테리어');

--관심테이블
create table interest(
   id varchar2(30),
   cNo number not null,
   primary key(id,cNo),
   constraint id foreign key(id) references y_member(id) ON DELETE CASCADE,
    constraint c_no foreign key(cNo) references category(cNo) ON DELETE CASCADE
)

-- rank table
drop table rank;
create table rank(
   keyword varchar2(100) primary key,
   count number default 1
)

-- board table
create table y_board(
   bNo number primary key,
   bContent clob not null,
   bPostdate date not null,
   bType varchar2(100) not null,
   id varchar2(30) constraint fk_yboard_id references y_member
   ON DELETE CASCADE
);

--글쓰기파일업로드
insert into Y_BOARD values(seq_yboard.nextval,'안녕 아이폰 노주희 아이폰se',sysdate,'기타','java');
insert into board_opt(bNo,filepath) values(2,'ssss');
select b.bno,b.bcontent,b.bpostdate,b.btype,b.id,o.local,o.filepath from Y_BOARD b, BOARD_OPT o where b.bno=o.bno
select * from Y_BOARD


-- board option table
create table board_opt(
   	optNo number primary key,
    bNo number not null,
    local varchar2(100),
    filepath varchar2(100),
   constraint fk_board_bno foreign key(bNo) references y_board ON DELETE CASCADE,
)

-- funding table
create table funding(
   fTitle varchar2(30) not null,
   fPoint number default 0,
   fDeadLine date not null,
   fPeople number default 0,
   bNo number constraint fk_board_no references y_board ON DELETE CASCADE,
   constraint pk_fund primary key(bNo)
)

--Grade Table
create table grade(
   gNo number primary key,
   grade number default 0
);











