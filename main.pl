
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

%Selectores
%Domains
%Fecha: fecha
%StrFecha: string.
%Predicates
%fechaToString(Fecha,StrFecha).
%Goals
%Convertir un dato tipo fecha a string.
%clauses
%Regla 

fechaToString(Fecha,StrFecha):-
    
    getDia(Fecha,Dia),
    string_concat("La fecha del documento es: ",Dia,FS),
    getMes(Fecha,Mes),
    string_concat(FS," del ",FS1),
    string_concat(FS1,Mes,FS2),
    string_concat(FS2," del ",FS3),    
    getAnio(Fecha,Anio),
    string_concat(FS3,Anio,FS4),
    string_concat(FS4,"\n",StrFecha).


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
    getPlatformName(Sn1,Pname),
    getPlatformDate(Sn1,Pdate),
    getPlatformUsers(Sn1,Pusers),
    getPlatformDocs(Sn1,Pdocs),
    getPlatformDocsVer(Sn1,PDocsVersions),
    getPlatformShare(Sn1,ShareList),
    Sn2 = [Pname,Pdate,Pusers,Pdocs,[User],ShareList,PDocsVersions].






%-------------------------------------

%TDA ParadigmaDocs
%Name: nombre de la Platforma
%Date: Fecha de creación Platforma
%SOut: TDA resultante
/*
Representación
string X list X list x list
[Name,Date,Registrados,Documentos,Online,Share,DocVersions]

*/
%Domains
%Name: string
%Date: Fecha
%SOut: ParadigmaDocs
%Predicates
%paradigmaDocs(Name,Date,SOut)
%Goals
%Crear una Platforma del tipo paradigmaDocs.
%clauses
%Regla
paradigmaDocs(Name,Date,SOut):-
    string(Name), 
    isFecha(Date), 
    SOut = [Name,Date,[],[],[],[],[]].


%Domains
%listParadigmaDocs: ParadigmaDocs
%Predicates
%isParadigmaDocs([NameP,DateP,[],[],[],[]])
%Goals
%Pertenencia, permite verificar si el dato ingresado es del tipo paradigmaDocs
%clauses
%Regla 
isParadigmaDocs([NameP,DateP,_,_,_,_,_]):-
    string(NameP),
    isFecha(DateP).


%Domains
%listParadigmaDocs: ParadigmaDocs
%PdatoConseguir: depende del dato a conseguir,
%Predicates
%getPlatformData([NameP,DateP,[],[],[],[],[]],Pdata).
%Goals
%Selectores, obtiene datos especificos del paradigmaDocs
%clauses
%Regla 


%nombre Platforma
getPlatformName([NameP,DateP,_,_,_,_,_],Pname):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    Pname = NameP.
%fecha creación Platforma
getPlatformDate([NameP,DateP,_,_,_,_,_],Pdate):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    Pdate = DateP.
%Obtiene los usuarios registrados
getPlatformUsers([NameP,DateP,UsersP,_,_,_,_],Pusers):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    Pusers = UsersP.
%Obtiene los documentos
getPlatformDocs([NameP,DateP,_,DocsP,_,_,_],Pdocs):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    Pdocs = DocsP.
%Obtiene el usuario activo.
getPlatformActiveUsr([NameP,DateP,_,_,ActiveP,_,_],PActive):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    PActive = ActiveP.
%Obtiene los documentos compartidos.
getPlatformShare([NameP,DateP,_,_,_,ShareList,_],Pshare):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    Pshare = ShareList.  
%Obtiene el historial de documentos.
getPlatformDocsVer([NameP,DateP,_,_,_,_,DocsVersions],PDocsVersions):-
    isParadigmaDocs([NameP,DateP,_,_,_,_,_]),
    PDocsVersions = DocsVersions.



%-------------------------------------------------------
%TDA Docs
%Representacion
%createDoc(fecha X string X string X string X doc)
%Returns
%[idDoc, idVer,Nombre,Contenido,propietario]
%Constructor
%Domains
%Predicates
%createDoc(Fecha,Nombre,Content,Owner,NewDoc)
%Goals
%Crea un nuevo documento.
%clauses
%Regla


createDoc(IdDoc,Fecha,Nombre,Content,Owner,NewDoc):-
    NewDoc = [IdDoc,1,Fecha,Nombre,Content,Owner].

%-----------------Pertenencia--------------
%Domains
%listDoc: doc
%Predicates
%isDoc([idDoc,idVer,Fecha,Nombre,Content,Owner]).
%Goals
%Pertenencia, permite verificar si el dato ingresado es del tipo Doc.
%clauses
%Regla 

isDoc([IdDoc,IdVer,Fecha,Nombre,Content,[Owner|_]]):-
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
%getALGOdoc([listDoc],GetID]).
%Goals
% Obtener el elemento que se busca del doc.
%clauses
%Regla 

%Obtiene ID doc
getIDdoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner],GetID):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner]),
    GetID = IdDoc.
%Obtiene ID ver
getIDVer([IdDoc,IdVer,Fecha,Nombre,Content,Owner],GetVer):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner]),
    GetVer = IdVer.
%Obtiene fecha doc
getFechaDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner],GetDateDoc):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner]),
    GetDateDoc = Fecha.

%Obtiene Nombre doc
getNombreDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner],GetNombreDoc):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner]),
    GetNombreDoc = Nombre.

%Obtiene contenido doc
getContentDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner],GetContent):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner]),
    GetContent = Content.


%Domains
%list: doc
%GetOwner: list
%Predicates
%getOwnerDoc([listDoc],GetOwner).
%Goals
% Obtener el dueño del doc entregado.
%clauses
%Regla 

getOwnerDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner],GetOwner):-
    isDoc([IdDoc,IdVer,Fecha,Nombre,Content,Owner]),
    GetOwner = Owner.


