-- Task 1
--Вывести список сотрудников, получающих заработную плату большую чем у непосредственного руководителя
create view employee_salary
as
select e1.name,
       e1.salary as employee_salary,
       e2.salary as chief_salary,
       d.name as department_name
from employee as e1
left join employee e2 on e1.chief_id = e2.id
left join department d on d.id = e1.department_id
where e1.salary > e2.salary
limit 10;


-- Task 2
--Вывести список сотрудников, получающих максимальную заработную плату в своем отделе

select * from department d
left join employee e on e.department_id = d.id
where e.salary = (select max(salary) from employee e where e.department_id = d.id);

--Task 3
--Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек
 explain select * from department d
where (select count(e1) from employee e1 where e1.department_id = d.id ) <= 3;

--Task 4
--Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том-же отделе
explain select distinct e2.* from employee e1
inner join employee e2 on e1.id = e2.chief_id and e1.department_id != e2.department_id;

--Task 5
--Найти список ID отделов с максимальной суммарной зарплатой сотрудников

  with  id_sum as (select e.department_id, sum(salary) as salary
    from   employee e
    group  by department_id)
  select distinct i1.department_id from id_sum i1
       join id_sum i on i1.salary =(select max(salary) from id_sum);
