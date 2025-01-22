clc;
close all;
import ELSclique.*
rng(4)
N=100;%No of links

x=rand(1,N)*5;
y=rand(1,N)*5;

%scatter(x,y)
%Distance of the nodes
d=zeros(N,N);
for i=1:N
    for j=i+1:N
        d(i,j)=sqrt((x(j)-x(i))^2+(y(j)-y(i))^2);
        d(j,i)=d(i,j);
    end
end

%Selecting those nodes for edges which has distance less than or equal
% to 1

A=zeros(N);
for i=1:N
    for j=i+1:N
        if d(i,j)<=1
            A(i,j)=1;
            A(j,i)=1;
        end
    end
end

[cliques]=ELSclique(A);
log_cliques=full(cliques);
clique_size=zeros(1,size(log_cliques,2));
for i=1:length(clique_size)
     for j=1:size(log_cliques,1)
        if log_cliques(j,i)==1
            clique_size(i)=clique_size(i)+1;
        end    
     end 
end 
%figure(2)
%G=graph(A);
%plot(G,"XData",x,"YData",y)
%{
Adjust the adjacency matrix to ensure no clique is larger than the
maximum clique size
%}
for i = 1:size(log_cliques, 2)
    cliqueNodes = find(log_cliques(:, i)==1);
    if length(cliqueNodes) > 10
        % Remove edges to break the clique
        cliqueEdges = nchoosek(cliqueNodes, 2);
        for j = 1:size(cliqueEdges, 1)
            A(cliqueEdges(j, 1), cliqueEdges(j, 2)) = 0;
            A(cliqueEdges(j, 2), cliqueEdges(j, 1)) = 0;
        end
    end
end

[cliques_re]=ELSclique(A);
log_cliques_re=full(cliques_re);
clique_size_re=zeros(1,size(log_cliques_re,2));
for i=1:length(clique_size_re)
     for j=1:size(log_cliques_re,1)
        if log_cliques_re(j,i)==1
            clique_size_re(i)=clique_size_re(i)+1;
        end    
     end 
end
figure(3)
G_re=graph(A);
plot(G_re,"XData",x,"YData",y)
