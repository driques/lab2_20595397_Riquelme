%test
%TDA Fecha
%Representacion fecha(integer, integer, integer, TDA Fecha).
%Funcion constructora de fecha
%Dom: int x int x int x TDA Fecha
fecha(Dia, Mes, Anio, FechaNueva):-
    integer(Dia), Dia > 0, Dia =< 31,
    integer(Mes), Mes > 0, Mes =< 12,
    integer(Anio), Anio > 0,
    FechaNueva = [Dia, Mes, Anio].


%Pertenencia
%Funcion verifica tipo de dato fecha
%Dom: int x int x int 
isFecha([Dia, Mes, Anio]):-
    integer(Dia),
    integer(Mes),
    integer(Anio).

%Selectores
%Permite obtener un dato de Fecha, misma def para los 3.
%Dom: int x int x int
getDia([Dia, Mes, Anio], ObtenDia):-
    isFecha([Dia, Mes, Anio]),
    ObtenDia = Dia.
getDia([Dia,Mes,Anio],ObtenDia):-
    isFecha([Dia, Mes, Anio]),
    ObtenDia = Mes.
getDia([Dia, Mes, Anio], ObtenDia):-
    isFecha([Dia, Mes, Anio]),
    ObtenDia = Anio.


%--------------------------------------------------------------------------
%TDA Usuario
%newUser(Username X Password X Fecha X IsActive X Users)
%Representacion newUser (string X string X fecha X integer X users)
%0 es activo, 1 es activo.
%Constructor
%Crea un usuario nuevo, verifica sus datos y lo agrega a la lista de usuarios
%Dom: string X string X fecha X bool X users
newUser(Username, Password, Fecha, Users):-
    string(Username),
    string(Password),
    isFecha(Fecha),
    Users = [Username,Password,Fecha,0].

%Pertenencia
%Verifica que la lista ingresada sea del tipo usuario.
%Dom: list
isUser([Username,Password,Fecha,Active]):-
     string(Username),
    string(Password),
    isFecha(Fecha),
    integer(Active).

%Selectores
%Obtiene los datos de la lista usuario ingresada
%Dom: list X dato
getUsername([Username,Password,Fecha,Active],ObtenUser):-
    isUser([Username,Password,Fecha,Active]),
    ObtenUser = Username.
getPassword([Username,Password,Fecha,Active],ObtenPass):-
    isUser([Username,Password,Fecha,Active]),
    ObtenPass = Password.
getFecha([Username,Password,Fecha,Active],ObtenFecha):-
    isUser([Username,Password,Fecha,Active]),
    ObtenFecha = Fecha.
getActive([Username,Password,Fecha,Active],ObtenActive):-
    isUser([Username,Password,Fecha,Active]),
    ObtenActive = Active.

%Modificadores
%Deja a un usuario activo
%Dom: list X ModUser
online([Username,Password,Fecha,Active],ActUser):-
    isUser([Username,Password,Fecha,Active]),
    getUsername([Username,Password,Fecha,Active],OfflineUser),
    getUserPassword([Username,Password,Fecha,Active],Pass),
    getFecha([Username,Password,Fecha,Active],FechaCreate),
    ActUser = [OfflineUser,Pass,FechaCreate,1].



%Deja a un usuario inactivo
%Dom: list X ModUser
offline([Username,Password,Fecha,Active],OffUser):-
    isUser([Username,Password,Fecha,Active]),
    getUsername([Username,Password,Fecha,Active],OfflineUser),
    getUserPassword([Username,Password,Fecha,Active],Pass),
    getFecha([Username,Password,Fecha,Active],FechaCreate),
    OffUser = [OfflineUser,Pass,FechaCreate,0].
addUser(ListaUser,UserToAdd,NewListUsers):-
    append([UserToAdd],ListaUser,NewListUsers).

