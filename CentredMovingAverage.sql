-- Execute in SQL/Plus
---------------------------

drop table test;

create table test(x number, y number);

insert into test(x,y) values(1 ,1);
insert into test(x,y) values(2, 2);
insert into test(x,y) values(3, 3);
insert into test(x,y) values(4, 3);
insert into test(x,y) values(5, 3);
insert into test(x,y) values(6, 4);
insert into test(x,y) values(7, 1);
insert into test(x,y) values(8, 6);
insert into test(x,y) values(9, 9);
insert into test(x,y) values(10, 21);
insert into test(x,y) values(11, 18);
insert into test(x,y) values(12, 13);
insert into test(x,y) values(13, 10);
insert into test(x,y) values(14, 7);
insert into test(x,y) values(15, 6);
insert into test(x,y) values(16, 5);
insert into test(x,y) values(17, 4);
insert into test(x,y) values(18, 2);
insert into test(x,y) values(19, 3);
insert into test(x,y) values(20, 4);


select *
 from test;
 
column x format 99
column y format 99
column centredMovingAvg format 990.00

 
WITH movAvg AS (SELECT 2 midPointOffset FROM DUAL), 
     avgCandidates AS ( 
                       SELECT x,
                              y,   
                              AVG(y) 
                                 OVER (ORDER BY x ROWS BETWEEN m.midPointOffset PRECEDING AND m.midPointOffset FOLLOWING) centredMovingAvg, 
                              ROW_NUMBER() 
                                 OVER (ORDER BY 1) rn, 
                              COUNT(*) 
                                 OVER (ORDER BY 1) - m.midPointOffset + 1 windowUpper
                          FROM test, 
                               movAvg m
                       ) 
      SELECT x, y, centredMovingAvg
        FROM avgCandidates c, 
             movAvg a 
           WHERE c.rn > a.midPointOffset 
             AND c.rn < c.windowUpper;