getDocumentsByOwner([],_,_):- !.

getDocumentsByOwner([Car|_],Owner,DocOwner):-
    isDoc(Car),
    getOwnerDoc(Car,POwner),
    Owner = POwner,
    DocOwner = Car.


getDocumentsByOwner([_|Cdr],Owner,DocOwner):-
    getDocumentsByOwner(Cdr,Owner,DocOwner).


getAllDocsByOwner(Docs,Owner,DocOwnerList):-
    findall(DocOwner,getDocumentsByOwner(Docs,Owner,DocOwner),DocOwnerList).


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
    getOwnerDoc(Car,GetOwner).

getDocOwnerByID([_|Cdr],GetOwner,Id):-
    getDocOwnerByID(Cdr,GetOwner,Id).


getDocOwnerByID1([],_,_):- fail,!.

getDocOwnerByID1([Car|_],GetOwner,Id):-
    isDoc(Car),
    getIDdoc(Car,IdDoc),
    IdDoc=Id,
    getOwnerDoc(Car,GetOwner),!.

getDocOwnerByID1([_|Cdr],GetOwner,Id):-
    getDocOwnerByID1(Cdr,GetOwner,Id).


%Domains
%list: docs
%IdDoc: list
%Predicates
%getListId([],IdDoc).
%Goals
% Obtener los id de los documentos
%clauses
%Regla 

getListId([],_):-!.

getListId([Doc|_],IdDoc):-
    getIDdoc(Doc,IdDoc).

getListId([_|CarDoc],IdDoc):-
    getListId(CarDoc,IdDoc).

%Domains
%ListDocs: list
%ListID: list
%Predicates
%getFinalListId(ListDocs,ListID).
%Goals
% Obtener los id de los documentos en una lista
%clauses
%Regla 
getFinalListId(ListDocs,ListID):-
    findall(Ids,getListId(ListDocs,Ids),ListID).



%Domains
%ListDocs: list
%Result: integer
%Predicates
%getMaxId([Doc1|Cdr], Result).
%Goals
% Obtener el max id de la lista.
%clauses
%Regla 
getMaxId([Doc],Doc):-!.
getMaxId([Doc1|Cdr], Result) :-
    getMaxId(Cdr,Doc2),
    ( Doc1 >= Doc2, Result=Doc1 ;
      Result=Doc2), !.




%Domains
%Dato: dato
%list: list
%Resultado : dato
%Predicates
%myDeleteElemList(Dato, list, Resultado).
%Goals
% elimina un elemento de una lista
%clauses
%Regla 
myDeleteElemList(Dato, [Dato|Cdr], Cdr):- !.
myDeleteElemList(Dato, [Car|Cdr], [Car|Resultado]) :-
    myDeleteElemList(Dato, Cdr, Resultado).

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
    GetterID is 1,!.
getNewID(Docs, GetterID) :-
    getFinalListId(Docs,ListId),
    reverse(ListId,ReverseListId),
    myDeleteElemList(_,ReverseListId,NewListId),
    getMaxId(NewListId,MaxId),
    GetterID is MaxId+1,!.



%Domains
%list: doc
%ID: integer
%DocById: doc
%Predicates
%getDocsByID(Documents,ID,DocById).
%Goals
%Obtiene un doc especificos a partir de un ID.
%clauses
%Regla
getDocsByID([],_,_):-fail,!.

getDocsByID([Doc|_],ID,DocById):-
    getIDdoc(Doc,DocID),
    DocID = ID,
    DocById = Doc.

getDocsByID([_|CdrDoc],ID,DocById):-
    getDocsByID(CdrDoc,ID,DocById).


%---------------Predicados extras-------------------------------
%Domains
%Doc: doc
%Text: string
%Date: Fecha
%DocText: doc
%Predicates
%insertText(Doc,Text,Date,DocText).
%Goals
%Agrega texto al contenido de un doc.
%clauses
%Regla


insertText(Doc,Text,Date,DocText):-
    isDoc(Doc),
    getIDdoc(Doc,IdDoc),
    getIDVer(Doc,IdVer),
    (IdVerNew is IdVer + 1),
    getNombreDoc(Doc,NombreDoc),
    getContentDoc(Doc,ContentDoc),
    getOwnerDoc(Doc,OwnerDoc),
    string_concat(ContentDoc,Text,NewContent),
    DocText = [IdDoc,IdVerNew,Date,NombreDoc,NewContent,OwnerDoc].



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
%Encapsular la predicado otorgaPermisos para poder ejecutar findall y rellenar la lista
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
    getPlatformUsers(Pdocs, Users), 
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
    getPlatformUsers(Sn1, PaUsers), 
    append([NewUser], PaUsers, NuevosUsuarios), 
    getPlatformName(Sn1, PlatformName),
    getPlatformDocs(Sn1,PlatformDocs), 
    getPlatformDate(Sn1, DatePlatform),
    getPlatformActiveUsr(Sn1,ActiveUsrPlatform),
    getPlatformShare(Sn1,ShareList),
    getPlatformDocsVer(Sn1,DocsVersions),
    Sn2 = [PlatformName, DatePlatform, NuevosUsuarios,PlatformDocs,ActiveUsrPlatform,ShareList,DocsVersions].



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
    getPlatformActiveUsr(Sn1,Active),
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
    getPlatformUsers(Sn1,RegUsers),
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
    getPlatformActiveUsr(Sn1,ActiveUsr),
    isFecha(Fecha),
    string(Nombre),
    string(Contenido),
    getPlatformDocs(Sn1,Docs),
    getNewID(Docs,IdDoc),
    createDoc(IdDoc,Fecha,Nombre,Contenido,ActiveUsr,NewDoc),
    append([NewDoc],Docs,ListDocs),
    getPlatformUsers(Sn1, PaUsers),
    getPlatformName(Sn1, PlatformName),
    getPlatformDate(Sn1, DatePlatform),
    getPlatformShare(Sn1,ShareList),
    getPlatformDocsVer(Sn1,DocsVersions),
    Sn2 = [PlatformName, DatePlatform, PaUsers,ListDocs,[],ShareList,DocsVersions]. 
