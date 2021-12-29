
%---------------------------------------------------------
%TDA Fecha
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
isParadigmaDocs([NameP,DateP,_,_,_]):-
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


%-------------------------------------------------------
%TDA Docs
%Representacion
%createDoc(fecha X string X string X string X doc)
%Returns
%[idDoc, idVer,Nombre,Contenido,propietario,shareList]
%Constructor
%Domains
%Predicates
%createDoc(Fecha,Nombre,Content,Owner,NewDoc)
%Goals
%Crea un nuevo documento.
%clauses
%Regla


createDoc(IdDoc,Fecha,Nombre,Content,Owner,NewDoc):-
    NewDoc = [IdDoc,1,Fecha,Nombre,Content,Owner,[]].

%-----------------Pertenencia--------------
%Domains
%listDoc: doc
%Predicates
%isDoc([idDoc,idVer,Fecha,Nombre,Content,Owner,_]).
%Goals
%Pertenencia, permite verificar si el dato ingresado es del tipo Doc.
%clauses
%Regla 

isDoc([IdDoc,IdVer,Fecha,Nombre,Content,[Owner|_],_]):-
    integer(IdDoc),
    integer(IdVer),
    isFecha(Fecha),
    string(Nombre),
    string(Content),
    string(Owner).

%----------------Selectores----------------------
%Domains
%list: doc
%GetID: integer
%Predicates
%getIDdoc([listDoc],GetID]).
%Goals
% Obtener el id del ultimo doc creado.
%clauses
%Regla 

getIDdoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner,_],GetID):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner,_]),
    GetID = IdDoc.
%Domains
%list: doc
%GetOwner: list
%Predicates
%getOwnerDoc([listDoc],GetOwner).
%Goals
% Obtener el dueño del doc entregado.
%clauses
%Regla 

getOwnerDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner,_],GetOwner):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner,_]),
    GetOwner = Owner.




%Domains
%list: docs
%GetOwner: list
%Id: integer
%Predicates
%getDocOwnerByID([listDoc],GetOwner,Id).
%Goals
% Obtener el dueño del doc entregando el id.
%clauses
%Regla 

getDocOwnerByID([],_,_):- fail,!.
getDocOwnerByID([Car|_],GetOwner,Id):-
    isDoc(Car),
    getIDdoc(Car,IdDoc),
    IdDoc=Id,
    getOwnerDoc(Car,GetOwner),!.
getDocOwnerByID([_|Cdr],GetOwner,Id):-
    getDocOwnerByID(Cdr,GetOwner,Id).




%Domains
%list: doc
%GetterID: integer
%Predicates
%getNewID([listDoc],GetID]).
%Goals
% Genera un nuevo ID para la creación de un doc.
%clauses
%Regla

getNewID([], GetterID) :- 
    GetterID is 1.
getNewID([Car|_], GetterID) :-
    isDoc(Car), 
    getIDdoc(Car, ID), 
    GetterID is ID+1.


%---------------Funciones extras-------------------------------


%ListaPermisos = ["W","R","C"] <- o variaciones
%ListaUsernamesPermitidos = ["Pepito","Juan"]
%Salida = [[IdDoc,userName,[Permisos]],[IdDoc,userName,[Permisos]]]

%Domains
%list: list
%ListaPermisos: list
%DocId: integer
%Share: list
%Predicates
%otorgaPermisos([UserPermitido|_],ListaPermisos,DocId,Share)
%Goals
%Otorgar permisos a un conjunto de usuarios.
%clauses
%Regla 

otorgaPermisos([],_,_,_):- !.

otorgaPermisos([UserPermitido|_],ListaPermisos,DocId,Share):-
    append([DocId],[UserPermitido],SiguienteList),
    append(SiguienteList,[ListaPermisos],Share).


otorgaPermisos([_|SiguientesUsers],ListaPermisos,DocId,Share):-
    otorgaPermisos(SiguientesUsers,ListaPermisos,DocId,Share).


%Domains
%ListaUsernamesPermitidos: list
%ListaPermisos: list
%DocId: integer
%Share: list
%ReturnList: list
%Predicates
%creaListaShare(ListaUsernamesPermitidos,ListaPermisos,DocId,Share,ReturnList)
%Goals
%Encapsular la función otorgaPermisos para poder ejecutar findall y rellenar la lista
%clauses
%Regla 

creaListaShare(ListaUsernamesPermitidos,ListaPermisos,DocId,Share,ReturnList):-
    findall(Share,otorgaPermisos(ListaUsernamesPermitidos,ListaPermisos,DocId,Share),ReturnList).


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


