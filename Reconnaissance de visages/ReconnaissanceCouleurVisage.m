clear all;
close all;
clc;

nb_classe =50;% d�fini le nombre de classe 
nb_image =8;% d�fini le nombre d�images par classe
nb_ima_train=4;% d�fini le nombre d�images d�apprentissage par classe
nb_bins = 4096;% d�fini la taille de l�histogramme des LBP consid�r�
%%  Apprentisage
Attributs_Y=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_I=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_Q=zeros( nb_ima_train*nb_classe,nb_bins );
comp_train =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d�apprentissage
        %Enregistrement du num�ro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %D�termination du num�ro de l�image
        num_image = 1 + mod( i-1,8);
        %Concat�nation des cha�nes de caract�res
        %pour constituer le chemin d�acc�s au fichier image

            fichier_train=['NouvelleBase\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];

            % Affichage du num�ro de la classe
            disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
            % Ouverture de l � image
            Ima_train = imread ( fichier_train ) ;
            yiq_image = rgb2ntsc(Ima_train); 
            % Extraction des composantes Y I Q
            yiq_image_Y= yiq_image(:,:,1);
            yiq_image_I= yiq_image(:,:,2);
            yiq_image_Q= yiq_image(:,:,3);

            % Extraction des attributs de texture
            Attributs_Y(comp_train, :) = lbp(yiq_image_Y, 2, 12, 0, 'nh');
            Attributs_I(comp_train, :) = lbp(yiq_image_I, 2, 12, 0, 'nh');
            Attributs_Q(comp_train, :) = lbp(yiq_image_Q, 2, 12, 0, 'nh');
            comp_train = comp_train + 1;
          
%         end
          
       
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
        %Enregistrement du num�ro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %D�termination du num�ro de l�image
        num_image = 1 + mod( i-1,8);
        %Concat�nation des cha�nes de caract�res
        %pour constituer le chemin d�acc�s au fichier image

           fichier_train=['NouvelleBase\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];

            % Affichage du num�ro de la classe
            disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
            % Ouverture de l � image
            Ima_train = imread ( fichier_train ) ;
            yiq_image = rgb2ntsc(Ima_train); 
            % Extraction des composantes H S V
            yiq_image_Y= yiq_image(:,:,1);
            yiq_image_I= yiq_image(:,:,2);
            yiq_image_Q= yiq_image(:,:,3);
            % Extraction des attributs de texture
            Attributs_test_Y(comp_test, :) = lbp(yiq_image_Y, 2, 12, 0, 'nh');
            Attributs_test_I(comp_test, :) = lbp(yiq_image_I, 2, 12, 0, 'nh');
            Attributs_test_Q(comp_test, :) = lbp(yiq_image_Q, 2, 12, 0, 'nh');
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
Temps_et_taux=zeros(1,4);
Temps_et_taux(1, 1) = temps_extraction_apprentissage_YIQ;
Temps_et_taux(1, 2) = temps_extraction_test_YIQ;
Temps_et_taux(1, 3) = temps_classification_YIQ;
Temps_et_taux(1, 4) = Taux_classification_YIQ;
