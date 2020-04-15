function [ L000,L200,L020,L002 ] = tesseroid1( r,fai,lamda,r0,fai0,lamda0 )
%TESSEROID1 Summary of this function goes here
%   Detailed explanation goes here
cosfai=cos(fai);
sinfai=sin(fai);
% coslamda=cos(lamda);
% sinlamda=sin(lamda);
cosfai0=cos(fai0);
sinfai0=sin(fai0);
% coslamda0=cos(lamda0);
% sinlamda0=sin(lamda0);
dlamda=lamda0-lamda;
cosdlamda=cos(dlamda);
sindlamda=sin(dlamda);

cosdis=sinfai*sinfai0+cosfai*cosfai0*cosdlamda;
sindis=sqrt(1-cosdis^2);

l0=sqrt(r^2+r0^2-2*r*r0*cosdis);

L000=r0^2*(r-r0*cosdis)*cosfai0/l0^3;

L200=r*cosfai0/l0^3*(2-3*r0/l0^2*(5*r0-(2*r+3*r0*cosdis)*cosdis)+15*r0^3/l0^4*sindis^2*(r0-r*cosdis));

L020=(r0/l0)^3*cosfai*(1-2*sinfai0^2)*cosdlamda+r0^2/l0^5*(-r*(r^2+r0^2)*cosfai0+...
    r0*sinfai*(-r*r0*(sinfai*cosfai0-cosfai*sinfai0*cosdlamda)+sinfai0*cosfai0*(2*r^2+4*r0^2-3*r*r0*sinfai*sinfai0))+...
    r0^2*cosfai*cosdlamda*(1-2*sinfai0^2)*(r0+r*cosfai*cosfai0*cosdlamda)+...
    r*r0^2*cosfai*sinfai0*cosfai0*cosdlamda*(3*sinfai*cosfai0-4*cosfai*sinfai0*cosdlamda))+...
    5*r*r0^3/l0^7*(-r*(r^2+r0^2)*sinfai0+r0^2*cosfai*sinfai0*cosfai0*cosdlamda*(r0+r*cosfai*cosfai0*cosdlamda)+...
    r0*sinfai*(2*r^2-r0^2-r*r0*cosdis+sinfai0^2*(r^2+2*r0^2-r*r0*sinfai*sinfai0)))*(sinfai*cosfai0-cosfai*sinfai0*cosdlamda);

L002=r0^3/l0^3*cosfai*cosfai0^2*(cosdlamda-3*r/l0^2*(2*r0*cosfai*cosfai0*sindlamda^2+(r-r0*cosdis)*cosdlamda)+...
    15*r^2*r0/l0^4*cosfai*cosfai0*(r-r0*cosdis)*sindlamda^2);


end

