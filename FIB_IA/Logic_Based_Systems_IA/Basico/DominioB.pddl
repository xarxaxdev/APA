(define (domain menu_maker)
  (:requirements :adl :strips)
  (:types plato tipo dia - object
          primero segundo - plato
  )
  (:predicates
    (incompatible ?x - primero ?y - segundo)
    (dia_asignado ?d - dia)
  )



  (:action crear_menu
    :parameters (?p - primero ?s - segundo ?d - dia)
    :precondition (and (not (incompatible ?p ?s))
                       (not (dia_asignado ?d))
    )
    :effect  (dia_asignado ?d)
  )
)
