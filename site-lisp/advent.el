(define-skeleton advent-day-hs
 "A template for advent of code days"
 "Day: "
 "module Day" str " (day" str ") where
import Game.Advent
import Paths_" (skeleton-read "Project name: ") " (getDataFileName)

datafile filename = getDataFileName filename >>= readFile

{- | Part 1.  Short description of the problem.
>>> d" str "p1 \"day" str "-ex.txt\"
\"TODO\"
-}
d" str "p1 filename = do
  input <- datafile filename
  return \"Day " str " Part 1 result\"

{- | Part 2.  Short description of the problem.
>>> d" str "p2 \"day" str "-ex.txt\"
\"TODO\"
-}
d" str "p2 filename = do
  input <- datafile filename
  return \"Day " str " Part 1 result\"


day" str " :: Day
day" str " =
  Day
    { dayName = \"" str "\",
      dayPart1 = d" str "p1 \"day" str ".txt\",
      dayPart2 = d" str "p1 \"day" str ".txt\",
    }")


