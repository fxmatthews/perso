close all;
clear all;

champions = csvread('championsNoNamed.csv');
[n m] = size(champions);

				% On centre reduit les champions pour les mettre sur un pied d'egalite
mChampions = mean(champions);
varChampions = var(champions);
for i = 1:n
  champions(i,:) = (champions(i,:) - mChampions)./varChampions;
end

% chaque neurone doit etre de taille m (ou moins si on accepte
% coment formaliser le reseau ? on va essayer plusieurs cartes et voir ce
% que ça donne

%% Carte carree

nNeurones = 40;
norme = 2;
reseau = null(nNeurones);
				% initialisation
for i=1:nNeurones
  for j=1:nNeurones
    reseau(i,j).valeur = champions(1,:) + rand(1,m);
  end
end
pas = 0.1;
nbIterations = 1;
for z = 1 : nbIterations
  pas = pas - pas/4;
  for k=2:n
				% Determination neurone de norme minimum
    indicesMin = [1 1]; % comment determiner epsilon ? la norme ?
    for i=1:nNeurones
      for j=1:nNeurones
        if norm(reseau(i,j).valeur - champions(k,:), norme) < norm(reseau(indicesMin(1), indicesMin(2)).valeur - champions(k,:), norme)
          indicesMin = [i j];
        end
      end
    end
    iMin = indicesMin(1);
    jMin = indicesMin(2);
				% mise a jour de la carte
    for i=-1:1
      for j=-1:1
        iTmp = iMin+i;
        jTmp = jMin+j;
        if iTmp > 0 && iTmp <= nNeurones
          if jTmp > 0 && jTmp <= nNeurones
            tmp = reseau(iTmp, jTmp).valeur;
            reseau(iTmp, jTmp).valeur = tmp + pas * (tmp - champions(k,:));
          end
        end
      end
    end
  end
end

				% Arrichage des données

