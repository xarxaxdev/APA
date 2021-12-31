(define (problem sample_1)
  (:domain menu_maker)
  (:objects
    EnsaladaGarbanzos FideuaAlliOli PatatasFritas EnsaladaVerde SopaAjo PastaCarbonara - primero
    LangostinoAjoMiel FabadaAsturiana - segundo
    lunes martes miercoles jueves viernes - dia
  )
  (:init
    (incompatible FideuaAlliOli FabadaAsturiana)
    (incompatible EnsaladaGarbanzos FabadaAsturiana)
    (incompatible PatatasFritas LangostinoAjoMiel)
    ;(incompatible EnsaladaGarbanzos LangostinoAjoMiel)
  )
  (:goal (forall (?d - dia) (dia_asignado ?d) )
  )
)
