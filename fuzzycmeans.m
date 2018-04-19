%%
% Fuzzy c-means
% Autor: Thiago Silva
%

load ruspini.txt

% parâmetro de influência de pesos (m > 1)
m = 2;

% dimensões da base ruspini
numvar = 2;

% parãmetro número de centróides (protótipos)
numcentros = 4;

% inicialmente centróides aleatoriamente
centros = ruspini(randperm(length(ruspini), numcentros), :);

% matriz de distâncias
dist = zeros(length(ruspini), numcentros);

% matriz de partição
u = zeros(length(ruspini), numcentros);

% iterações
ITER = 1;
while ITER < 100
    
    % calcula as distâncias
    for i=1:length(ruspini)
        for j=1:numcentros
            dist(i, j) = 0;
            for k=1:numvar
                dist(i, j) = dist(i, j) + (centros(j, k) - ruspini(i, k))^2;
            end
            dist(i, j) = sqrt(dist(i, j));
        end
    end
    
    % atualiza matriz de partição
    for i=1:length(ruspini)
        for j=1:numcentros
            u(i, j) = 1 / sum((dist(i, j) ./ dist(i, :)).^(2 / (m-1)));
            if isnan(u(i, j))
                u(i, j) = 1;
            end
        end
    end
    
    % atualiza os protótipos
    for i=1:numcentros
        for j=1:numvar
            centros(i, j) = sum(ruspini(:, j) .* u(:, i).^m) / sum(u(:, i).^m);
        end
    end
    
    ITER = ITER + 1;
end

% gráficos de resultados
% base de dados em preto
plot(ruspini(:, 1), ruspini(:, 2), 'ko', 'MarkerFaceColor', 'k')
hold on
% protótipos em vermelho
plot(centros(:, 1), centros(:, 2), 'ro', 'MarkerFaceColor', 'r')
title('Fuzzy c-means - Ruspini')
