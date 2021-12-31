-- per a que aixo funcioni s'ha de compilar amb ghc
-- i llavors executar
-- o bé cridar main desde gchi
main :: IO () 
main = do 
 x <- getLine
 if (x== "*") then return ()
 else do 
  putStr ( parseandandswer  x ) 
  main

parseandandswer:: String -> String
parseandandswer "*" = ""
parseandandswer x 
 |valor < 18 = (head$ words x) ++ (": magror\n")
 |(valor > 18)  && (valor <=25) = (head$ words x) ++ (": corpulencia normal\n")
 |(valor > 25)  && (valor <30) = (head$ words x) ++ (": sobrepes\n")
 |(valor >= 30)  && (valor <40) = (head$ words x) ++ (": obesitat\n")
 |(valor >= 40) = (head$ words x) ++ (": obesitat morbida\n")
 | otherwise = "Hola maco!\n"
 where valor = imc(  tail(words x) )

imc:: [String] -> Float 
imc x= (read $ head x) / (height* height) 
 where height=read$ head $tail x 