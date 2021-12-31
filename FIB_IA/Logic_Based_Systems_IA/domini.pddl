(define (domain menu_maker)
  (:requirements :adl :typing :strips :equality)
  (:types plato tipo dia first - object
          primero segundo - plato
  )
  (:predicates
    (incompatible ?p - primero ?s - segundo)
    (asignadoP_a ?p - primero ?d - dia)
    (asignadoS_a ?s - segundo ?d - dia)
    (consecutivo ?d1 - dia ?d2 - dia) ;; dos dias d vienen despues uno del otro
    (estipoP ?p - primero ?t - tipo) ;; plato p es del tipo t
    (estipoS ?p - segundo ?t - tipo)
    (dia_asignado ?d - dia)
    (usado ?p - plato)
    (especifico ?p - plato ?d - dia)
    (first)
  )
  (:functions


  )



  (:action asignar_primero_con_especifico_P
    :parameters (?p - primero ?s - segundo ?d - dia)
    :precondition (and (asignadoP_a ?p ?d)
                       (not (first))
                       (not (incompatible ?p ?s))
                       (not (dia_asignado ?d))
                       (not (usado ?p))
                       (not (usado ?s))
                  )

    :effect (and (dia_asignado ?d)
                 (usado ?p)
                 (usado ?s)
                 (asignadoS_a ?s ?d)
                 (first)
            )
  )

  (:action asignar_primero_con_especifico_S
    :parameters (?p - primero ?s - segundo ?d - dia)
    :precondition (and (asignadoS_a ?s ?d)
                       (not (first))
                       (not (incompatible ?p ?s))
                       (not (dia_asignado ?d))
                       (not (usado ?p))
                       (not (usado ?s))
                  )

    :effect (and (dia_asignado ?d)
                 (usado ?p)
                 (usado ?s)
                 (asignadoP_a ?p ?d)
                 (first)
            )
  )

  (:action asignar_primero_con_especifico
    :parameters (?p - primero ?s - segundo ?d - dia)
    :precondition (and (asignadoS_a ?s ?d)
                       (asignadoP_a ?p ?d)
                       (not (first))
                       (not (incompatible ?p ?s))
                       (not (dia_asignado ?d))
                       (not (usado ?p))
                       (not (usado ?s))
                  )

    :effect (and (dia_asignado ?d)
                 (usado ?p)
                 (usado ?s)
                 (first)
            )
  )

  (:action asignar_primero_sin_especifico
    :parameters (?p - primero ?s - segundo ?d - dia)
    :precondition (and (not (asignadoP_a ?p ?d))
                       (not (asignadoS_a ?s ?d))
                       (not (first))
                       (not (incompatible ?p ?s))
                       (not (dia_asignado ?d))
                       (not (usado ?p))
                       (not (usado ?s))
                  )

    :effect (and (dia_asignado ?d)
                 (usado ?p)
                 (usado ?s)
                 (asignadoP_a ?p ?d)
                 (asignadoS_a ?s ?d)
                 (first)
            )
  )


  (:action asignar_dia
    :parameters (?p2 - primero ?tp2 - tipo ?s2 - segundo  ?ts2 - tipo ?d2 - dia
                 ?p1 - primero ?tp1 - tipo ?s1 - segundo  ?ts1 - tipo ?d1 - dia
                )
    :precondition (and (asignadoP_a ?p1 ?d1)
                       (asignadoS_a ?s1 ?d1)
                       (consecutivo ?d1 ?d2)
                       (estipoP ?p1 ?tp1)
                       (estipoP ?p2 ?tp2)
                       (estipoS ?s1 ?ts1)
                       (estipoS ?s2 ?ts2)
                       (not (incompatible ?p2 ?s2))
                       (not (dia_asignado ?d2))
                       (not (usado ?p2))
                       (not (usado ?s2))
                       (not (=  ?tp1 ?tp2))
                       (not (=  ?ts1 ?ts2))

                  )
    :effect (and (dia_asignado ?d2)
                 (usado ?p2)
                 (usado ?s2)
                 (asignadoP_a ?p2 ?d2)
                 (asignadoS_a ?s2 ?d2)
            )
  )
)
