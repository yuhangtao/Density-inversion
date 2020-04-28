clc;
clear;
load B;
load point_mass.mat
[ x ] = inverse( 'density_D1.txt',B,L,point_mass );