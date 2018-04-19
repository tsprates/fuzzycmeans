%%
% Fuzzy c-means
% Autor: Thiago Silva
%

clc
clear all
close all

load ruspini.txt

% parâmetro de influência de pesos (m > 1)
m = 2;

% número de dados
n = length(ruspini);

% dimensões da base ruspini
p = size(ruspini, 2);

% parâmetro número de centróides (protótipos)
numcentros = 4;

% inicialmente centróides aleatoriamente
centros = ruspini(randperm(n, numcentros), :);

% matriz de distâncias
dist = zeros(n, numcentros);

% matriz de partição
u = zeros(n, numcentros);

% iterações
for ITER = 1:100
    
    % calcula as distâncias
    for i = 1:n
        for j = 1:numcentros
            dist(i, j) = 0;
            for k = 1:p
                dist(i, j) = dist(i, j) + (centros(j, k) - ruspini(i, k))^2;
            end
            dist(i, j) = sqrt(dist(i, j));
        end
    end
    
    % atualiza matriz de partição
    for i = 1:n
        for j = 1:numcentros
            u(i, j) = 1 / sum((dist(i, j) ./ dist(i, :)).^(2 / (m-1)));
            if isnan(u(i, j))
                u(i, j) = 1;
            end
        end
    end
    
    % atualiza os protótipos
    for i = 1:numcentros
        for j = 1:p
            centros(i, j) = sum(ruspini(:, j) .* u(:, i).^m) / sum(u(:, i).^m);
        end
    end
end

% gráficos de resultados
% base de dados em preto
plot(ruspini(:, 1), ruspini(:, 2), 'ko', 'MarkerFaceColor', 'k')
hold on
% protótipos em vermelho
plot(centros(:, 1), centros(:, 2), 'ro', 'MarkerFaceColor', 'r')
title('Fuzzy c-means - Ruspini')