%----------------------------------------------------------
%-----------------Share------------------------------------
%Que haya una sesion iniciada
%Que los usuarios a los cuales se comparten esten registrados
%Verificar que sea el propietario
%ListaPermisos = ["W","R","C"] <- o variaciones
%ListaUsernamesPermitidos = ["Pepito","Juan"]
%Salida = [[IdDoc,userName,[Permisos]],[IdDoc,userName,[Permisos]]]
paradigmaDocsShare(Sn1, DocId,ListaPermisos,ListaUsernamesPermitidos,Sn2):-
    not(notLogin(Sn1)),
    getPlatformActiveUsr(Sn1,ActiveUsr),
    getPlatformDocs(Sn1,Docs),
    getDocOwnerByID(Docs,Owner,DocId),
    ActiveUsr = Owner,
    getPlatformUsers(Sn1, PaUsers),
    existenUsernames(PaUsers,ListaUsernamesPermitidos),
    creaListaShare(ListaUsernamesPermitidos,ListaPermisos,DocId,_,ListaShare),
    %-------Ahora se arma Sn2
    getPlatformDocs(Sn1,Pldocs),
    getPlatformName(Sn1, PlatformName),
    getPlatformDate(Sn1, DatePlatform),
    getPlatformDocsVer(Sn1,DocsVersions),
    getPlatformShare(Sn1,SharePlatform),
    append(ListaShare,SharePlatform,FinalShare),
    Sn2 = [PlatformName, DatePlatform, PaUsers,Pldocs,[],FinalShare,DocsVersions],!. 
    
   

%---------------Pertenencia-----------------------------------
%Domains
%list: share
%Predicates
%isShare([ID,User,PermissionList]).
%Goals
% verifica que una lista sea de tipo share.
%clauses
%Regla 
isShare([ID,User,PermissionList]):-
    integer(ID),
    string(User),
    is_list(PermissionList).


%--------SelectoresShare-----------------------------------------------
%Domains
%list: share
%ShareDato: dato
%Predicates
%getShareDato([ID,User,PermissionList],ShareDato).
%Goals
%Selecciona un dato especifico de la lista share.
%clauses
%Regla 
getShareID([ID,User,PermissionList],ShareId):-
    isShare([ID,User,PermissionList]),
    ShareId = ID.

getShareUsr([ID,User,PermissionList],ShareUsr):-
    isShare([ID,User,PermissionList]),
    ShareUsr = User.

getSharePermissionList([ID,User,PermissionList],SharePermissionList):-
    isShare([ID,User,PermissionList]),
    SharePermissionList = PermissionList.

%----------------------------------------------------------------------------
%-------------------------------------Add------------------------------------


%Domains
%list: usr
%ShareList: list
%MyId: integer
%Predicates
%writePermission(User,ShareList,MyId).
%Goals
%Pregunta si un usr tiene permiso de escritura.
%clauses
%Regla 
writePermission(_,[],_):- fail,!.

writePermission([User|_],[ShareList|_],MyId):-
    isShare(ShareList),
    getShareUsr(ShareList,ShareUsr),
    getShareID(ShareList,ShareID),
    ShareID = MyId,
    User = ShareUsr,
    getSharePermissionList(ShareList,Permissions),
    member("W",Permissions).


writePermission(User,[_|CdrShareList],MyId):-
    writePermission(User,CdrShareList,MyId).
    
%Domains
%Sn1: Platform
%DocId: integer
%Predicates
%isOwner(Sn1,DocId).
%Goals
%Pregunta si un usr es propietario de un doc.
%clauses
%Regla 

isOwner(Sn1,DocId):-
    getPlatformActiveUsr(Sn1,ActiveUsr),
    getPlatformDocs(Sn1,Docs),
    getDocOwnerByID(Docs,Owner,DocId),
    ActiveUsr = Owner.

%Domains
%Sn1: Platform
%DocId: integer
%Predicates
%isWriteP(Sn1,DocId).
%Goals
%Inicializa writePermission.
%clauses
%Regla 
isWriteP(Sn1,DocId):-
    getPlatformActiveUsr(Sn1,ActiveUsr),
    getPlatformShare(Sn1,ShareList),
    writePermission(ActiveUsr,ShareList,DocId).

%Domains
%Sn1: Platform
%DocumentId: integer
%Date: Fecha
%ContenidoTexto: string
%Sn2: Platform
%Predicates
%paradigmaDocsAdd(Sn1, DocumentId, Date, ContenidoTexto, Sn2).
%Goals
%Permite agregar texto al final del contenido de un doc especifico si es
%que se cumplen todos los requisitos.
%clauses
%Regla 
paradigmaDocsAdd(Sn1, DocumentId, Date, ContenidoTexto, Sn2):-
    not(notLogin(Sn1)),
    (isOwner(Sn1,DocumentId);isWriteP(Sn1,DocumentId)),
    getPlatformDocs(Sn1,Docs),
    getDocsByID(Docs,DocumentId,DocById),
    myDeleteElemList(DocById,Docs,NewDocs),
    insertText(DocById,ContenidoTexto,Date,DocText),
    append([DocText],NewDocs,ListDocs),
    getPlatformUsers(Sn1, PaUsers),
    getPlatformName(Sn1, PlatformName),
    getPlatformDate(Sn1, DatePlatform),
    getPlatformShare(Sn1,ShareList),
    getPlatformDocsVer(Sn1,DocsVersions),
    append([DocById],DocsVersions,NewVersions),
    Sn2 = [PlatformName, DatePlatform, PaUsers,ListDocs,[],ShareList,NewVersions],!. 
    






