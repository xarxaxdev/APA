(define: domain problema2)
  (:requirements :strips)
  (:types )
(:predicates (CUBO ?x)
             (POS ?x)
             (in_pos ?x ?y)
             (is_goal ?x ?y)
             (on_goal ?x)
             )

(:action swap: parameters (?x ?y)
  :precondition  (NOT (on_goal ?x)
                      (on_goal ?y))
  )

(:action accept: parameters )
  :precondition (and (on_goal cuboa)
                     (on_goal cubob)
                     (on_goal cuboc))


;;;;;;;;;;;

(define (domain vector))
  (:requirements :strips)
  (:types element-object
          posicio-object
        )
  (:predicates (esta_en ?x- element)
                        ?y-posicio)
               (esta_a_dreta ?p-posicio)
                             ?q-posicio))
  (:action swap
    :parameters ( ?x -element ?p-posicio
                  ?y-element  ?q-posicio)
    :precondition (and (esta-en ?x ?y)
                       (esta-en ?y ?q))
    :effect (and (esta_en ?x ?q)
                 (esta_en ?y ?p)
                 (not (esta-en ?x ?p))
                 (not (esta-en ?y ?q))
                 )