%TDA ParadigmaDocs
%Name: nombre de la plataforma
%Date: Fecha de creación plataforma
%SOut: TDA resultante
/*
Representación
string X list X list x list
[Name,Date, Registrados,Documentos]

*/

paradigmaDocs(Name,Date,SOut):-
    string(Name), 
    isFecha(Date), 
    SOut = [Name,Date,[],[]].
%Pertenencia, permite verificar si el dato ingresado es del tipo paradigmaDocs
%Dom: list 
isParadigmaDocs([NameP,DateP,[],[]]):-
    string(NameP),
    isFecha(DateP).
%Selectores
%Obtiene datos especificos del paradigmaDocs
%nombre plataforma
getPlataformName([NameP,DateP,_,_],Pname):-
    isParadigmaDocs([NameP,DateP,_,_]),
    Pname = NameP.
%fecha creación plataforma
getPlataformDate([NameP,DateP,_,_],Pdate):-
    isParadigmaDocs([NameP,DateP,_,_]),
    Pdate = DateP.
%Obtiene los usuarios registrados
getPlataformUsers([NameP,DateP,UsersP,_],Pusers):-
    isParadigmaDocs([NameP,DateP,_,_]),
    Pusers = UsersP.
%Obtiene los documentos
getPlataformDocs([NameP,DateP,_,DocsP],Pdocs):-
    isParadigmaDocs([NameP,DateP,_,_]),
    Pdocs = DocsP.


%Creacion de predicados
%---------Register----------------------------------------------
%Predicado que busca usuario entre los registrados en paradigmaDocs
searchUsername([], _) :- fail, !.
searchUsername([Car|_], Username) :-
    isUser(Car), getUsername(Car, User), 
    Username == User, !.
searchUsername([_|Cdr], Username) :-
    searchUsername(Cdr, Username).

%Objetivo: verifica que el usuario no exista.
%Dominio: Pdocs, string
%Recorrido: si el usuario existe retorna true, si no, false

existeUsuario(Pdocs, Username) :-
    isParadigmaDocs(Pdocs), 
    getUsername(Pdocs, Users), 
    searchUsername(Users, Username).

%Objetivo: 
%Dominio: Pdocs x fecha x string x string x Pdocs2
%Recorrido: 
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
    getDateSN(Sn1, DatePlataform),
    Sn2 = [PlataformName, DatePlataform, NuevosUsuarios,PlataformDocs].



%----------------------------------------------------------
%-----------------Login------------------------------------


paradigmaDocsLogin(Sn1,User,Password,sn2):-
    getPlataformUsers(Sn1,PlataformUsersList),
/*Me falta verificar que el usuario no esté loggeado, que exista,
que la contrasenia sea correcta */    






%******* Login (predicados a usar)



%Objetivo: obtiene un usuario en específico de las listas de usuarios de socialnetwork
%Dominio: string, list, variable vacía
%Recorrido: si esta, retorna el usuario consultado, si no, retorna false
obtenerUsuario(Username, [Cabeza|_], Resultado) :-
    getUsername(Cabeza, User), Username = User, Resultado = Cabeza, !.
obtenerUsuario(Username, [_|Cola], Resultado) :-
    obtenerUsuario(Username, Cola, Resultado).

%Objetivo: verifica si el usuario esta registrado en la socialnetwork
%Dominio: list, string, string
%Recorrido: true o false
estaUsuarioRegistrado([Cabeza|_], Username, Password) :-
    getUsername(Cabeza, User), getUserPassword(Cabeza, Pass), Username = User, Password = Pass, !.
estaUsuarioRegistrado([_|Cola], Username, Password) :-
    estaUsuarioRegistrado(Cola, Username, Password).

%Objetivo: verificar si hay un usuario con sesión activa
%Dominio: list
%Recorrido: booleano (true o false)
estaUsuarioSesionActiva([Listado_Usuarios | _]) :-
    getUserSesion(Listado_Usuarios, User_Sesion), User_Sesion = "ACTIVA".