%----------------------------------------------------------------------------
%-------------------------------------RestoreVersion------------------------------------
%------------------------Debo comentar getDocByVerAndId




%Domains
%DocsVersions: list
%IdVersion: integer
%DocumentId: integer
%GetDocVer: Doc
%Predicates
%getDocByVerAndId(DocsVersions,IdVersion,DocumentId,GetDocVer)
%Goals
%Obtiene un doc con un id de versión y documento especifico.
%clauses
%Regla 


getDocByVerAndId([],_,_,_):- fail,!.

getDocByVerAndId([Car|_],VerId,DocId,GetDoc):-
    isDoc(Car),
    getIDdoc(Car,IdFromCar),
    getIDVer(Car,VerFromCar),
    VerId = VerFromCar,
    DocId = IdFromCar,
    GetDoc = Car,!.

getDocByVerAndId([_|Cdr],VerId,DocId,GetDoc):-
    getDocByVerAndId(Cdr,VerId,DocId,GetDoc).


%Domains
%Sn1: ParadigmaDocs
%DocumentId: integer
%IdVersion: integer
%Sn2: ParadigmaDocs
%Predicates
%paradigmaDocsRestoreVersion(Sn1, DocumentId, IdVersion, Sn2)
%Goals
%genera una Platforma con el doc activo que cumpla la versión especifica.
%clauses
%Regla 



paradigmaDocsRestoreVersion(Sn1, DocumentId, IdVersion, Sn2):-
    not(notLogin(Sn1)),
    isOwner(Sn1,DocumentId),
    getPlatformDocsVer(Sn1,DocsVersions),
    getDocByVerAndId(DocsVersions,IdVersion,DocumentId,GetDocVer),

    getPlatformDocs(Sn1,Docs),
    getDocsByID(Docs,DocumentId,DocById),
    myDeleteElemList(DocById,Docs,NewDocs),
    
    append([GetDocVer],NewDocs,ListDocs),
    getPlatformUsers(Sn1, PaUsers),
    getPlatformName(Sn1, PlatformName),
    getPlatformDate(Sn1, DatePlatform),
    getPlatformShare(Sn1,ShareList),
    getPlatformDocsVer(Sn1,DocsVersions),

    myDeleteElemList(GetDocVer,DocsVersions,NewDocsVersion),
    append([DocById],NewDocsVersion,NewVersions),
    Sn2 = [PlatformName, DatePlatform, PaUsers,ListDocs,[],ShareList,NewVersions],!. 




%----------------------------------------------------------------------------
%-------------------------------------paradigmaDocsToString-----------------------------

%Domains
%list: list
%Car: dato.
%Predicates
%getCar([Car|_],Car)..
%Goals
%Obtener el primer elemento de una lista
%clauses
%Regla 

getCar([Car|_],Car).


%Domains
%DocsList: list
%DocsStr: string.
%Predicates
%docsToString(DocsList,DocsStr)
%Goals
%transformar documentos a un string legible
%clauses
%Regla 

docsToString([],_,_):- !.
docsToString([Car|_],ActualStr,DocsStr):-
    getIDdoc(Car,IdDoc),
    string_concat("<- ID documento ",ActualStr,Str1),
    string_concat(IdDoc,Str1,Str2),

    getIDVer(Car,IdVer),
    string_concat("<- ID Version ",Str2,Str3),
    string_concat(IdVer,Str3,Str4),
    string_concat("\n",Str4,StrIDS),
    getOwnerDoc(Car,Owner),
    getCar(Owner,MyOwner),
    string_concat("\npropietario: ",MyOwner,StrOwner),
    string_concat(StrIDS,StrOwner,Str5),
    getFechaDoc(Car,Fecha),
    fechaToString(Fecha,FechaStr),
    string_concat(FechaStr,Str5,Str6),
    getNombreDoc(Car,NombreDoc),
    string_concat(Str6,"\nNombre documento: ",Str7),
    string_concat(Str7,NombreDoc,Str8),
    string_concat(Str8,"\n",Str9),
    getContentDoc(Car,ContentDoc),
    string_concat(Str9,"Contenido doc: \n",Str10),
    string_concat(Str10,ContentDoc,Str11),
    string_concat(Str11,"\n",DocsStr).
    
docsToString([_|Cdr],ActualStr,DocsStr):-
    docsToString(Cdr,ActualStr,DocsStr).



%----------------------------------------



%Domains
%Permissions: list
%Permiso: string.
%Predicates
%nombrePermisos(Permissions,Pms)
%Goals
%Transformar permisos a un string legible
%clauses
%Regla 
nombrePermisos([],_):-!.
nombrePermisos([Car|_],Permiso):-
    (Car = "W" , Permiso = " Escritura ");
    (Car="R",Permiso = " Lectura ");
    (Car="C", Permiso = "Comentario").

nombrePermisos([_|Cdr],Permiso):-
    nombrePermisos(Cdr,Permiso).


%Domains
%Permissions: list
%PermissionsStr: string.
%Predicates
%permisosToStr(Permissions,PermissionsStr)
%Goals
%Encapsular predicado nombrePermisos para obtener todos los resultados.
%clauses
%Regla 

permisosToStr(Permissions,PermissionsStr):-
    findall(Pms,nombrePermisos(Permissions,Pms),ListaPermisos),
    reverse(ListaPermisos,ReverseListPerm),
    myDeleteElemList(_,ReverseListPerm,NewListPerm),
    reverse(NewListPerm,FinalList),
    atomics_to_string(FinalList,PermissionsStr).



