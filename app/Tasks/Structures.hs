module Tasks.Structures (task) where


import Task (Task(..))
import Autotool.Data.LazyTree (showFnTree)
import Autotool.DAO.Structure ( Struktur(..) )
import Autotool.Solver.Structures (solve)

task :: Task
task = Task
    { runTask = run
    , name = "structs"
    , autotoolName = "Term"
    , description = "Finds an expression with different value (semantically) in two structs"
    , longDescription = unlines 
        [ "Finds an expression with different value (semantically) in two structs"
        , "Note: Does currently only work on *two* structs. Also the structs need to have the"
        , "same signature."
        ]
    , parameters =
        [ ("structs", "The structs that shall evaluate the searched expression to different values")
        ]
    , exampleInput = show $ StructureDescription
        { structs = read "[ Struktur { universum = mkSet [ 1, 2, 3, 4] , predicates = listToFM    [ ] , functions = listToFM [ ( f , {(1 , 1 , 1) , (1 , 2 , 3) , (1 , 3 , 4) , (1 , 4 , 3) , (2 , 1 , 3) , (2 , 2 , 1) , (2 , 3 , 4) , (2 , 4 , 4) , (3 , 1 , 3) , (3 , 2 , 1) , (3 , 3 , 2) , (3 , 4 , 4) , (4 , 1 , 2) , (4 , 2 , 1) , (4 , 3 , 4) , (4 , 4 , 4)} ) , ( g , {(1 , 4) , (2 , 2) , (3 , 3) , (4 , 4)} ) , ( c, {(2)}) ] }, Struktur { universum = mkSet [ 1, 2, 3, 4] , predicates = listToFM    [ ] , functions = listToFM [ ( f , {(1 , 1 , 1) , (1 , 2 , 3) , (1 , 3 , 4) , (1 , 4 , 3) , (2 , 1 , 3) , (2 , 2 , 1) , (2 , 3 , 4) , (2 , 4 , 4) , (3 , 1 , 3) , (3 , 2 , 1) , (3 , 3 , 2) , (3 , 4 , 4) , (4 , 1 , 2) , (4 , 2 , 1) , (4 , 3 , 3) , (4 , 4 , 4)} ) , ( g , {(1 , 4) , (2 , 2) , (3 , 3) , (4 , 4)} ) , ( c, {(2)}) ] } ]"
        }
    }


run :: String -> String
run = showFnTree . solve . structs . read

newtype StructureDescription = StructureDescription { structs :: [Struktur] } deriving (Show,Read)