clear all;
clc;

%-------------------------------Escolha a fonte utilizada-------------------------------%
seno = 0;
impulso = 0;
degrau = 1;


%---------------------------Escolha a condutividadae elétrica---------------------------%
%Valores obtidos em https://en.wikipedia.org/wiki/Electrical_resistivity_and_conductivity

% Vácuo
sigma = 0;

% PET
% sigma = 10^(-21);

% Borracha
% sigma = 10^(-14);

% Vidro
% sigma = 10^(-11);

% Água destilada
% sigma = 5.5*10^(-6);

% Madeira Úmida
% sigma = 10^(-3);

% Platina
% sigma = 9.43*10^(6);


%--------------------------------Constantes do simulador--------------------------------%
Nt = 300;           %Quantidade de dt
Nx = 200;           %Quantidade de dx
Ny = 200;           %Quantidade de dy

%vácuo:
epsilon = 8.854*10^(-12);   %permissividade elétrica
mi = 4*pi*10^(-7);          %permeabilidade  magnética
sigmaEstrela = 0;           %perda magnética equivalente

c = 1/sqrt(mi * epsilon);   %velocidade da luz

dx = 15*10^(3);
dt = 1.000*(dx/(c*sqrt(2)));
delta = dx;

Ca = (2*epsilon - sigma*dt)/(2*epsilon + sigma*dt);
Cb = (2*dt)/(delta*(2*epsilon + sigma*dt));

Da = (2*mi - sigmaEstrela*dt)/(2*mi + sigmaEstrela*dt);
Db = (2*dt)/(delta*(2*mi + sigmaEstrela*dt));

%matrizes
Ez = zeros(Nx,Ny,Nt);
Hx = zeros(Nx,Ny,Nt);
Hy = zeros(Nx,Ny,Nt);


%--------------------------------inicio do processo--------------------------------%
centerX = round(Nx / 2);
centerY = round(Ny / 2);

titulo = ' ';
if degrau == 1
    titulo = '\fontsize{10}Plot de E_z usando excitação tipo degrau e na interação = ';
elseif impulso == 1
     Ez(centerX, centerY, 1) = 1;
     Ez(centerX, centerY, 2) = 1;
    titulo = '\fontsize{10}Plot de E_z usando excitação tipo impulso e na interação = ';
elseif seno == 1
    titulo = '\fontsize{10}Plot de E_z usando excitação tipo seno e na interação = ';
end


%--------------------------------inicio da iteracao--------------------------------%
for n = 2:(Nt-1)      
    for x = 1:(Nx-1)
        for y = 1:(Ny-1)
             Hx(x, y, n) = Da*Hx(x, y, n-1) + Db*(Ez(x, y, n) - Ez(x, y+1, n));
        end
    end

    for x = 1:(Nx-1)
        for y = 1:(Ny-1)
             Hy(x, y, n) = Da*Hy(x, y, n-1) + Db*(Ez(x+1, y, n) - Ez(x, y, n));
        end
    end
    
    for x = 3:(Nx-2)
        for y = 3:(Ny-2)
            Ez(x, y, n+1) = Ca*Ez(x, y, n) + Cb*(Hy(x, y, n) - Hy(x-1, y, n) + Hx(x, y-1, n) - Hx(x, y, n));
        end
    end
    
    %Força a excitação
    %a fonte impulso não força nenhuma excitação durante a execução das
    %interações
    if degrau == 1
        Ez(centerX, centerY, n+1) = 1;
    elseif seno == 1
        Ez(centerX, centerY, n+1) = sin(n*2*pi*5/Nt);
    end
    
    %Condições de borda
    Ez(1:Nx, 1  , n+1)=0;
    Ez(1:Nx, Ny , n+1)=0;
    Ez(1   ,1:Ny, n+1)=0;
    Ez(Nx  ,1:Ny, n+1)=0;
            
end


x = 1:1:Nx;
for n=1:Nt              
    f1 = figure(1);
    tiledlayout(2,1)
    mesh(x,x,Ez(:,:,n),'linewidth',2);
    zlim([-1 1]);

    xlabel('X \rightarrow');
    ylabel('\leftarrow Y');
    zlabel('E_z \rightarrow');
    
    titlestring=[titulo num2str(n)];
    title(titlestring,'color','k','FontSize',12);
    
	grid on
	grid minor
    
    
    f2 = figure(2);
    imagesc(delta*(1:1:Nx)*1e+6,(1e+6*delta*(1:1:Ny))',Ez(:,:,n)',[-0.5,0.5]);colorbar;
    title([titulo num2str(n)]); 
    xlabel('X');
    ylabel('Y');

%     if(mod(n,20) == 0)
%         saveas(f1,sprintf('e3_9_Ez_3d_i%d.png',n));
%         saveas(f2,sprintf('e3_9_Ez_2d_i%d.png',n));
%     end
% 	getframe();
%     pause;
	
end