%Domains
%Compartidos: list
%ToStr: string.
%Usr: string
%Predicates
%stringShare(Compartidos,ToStr,Usr)
%Goals
%Transformar a string la lista de share.
%clauses
%Regla     

stringShare([],_,_):-!.

stringShare([Car|_],Usr,ToStr):-
    isShare(Car),
    getShareID(Car,ShareID),
    string_concat("\nID documento compartido: ",ShareID,ShareStrId),
    getShareUsr(Car,ShareUsr),
    ShareUsr = Usr,
    string_concat(ShareStrId,"\nCompartido con: ",ShareUsrStr),
    string_concat(ShareUsrStr,ShareUsr,Share1),
    getSharePermissionList(Car,Permissions),
    permisosToStr(Permissions,PermissionsStr),
    string_concat(Share1,"\ncon permisos: ",Share2),
    string_concat(Share2,PermissionsStr,Share3),
    string_concat("\n",Share3,ToStr).


stringShare([_|Cdr],Usr,ToStr):-
    stringShare(Cdr,Usr,ToStr).



 
%Domains
%Sn1: ParadigmaDocs
%StrOut1: String
%Predicates
%strOnline(Sn1,StrOut1)
%Goals
%Transformar a string una Platforma paradigmaDocs con sesión iniciada.
%clauses
%Regla     


strOnline(Sn1,StrOut1):-
    getPlatformActiveUsr(Sn1,ActiveUsr),
    getPlatformDocs(Sn1,DocsPlatform),
    getCar(ActiveUsr,StrActUsr),
    string_concat("\nUsuario activo: ",StrActUsr,StrOut),
    string_concat(StrOut,"\n",StrOut2),
    getAllDocsByOwner(DocsPlatform,ActiveUsr,DocOwnerList),
    findall(StrDocsSalida,docsToString(DocOwnerList,"",StrDocsSalida),ListDocs),
    reverse(ListDocs,ReverseListDocs),
    myDeleteElemList(_,ReverseListDocs,NewListDocs),
    reverse(NewListDocs,FinalListDocs),
    atomics_to_string(FinalListDocs,FinalStrDocs),
    string_concat(StrOut2,FinalStrDocs,MyDocs),
    string_concat(MyDocs,"\nDocumentos compartidos conmigo -\n",ShareDocs),
    getPlatformShare(Sn1,ShareList),
    findall(StrShare,stringShare(ShareList,StrActUsr,StrShare),ListShareStr),
    reverse(ListShareStr,ReverseListShare),
    myDeleteElemList(_,ReverseListShare,NewListShare),
    reverse(NewListShare,FinalListShare),
    atomics_to_string(FinalListShare,FinalStrShare),
    string_concat(ShareDocs,FinalStrShare,StrOutShare),
    
    %--------------------------------------
    string_concat(StrOutShare,"\nVersiones anteriores: \n",StrVer),
    getPlatformDocsVer(Sn1,DocsVersions),
    getAllDocsByOwner(DocsVersions,ActiveUsr,DocVerOwnList),
    findall(StrVerDocs,docsToString(DocVerOwnList,"",StrVerDocs),ListVerDoc),
    reverse(ListVerDoc,ReverseListDocsVer),
    myDeleteElemList(_,ReverseListDocsVer,NewListDocsVer),
    reverse(NewListDocsVer,FinalListDocsVer),
    atomics_to_string(FinalListDocsVer,FinalStrDocsVer),
    string_concat(StrVer,FinalStrDocsVer,StrOut1).


%Domains
%Sn1: ParadigmaDocs
%StrOut1: String
%Predicates
%strOffline(Sn1,StrOut)
%Goals
%Transformar a string una Platforma paradigmaDocs con sesión offline.
%clauses
%Regla     


strOffline(Sn1,StrOut):-
    getPlatformDocs(Sn1,AllDocs),
    findall(StrDocsSalida,docsToString(AllDocs,"",StrDocsSalida),ListDocs),
    reverse(ListDocs,ReverseListDocs),
    myDeleteElemList(_,ReverseListDocs,NewListDocs),
    reverse(NewListDocs,FinalListDocs),
    atomics_to_string(FinalListDocs,FinalStrDocs),
    string_concat("\nNo hay usuario activo.\n","\nDocumentos: \n",AllStrDoc),
    string_concat(AllStrDoc,FinalStrDocs,StrDocs),

    string_concat(StrDocs,"Documentos compartidos \n",StrShareOffline),
    getPlatformShare(Sn1,ShareList),
    findall(StrShare,stringShare(ShareList,_,StrShare),ListShareStr),
    reverse(ListShareStr,ReverseListShare),
    myDeleteElemList(_,ReverseListShare,NewListShare),
    reverse(NewListShare,FinalListShare),
    atomics_to_string(FinalListShare,FinalStrShare),
    string_concat(StrShareOffline,FinalStrShare,StrOutShare),
    string_concat(StrOutShare,"\nVersiones anteriores: \n",StrVer),
    getPlatformDocsVer(Sn1,DocsVersions),
    findall(StrVerDocs,docsToString(DocsVersions,"",StrVerDocs),ListVerDoc),
    reverse(ListVerDoc,ReverseListDocsVer),
    myDeleteElemList(_,ReverseListDocsVer,NewListDocsVer),
    reverse(NewListDocsVer,FinalListDocsVer),
    atomics_to_string(FinalListDocsVer,FinalStrDocsVer),
    string_concat(StrVer,FinalStrDocsVer,StrOut).



%Domains
%Sn1: ParadigmaDocs
%StrOut1: String
%Predicates
%paradigmaDocsToString(Sn1,StrOut)
%Goals
%Transformar a string una Platforma paradigmaDocs, predicado que encapsula y decide si es offline u online.
%clauses
%Regla     

