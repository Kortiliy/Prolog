% Copyright

implement main
    open core, stdio

domains
    goals = гол; голов; гола.

class facts - foot
    игрок : (integer PlayerID, string Name, string Position, string Activity, real KolvoGolov, goals G).
    зарплата : (integer SalaryID, real Dengi).
    матч : (integer MatchID, integer ID1, integer ID2, string Date, string Score, string Stadium, string Winner).
    команда : (integer TeamID, string Nazvanie).
    состав_команды : (integer SostavID, integer Player1ID, integer Player2ID).

class facts
    s : (real Sum) single.

clauses
    s(0).

class predicates
    статистика_игрока : (string Name) nondeterm.
    сколько_зарплата_у_состава : (integer SostavID).
    кто_победил_в_матче : (integer MatchID) nondeterm.
    на_каком_стадионе_играли_команды : (integer MatchID).

clauses
    статистика_игрока(Name) :-
        игрок(PlayerID, Name, Position, Activity, KolvoGolov, G),
        writef("Имя \t%  \n", Name),
        зарплата(PlayerID, Dengi),
        writef("Зарплата \t%  \n", Dengi),
        writef("Позиция \t% \n", Position),
        writef("Активность \t%  \n", Activity),
        writef("Кол-во забитых голов \t% \n", KolvoGolov),
        writef("\t%:\n", G),
        fail.
    статистика_игрока(Name) :-
        игрок(_, Name, _, _, _, _).

    сколько_зарплата_у_состава(SostavID) :-
        состав_команды(SostavID, Player1ID, Player2ID),
        writef("Общая зарплата состава %:\n", SostavID),
        assert(s(0)),
        зарплата(Player1ID, Dengi1),
        зарплата(Player2ID, Dengi2),
        s(Sum),
        assert(s(Sum + Dengi1 + Dengi2)),
        fail.
    сколько_зарплата_у_состава(SostavID) :-
        s(Sum),
        writef("\tВ итоге: %\n", Sum).

    кто_победил_в_матче(MatchID) :-
        writef("Победитель матча номер %:\n", MatchID),
        матч(MatchID, _, _, _, Score, _, Winner),
        writef(" \t%  \n", Winner),
        writef("Счет: \t%  \n", Score),
        fail.
    кто_победил_в_матче(MatchID) :-
        матч(MatchID, _, _, _, _, _, _).

    на_каком_стадионе_играли_команды(MatchID) :-
        writef(" Команды, игравшие в матче под номером %:\n", MatchID),
        матч(MatchID, ID1, ID2, Date, _, Stadium, _),
        команда(ID1, Nazvanie1),
        команда(ID2, Nazvanie2),
        writef("Первая команда: \t%  \n", Nazvanie1),
        writef("Вторая команда: \t%  \n", Nazvanie2),
        writef("Дата матча: \t%  \n", Date),
        writef("Стадион: \t%  \n", Stadium),
        fail.
    на_каком_стадионе_играли_команды(MatchID) :-
        nl.

clauses
    run() :-
        file::consult("../football.txt", foot),
        fail.

    run() :-
        статистика_игрока("Криштиану Роналду"),
        fail.

    run() :-
        сколько_зарплата_у_состава(1),
        fail.

    run() :-
        кто_победил_в_матче(1),
        fail.

    run() :-
        на_каком_стадионе_играли_команды(1),
        fail.

    run().

end implement main

goal
    console::runUtf8(main::run).
