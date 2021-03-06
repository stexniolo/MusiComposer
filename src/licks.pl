['./composer.pl'].

% test di prova compatibilita licks
suonaIn(_,21).
suonaIn(Tonica,N) :-
  lick(N,Tonica,_),
  N1 is N+1,
  suonaIn(Tonica, N1).
suonaIn(Tonica) :- suonaIn(Tonica, 1).

% costruisce la lista degli indici relativi alla Tonica
% costruisci_indici(+IndiceTonica, +ListaIndici; -Res)
costruisci_indici(_,[],_).
costruisci_indici(_,[T|_],_) :- var(T).
costruisci_indici(IndiceTonica, [T|C], Res) :-
    NewIndice is IndiceTonica + T,
    Res = [NewIndice|NC],
    costruisci_indici(IndiceTonica, C, NC).

% costruisce le note a partire dagli indici costruiti prima
% costruisci_note(+ListaIndici, -Res)
costruisci_note([], _).
costruisci_note([T|C], Res) :-
    estensione_armonica_chitarra(EstensioneArmonica),
    nth0(T, EstensioneArmonica, Nota1),
    Res = [Nota1|NC],
    costruisci_note(C, NC).

% costruisce il lick a partire dalle note costruite prima
% costruisci_lick(+ListaNote, -Res)
costruisci_note2([],_).
costruisci_note2([T|C], Res) :-
    nota(T, InfoNota),
    Res = [InfoNota|NC],
    costruisci_note2(C, NC).

% costruisce il lick finale a partire dalle note ricavate
% costruisci_lick(+IndiceTonica, +ListaIndici, +ListaRitmi, -Lick)
costruisci_lick(_,_,[],_).
costruisci_lick(IndiceTonica, [T|C], [T2|C2], Lick) :-
    costruisci_indici(IndiceTonica, [T|C], R1),
    costruisci_note(R1, R2),
    costruisci_note2(R2,R3),
    costruisci_lick(R3, [T2|C2], Lick).

% costruisci_lick(+ListaFinale, +ListaRitmi, -Lick)
costruisci_lick([],[],_).
costruisci_lick([T1|C1], [T2|C2], Lick) :-
    Lick = [[T1,T2] | NC],
    costruisci_lick(C1, C2, NC).


% vari lick da 4/4 (note+tempo)
% lick(+Numero, +Tonica, -Lick)

lick(1, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[0,-2,-5,-6,-7,-9,-12],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    half],
    Lick),
  !.

lick(2, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[3,4,7,12,10,7,5,7,3,4,0,0],
    ['16th','16th','16th','16th','16th','16th','16th','16th',
    '16th','16th',quarter,pausa_eighth],
    Lick),
  !.

lick(3, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[7,7,12,12,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    half,pausa_quarter],
    Lick),
  !.

lick(4, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[12,10,7,6,5,3,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,half],
    Lick),
  !.

lick(5, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-12,-10,-9,-8,-5,-3,-5],
    [quarter,eighth,eighth,eighth,eighth,eighth,eighth],
    Lick),
  !.

lick(6, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[12,10,9,7,9,3,2,0,-3,-5],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    eighth,eighth,croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    eighth,eighth],
    Lick),
  !.

lick(7, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[7,6,5,0,3,4],
    [quarter,quarter,eighth,eighth,eighth,eighth],
    Lick),
  !.

lick(8, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[7,0,7,0,4,7,0,4],
    [eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth],
    Lick),
  !.

lick(9, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[0,4,0,2,5,0,3,6,0,4,7,0],
    [eighth,eighth,eighth,eighth,eighth,eighth,
    eighth,eighth,eighth,eighth,half,pausa_quarter],
    Lick),
  !.

lick(10, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-10,-7,-3,0,-1,2,5,8,7,5,2,3,4,12,0],
    [pausa_quarter,croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,
    pausa_quarter],
    Lick),
  !.

lick(11, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[0,12,9,5,2,11,2,5,8,7,5,2,3,4,-5,0],
    [pausa_eighth,eighth,croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,
    pausa_quarter],
    Lick),
  !.

lick(12, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-10,-8,-7,-3,0,4,2,0,-1,2,5,7,8,10,8,7,5,4,0,-5,-7-8,0,0],
    [eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,
    eighth,eighth,eighth,'16th','16th',eighth,eighth,quarter,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,eighth,eighth,
    pausa_quarter],
    Lick),
  !.

lick(13, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-10,-9,-7,-5,-4,-2,-1,3,2,0,-5,-9,-10,-12,0],
    [eighth,eighth,eighth,eighth,eighth,eighth,eighth,eighth,quarter,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,eighth,eighth,
    pausa_quarter],
    Lick),
  !.

lick(14, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[3,0,-2,0,-2,-5,-2,-5,-7,-5,-7,-9],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale],
    Lick),
  !.

lick(15, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-12,-9,-7,-5,-2,0,3,5,7,10,12,15,7],
    ['16th','16th','16th','16th',
    '16th','16th','16th','16th',
    '16th','16th','16th','16th',quarter],
    Lick),
  !.

lick(16, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[3,0,-5,3,0,-5,3,0,-5,3,0,-5],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale],
    Lick),
  !.

lick(17, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[0,0,9,7,6,5,3,2,0],
    [pausa_eighth,eighth,quarter,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale],
    Lick),
  !.

lick(18, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[6,7,12,10,7,6,5,3,0,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,quarter],
    Lick),
  !.

lick(19, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[15,12,7,3,0,-5,-5,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    quarter,pausa_quarter],
    Lick),
  !.

lick(20, Tonica, Lick) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[12,10,7,5,7,5,3,0],
    [quarter, croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    quarter],
    Lick),
  !.

turnaround(1,Tonica,Turn) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-5,4,-5,-6,3,-6,-7,2,-7,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    quarter],
    Turn),
  !.

turnaround(2,Tonica,Turn) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-2,0,4,-3,0,3,-5,0,2,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    quarter],
    Turn),
  !.

turnaround(3,Tonica,Turn) :-
  estensione_armonica_chitarra(X),
  indiceDi(X,Tonica,Indice),
  costruisci_lick(Indice,[-5,-2,4,-6,-3,3,-7,-4,2,0],
    [croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    croma_terzina_iniziale,croma_terzina,croma_terzina_finale,
    quarter],
    Turn),
  !.


assegna_punteggio(N,Punteggio) :-
  N = 1,
  Punteggio is 5.

assegna_punteggio(N,Punteggio) :-
  N = 2,
  Punteggio is 3.

assegna_punteggio(N,Punteggio) :-
  N > 2,
  Punteggio is 1.

fitness_function(Risultato) :-
  lick(1,g3,L),
  prendiritmo(L,Ritmi),
  conta_battute(Ritmi, NumBattute),
  assegna_punteggio(NumBattute,Num),
  Probabilita is Num/80,
  Risultato = [Probabilita | C],
  fitness_function(C,2).
fitness_function(_,21).
fitness_function(Risultato,N) :-
  N1 is N+1,
  lick(N,g3,L),
  prendiritmo(L,Ritmi),
  conta_battute(Ritmi, NumBattute),
  assegna_punteggio(NumBattute,Num),
  Probabilita is Num/80,
  Risultato = [Probabilita | C],
  fitness_function(C,N1).

% probabilità di scegliere un lick che abbia il numero di battute indicato
% 1 battuta --> 68.75%
% 2 battute --> 30.00%
% 3 battute --> 1.25%