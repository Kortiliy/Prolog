/* Факты */

/* Команды */
team(1,"Спартак", "Москва").
team(2,"ЦСКА", "Москва").
team(3,"Барселона", "Каталония").
team(4,"Реал-Мадрид", "Мадрид").
team(5,"Бавария", "Мюнхен").

/* Стадионы*/

stadium(11,"Сантьяго Бернабеу","Мадрид").
stadium(22,"ЦСКА Арена","Москва").
stadium(33,"Камп Ноу","Каталония").
stadium(44,"Открытие Арена","Москва").
stadium(55,"Альянс Арена","Мюнхен").

/* Принадлежность стадионов командам */

place(1,44).
place(2,22).
place(3,33).
place(4,11).
place(5,55).

/* Игроки */

player(111,"Карим Бензема","35",4).
player(222,"Томас Мюллер","33",5).
player(333,"Ансу Фати","20",3).
player(444,"Игорь Акинфеев","37",2).
player(555,"Георгий Джикия","29",1).

/* Матчи */

match(1111,"05/04/23",4,3,"4-0","Камп Ноу","Победитель: Реал-Мадрид").
match(2222,"16/10/22",1,2,"2-2","ВЭБ Арена","Победитель: Спартак - ЦСКА Ничья").
match(3333,"26/10/22",3,5,"0-3","Камп Ноу", "Победитель Бавария").
match(4444,"21/07/19",5,4,"3-1","NRG-стэдиум","Победитель Бавария").

/* Трансферы */

transfer(12,111,5).
transfer(13,222,4).
transfer(14,333,2).
transfer(15,444,1).
transfer(16,555,3).

/* Зарплаты */

salary(71,111,"2000000$"). 
salary(72,222,"2500000$"). 
salary(73,333,"4000000$"). 
salary(74,444,"900000$"). 
salary(75,555,"700000$"). 

/* Рейтинг УЕФА */

rating_uefa(81,1,"61").
rating_uefa(82,2,"49").
rating_uefa(83,3,"2").
rating_uefa(84,4,"5").
rating_uefa(85,5,"9").

/* Мировой рейтинг */

world_rating(91,1,"49").
world_rating(92,2,"51").
world_rating(93,3,"4").
world_rating(94,4,"1").
world_rating(95,5,"2"). 

/* Голы */

goals(61,111,"637").
goals(62,222,"578").
goals(63,333,"359").
goals(64,444,"0").
goals(65,555,"567").

/* Правила */

find_player(IDp,NameP,Age):- player(IDp,NameP,Age,_).

find_stadium(IDs,NameS):- stadium(IDs,NameS,_).

find_match(IDm,Date,Score,Arena):- match(IDm,Date,_,_,Score,Arena,_).

find_winner(IDm,Winner):- match(IDm,_,_,_,_,_,Winner).

clubstatistic(IDc,Rank1,Rank2):- world_rating(_,IDc,Rank1), rating_uefa(_,IDc,Rank2).

player_statistic(IDp,NameP,Age,Team,Salary,Goals):- player(IDp,NameP,Age,X), team(X,Team,_,), salary(_,IDp,Salary), goals(_,IDp,Goals).

