select* from species;
select * from species_type
select * from species_in_places

/* ЗАДАНИЕ 1*/
--1 Составьте запрос, который выведет имя вида с наименьшим id. Результат будет соответствовать букве «М».

select species_id, species_name from species
order by species_id
limit 1;

--2 Составьте запрос, который выведет имя вида с количеством представителей более 1800. Результат будет соответствовать букве «Б».

select species_name, species_amount from species
where species_amount> 1800;

--3 Составьте запрос, который выведет имя вида, начинающегося на «п» и относящегося к типу с type_id = 5. Результат будет соответствовать букве «О».

select species_name, type_id from species
where species_name like 'п%' 
and type_id = 5;

--4 Составьте запрос, который выведет имя вида, заканчивающегося на «са» или количество представителей которого равно 5. Результат будет соответствовать букве В.

select species_name, species_amount from species
where species_name like '%са' 
or species_amount= 5;

/* ЗАДАНИЕ 2*/

--1 Составьте запрос, который выведет имя вида, появившегося на учете в 2023 году. Результат будет соответствовать букве «Ы».

select distinct species_name, to_char(date_start,'YYYY') from species
where to_char(date_start,'YYYY') = '2023';

--2 Составьте запрос, который выведет названия отсутствующего (status = absent) вида, расположенного вместе с place_id = 3. Результат будет соответствовать букве «С».

select species_name, species_status, species_in_places.place_id from species 
inner join species_in_places
on species.species_id = species_in_places.species_id
where species_status = 'absent' and species_in_places.place_id = 3;

--3 Составьте запрос, который выведет название вида, расположенного в доме и появившегося в мае, а также и количество представителей вида. Название вида будет соответствовать букве «П».

select species_name, place.place_name, to_char(date_start,'MM'), species_amount from species 
inner join (
	select species_in_places.species_id, places.place_name from species_in_places 
	inner join places 
	on species_in_places.place_id = places.place_id
	where place_name='дом') as place 
on place.species_id = species.species_id
where to_char(date_start,'MM')='05';

--4 Составьте запрос, который выведет название вида, состоящего из двух слов (содержит пробел). Результат будет соответствовать знаку !.

select species_name from species
where species_name like '% %';

/* ЗАДАНИЕ 3*/

--1 Составьте запрос, который выведет имя вида, появившегося с малышом в один день. Результат будет соответствовать букве «Ч».

select species_name, species.date_start from species
inner join (
	select date_start from species 
	where species_name = 'малыш') as baby
on species.date_start = baby.date_start 
where species.species_name<> 'малыш';

--2 Составьте запрос, который выведет название вида, расположенного в здании с наибольшей площадью. Результат будет соответствовать букве «Ж».

select species.species_name, psize.place_size from species 
inner join (
	select species_in_places.species_id, places.place_size from species_in_places 
	inner join places
		on species_in_places.place_id = places.place_id
		where places.place_id = 1 or places.place_id = 2
			group by species_in_places.species_id, places.place_size
			order by places.place_size desc
			limit 1) 
			as psize
on psize.species_id = species.species_id;


--3 Составьте запрос/запросы, которые найдут название вида, относящегося к 5-й по численности группе проживающей дома. Результат будет соответствовать букве «Ш».

select type_id, sum (species_amount) from species 
group by type_id
order by sum desc 
limit 5;

select species_name from species
inner join species_in_places
on species.species_id = species_in_places.species_id
inner join places 
on species_in_places.place_id = places.place_id
WHERE places.place_name = 'дом' and species.type_id = 3;

--4 Составьте запрос, который выведет сказочный вид (статус fairy), не расположенный ни в одном месте. Результат будет соответствовать букве «Т».

select species.species_name, places.place_name from species
full join species_in_places
on species.species_id = species_in_places.species_id
full join places
on species_in_places.place_id = places.place_id
where species.species_status = 'fairy' and place_name is null; 

/*Ответы 
М малыш
Б роза
О подсолнух
В лиса

Ы обезьяна
С яблоко
П собака
! голубая рыба

Ч кошка
Ж лошадь
Ш попугай
Т единорог

ТЫ
ВСЕ
МОЖЕШЬ!
*/