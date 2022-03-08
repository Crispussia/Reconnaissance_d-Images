clear all;
close all;
clc;
%% 11)
nb_classe =50;% défini le nombre de classe 
nb_image =12;% défini le nombre d’images par classe
nb_ima_train=6;% défini le nombre d’images d’apprentissage par classe
nb_bins = 4096;% défini la taille de l’histogramme des LBP considéré
Attributs_R=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_G=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_B=zeros( nb_ima_train*nb_classe,nb_bins );
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
        % Extraction des composantes R G B
        Ima_train_R= Ima_train(:,:,1);
        Ima_train_G= Ima_train(:,:,2);
        Ima_train_B= Ima_train(:,:,3);
       
        % Extraction des attributs de texture
        Attributs_R(comp_train, :) = lbp(Ima_train_R, 2, 12, 0, 'h');
        Attributs_G(comp_train, :) = lbp(Ima_train_G, 2, 12, 0, 'h');
        Attributs_B(comp_train, :) = lbp(Ima_train_B, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
Attributs = [Attributs_R Attributs_G Attributs_B ];
temps_extraction_apprentissage=toc;
%% Test

Attributs_test_R=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_B=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_G=zeros( nb_ima_train*nb_classe,nb_bins );


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
         % Extraction des composantes R G B
        Ima_test_R= Ima_train(:,:,1);
        Ima_test_G= Ima_train(:,:,2);
        Ima_test_B= Ima_train(:,:,3);
       
        % Extraction des attributs de texture
        Attributs_test_R(comp_test, :) = lbp(Ima_test_R, 2, 12, 0, 'h');
        Attributs_test_G(comp_test, :) = lbp(Ima_test_G, 2, 12, 0, 'h');
        Attributs_test_B(comp_test, :) = lbp(Ima_test_B, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
Attributs_test=[Attributs_test_R Attributs_test_G Attributs_test_B];
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

Temps_et_taux = zeros(5, 4);
Temps_et_taux(1, 1) = temps_extraction_apprentissage;
Temps_et_taux(1, 2) = temps_extraction_test;
Temps_et_taux(1, 3) = temps_classification;
Temps_et_taux(1, 4) = Taux_classification;

%% 12
%% RGB->HSV
%%  Apprentisage
Attributs_H=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_S=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_V=zeros( nb_ima_train*nb_classe,nb_bins );
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
        hsv_image = rgb2hsv(Ima_train); 
        % Extraction des composantes H S V
        hsv_image_H= hsv_image(:,:,1);
        hsv_image_S= hsv_image(:,:,2);
        hsv_image_V= hsv_image(:,:,3);
       
        % Extraction des attributs de texture
        Attributs_H(comp_train, :) = lbp(hsv_image_H, 2, 12, 0, 'h');
        Attributs_S(comp_train, :) = lbp(hsv_image_S, 2, 12, 0, 'h');
        Attributs_V(comp_train, :) = lbp(hsv_image_V, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
Attributs_HSV = [Attributs_H Attributs_S Attributs_V ];
temps_extraction_apprentissage_HSV=toc;
%% Test

Attributs_test_H=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_S=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_V=zeros( nb_ima_train*nb_classe,nb_bins );


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
        hsv_image = rgb2hsv(Ima_train); 
        % Extraction des composantes H S V
        hsv_image_H= hsv_image(:,:,1);
        hsv_image_S= hsv_image(:,:,2);
        hsv_image_V= hsv_image(:,:,3);
        % Extraction des attributs de texture
        Attributs_test_H(comp_test, :) = lbp(hsv_image_H, 2, 12, 0, 'h');
        Attributs_test_S(comp_test, :) = lbp(hsv_image_S, 2, 12, 0, 'h');
        Attributs_test_V(comp_test, :) = lbp(hsv_image_V, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
Attributs_test_HSV=[Attributs_test_H Attributs_test_S Attributs_test_V];
temps_extraction_test_HSV=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_HSV, 1)
    distances = zeros(size(Attributs_test_HSV,1), 1);
    for i=1 :size(Attributs_HSV, 1)
        distances(i) = sum(min(Attributs_test_HSV(j,:), Attributs_HSV(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_HSV = toc;
Taux_classification_HSV = compteur_im_bien_classees/size(Attributs_test_HSV, 1);
Temps_et_taux(2, 1) = temps_extraction_apprentissage_HSV;
Temps_et_taux(2, 2) = temps_extraction_test_HSV;
Temps_et_taux(2, 3) = temps_classification_HSV;
Temps_et_taux(2, 4) = Taux_classification_HSV;

%% RGB->YIQ
%%  Apprentisage
Attributs_Y=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_I=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_Q=zeros( nb_ima_train*nb_classe,nb_bins );
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
        yiq_image = rgb2ntsc(Ima_train); 
        % Extraction des composantes Y I Q
        yiq_image_Y= yiq_image(:,:,1);
        yiq_image_I= yiq_image(:,:,2);
        yiq_image_Q= yiq_image(:,:,3);
       
        % Extraction des attributs de texture
        Attributs_Y(comp_train, :) = lbp(yiq_image_Y, 2, 12, 0, 'h');
        Attributs_I(comp_train, :) = lbp(yiq_image_I, 2, 12, 0, 'h');
        Attributs_Q(comp_train, :) = lbp(yiq_image_Q, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
Attributs_YIQ = [Attributs_Y Attributs_I Attributs_Q ];
temps_extraction_apprentissage_YIQ=toc;
%% Test

Attributs_test_Y=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_I=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_Q=zeros( nb_ima_train*nb_classe,nb_bins );


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
        yiq_image = rgb2ntsc(Ima_train); 
        % Extraction des composantes H S V
        yiq_image_Y= yiq_image(:,:,1);
        yiq_image_I= yiq_image(:,:,2);
        yiq_image_Q= yiq_image(:,:,3);
        % Extraction des attributs de texture
        Attributs_test_Y(comp_test, :) = lbp(yiq_image_Y, 2, 12, 0, 'h');
        Attributs_test_I(comp_test, :) = lbp(yiq_image_I, 2, 12, 0, 'h');
        Attributs_test_Q(comp_test, :) = lbp(yiq_image_Q, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
Attributs_test_YIQ=[Attributs_test_Y Attributs_test_I Attributs_test_Q];
temps_extraction_test_YIQ=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_YIQ, 1)
    distances = zeros(size(Attributs_test_YIQ,1), 1);
    for i=1 :size(Attributs_YIQ, 1)
        distances(i) = sum(min(Attributs_test_YIQ(j,:), Attributs_YIQ(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_YIQ = toc;
Taux_classification_YIQ = compteur_im_bien_classees/size(Attributs_test_YIQ, 1);
Temps_et_taux(3, 1) = temps_extraction_apprentissage_YIQ;
Temps_et_taux(3, 2) = temps_extraction_test_YIQ;
Temps_et_taux(3, 3) = temps_classification_YIQ;
Temps_et_taux(3, 4) = Taux_classification_YIQ;

%% RGB->LAB
%%  Apprentisage
Attributs_L=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_A=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_B=zeros( nb_ima_train*nb_classe,nb_bins );
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
        lab_image = rgb2lab(Ima_train); 
        % Extraction des composantes Y I Q
        lab_image_L= lab_image(:,:,1);
        lab_image_A= lab_image(:,:,2);
        lab_image_B= lab_image(:,:,3);
       
        % Extraction des attributs de texture
        Attributs_L(comp_train, :) = lbp(lab_image_L, 2, 12, 0, 'h');
        Attributs_A(comp_train, :) = lbp(lab_image_A, 2, 12, 0, 'h');
        Attributs_B(comp_train, :) = lbp(lab_image_B, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
Attributs_LAB = [Attributs_L Attributs_A Attributs_B ];
temps_extraction_apprentissage_LAB=toc;
%% Test

Attributs_test_L=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_A=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_B=zeros( nb_ima_train*nb_classe,nb_bins );


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
        lab_image = rgb2lab(Ima_train); 
        % Extraction des composantes H S V
        lab_image_L= lab_image(:,:,1);
        lab_image_A= lab_image(:,:,2);
        lab_image_B= lab_image(:,:,3);
        % Extraction des attributs de texture
        Attributs_test_L(comp_test, :) = lbp(lab_image_L, 2, 12, 0, 'h');
        Attributs_test_A(comp_test, :) = lbp(lab_image_A, 2, 12, 0, 'h');
        Attributs_test_B(comp_test, :) = lbp(lab_image_B, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
Attributs_test_LAB=[Attributs_test_L Attributs_test_A Attributs_test_B];
temps_extraction_test_LAB=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_LAB, 1)
    distances = zeros(size(Attributs_test_LAB,1), 1);
    for i=1 :size(Attributs_LAB, 1)
        distances(i) = sum(min(Attributs_test_LAB(j,:), Attributs_LAB(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_LAB = toc;
Taux_classification_LAB = compteur_im_bien_classees/size(Attributs_test_LAB, 1);
Temps_et_taux(5, 1) = temps_extraction_apprentissage_LAB;
Temps_et_taux(5, 2) = temps_extraction_test_LAB;
Temps_et_taux(5, 3) = temps_classification_LAB;
Temps_et_taux(5, 4) = Taux_classification_LAB;

%% RGB->YCbCr
%%  Apprentisage
Attributs_Y=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_Cb=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_Cr=zeros( nb_ima_train*nb_classe,nb_bins );
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
        ycbcr_image = rgb2ycbcr(Ima_train); 
        % Extraction des composantes Y I Q
        ycbcr_image_Y= ycbcr_image(:,:,1);
        ycbcr_image_Cb=ycbcr_image(:,:,2);
        ycbcr_image_Cr= ycbcr_image(:,:,3);
       
        % Extraction des attributs de texture
        Attributs_Y(comp_train, :) = lbp(ycbcr_image_Y, 2, 12, 0, 'h');
        Attributs_Cb(comp_train, :) = lbp(ycbcr_image_Cb, 2, 12, 0, 'h');
        Attributs_Cr(comp_train, :) = lbp(ycbcr_image_Cr, 2, 12, 0, 'h');
        
        comp_train = comp_train + 1;
    end
end
Attributs_YCbCr = [Attributs_Y Attributs_Cb Attributs_Cr ];
temps_extraction_apprentissage_YCbCr=toc;
%% Test

Attributs_test_Y=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_Cb=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_test_Cr=zeros( nb_ima_train*nb_classe,nb_bins );


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
        ycbcr_image = rgb2ycbcr(Ima_train); 
        % Extraction des composantes H S V
        ycbcr_image_Y= ycbcr_image(:,:,1);
        ycbcr_image_Cb= ycbcr_image(:,:,2);
        ycbcr_image_Cr= ycbcr_image(:,:,3);
        % Extraction des attributs de texture
        Attributs_test_Y(comp_test, :) = lbp(ycbcr_image_Y, 2, 12, 0, 'h');
        Attributs_test_Cb(comp_test, :) = lbp(ycbcr_image_Cb, 2, 12, 0, 'h');
        Attributs_test_Cr(comp_test, :) = lbp(ycbcr_image_Cr, 2, 12, 0, 'h');
        
        comp_test = comp_test + 1;
    end
end
Attributs_test_YCbCr=[Attributs_test_Y Attributs_test_Cb Attributs_test_Cr];
temps_extraction_test_YCbCr=toc;
compteur_im_bien_classees = 0;

tic
for j = 1:size(Attributs_test_YCbCr, 1)
    distances = zeros(size(Attributs_test_YCbCr,1), 1);
    for i=1 :size(Attributs_YCbCr, 1)
        distances(i) = sum(min(Attributs_test_YCbCr(j,:), Attributs_YCbCr(i, :)));
    end

    [val, indice] = max(distances);

    classe_image_test_estimee(j) = num_classe_train(indice);  
    
    if(classe_image_test_estimee(j) == num_classe_test(j))
        compteur_im_bien_classees = compteur_im_bien_classees + 1;
    end
    
end
temps_classification_YCbCr = toc;
Taux_classification_YCbCr = compteur_im_bien_classees/size(Attributs_test_YCbCr, 1);
Temps_et_taux(4, 1) = temps_extraction_apprentissage_YCbCr;
Temps_et_taux(4, 2) = temps_extraction_test_YCbCr;
Temps_et_taux(4, 3) = temps_classification_YCbCr;
Temps_et_taux(4, 4) = Taux_classification_YCbCr;

