%   Code to draw figures of interface and stream function
%   for the 2D non-rotating code

clear all; clc;

%   Plot of interface
sZ = load('MeshSize.txt');
sizey = sZ(2)+1;
sizex = sZ(1)+1;

y = load('twoD.txt');
aux = length(y)/(sizex*sizey);
Y = reshape(y,sizey,sizex,aux);

phi = linspace(0,1,sizex); xi = linspace(0,30,sizey);
[P,Xi]= meshgrid(phi,xi);

[P,Xi]

figure
subplot(1,3,2)
    
for i = 1:aux,
    contour(P,Xi,Y(:,:,i),[1],'b')
    hold on
end

ylabel('Interface','fontsize',14)
title('Fully 2D Simulation with Fitted Curve')

% plot of \Psi at each time interval with moving frame
clear y
y = load('Stream.txt');
Y = reshape(y,sizey,sizex,aux);

sizey,sizex,aux


i = 0;
while i<aux & i<6,
    i = i+1;
    if i ==1 | i==4,
        figure
    end
    mod(i-1,3)+1
    subplot(1,3,mod(i-1,3)+1)
    [C,h] = contour(P,Xi,Y(:,:,i),[.1,.5,.7]);
    clabel(C,h)
    colormap spring
    hold on
end


hold off