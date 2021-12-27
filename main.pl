
%---------------------------------------------------------
%Domains
%Dia: integer
%Mes: integer
%Anio: integer
%FechaNueva: fecha
%Predicates
%fecha(Dia, Mes, Anio, FechaNueva).
%Goals
%Generar una fecha valida
%clauses
%Regla
fecha(Dia, Mes, Anio, FechaNueva):-
    integer(Dia), Dia > 0, Dia =< 31,
    integer(Mes), Mes > 0, Mes =< 12,
    integer(Anio), Anio > 0,
    FechaNueva = [Dia, Mes, Anio].


%Domains
%Dia: integer
%Mes: integer
%Anio: integer
%Predicates
%isFecha(Dia, Mes, Anio).
%Goals
%Verificar una fecha valida
%clauses
%Regla
isFecha([Dia, Mes, Anio]):-
    integer(Dia),
    integer(Mes),
    integer(Anio).

%Selectores
%Domains
%list: [Dia,Mes,Anio]
%ObtenElemntoAObtener: integer.
%Predicates
%getElemntoObtener([Dia, Mes, Anio], ObtenElemntoAObtener).
%Goals
%Selectores para dia, mes o año.
%clauses
%Regla
getDia([Dia, Mes, Anio], ObtenDia):-
    isFecha([Dia, Mes, Anio]),
    ObtenDia = Dia.
getMes([Dia,Mes,Anio],ObtenMes):-
    isFecha([Dia, Mes, Anio]),
    ObtenMes = Mes.
getAnio([Dia, Mes, Anio], ObtenAnio):-
    isFecha([Dia, Mes, Anio]),
    ObtenAnio = Anio.


%--------------------------------------------------------------------------
%TDA Usuario
%newUser(Username X Password X Fecha X IsActive X Users)
%Representacion newUser (string X string X fecha X integer X users)

%Constructor

%Domains
%Username:string
%Password: string
%Fecha: fecha
%Users: list
%Predicates
%newUser(Username, Password, Fecha, Users)
%Goals
%Crea un usuario nuevo, verifica sus datos y lo agrega a la lista de usuarios
%clauses
%Regla

newUser(Username, Password, Fecha, Users):-
    string(Username),
    string(Password),
    isFecha(Fecha),
    Users = [Username,Password,Fecha].

%Pertenencia

%Domains
%ListUser:list
%Predicates
%isUser([Username,Password,Fecha])
%Goals
%Verifica que la lista ingresada sea del tipo usuario.
%clauses
%Regla
isUser([Username,Password,Fecha]):-
     string(Username),
    string(Password),
    isFecha(Fecha).

%Selectores

%Domains
%ListUser:list
%ObtenUser: string o fecha
%Predicates
%getUsername([Username,Password,Fecha],ObtenUser)
%Goals
%Selectores obtienen los datos de la lista usuario ingresada
%clauses
%Regla
getUsername([Username,Password,Fecha],ObtenUser):-
    isUser([Username,Password,Fecha]),
    ObtenUser = Username.
getPassword([Username,Password,Fecha],ObtenPass):-
    isUser([Username,Password,Fecha]),
    ObtenPass = Password.
getFecha([Username,Password,Fecha],ObtenFecha):-
    isUser([Username,Password,Fecha]),
    ObtenFecha = Fecha.

%Modificadores
%Domains
%Sn1: ParadigmaDocs
%User: string
%Sn2: ParadigmaDocs
%Predicates
%insertActiveUser(Sn1,User,Sn2)
%Goals
%Agregar un usuario a la lista del user activo.
%clauses
%Regla
insertActiveUser(Sn1,User,Sn2):-
    getPlataformName(Sn1,Pname),
    getPlataformDate(Sn1,Pdate),
    getPlataformUsers(Sn1,Pusers),
    getPlataformDocs(Sn1,Pdocs),
    Sn2 = [Pname,Pdate,Pusers,Pdocs,[User]].






%-------------------------------------

%TDA ParadigmaDocs
%Name: nombre de la plataforma
%Date: Fecha de creación plataforma
%SOut: TDA resultante
/*
Representación
string X list X list x list
[Name,Date,Registrados,Documentos,Online]

*/
%Domains
%Name: string
%Date: Fecha
%SOut: ParadigmaDocs
%Predicates
%paradigmaDocs(Name,Date,SOut)
%Goals
%Crear una plataforma del tipo paradigmaDocs.
%clauses
%Regla
paradigmaDocs(Name,Date,SOut):-
    string(Name), 
    isFecha(Date), 
    SOut = [Name,Date,[],[],[]].


%Domains
%listParadigmaDocs: ParadigmaDocs
%Predicates
%isParadigmaDocs([NameP,DateP,[],[],[]])
%Goals
%Pertenencia, permite verificar si el dato ingresado es del tipo paradigmaDocs
%clauses
%Regla 
isParadigmaDocs([NameP,DateP,[],[],[]]):-
    string(NameP),
    isFecha(DateP).


