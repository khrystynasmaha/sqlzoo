--Table #1: stops(id, name)
--Table #2: route(num, company, pos, stop)

--1. How many stops are in the database.

SELECT COUNT(id)
 FROM stops;
 
--2. Find the id value for the stop 'Craiglockhart'.

SELECT id
 FROM stops
 WHERE name='Craiglockhart';
 
--3. Give the id and the name for the stops on the '4' 'LRT' service.

SELECT id, name
 FROM stops
  JOIN route ON id=stop
   WHERE company= 'LRT' AND num='4';
   
--4. Give the number of routes that visit either London Road (149) or Craiglockhart (53). 
--Restrict the output to the services having at least 2 routes.

SELECT company, num, COUNT(*)
 FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)>=2;

--5. Show the services from Craiglockhart to London Road.

SELECT a.company, a.num, a.stop, b.stop
 FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
 WHERE a.stop=53 AND b.stop=149;
 
--6. Show the services from Craiglockhart to London Road.
--However by joining two copies of the stops table refer to stops by name rather than by number. 

SELECT a.company, a.num, x.name, y.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops x ON (a.stop=x.id)
  JOIN stops y ON (b.stop=y.id)
WHERE x.name='Craiglockhart' AND y.name='London Road';

--7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith').

SELECT a.company, a.num
 FROM route a 
  JOIN route b ON (a.company=b.company AND a.num=b.num)
   WHERE a.stop=115 AND b.stop=137
GROUP BY a.company, a.num;
 
--8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'.

SELECT a.company, a.num
 FROM route a 
  JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops s1 ON s1.id=a.stop
  JOIN stops s2 ON s2.id=b.stop
 WHERE s1.name='Craiglockhart' AND s2.name='Tollcross';
 
--9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 
--'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

SELECT s2.name, a.company, a.num
 FROM route a
  JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops s1 ON s1.id=a.stop
  JOIN stops s2 ON s2.id=b.stop
 WHERE s1.name='Craiglockhart'
GROUP BY s2.name, a.company, a.num;

--10. Find the routes involving two buses that can go from Craiglockhart to Lochend. 
--Show the bus no. and company for the first bus, the name of the stop for the transfer, 
--and the bus no. and company for the second bus.

SELECT one.num, one.company, one.name, two.num, two.company
 FROM
  (SELECT distinct a.num, s2.name, a.company
    FROM route a
    JOIN route b ON (a.company=b.company AND a.num=b.num)
    JOIN stops s1 ON s1.id=a.stop
    JOIN stops s2 ON s2.id=b.stop
   WHERE s1.name='Craiglockhart') one
JOIN
 (SELECT distinct a.num, s1.name, a.company
   FROM route a
   JOIN route b ON (a.company=b.company AND a.num=b.num)
   JOIN stops s1 ON s1.id=a.stop
   JOIN stops s2 ON s2.id=b.stop
  WHERE s2.name='Lochend') two
WHERE one.name=two.name;
