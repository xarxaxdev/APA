type Ident = String


data BExpr a = AND (BExpr a) (BExpr a) |
				OR (BExpr a) (BExpr a)|
				NOT (BExpr a) |
				GT (NExpr a) (NExpr a) |
				Eq (NExpr a) (NExpr a)  deriving (Show)

data NExpr a = Var Ident |
				Const a |
				Plus (NExpr a) (NExpr a) |
				Minus (NExpr a) (NExpr a) |
				Times (NExpr a) (NExpr a) deriving (Show)


data Command a = Input (NExpr a) |
					Print (NExpr a) |
					Assign (NExpr a) (NExpr a) |
					Empty (NExpr a) |
					Pop (NExpr a) (NExpr a) |
					Size (NExpr a) (NExpr a) |
					Push (NExpr a) (NExpr a) |
					Seq [(Command a)] |
					Cond (BExpr a) [(Command a)] |
					Loop (BExpr a) [(Command a)] deriving (Show)



--instance (Show a) => Show (NExpr a) where
--	show (Var s) = "Var: "++(show s)