%UsersRegister = [["manolo", "1234", [1, 2, 2021]], ["driques", "1234", [1, 2, 2021]]].
%ListaUsernamesPermitidos = ["driques","juan"].
%Domains
%UsuariosRegistrados: list
%ListaUsernamesPermitidos: list
%Predicates
%existenUsernames(UsuariosRegistrados,[User|Cdr])
%Goals
%Busca la existencia de un conjunto de usuarios entre un conjunto de registrados
%clauses
%Regla 
existenUsernames(_,[]):-!.

existenUsernames(UsuariosRegistrados,[User|Cdr]):-
    searchUsername(UsuariosRegistrados,User),
    existenUsernames(UsuariosRegistrados,Cdr).



%-------------------------------------------------------

%Creacion de predicados
%---------Register----------------------------------------------




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
%isRegister([Car|_], Username, Password).
%Goals
% verifica si el usuario esta registrado.
%clauses
%Regla 

isRegister([Car|_], Username, Password) :-
    getUsername(Car, User), 
    getPassword(Car, Pass),
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

%----------------------------------------------------------
%-----------------Create------------------------------------
%Domains
%Sn1: ParadigmaDocs
%Fecha: fecha
%Nombre: string
%Contenido: string
%Sn2: ParadigmaDocs
%Predicates
%paradigmaDocsCreate(Sn1,Fecha,Nombre,Contenido,Sn2).
%Goals
% Crea un documento en Sn2 si es que se cumplen las clausulas necesarias.
%clauses
%Regla 
paradigmaDocsCreate(Sn1,Fecha,Nombre,Contenido,Sn2):-
    not(notLogin(Sn1)),
    getPlataformActiveUsr(Sn1,ActiveUsr),
    isFecha(Fecha),
    string(Nombre),
    string(Contenido),
    getPlataformDocs(Sn1,Docs),
    getNewID(Docs,IdDoc),
    createDoc(IdDoc,Fecha,Nombre,Contenido,ActiveUsr,NewDoc),
    append([NewDoc],Docs,ListDocs),
    getPlataformUsers(Sn1, PaUsers),
    getPlataformName(Sn1, PlataformName),
    getPlataformDate(Sn1, DatePlataform),
    Sn2 = [PlataformName, DatePlataform, PaUsers,ListDocs,[]]. 
%----------------------------------------------------------
%-----------------Share------------------------------------
%Que haya una sesion iniciada
%Que los usuarios a los cuales se comparten esten registrados
%Verificar que sea el propietario
%ListaPermisos = ["W","R","C"] <- o variaciones
%ListaUsernamesPermitidos = ["Pepito","Juan"]
%Salida = [[IdDoc,userName,[Permisos]],[IdDoc,userName,[Permisos]]]
paradigmaDocsShare(Sn1, DocId,ListaPermisos,ListaUsernamesPermitidos,Sn2):-
    getPlataformActiveUsr(Sn1,ActiveUsr),
    getPlataformDocs(Sn1,Docs),
    getDocOwnerByID(Docs,Owner,DocId),
    ActiveUsr = Owner,
    getPlataformUsers(Sn1, PaUsers),
    existenUsernames(PaUsers,ListaUsernamesPermitidos),
    creaListaShare(ListaUsernamesPermitidos,ListaPermisos,DocId,_,ListaShare),
    %-------Ahora se arma Sn2
    getPlataformDocs(Sn1,Pldocs),
    getPlataformName(Sn1, PlataformName),
    getPlataformDate(Sn1, DatePlataform),
    Sn2 = [PlataformName, DatePlataform, PaUsers,Pldocs,ListaShare]. 
    
    



%----------------------------------------------------------------------------


/*

EJEMPLOS


--------------------------------------------------Registro de "driques"-------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister).
----------------------------------------------Login de "driques", se logea con exito-----------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2).
-------------------------------------------------------Login errado------------------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsLogin(Sn2,"driques","1234",Sn3).
---------------------------------------------------Crea nuevo Doc----------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),
paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),
paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),
paradigmaDocsLogin(DocOut,"manolo","1234",Login2),paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut).
--------------------------------------------------Comparte doc 1 Errado porque ni pepito ni juan existen----------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["Pepito","Juan"],Snfinal).
--------------------------------------------------Comparte doc 1 Bueno----------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal).
*/








%------------------------------Funciones y recordatorios personales--------------------------------------

/*
set_prolog_flag(answer_write_options,
                   [ quoted(true),
                     portray(true),
                     spacing(next_argument)
                   ]).*/

%Objetivo: elimina un elemento de una lista
myDeleteElemList(Dato, [Dato|Cdr], Cdr):- !.
myDeleteElemList(Dato, [Car|Cdr], [Car|Resultado]) :-
    myDeleteElemList(Dato, Cdr, Resultado).
