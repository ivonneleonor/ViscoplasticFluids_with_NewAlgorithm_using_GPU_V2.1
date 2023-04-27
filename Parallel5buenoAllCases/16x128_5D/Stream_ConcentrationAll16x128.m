clearvars
 clear data
 c = load('twoD2.txt');
 Psi = load('Stream2.txt');


%for time=[0,10,20,30,40]
s1=subplot(1,5,1)
n=15
m=127


%c1=c(1+n*time:n*time+n,1:m) 
c1=c(1+n*0:n*0+n,1:m)

h1=c1';
contourf(h1,50,'LineStyle','none');
xlabel('\phi', fontsize=50) 
ylabel('\xi', fontsize=50)
set(gca,'xtick',[],fontsize=10);
set(gca,'ytick',[],fontsize=10);

xticks([1 7.5 15])
xticklabels({'0','0.5','1.0'})
 
yticks([0 12.7 25.4 38.1 50.8 63.5 76.2 88.9 101.6 114.3 127])
yticklabels({'0','1.0','2.0','3.0','4.0','5.0','6.0','7.0','8.0','9.0','10.0'})


 hold on

Psi1=Psi(1+n*0:n*(0+1),1:m);

h2=(Psi1/2)';
[C,h] =contour(h2,10,'linewidth',1)
h.LineColor = [1 1 1];
set(s1,'Units','normalized', 'position', [0.2 0.13 0.09 0.82]);


s2=subplot(1,5,2)


c1=c(1+n*1:n*1+n,1:m)

h1=c1';
contourf(h1,50,'LineStyle','none');
xlabel('\phi', fontsize=50) 

set(gca,'xtick',[],fontsize=10);
set(gca,'ytick',[],fontsize=10);

xticks([1 7.5 15])
xticklabels({'0','0.5','1.0'})
 
yticks([0 12.7 25.4 38.1 50.8 63.5 76.2 88.9 101.6 114.3 127])
yticklabels({'0','1.0','2.0','3.0','4.0','5.0','6.0','7.0','8.0','9.0','10.0'})

 set(gca,'ytick',[])
 set(gca,'yticklabel',[])

hold on



Psi1=Psi(1+n*1:n*(1+1),1:m);

h2=(Psi1/2)';
[C,h] =contour(h2,10,'linewidth',1)
set(s2,'Units','normalized', 'position', [0.35 0.13 0.09 0.82]);h.LineColor = [1 1 1];


s3=subplot(1,5,3)

c1=c(1+n*2:n*2+n,1:m)

h1=c1';
contourf(h1,50,'LineStyle','none');
xlabel('\phi', fontsize=50) 

set(gca,'xtick',[],fontsize=10);
set(gca,'ytick',[],fontsize=10);


xticks([1 7.5 15])
xticklabels({'0','0.5','1.0'})
 
yticks([0 12.7 25.4 38.1 50.8 63.5 76.2 88.9 101.6 114.3 127])
yticklabels({'0','1.0','2.0','3.0','4.0','5.0','6.0','7.0','8.0','9.0','10.0'})



 set(gca,'ytick',[])
 set(gca,'yticklabel',[])

hold on


Psi1=Psi(1+n*2:n*(2+1),1:m);

h2=(Psi1/2)';
[C,h] =contour(h2,10,'linewidth',1)
h.LineColor = [1 1 1];
set(s3,'Units','normalized', 'position', [0.5 0.13 0.09 0.82]);

s4=subplot(1,5,4)

c1=c(1+n*3:n*3+n,1:m)

h1=c1';
contourf(h1,50,'LineStyle','none');
xlabel('\phi', fontsize=50) 

set(gca,'xtick',[],fontsize=10);
set(gca,'ytick',[],fontsize=10);

xticks([1 7.5 15])
xticklabels({'0','0.5','1.0'})
 
yticks([0 12.7 25.4 38.1 50.8 63.5 76.2 88.9 101.6 114.3 127])
yticklabels({'0','1.0','2.0','3.0','4.0','5.0','6.0','7.0','8.0','9.0','10.0'})



 set(gca,'ytick',[])
 set(gca,'yticklabel',[])

hold on


Psi1=Psi(1+n*3:n*(3+1),1:m);

h2=(Psi1/2)';
[C,h] =contour(h2,10,'linewidth',1)
h.LineColor = [1 1 1];
set(s4,'Units','normalized', 'position', [0.65 0.13 0.09 0.82]);

s5=subplot(1,5,5)

c1=c(1+n*4:n*4+n,1:m)

h1=c1';
contourf(h1,50,'LineStyle','none');
xlabel('\phi', fontsize=50) 

set(gca,'xtick',[],fontsize=10);
set(gca,'ytick',[],fontsize=10);

xticks([1 7.5 15])
xticklabels({'0','0.5','1.0'})
 
yticks([0 12.7 25.4 38.1 50.8 63.5 76.2 88.9 101.6 114.3 127])
yticklabels({'0','1.0','2.0','3.0','4.0','5.0','6.0','7.0','8.0','9.0','10.0'})

c=colorbar;
%c = colorbar('Location','eastoutside');
title(c,'Concentration')


set(gca,'ytick',[])
set(gca,'yticklabel',[])

hold on


Psi1=Psi(1+n*4:n*(4+1),1:m);

h2=(Psi1/2)';
[C,h] =contour(h2,10,'linewidth',1)
h.LineColor = [1 1 1];

set(s5,'Units','normalized', 'position', [0.8 0.13 0.09 0.82]);


disp('exportgraphics')%for R2020a or newer https://de.mathworks.com/help/matlab/ref/exportgraphics.html
exportgraphics(gcf,'CaseD.eps','BackgroundColor','none','ContentType','vector')
exportgraphics(gcf,'CaseD.pdf','BackgroundColor','none','ContentType','vector')
