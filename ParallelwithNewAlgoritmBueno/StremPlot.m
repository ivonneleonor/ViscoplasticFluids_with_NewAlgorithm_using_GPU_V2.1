clear all; clc;
%   Plot of interface
sZ = load('MeshSize.txt');
sizex = sZ(1)+1;
sizey = sZ(2)+1;
sizex
sizey
% aux = length(y)/(sizex*sizey);
clear y
y = load('Stream.txt');
%  Psi = reshape(y,sizey,sizex);
% contour(Psi',20,'linewidth',2);