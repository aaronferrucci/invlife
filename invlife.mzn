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
% N x M rectangle
% (N is horizontal length)
int: n = 5;
int: m = 5;
set of int: N = 1..n;
set of int: M = 1..m;
array[N, M] of var 0..1: grid;

% end_grid is initialized in a data file
array[N, M] of var 0..1: end_grid;

end_grid=[|
 0, 0, 0, 0, 0|
 0, 0, 1, 0, 0|
 0, 0, 1, 0, 0|
 0, 0, 1, 0, 0|
 0, 0, 0, 0, 0|];

constraint forall(i in N, j in M) (
  grid[i, j] = end_grid[i, j]
);

solve satisfy;

output
[show_int(1, grid[i, j]) ++ 
if j mod n == 0 then "\n" else " " endif 
| i in M, j in N];