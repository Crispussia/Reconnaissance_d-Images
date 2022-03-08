clear all;
close all;
clc;
nb_classe =50;% défini le nombre de classe 
nb_image =12;% défini le nombre d’images par classe
nb_ima_train=6;% défini le nombre d’images d’apprentissage par classe
nb_bins = 4096;% défini la taille de l’histogramme des LBP considéré
%% Analyse centrée sur le visage
%% 13)
% faceDetector = vision.CascadeObjectDetector;
% I = imread('Base\1-06.jpg');
% bboxes=faceDetector(I); 
% % IFaces = insertObjectAnnotation(I,'rectangle',bboxes,'Face');   
% % figure
% % imshow(IFaces)
% % title('Detected faces');
% I2 = imcrop(I,bboxes);
% % figure
% % imshow(I2)
% imwrite(I2,'NouvelleBase\1-06.jpg');
%%
comp_train =1;
faceDetector = vision.CascadeObjectDetector;
j=1;
tic
for i =1:nb_image*nb_classe 
   
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
        if( num_image~=1 && num_image~=2 && num_image~=9 && num_image~=10)
            Ima_train = imread ( fichier_train ) ;
            bboxes=faceDetector(Ima_train); 
            if (size(bboxes,1)~=1)
               I2 = imcrop(Ima_train,bboxes(2,:));
            else
               I2 = imcrop(Ima_train,bboxes);
            end
            imwrite(I2,['NouvelleBase\' num2str(num_classe_train(comp_train)) '-0' num2str(j ) '.jpg']);
                j=j+1;
                if(j==9)
                    j=1;
                end
        end
       
        comp_train = comp_train + 1;
   
end