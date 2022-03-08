clear all;
close all;
clc;

nb_classe =50;% défini le nombre de classe 
nb_image =8;% défini le nombre d’images par classe
nb_ima_train=4;% défini le nombre d’images d’apprentissage par classe
nb_bins = 4096;% défini la taille de l’histogramme des LBP considéré
%%  Apprentisage


Attributs_Y_i=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_I_i=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_Q_i=zeros( nb_ima_train*nb_classe,nb_bins );
comp_train =1;
j=1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)~=0)% les  images impaires constituent les images d’apprentissage
        %Enregistrement du numéro de la classe dans un tableau 
        num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,8);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image

            fichier_train=['NouvelleBase\' num2str(num_classe_train(comp_train)) '-0' num2str( num_image ) '.jpg'];

            % Affichage du numéro de la classe
            disp( [ fichier_train ' Classe ' num2str( num_classe_train ( comp_train))] );
            % Ouverture de l ’ image
            Ima_train = imread ( fichier_train ) ;
            
            
            [X_ImaT, Y_ImaT, Z_ImaT] = size(Ima_train);

            X_Imagette = floor(X_ImaT/5);

            Y_Imagette = floor(Y_ImaT/5);

            for x = 1:5

                for y = 1:5

                    bbx0 = (x-1)*X_Imagette + 1;

                    bby0 = (y-1)*Y_Imagette + 1;

                    bbx1 = (x-1)*X_Imagette + X_Imagette;

                    bby1 = (y-1)*Y_Imagette + Y_Imagette;

                    Imagette = Ima_train(bbx0:bbx1,bby0:bby1,:);
                    
                    yiq_image = rgb2ntsc(Imagette); 
                    % Extraction des composantes Y I Q
                    yiq_image_Y= yiq_image(:,:,1);
                    yiq_image_I= yiq_image(:,:,2);
                    yiq_image_Q= yiq_image(:,:,3);
                    
                    
                    Attributs_Y_i(j, :) = lbp(yiq_image_Y, 2, 12, 0, 'nh');
                    Attributs_I_i(j, :) = lbp(yiq_image_I, 2, 12, 0, 'nh');
                    Attributs_Q_i(j, :) = lbp(yiq_image_Q, 2, 12, 0, 'nh');

                    j=j+1;                    
                     comp_train = comp_train + 1;
                end 
            end          
           
    end
end
Attributs_YIQ = [Attributs_Y_i Attributs_I_i Attributs_Q_i ];
temps_extraction_apprentissage_YIQ=toc;       
%% Test
j=1;



Attributs_Y_test_i=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_I_test_i=zeros( nb_ima_train*nb_classe,nb_bins );
Attributs_Q_test_i=zeros( nb_ima_train*nb_classe,nb_bins );
comp_test =1;
tic
for i =1:nb_image*nb_classe 
    if(mod(i,2)==0)% les  images paires constituent les images de test
        %Enregistrement du numéro de la classe dans un tableau 
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        %Détermination du numéro de l’image
        num_image = 1 + mod( i-1,8);
        %Concaténation des chaînes de caractères
        %pour constituer le chemin d’accès au fichier image

           fichier_train=['NouvelleBase\' num2str(num_classe_test(comp_test)) '-0' num2str( num_image ) '.jpg'];

            % Affichage du numéro de la classe
            disp( [ fichier_train ' Classe ' num2str( num_classe_test ( comp_test))] );
            % Ouverture de l ’ image
            Ima_train = imread ( fichier_train ) ;
            
            [X_ImaT, Y_ImaT, Z_ImaT] = size(Ima_train);

            X_Imagette = floor(X_ImaT/5);

            Y_Imagette = floor(Y_ImaT/5);

            for x = 1:5

                for y = 1:5

                    bbx0 = (x-1)*X_Imagette + 1;

                    bby0 = (y-1)*Y_Imagette + 1;

                    bbx1 = (x-1)*X_Imagette + X_Imagette;

                    bby1 = (y-1)*Y_Imagette + Y_Imagette;

                    Imagette = Ima_train(bbx0:bbx1,bby0:bby1,:);
                    
                   
                    yiq_image = rgb2ntsc(Imagette); 
                    % Extraction des composantes Y I Q
                    yiq_image_Y= yiq_image(:,:,1);
                    yiq_image_I= yiq_image(:,:,2);
                    yiq_image_Q= yiq_image(:,:,3);
                    
                    
                    Attributs_Y_test_i(j, :) = lbp(yiq_image_Y, 2, 12, 0, 'nh');
                    Attributs_I_test_i(j, :) = lbp(yiq_image_I, 2, 12, 0, 'nh');
                    Attributs_Q_test_i(j, :) = lbp(yiq_image_Q, 2, 12, 0, 'nh');

                    j=j+1;            
                    
                    comp_test = comp_test + 1;
                    
     
                end
                
        
            end
                   
                      
         
    end
end
Attributs_test_YIQ=[Attributs_Y_test_i Attributs_I_test_i Attributs_Q_test_i];
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