paradigmaDocsToString(Sn1,StrOut):-
    not(notLogin(Sn1)) ->
    (strOnline(Sn1,StrOut1),getPlatformName(Sn1,NamePlatform),
    string_concat(NamePlatform,StrOut1,StrOut));
    (strOffline(Sn1,StrOut1),getPlatformName(Sn1,NamePlatform),
    string_concat(NamePlatform,StrOut1,StrOut)),!.





%------------------------------------------------------------------------------------------------
%-------------------------------------paradigmaDocsRevokeAllAccesses-----------------------------


%Domains
%ActiveUsr: list
%Docs: Docs
%Predicates
%checkAllId(Ids,ActiveUsr,Docs)
%Goals
%Verificar los id con respecto al usuario activo.
%clauses
%Regla  

checkAllId([],_,_):- fail,!.

checkAllId([Car|_],ActiveUsr,Docs):-
    getDocOwnerByID1(Docs,Owner,Car),
    Owner = ActiveUsr.

checkAllId([_|Cdr],ActiveUsr,Docs):-
    checkAllId(Cdr,ActiveUsr,Docs).


%Domains
%ActiveUsr: list
%Docs: Docs
%Predicates
%countCheckId(Ids,ActiveUsr,Docs)
%Goals
%Verificar los id con respecto al usuario activo.
%clauses
%Regla  


countCheckId(Ids,ActiveUsr,Docs):-
    findall(ActiveUsr,checkAllId(Ids,ActiveUsr,Docs),BoolList),
    length(BoolList,BoolListLength),
    length(Ids,IdsLength),
    BoolListLength = IdsLength.

%Domains
%ListIDs: list
%ShareList: list
%ToDelete: share
%Predicates
%deleteShare(ListIDs,ShareList,ToDelete)
%Goals
%Buscar los elementos a borrar del shareList junto con revokeAccess
%clauses
%Regla  

deleteShare([],_,_):- fail,!.

deleteShare([Car|_],ShareList,ToDelete):-
    integer(Car),
    revokeAccess(ShareList,Car,ToDelete).

deleteShare([_|Cdr],ShareList,ToDelete):-
    Cdr\=[],
    deleteShare(Cdr,ShareList,ToDelete).    


%Domains
%ListIDs: list
%ShareList: list
%ToDelete: share
%Predicates
%revokeAccess(ListIDs,ShareList,ToDelete)
%Goals
%Complemento deleteShare
%clauses
%Regla  

revokeAccess([],_,_):-!.
revokeAccess([Car|_],Id,ToDelete):-
    isShare(Car),
    getShareID(Car,ShareID),
    Id=ShareID,
    ToDelete = Car.

revokeAccess([_|Cdr],Id,ToDelete):-
    revokeAccess(Cdr,Id,ToDelete).

%Domains
%Sn1: ParadigmaDocs
%ListIDs: list
%Predicates
%revokeWithName(Sn1,ListIDs)
%Goals
%Buscar los ids de los documentos del usr activo
%clauses
%Regla  

revokeWithName(Sn1,ListIDs):-
    getPlatformDocs(Sn1,Docs),
    getPlatformActiveUsr(Sn1,ActiveUsr), 
    findall(IDS,getDocOwnerByID(Docs,ActiveUsr,IDS),ListIDs).




%Domains
%Sn1: ParadigmaDocs
%ListIDs: list
%FinalShareList: list
%Predicates
%revokeWithIds(Sn1,ListIDs)
%Goals
%Eliminar los usuarios compartidos a partir de una lista de ids
%clauses
%Regla  

cleanList([],_):- fail,!.
cleanList([Car|_],NewList):-
    Car\=[],
    NewList = Car.
cleanList([_|Cdr],NewList):-
    cleanList(Cdr,NewList).



revokeWithIds(Sn1,ListIDs,FinalShareList):-
    getPlatformShare(Sn1,ShareList),
    findall(ToDelete,deleteShare(ListIDs,ShareList,ToDelete),UsrsToDelete),
    findall(NewList,cleanList(UsrsToDelete,NewList),FinalUsrsToDelete),
    subtract(ShareList,FinalUsrsToDelete,FinalShareList).


%Domains
%Sn1: ParadigmaDocs
%DocumentIds: list
%Sn2: ParadigmaDocs
%Predicates
%paradigmaDocsRevokeAllAccesses( Sn1, DocumentIds, Sn2)
%Goals
%Eliminar los usuarios compartidos, dependiendo si existe o no una lista de ids.
%clauses
%Regla  

paradigmaDocsRevokeAllAccesses( Sn1, DocumentIds, Sn2):-
    not(notLogin(Sn1)),
    getPlatformActiveUsr(Sn1,ActiveUsr),
    getPlatformDocs(Sn1,Docs),
    countCheckId(DocumentIds,ActiveUsr,Docs),
    DocumentIds = [] ->
    (revokeWithName(Sn1,AllIds),
    revokeWithIds(Sn1,AllIds,FinalShareList),
    getPlatformUsers(Sn1, PaUsers),
    getPlatformName(Sn1, PlatformName),
    getPlatformDate(Sn1, DatePlatform),
    getPlatformDocsVer(Sn1,DocsVersions),
    getPlatformDocs(Sn1,Docs),
    Sn2 = [PlatformName, DatePlatform, PaUsers,Docs,[],FinalShareList,DocsVersions]);
    ( 
    revokeWithIds(Sn1,DocumentIds,FinalShareList),
    getPlatformUsers(Sn1, PaUsers),
    getPlatformName(Sn1, PlatformName),
    getPlatformDate(Sn1, DatePlatform),
    getPlatformDocsVer(Sn1,DocsVersions),
    getPlatformDocs(Sn1,Docs),
    Sn2 = [PlatformName, DatePlatform, PaUsers,Docs,[],FinalShareList,DocsVersions]),!.





