(define (problem p2)
  (:domain problem2)
  (:objects cuboc, cuboa, cubob
            first, second, third))

(:init (CUBO cuboc) (CUBO cuboa) (CUBO cubob)
       (POS first) (POS second) (POS third)
       (in_pos first cuboc) (in_pos second cuboa) (in_pos third cubob)
       (is_goal first cuboa) (is_goal second cubob) (is_goal third cuboc)
)

(:goal (and (on_goal cuboa)
            (on_goal cubob)
            (on_goal cuboc)
            ))

;;;;;;;;;;;;;;









Objects begin, a, b, c, end
Init AntesDe (begin,a)
              (a,b)
              (b,c)
              (c,end)

swap (nota notb not)