%Domains
%listParadigmaDocs: ParadigmaDocs
%PdatoConseguir: depende del dato a conseguir,
%Predicates
%getPlataformData([NameP,DateP,[],[],[]],Pdata).
%Goals
%Selectores, obtiene datos especificos del paradigmaDocs
%clauses
%Regla 


%nombre plataforma
getPlataformName([NameP,DateP,_,_,_],Pname):-
    isParadigmaDocs([NameP,DateP,_,_,_]),
    Pname = NameP.
%fecha creación plataforma
getPlataformDate([NameP,DateP,_,_,_],Pdate):-
    isParadigmaDocs([NameP,DateP,_,_,_]),
    Pdate = DateP.
%Obtiene los usuarios registrados
getPlataformUsers([NameP,DateP,UsersP,_,_],Pusers):-
    isParadigmaDocs([NameP,DateP,_,_,_]),
    Pusers = UsersP.
%Obtiene los documentos
getPlataformDocs([NameP,DateP,_,DocsP,_],Pdocs):-
    isParadigmaDocs([NameP,DateP,_,_,_]),
    Pdocs = DocsP.
%Obtiene el usuario activo.
getPlataformActiveUsr([NameP,DateP,_,_,ActiveP],PActive):-
    isParadigmaDocs([NameP,DateP,_,_,_]),
    PActive = ActiveP.



%Creacion de predicados
%---------Register----------------------------------------------

%Domains
%userList: list
%Username: string
%Predicates
%searchUsername([_|Cdr], Username).
%Goals
%Predicado que busca usuario entre los registrados en paradigmaDocs
%clauses
%Regla 

searchUsername([], _) :- fail, !.
searchUsername([Car|_], Username) :-
    isUser(Car), 
    getUsername(Car, User), 
    Username == User, !.
searchUsername([_|Cdr], Username) :-
    searchUsername(Cdr, Username).



%Domains
%Pdocs: ParadigmaDocs
%Username: string
%Predicates
%existeUsuario(Pdocs, Username).
%Goals
%verifica que el usuario no exista.
%clauses
%Regla 

existeUsuario(Pdocs, Username) :-
    isParadigmaDocs(Pdocs), 
    getUsername(Pdocs, Users), 
    searchUsername(Users, Username).

%Domains
%Sn1: ParadigmaDocs
%Fecha: fecha
%Username: string
%Password: string
%Sn2: ParadigmaDocs
%Predicates
%paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2) .
%Goals
%Registra un usuario en paradigmaDocs.
%clauses
%Regla 
paradigmaDocsRegister(Sn1, Fecha, Username, Password, Sn2) :-
    %------------------Verificadores 
    isParadigmaDocs(Sn1), 
    isFecha(Fecha), 
    string(Username), 
    string(Password), 
    not(existeUsuario(Sn1, Username)), 
    %------------------
    newUser(Username, Password, Fecha, NewUser),
    getPlataformUsers(Sn1, PaUsers), 
    append([NewUser], PaUsers, NuevosUsuarios), 
    getPlataformName(Sn1, PlataformName),
    getPlataformDocs(Sn1,PlataformDocs), 
    getPlataformDate(Sn1, DatePlataform),
    getPlataformActiveUsr(Sn1,ActiveUsrPlataform),
    Sn2 = [PlataformName, DatePlataform, NuevosUsuarios,PlataformDocs,ActiveUsrPlataform].



%----------------------------------------------------------
%-----------------Login------------------------------------

%Domains
%regisersUsers: list
%Username: string
%Password: string
%Predicates
%isRegister([Cabeza|_], Username, Password).
%Goals
% verifica si el usuario esta registrado.
%clauses
%Regla 

isRegister([Cabeza|_], Username, Password) :-
    getUsername(Cabeza, User), 
    getPassword(Cabeza, Pass),
    User=Username,
    Pass=Password,!.

isRegister([_|Cola], Username, Password) :-
    isRegister(Cola, Username, Password).

%Domains
%Sn1: ParadigmaDocs
%Predicates
%notLogin(Sn1).
%Goals
% verifica que la lista de online esté vacia.
%clauses
%Regla 

notLogin(Sn1):-
    getPlataformActiveUsr(Sn1,Active),
    [] = Active.


%Domains
%Sn1: ParadigmaDocs
%User: string
%Password: string
%Sn2: ParadigmaDocs
%Predicates
%paradigmaDocsLogin(Sn1,User,Password,Sn2).
%Goals
% Inicia sesion en paradigmaDocs.
%clauses
%Regla 
paradigmaDocsLogin(Sn1,User,Password,Sn2):-
    isParadigmaDocs(Sn1), 
    getPlataformUsers(Sn1,RegUsers),
    isRegister(RegUsers,User,Password),
    notLogin(Sn1),
    insertActiveUser(Sn1,User,Sn2).



/*

EJEMPLOS


Registro de "driques".
-fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister).
Login de "driques", se logea con exito.
-fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2).
Login errado.
-fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsLogin(Sn2,"driques","1234",Sn3).

*/