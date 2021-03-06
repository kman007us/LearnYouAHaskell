-- BROKEN since it only includes 1 head, i.e. 
-- [1,2,3,1,1] will show up as [1,2,3], excluding the other 2 1's

split' :: (Ord a) => [a] -> a -> Ordering -> [a]
split' [] _ _ = []
split' (x:xs) a LT
  | x < a     = x : split' xs a LT
  | otherwise = split' xs a LT 
split' (x:xs) a GT
  | x > a     = x : split' xs a GT
  | otherwise = split' xs a GT
-- non-exhaustive, unacceptable

quicksort :: (Ord a) => [a] => [a]
quicksort [] = []
quicksort (x:xs) 
   | isSorted' rs rs (head rs) = rs
   | otherwise = quicksort left ++ [x] ++ quicksort right
     where left = split' xs x LT
           right = split' xs x GT
           rs = left ++ [x] ++ right

-- caller should not have to provide list twice
isSorted' :: (Ord a) => [a] -> [a] -> a -> Bool
isSorted' [] [] _ = True
isSorted' (x:xs) [] _ = isSorted' xs xs (head xs)
isSorted' orig (x:xs) a
  | a > x     = False             -- includes a needless check on comparing to head
  | otherwise = isSorted' orig xs a

-- for the [a], does an item exists that satisfies the predicate?
find' :: [a] -> (a -> Bool) -> Bool
find' [] _ = False
find' (x:xs) f 
  | f x = True
  | otherwise = find' xs f 

gt' :: (Ord a) => a -> a -> Bool
gt' a b 
 | a > b     = True
 | otherwise = False

isSortedd :: (Ord a) => [a] -> Bool
isSortedd [] = True
isSortedd (x:xs) 
  | find' rs (== True) = False -- when applying gt' to each item, we found a "True"
  | otherwise = isSortedd xs
  where rs = map (gt' x) xs