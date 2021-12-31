(define (problem sample_1)
  (:domain menu_maker)
  (:objects
    EnsaladaGarbanzos EnsaladaVerde FideuaAlliOli PatatasFritas SopaAjo PastaCarbonara ArosCebolla Paella - primero
    FabadaAsturiana LangostinoAjoMiel PolloAlCurry Asado Salmon Lubina Kebab Lasagna CremaZanahoria - segundo
    sopa crema ensalada carne pescado marisco fideos rapida potaje - tipo
    viernes jueves miercoles martes lunes - dia
  )
  (:init
    (incompatible FideuaAlliOli FabadaAsturiana) ;; primero 1 compatible con segundo 2
    (incompatible EnsaladaGarbanzos FabadaAsturiana)
    (incompatible PatatasFritas LangostinoAjoMiel)
    (incompatible FideuaAlliOli Kebab)
    (incompatible ArosCebolla FabadaAsturiana)
    (incompatible Paella Kebab)

    (estipoP EnsaladaGarbanzos ensalada)
    (estipoP FideuaAlliOli fideos)
    (estipoP PatatasFritas rapida)
    (estipoP EnsaladaVerde ensalada)
    (estipoP SopaAjo sopa)
    (estipoP PastaCarbonara fideos)
    (estipoP ArosCebolla rapida)
    (estipoP Paella marisco)

    (estipoS LangostinoAjoMiel marisco)
    (estipoS FabadaAsturiana potaje)
    (estipoS PolloAlCurry carne)
    (estipoS Asado carne)
    (estipoS Salmon pescado)
    (estipoS Lubina pescado)
    (estipoS Kebab carne)
    (estipoS Lasagna carne)
    (estipoS CremaZanahoria crema)

    (consecutivo lunes martes)
    (consecutivo martes miercoles)
    (consecutivo miercoles jueves)
    (consecutivo jueves viernes)

    (asignadoP_a Paella jueves)
    (asignadoS_a Asado lunes)


  )
  (:goal (forall (?d - dia) (dia_asignado ?d) )
  )
)