%------------------------------------------------------------------------------------------------
%-------------------------------------paradigmaDocsSearch-----------------------------


%Domains
%ShareList: list
%Usr: string
%Docs: list
%newDoc: doc
%Predicates
%getShareDocsUser(ShareList,Usr,NewDoc)
%Goals
%Obtiene un doc que se le compartio a un usr.
%clauses
%Regla  


getShareDocsUser([],_,_,_):- !.

getShareDocsUser([Car|_],Usr,Docs,NewDoc):-
    getShareUsr(Car,ShareUsr),
    ShareUsr = Usr,
    getShareID(Car,ShareID),
    getDocsByID(Docs,ShareID,NewDoc).
    
    
getShareDocsUser([_|Cdr],Usr,Docs,NewDoc):-
    getShareDocsUser(Cdr,Usr,Docs,NewDoc).



%Domains
%ShareList: list
%Usr: string
%Docs: list
%newDoc: doc
%Predicates
%allShareWithMe(ShareList,Usr,Docs,DocsList)
%Goals
%Encapsula getShareDocsUser, obtiene la lista de docs.
%clauses
%Regla  

allShareWithMe(ShareList,Usr,Docs,DocsList):-
    findall(NewDoc,getShareDocsUser(ShareList,Usr,Docs,NewDoc),DocsList).


%Domains
%string: string
%palabra: string
%Predicates
%isInString(String,Palabra)
%Goals
%Verificar si el texto ingresado se encuentra en un string.
%clauses
%Regla  

isInString(String,Palabra):-
    sub_string(String, _, Length, _, Palabra),
    Length > 0,!.

%Domains
%Docs: list
%Str: string
%DocOut: doc
%Predicates
%getDocIfEqualStr(Docs,Str,DocOut)
%Goals
%Verifica si en una lista de docs existe una palabra.
%clauses
%Regla  


getDocIfEqualStr([],_,_):- !.

getDocIfEqualStr([Car|_],Text,DocOut):-
    getContentDoc(Car,ContentDoc),
    isInString(ContentDoc,Text),
    DocOut = Car.

getDocIfEqualStr([_|Cdr],Text,DocOut):-
    getDocIfEqualStr(Cdr,Text,DocOut).



%Domains
%Sn1: ParadigmaDocs
%SearchText: string
%Documents: list
%Predicates
%paradigmaDocsSearch(Sn1, SearchText, Documents):
%Goals
%Obtener los documentos con coincidencia con el texto ingresado
%buscando en versiones tanto actuales como pasadas, y los docs compartidos.
%clauses
%Regla  


paradigmaDocsSearch(Sn1, SearchText, Documents):-
    not(notLogin(Sn1)),
    getPlatformDocsVer(Sn1,DocsVersions),
    getPlatformShare(Sn1,ShareList),
    getPlatformActiveUsr(Sn1,ActiveUsr),
    getPlatformDocs(Sn1,DocsPlatform),
    getDocumentsByOwner(DocsPlatform,ActiveUsr,DocOwner),
    getCar(ActiveUsr,StrActUsr),
    allShareWithMe(ShareList,StrActUsr,DocsPlatform,ShareDocsMe),
    findall(DocsEq,getDocIfEqualStr([DocOwner],SearchText,DocsEq),DocsPlat),
    findall(DocsEq,getDocIfEqualStr(DocsVersions,SearchText,DocsEq),DocsVer),
    append(DocsPlat,DocsVer,Docs1),
    findall(DocsEq,getDocIfEqualStr(ShareDocsMe,SearchText,DocsEq),DocsSh),
    append(DocsSh,Docs1,Documents),!.
    
    


