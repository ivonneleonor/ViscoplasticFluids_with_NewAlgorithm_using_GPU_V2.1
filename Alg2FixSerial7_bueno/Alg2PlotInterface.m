% Example to plot streamlines and interface at a fix time for one run -- plot to be editted
%   for the 2D non-rotating code IN A MOVING FRAME

wanttoclear = 1;
if wanttoclear == 1,
    clear all; clc;
    wanttoclear = 1;
end

global kappa1 kappa2 rho1 rho2 e beta stokes deltat howmany P 
global Xi sizex sizey dx dy
global Z L

% create figure, with right size and color
figure(8); set(gcf,'position',[506 363 697 590],'Color','w')
fign='';
namesforfigs = ''; % put directory with text files
for ifig = 1:1,
    if wanttoclear == 1,
        % Concatenate file names
        meshfile = strcat(fign,'MeshSize','.txt');
        concentra = strcat(fign,'twoD','.txt');
        stream = strcat(fign,'Stream','.txt');
        paramfile = strcat(fign,'param','.txt');

%         [param_names, params] = textread(paramfile,'%s %f')
params=load('param.txt'); 
% kappa1 = params(1); kappa2 = params(2); rho1 = params(3); rho2 = params(4);
% e = params(5); beta = params(6); stokes = params(7); deltat = params(8);
% vC = params(9); wC = params(10); reciprocating = params(13);
% howmany = floor(params(11)/deltat)+1;
kappa1 = params(1,1); kappa2 = params(1,2); rho1 = params(2,1); rho2 = params(2,2);
e = params(5,1); beta = params(5,2); stokes = params(6,1); deltat = params(6,2); 
        
%         kappa1 = params(1); kappa2 = params(2); rho1 = params(3); rho2 = params(4);
%         e = params(5); beta = params(6); stokes = params(7); deltat = params(8);
%         vC = params(9); wC = params(10); reciprocating = params(13);
%         howmany = floor(params(11)/deltat)+1;



        %   Plot of interface
        sZ = load(meshfile); 
        sizey = sZ(2)+1; dy = sZ(4);
        sizex = sZ(1)*2+1; dx = sZ(3);

        L = sZ(2)/2*dy;

        y = load(concentra); 

        howmany = floor(length(y)/sizex/sizey)


        y = y(1:howmany*sizex*sizey,end);
        z = load(stream); z = z(1:howmany*sizex*sizey,end);

        aux = floor(length(y)/(sizex*sizey)); auz = floor(length(z)/(sizex*sizey));
        Y = reshape(y,sizex,sizey,aux); clear y
        Z = reshape(z,sizex,sizey,auz); clear z

        phi = linspace(0,1,sizex); xi = linspace(0,dy*(sizey-1),sizey);
        [Xi,P] = meshgrid(xi,phi); clear xi; clear phi
    end
    
    k = aux;
    h = gcf;
    axes('position',[0.065 0.74 .54 .8]); 
    hold on

   
    for i = 1:10,
        contour(Xi'-L+(i-1)*deltat,P',Y(:,:,i)',[.5],'k','linewidth',1.5)
        hold on        
    end
    
    
    
    set(gca,'XTick',[0:2:16],'fontsize',12,'box','on')
    xlim([0 16]); xlabel('$\xi$','fontsize',16,'interpreter','latex'); 
    ylim([-1 1]); ylabel('$\phi$','fontsize',16,'interpreter','latex')


    PsiStar = 2.0*(P + e/pi*sin(pi*P));


    hold on

    h = gcf;
    axes('position',[0.66 0.74-(ifig-1)*.33 .23 .23]); hold on
    
    pp3 = howmany;    
    minZ3 = min(min(min(Z(:,:,pp3))))*1.01
    maxZ3 = max(max(max(Z(:,:,pp3))))*1.01
    forcontour = linspace(minZ3,maxZ3,30);

    forXTicks = [-2:0.5:2];
%    forXlabels = {'-4';'-3';'-2';'-1';'0';'1';'2';'3';'4'};
    forXlims = [-2 2];

    [C,h]=contourf(Xi-L,P,Z(:,:,pp3),forcontour,'edgecolor','none');
    colormap bone; colorbar('position',[.9 0.74 .02 .8],'fontsize',9);
    hold on; contour(Xi'-L-dy/2,P',Y(:,:,pp3)'-.5,[0.0001],'k','linewidth',1.5)
    xlim(forXlims); ylim([-1,1])
    set(gca,'XTick',forXTicks,'fontsize',12,'box','on','lineWidth',2)
    %set(gca,'XTickLabel',forXlabels)
    set(gca,'YTick',[-1 0 1],'YTickLabel',{'-1';'0';'1'},'fontsize',12)
    title(['$t =$ ',num2str((pp3-1)*deltat,3)],'fontsize',16,'interpreter','latex');
    xlabel('$\xi$ - $t$','fontsize',16,'interpreter','latex'); 
    
end

