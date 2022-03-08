clear all;
close all;
clc;

nb_classe =50;% défini le nombre de classe 
nb_image =12;% défini le nombre d’images par classe
nb_ima_train=4;% défini le nombre d’images d’apprentissage par classe
nb_bins = 256;% défini la taille de l’histogramme des LBP considéré
Attributs=zeros( nb_ima_train*nb_classe,nb_bins );
%%  Apprentisage
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs(comp_train, :) = lbp(Ima_gray_train, 1, 8, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage=toc;
%% 5)

J = imread('.\Base\2-02.jpg');
J_gray = rgb2gray(J);

Att_textures = lbp(J_gray, 1, 8, 0, 'h');

distances = zeros(size(Attributs,1), 1);
for i=1 : comp_train - 1
    distances(i) = sum(min(Att_textures, Attributs(i, :)));
end

[val, indice] = max(distances);

classe = num_classe_train(indice);
%% 6)
Attributs_test=zeros( nb_ima_train*nb_classe,nb_bins );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs_test(comp_test, :) = lbp(Ima_gray_train, 1, 8, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test, 1)
    distances = zeros(size(Attributs_test,1), 1);
    for i=1 :size(Attributs, 1)
        distances(i) = sum(min(Attributs_test(j,:), Attributs(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification = toc;
Taux_classification = compteur_im_bien_classees/size(Attributs_test, 1);

Temps_1_et_taux = zeros(4, 4);
Temps_1_et_taux(1, 1) = temps_extraction_apprentissage;
Temps_1_et_taux(2, 1) = temps_extraction_test;
Temps_1_et_taux(3, 1) = temps_classification;
Temps_1_et_taux(4, 1) = Taux_classification;


%La variable Temps_2_et_taux est un tableau qui contiendra les résultats
%obtenus après variation de R et N.
Temps_2_et_taux(1, 1) = temps_extraction_apprentissage;
Temps_2_et_taux(2, 1) = temps_extraction_test;
Temps_2_et_taux(3, 1) = temps_classification;
Temps_2_et_taux(4, 1) = Taux_classification;

% 7) Déjà effectué et ça fonctionne

%% 8) Vérifier les variables temps_extraction_apprentissage, temps_extraction_test, temps_classification

%% 9) Utilisons les différentes variantes de LBP

