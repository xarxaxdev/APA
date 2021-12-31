-- per a que aixo funcioni s'ha de compilar amb ghc
-- i llavors executar
-- o bé cridar main desde gchi
main :: IO () 
main = do 
        x <- getLine
--        print $ respondre $ read x  SOLO ENTEROS
        putStr ( respondre  x ) 


respondre:: String -> String
respondre [] = "Hola maco!\n"
respondre x 
 | last (lastword $ words x)=='a' = "Hola maca!\n"
 | last (lastword $ words x)=='A' = "Hola maca!\n"
 | True = "Hola maco!\n"

lastword:: [String] -> String 
lastword []= []
lastword x 
 | last x == "" = lastword $ init x 
 | otherwise = last x

 

