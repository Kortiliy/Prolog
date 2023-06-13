implement main
    open core, stdio

domains
    goals = гол; голов; гола.

class facts - foot
    игрок : (integer PlayerID, string PlayerName, integer TrenerID, integer PositionID, string Activity, real KolVoGolov, goals G).
    тренер : (integer TrenerID, string TrenerName, string TeamName).
    зарплата : (integer PlayerID, real Dengi, string PlayerName).
    тюрьма_блю_лок : (integer BlueLockID, string Position).

class predicates  %Вспомогательные предикаты
    длина : (A*) -> integer N.
    сумма : (real* List) -> real Sum.
    среднее : (real* List) -> real Average determ.

clauses
    длина([]) = 0.
    длина([_ | T]) = длина(T) + 1.

    сумма([]) = 0.
    сумма([H | T]) = сумма(T) + H.

    среднее(L) = сумма(L) / длина(L) :-
        длина(L) > 0.

class predicates
    средняя_зарплата : (string TrenerName) -> real Dengi nondeterm.
    общее_количество_голов : (string Goals) -> real KolVoGolov nondeterm.
    игроки_на_определенной_позиции : (string PlayerName) -> string* Position nondeterm.

clauses
    общее_количество_голов(X) = сумма([ KolVoGolov || игрок(_, _, TrenerID, _, _, KolVoGolov, _) ]) :-
        тренер(TrenerID, X, _).

    игроки_на_определенной_позиции(X) = Goli :-
        тюрьма_блю_лок(PositionID, X),
        Goli = [ PlayerName || игрок(_, PlayerName, _, PositionID, _, _, _) ].

    средняя_зарплата(X) =
            среднее(
                [ Dengi ||
                    игрок(PlayerID, _, TrenerID, _, _, _, _),
                    зарплата(PlayerID, Dengi, _)
                ]) :-
        тренер(TrenerID, X, _).

clauses
    run() :-
        console::init(),
        file::consult("../football2.txt", foot),
        fail.

    run() :-
        X = 'Хавьер Эрнандес Креус',
        writef("Средняя зп игроков у : %", X),
        write("  равна :   ", средняя_зарплата(X)),
        nl,
        fail.

    run() :-
        X = 'Карло Анчелотти',
        writef("Средняя зп игроков у : %", X),
        write("  равна :   ", средняя_зарплата(X)),
        nl,
        fail.

    run() :-
        X = 'Фрэнк Лэмпард',
        writef("Средняя зп игроков у : %", X),
        write("  равна :   ", средняя_зарплата(X)),
        nl,
        fail.

    run() :-
        X = 'Хавьер Эрнандес Креус',
        L = общее_количество_голов(X),
        writef("Количество голов игроков, тренируемых  % составляет %.", X, L),
        writef("\n"),
        nl,
        fail.

    run() :-
        X = 'Карло Анчелотти',
        L = общее_количество_голов(X),
        writef("Количество голов игроков, тренируемых  % составляет %.", X, L),
        writef("\n"),
        nl,
        fail.

    run() :-
        X = 'Фрэнк Лэмпард',
        L = общее_количество_голов(X),
        writef("Количество голов игроков, тренируемых  % составляет %.", X, L),
        writef("\n"),
        nl,
        fail.

    run() :-
        X = 'нападающий',
        writef("Позиция : %", X),
        writef("  игроки:  %", игроки_на_определенной_позиции(X)),
        writef("\n"),
        nl,
        fail.

    run() :-
        X = 'защитник',
        writef("Позиция : %", X),
        writef("  игроки:  %", игроки_на_определенной_позиции(X)),
        writef("\n"),
        nl,
        fail.

    run() :-
        X = 'вратарь',
        writef("Позиция : %", X),
        writef("  игроки:  %", игроки_на_определенной_позиции(X)),
        writef("\n"),
        nl,
        fail.

    run() :-
        succeed.

end implement main

goal
    console::runUtf8(main::run).
