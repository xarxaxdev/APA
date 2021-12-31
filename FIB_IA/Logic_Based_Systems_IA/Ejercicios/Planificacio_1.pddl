(define (problem sample_1)
  (domain: menu_maker)
  (:object  Sopa Pan Crema Ensalada -primeros
            Pollo Pescado Gambas - segundos
            Lunes Martes Miercoles Jueves Viernes -dia)

  (:init
    (compatible Sopa Pollo) (compatible Sopa Pescado) (compatible Sopa Gambas)
    (compatible Pan Pollo)
    (compatible Ensalada Pollo) (compatible Ensalada Gambas)
    )
  (:goal (forall (?p - primero) (?s -segundo)
            (asignado ?x ?y)
          )
  )
)
