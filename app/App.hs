module App ( app, taskHelp, taskTypeDescriptions ) where

import Task (Task(..), describeTask, shortDescribeTask, TaskInput, TaskResult(..))
import qualified Tasks.Sets as Set ( task )
import qualified Tasks.MultiSets as MultiSet ( task )
import qualified Tasks.Relations as Relation ( task )
import qualified Tasks.Structures as Structures ( task )
import qualified Tasks.Graphs as Graphs ( task )
import qualified Tasks.Circle as Circle ( task )
import qualified Tasks.Hamilton as Hamilton ( task )
import qualified Tasks.Bipartit as Bipartit ( task )
import qualified Tasks.Isomorphism as Isomorphism ( task )
import qualified Tasks.StatementModel as StatementModel ( task )
import qualified Tasks.StatementEquivalent as StatementEquivalent ( task )
import qualified Tasks.StatementTransform as StatementTransform ( task )
import qualified Tasks.StatementCNF as StatementCNF ( task )
import qualified Tasks.StatementDNF as StatementDNF ( task )
import qualified Tasks.GraphParam as GraphParam ( task )
import Data.Foldable (find)
import Data.Char (toLower)
import Data.Function (on)


tasks :: [Task]
tasks =
    [ StatementModel.task
    , StatementEquivalent.task
    , StatementTransform.task
    , StatementCNF.task
    , StatementDNF.task
    , Set.task
    , MultiSet.task
    , Relation.task
    , Graphs.task
    , Circle.task
    , Hamilton.task
    , Bipartit.task
    , Isomorphism.task
    , GraphParam.task
    , Structures.task
    ]

app :: String -- ^ task type
    -> TaskInput -- ^ task description
    -> TaskResult String -- ^ output
app t d = case findTask t of
    (Just t) -> runTask t d
    _        -> Error $ "Task '" ++ t ++ "' not found."

taskHelp t = case findTask t of
    (Just t) -> describeTask t
    _        -> unknownTasktype t

taskTypeDescriptions :: [String]
taskTypeDescriptions = map shortDescribeTask tasks

-- help :: String
-- help = unlines $
--     [ "USAGE"
--     , "  <task> <task description file>"
--     , "  help <task>"
--     , "  help"
--     , ""
--     , "TASK TYPES"
--     ] ++ map (("  "++) . shortDescribeTask) tasks
findTask t = find (compare t . name) tasks
    where compare = (==) `on` map toLower

unknownTasktype t = "Unknown task type '" ++ t ++ "'. Available tasks are:\n" ++ taskTypes
    where taskTypes = unlines $ map (\t -> " - " ++ name t) tasks
