% Rules of life (https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
% At each step in time, the following transitions occur:
%
%  Any live cell with 0 or 1 live neighbours dies, as if caused by underpopulation.
%  Any live cell with 2 or 3 live neighbours lives on to the next generation.
%  Any live cell with more than 3 live neighbours dies, as if by overpopulation.
%  Any dead cell with exactly 3 live neighbours becomes a live cell, as if by reproduction.
%
% inverse rules:
%  a dead cell was:
%    live, with 0 or 1 live neighbors, or more than 3 live neighbors
%   or was
%    dead, with != 3 live neighbors
%  a live cell was:
%    live, with 2 or 3 live neighbors
%   or was
%    dead, with 3 live neighbors
%
% it's convenient to count live neighbors + self (n+s), which leads to these modified inverse rules:
%  a dead cell was:
%    live, with 1 or 2 n+s, or more than 4 n+s
%   or was
%    dead, with != 3 n+s
%  a live cell was:
%    live, with 3 or 4 n+s
%   or was
%    dead, with 3 n+s

% N x M rectangle
% (N is vertical dimension)
int: n;
int: m;
array[N, M] of var 0..1: end_grid;

set of int: N = 1..n;
set of int: M = 1..m;
array[N, M] of var 0..1: grid;

array[N, M] of var int: nps =
  array2d(N, M, [sum([grid[((j + n - 1 + y) mod n) + 1, ((i + m - 1 + x) mod m) + 1] | y in -1..1, x in -1..1]) | j in N, i in M]);

constraint forall (j in N, i in M) (
  end_grid[j, i] = 1 ->
    grid[j, i] = 1 /\ (nps[j, i] = 3 \/ nps[j, i] = 4)
      \/
    grid[j, i] = 0 /\ nps[j, i] = 3
);

constraint forall (j in N, i in M) (
  end_grid[j, i] = 0 ->
    grid[j, i] = 1 /\ (nps[j, i] = 1 \/ nps[j, i] = 2 \/ nps[j, i] > 4)
      \/
    grid[j, i] = 0 /\ nps[j, i] != 3
);

%constraint forall(j in N, i in M) (
%  ((end_grid[j, i] = 1) /\ (grid[j, i] = 1) /\ ((nps[j, i] == 3 \/ nps[j, i] == 4) \/
%                    (grid[j, i] = 0) /\ nps[j, i] != 3))
%    \/
%  ((end_grid[j, i] = 0) /\ (grid[j, i] = 1) /\ ((nps[j, i] == 1 \/ nps[j, i] == 2 \/ nps[j, i] > 4) \/
%                      (grid[j, i] = 0) /\ nps[j, i] != 3))
%);

solve satisfy;

output 
["grid:\n"] ++ [show_int(1, grid[j, i]) ++ if i mod m == 0 then "\n" else " " endif | j in N, i in M] ++ ["\n"] ++ 
["end_grid:\n"] ++ [show_int(1, end_grid[j, i]) ++ if i mod m == 0 then "\n" else " " endif | j in N, i in M] ++ ["\n"] ++ 
["nps:\n"] ++ [show_int(1, nps[j, i]) ++ if i mod m == 0 then "\n" else " " endif | j in N, i in M];
%output
%[show_int(1, s) ++ ", " ++show_int(1, grid[i, j]) ++ 
%if j mod n == 0 then "\n" else " " endif 
%| i in M, j in N];