/*

EJEMPLOS
--------------------------------------------------Creación de Platformas-------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout).
-> fecha(3,2,2021,FechaNueva),paradigmaDocs("WordCopy",FechaNueva,Pout).
-> fecha(1,4,2021,FechaNueva),paradigmaDocs("paradigmaOffice",FechaNueva,Pout).


--------------------------------------------------Registros -------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister).

Registro con error ya que, ya se registro "driques"
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister).

-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),  
paradigmaDocsRegister(PoutRegister,FechaNueva,"juan","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"pepe","1234",PoutRegister2).

----------------------------------------------Login-----------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2).

Login errado
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsLogin(Sn2,"driques","1234",Sn3).


-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"ThuPrincEXita","1234",Sn2),paradigmaDocsLogin(Sn2,"ThuPrincEXita","1234",Sn3).

---------------------------------------------------Crea nuevo Doc----------------------------------------------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),
paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),
paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),
paradigmaDocsLogin(DocOut,"manolo","1234",Login2),paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut).

-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),
paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),paradigmaDocsLogin(PoutRegister,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"Lorem ipsum","soy otro doc",FinalDocOut).


Se crea otro documento para ver si el nuevo predicado que toma el id max suma al nuevo id del doc.

-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),paradigmaDocsLogin(Sn7,"manolo","1234",Sn8),
paradigmaDocsCreate(Sn8,FechaNueva,"UltimoDoc Test","soy el ultimo doc",Sn9).



--------------------------------------------------Share----------------------------------------------------------------------------------------
Comparte doc 1 Errado porque ni pepito ni juan existen
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),
paradigmaDocsShare(Sn5,1,["W","R","C"],["Pepito","Juan"],Snfinal).

Comparte doc 1 Bueno
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsRegister(Sn5,FechaNueva,"pablo","1234",Sn6),
paradigmaDocsRegister(Sn6,FechaNueva,"juan","1234",Sn7),paradigmaDocsShare(Sn7,1,["W","R","C"],["manolo","pablo","juan"],Snfinal).

Fecha Incorrecta
-> fecha(12,24,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsRegister(Sn5,FechaNueva,"pablo","1234",Sn6),
paradigmaDocsRegister(Sn6,FechaNueva,"juan","1234",Sn7),paradigmaDocsShare(Sn7,1,["W"],["manolo","pablo","juan"],Snfinal).

------------------------------------------------Add-------------------------------------------------------------------------------------------------------
Correcto porque "driques" es owner del doc 1.
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7).

Correcto porque "manolo" tiene permisos de escritura en el doc 1.
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"manolo","1234",Sn6),paradigmaDocsAdd(Sn6,1,_,_,Sn7).

Incorrecto porque "driques" no es owner ni tiene permisos de escritura en el doc 2.
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,2,_,_,Sn7).




%------------------------------------RestoreVersion--------------------------------------------------------------------------------------


-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsRestoreVersion(Sn8, 1, 1, Sn9).

-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"manolo","1234",Sn6),paradigmaDocsAdd(Sn6,2,FechaNueva," CONTENIDO AGREGADO al segundo doc",Sn7),paradigmaDocsLogin(Sn7,"manolo","1234",Sn8),
paradigmaDocsRestoreVersion(Sn8, 2, 1, Sn9).

%Incorrecto, "driques" no es owner del doc 2.
->fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"manolo","1234",Sn6),paradigmaDocsAdd(Sn6,2,FechaNueva," CONTENIDO AGREGADO al segundo doc",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsRestoreVersion(Sn8, 2, 1, Sn9).



%------------------------------------paradigmaDocsToStr--------------------------------------------------------------------------------------


-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsRestoreVersion(Sn8, 1, 1, Sn9),paradigmaDocsToString(Sn9,StrOut).

-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"manolo","1234",Sn6),paradigmaDocsAdd(Sn6,2,FechaNueva," CONTENIDO AGREGADO al segundo doc",Sn7),paradigmaDocsLogin(Sn7,"manolo","1234",Sn8),
paradigmaDocsRestoreVersion(Sn8, 2, 1, Sn9),paradigmaDocsLogin(Sn9,"manolo","1234",Sn10),paradigmaDocsToString(Sn10,StrOut).

%Incorrecto, "driques" no es owner del doc 2 y la fecha es Incorrecta.
->fecha(132,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"manolo","1234",Sn6),paradigmaDocsAdd(Sn6,2,FechaNueva," CONTENIDO AGREGADO al segundo doc",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsRestoreVersion(Sn8, 2, 1, Sn9),paradigmaDocsToString(Sn9,StrOut)..




%------------------------------------RevokeAllAccesses--------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),
paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsRevokeAllAccesses(Sn8,[],SnRevoke).

Solo elimina de la lista de compartidos el doc 3

->fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Login3),
paradigmaDocsCreate(Login3,FechaNueva,"Lorem ipsum","soy un doc",FinalDocOut2),
paradigmaDocsLogin(FinalDocOut2,"driques","1234",Sn5),
paradigmaDocsShare(Sn5,3,["C"],["manolo"],Sn6),
paradigmaDocsLogin(Sn6,"driques","1234",Sn7),
paradigmaDocsShare(Sn7,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn8),paradigmaDocsAdd(Sn8,1,FechaNueva," CONTENIDO AGREGADO 1",Sn9),paradigmaDocsLogin(Sn9,"driques","1234",Sn10),
paradigmaDocsRevokeAllAccesses(Sn10,[3],SnRevoke).


Error, no hay sesión iniciada

->fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Login3),
paradigmaDocsCreate(Login3,FechaNueva,"Lorem ipsum","soy un doc",FinalDocOut2),
paradigmaDocsLogin(FinalDocOut2,"driques","1234",Sn5),
paradigmaDocsShare(Sn5,3,["C"],["manolo"],Sn6),
paradigmaDocsLogin(Sn6,"driques","1234",Sn7),
paradigmaDocsShare(Sn7,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn8),paradigmaDocsAdd(Sn8,1,FechaNueva," CONTENIDO AGREGADO 1",Sn9),
paradigmaDocsRevokeAllAccesses(Sn10,[3],SnRevoke).

-----------------------------------paradigmaDocsSearch-----------------------------------------------------
-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsSearch(Sn8,"soy", Sn9).

Error no hay sesión iniciada.

-> fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),
paradigmaDocsSearch(Sn8,"soy", Sn9).

Error no encuentra el string
->fecha(1,2,2021,FechaNueva),paradigmaDocs("GdocsCopy",FechaNueva,Pout),
paradigmaDocsRegister(Pout,FechaNueva,"driques","1234",PoutRegister1),paradigmaDocsRegister(PoutRegister1,FechaNueva,"manolo","1234",PoutRegister),
paradigmaDocsLogin(PoutRegister,"driques","1234",Sn2),paradigmaDocsCreate(Sn2,FechaNueva,"NuevoDoc 1","soy un doc",DocOut),paradigmaDocsLogin(DocOut,"manolo","1234",Login2),
paradigmaDocsCreate(Login2,FechaNueva,"NuevoDoc 2","soy otro doc",FinalDocOut),paradigmaDocsLogin(FinalDocOut,"driques","1234",Sn5),paradigmaDocsShare(Sn5,1,["W","R","C"],["manolo"],Snfinal),
paradigmaDocsLogin(Snfinal,"driques","1234",Sn6),paradigmaDocsAdd(Sn6,1,FechaNueva," CONTENIDO AGREGADO 1",Sn7),paradigmaDocsLogin(Sn7,"driques","1234",Sn8),
paradigmaDocsSearch(Sn8,"Profe tenga piedad", Sn9).

*/





/*

%------------------------------Predicados y recordatorios personales--------------------------------------


    set_prolog_flag(answer_write_options,
                       [ quoted(true),
                         portray(true),
                         spacing(next_argument)
                       ]).





    */