%% LBP Uniforme
nb_bins_unif = 59;
Attributs_unif=zeros( nb_ima_train*nb_classe, nb_bins_unif ); 
%Apprentisage
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        mapping_unif = getmapping(8, 'u2');
        Attributs_unif(comp_train, :) = lbp(Ima_gray_train, 1, 8, mapping_unif, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage_unif=toc;

Attributs_test_unif=zeros( nb_ima_train*nb_classe, nb_bins_unif );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        mapping = getmapping(8, 'u2');
        Attributs_test_unif(comp_test, :) = lbp(Ima_gray_train, 1, 8, mapping, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test_unif=toc;

compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_unif, 1)
    distances = zeros(size(Attributs_test_unif,1), 1);
    for i=1 :size(Attributs_unif, 1)
        distances(i) = sum(min(Attributs_test_unif(j,:), Attributs_unif(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_unif = toc;
Taux_classification_unif = compteur_im_bien_classees/size(Attributs_test_unif, 1);

Temps_1_et_taux(1, 2) = temps_extraction_apprentissage_unif;
Temps_1_et_taux(2, 2) = temps_extraction_test_unif;
Temps_1_et_taux(3, 2) = temps_classification_unif;
Temps_1_et_taux(4, 2) = Taux_classification_unif;

%La variable Temps_2_et_taux est un tableau qui contiendra les résultats
%obtenus après variation de R et N.
Temps_2_et_taux = zeros(4,3);
Temps_2_et_taux(1, 1) = temps_extraction_apprentissage_unif;
Temps_2_et_taux(2, 1) = temps_extraction_test_unif;
Temps_2_et_taux(3, 1) = temps_classification_unif;
Temps_2_et_taux(4, 1) = Taux_classification_unif;

%% LBP Invariant en Rotation
nb_bins_rot = 36;
Attributs_rot=zeros( nb_ima_train*nb_classe, nb_bins_rot ); 
%Apprentisage
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        mapping_rot = getmapping(8, 'ri');
        Attributs_rot(comp_train, :) = lbp(Ima_gray_train, 1, 8, mapping_rot, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage_rot=toc;

Attributs_test_rot=zeros( nb_ima_train*nb_classe, nb_bins_rot );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        mapping = getmapping(8, 'ri');
        Attributs_test_rot(comp_test, :) = lbp(Ima_gray_train, 1, 8, mapping, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test_rot=toc;

compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_rot, 1)
    distances = zeros(size(Attributs_test_rot,1), 1);
    for i=1 :size(Attributs_rot, 1)
        distances(i) = sum(min(Attributs_test_rot(j,:), Attributs_rot(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_rot = toc;
Taux_classification_rot = compteur_im_bien_classees/size(Attributs_test_rot, 1);

Temps_1_et_taux(1, 3) = temps_extraction_apprentissage_rot;
Temps_1_et_taux(2, 3) = temps_extraction_test_rot;
Temps_1_et_taux(3, 3) = temps_classification_rot;
Temps_1_et_taux(4, 3) = Taux_classification_rot;


%% LBP Uniforme Invariant en Rotation 
nb_bins_Unifrot = 10;
Attributs_rot=zeros( nb_ima_train*nb_classe, nb_bins_Unifrot ); 
%Apprentisage
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        mapping_Unifrot = getmapping(8, 'riu2');
        Attributs_Unifrot(comp_train, :) = lbp(Ima_gray_train, 1, 8, mapping_Unifrot, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage_Unifrot=toc;

Attributs_test_Unifrot=zeros( nb_ima_train*nb_classe, nb_bins_Unifrot);
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        mapping = getmapping(8, 'riu2');
        Attributs_test_Unifrot(comp_test, :) = lbp(Ima_gray_train, 1, 8, mapping, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test_Unifrot=toc;

compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_Unifrot, 1)
    distances = zeros(size(Attributs_test_Unifrot,1), 1);
    for i=1 :size(Attributs_Unifrot, 1)
        distances(i) = sum(min(Attributs_test_Unifrot(j,:), Attributs_Unifrot(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_Unifrot = toc;
Taux_classification_Unifrot = compteur_im_bien_classees/size(Attributs_test_Unifrot, 1);

Temps_1_et_taux(1, 4) = temps_extraction_apprentissage_Unifrot;
Temps_1_et_taux(2, 4) = temps_extraction_test_Unifrot;
Temps_1_et_taux(3, 4) = temps_classification_Unifrot;
Temps_1_et_taux(4, 4) = Taux_classification_Unifrot;


%% LBP Uniforme R=2 et N=12 avec R le rayon et N le nombre de voisins 
nb_bins = 4096;
Attributs=zeros( nb_ima_train*nb_classe, nb_bins ); 
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs(comp_train, :) = lbp(Ima_gray_train, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage=toc;


Attributs_test=zeros( nb_ima_train*nb_classe,nb_bins );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs_test(comp_test, :) = lbp(Ima_gray_train, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test, 1)
    distances = zeros(size(Attributs_test,1), 1);
    for i=1 :size(Attributs, 1)
        distances(i) = sum(min(Attributs_test(j,:), Attributs(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification = toc;
Taux_classification = compteur_im_bien_classees/size(Attributs_test, 1);


%La variable Temps_2_et_taux est un tableau qui contiendra les résultats
%obtenus après variation de R et N.
Temps_2_et_taux(1, 2) = temps_extraction_apprentissage;
Temps_2_et_taux(2, 2) = temps_extraction_test;
Temps_2_et_taux(3, 2) = temps_classification;
Temps_2_et_taux(4, 2) = Taux_classification;







%% LBP Uniforme R=4 et N=16 avec R le rayon et N le nombre de voisins 
nb_bins = 65536;
Attributs=zeros( nb_ima_train*nb_classe, nb_bins ); 
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs(comp_train, :) = lbp(Ima_gray_train, 4, 16, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage=toc;


Attributs_test=zeros( nb_ima_train*nb_classe,nb_bins );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs_test(comp_test, :) = lbp(Ima_gray_train, 4, 16, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test, 1)
    distances = zeros(size(Attributs_test,1), 1);
    for i=1 :size(Attributs, 1)
        distances(i) = sum(min(Attributs_test(j,:), Attributs(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification = toc;
Taux_classification = compteur_im_bien_classees/size(Attributs_test, 1);


%La variable Temps_2_et_taux est un tableau qui contiendra les résultats
%obtenus après variation de R et N.
Temps_2_et_taux(1, 3) = temps_extraction_apprentissage;
Temps_2_et_taux(2, 3) = temps_extraction_test;
Temps_2_et_taux(3, 3) = temps_classification;
Temps_2_et_taux(4, 3) = Taux_classification;






%% LBP Classique R=2 et N=12 avec R le rayon et N le nombre de voisins Distance de Manathan
nb_bins = 4096;
Attributs=zeros( nb_ima_train*nb_classe, nb_bins ); 
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs(comp_train, :) = lbp(Ima_gray_train, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage_Manathan=toc;


Attributs_test=zeros( nb_ima_train*nb_classe,nb_bins );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs_test(comp_test, :) = lbp(Ima_gray_train, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test_Manathan=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test, 1)
    distances = zeros(size(Attributs_test,1), 1);
    for i=1 :size(Attributs, 1)
        distances(i) = sum(min(Attributs_test(j,:), Attributs(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_Manathan = toc;
Taux_classification_Manathan = compteur_im_bien_classees/size(Attributs_test, 1);

Temps_et_Taux_Manathan=zeros(4, 1);
Temps_et_Taux_Manathan(1,1)=temps_extraction_apprentissage_Manathan;
Temps_et_Taux_Manathan(2,1)=temps_extraction_test_Manathan;
Temps_et_Taux_Manathan(3,1)=temps_classification_Manathan;
Temps_et_Taux_Manathan(4,1)=Taux_classification_Manathan;

%% 10

%% LBP Classique R=2 et N=12 avec R le rayon et N le nombre de voisins Distance Euclidienne
nb_bins = 4096;
Attributs=zeros( nb_ima_train*nb_classe, nb_bins ); 
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_train ( comp_train )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs(comp_train, :) = lbp(Ima_gray_train, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
temps_extraction_apprentissage=toc;


Attributs_test=zeros( nb_ima_train*nb_classe,nb_bins );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
    %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,12);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image
        if(num_image < 10)
            fichier_train=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];
        else
            fichier_train=['Base\' num2str(num_classe_test ( comp_test )) '-' num2str( num_image ) '.jpg' ] ;
        end
        % Affichage du numéro de la classe
        disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
        % Ouverture de l ’ image
        Ima_train = imread ( fichier_train ) ;
        % Conversionenniveaux de gris
        Ima_gray_train = rgb2gray ( Ima_train ) ;
        % Extraction des attributs de texture
        Attributs_test(comp_test, :) = lbp(Ima_gray_train, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
temps_extraction_test=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test, 1)
    distances = zeros(size(Attributs_test,1), 1);
    for i=1 :size(Attributs, 1)
        distances(i) = sqrt(sum((abs(Attributs_test(j,:)- Attributs(i, :))).^2));
    end

    [val, indice] = min(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification = toc;
Taux_classification_eucli = compteur_im_bien_classees/size(Attributs_test, 1);