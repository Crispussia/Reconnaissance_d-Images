clear all;
close all;
clc;
%% 2  Caractérisation : extraction des attributs de texture

%1)
I=imread('./Base/1-03.jpg');
I_gray=rgb2gray(I);
figure;
subplot(1,2,1);imshow(I); title('Image Originale');
subplot(1,2,2);imshow(I_gray); title('Image intensié');

%2)
R=1;
N=8;
Attributs=lbp(I_gray,R,N,0,'h');
figure;
plot(Attributs);
title('Histogramme LBP sous forme Classique');

%3
R1=1;
N1=8;
R2=2;
N2=12;
R3=4;
N3=16;

Att1_Classique=lbp(I_gray,R1,N1,0,'h');
Att2_Classique=lbp(I_gray,R2,N2,0,'h');
Att3_Classique=lbp(I_gray,R3,N3,0,'h');
figure;
subplot(1,3,1);plot(Att1_Classique); title('Histogramme LBP Classique  avec (R,N)=(1,8)');
subplot(1,3,2);plot(Att2_Classique); title('Histogramme LBP Classique  avec (R,N)=(2,12)');
subplot(1,3,3);plot(Att3_Classique); title('Histogramme LBP Classique  avec (R,N)=(4,16)');


map1_Uniforme=getmapping(N1,'u2');
Att1_Uniforme=lbp(I_gray,R1,N1,map1_Uniforme,'h');
map2_Uniforme=getmapping(N2,'u2');
Att2_Uniforme=lbp(I_gray,R2,N2,map2_Uniforme,'h');
map3_Uniforme=getmapping(N3,'u2');
Att3_Uniforme=lbp(I_gray,R3,N3,map3_Uniforme,'h');
figure;
subplot(1,3,1);plot(Att1_Uniforme); title('Histogramme LBP uniforme  avec (R,N)=(1,8)');
subplot(1,3,2);plot(Att2_Uniforme); title('Histogramme LBP uniforme  avec (R,N)=(2,12)');
subplot(1,3,3);plot(Att3_Uniforme); title('Histogramme LBP uniforme  avec (R,N)=(4,16)');


map1_Rotation=getmapping(N1,'ri');
Att1_Rotation=lbp(I_gray,R1,N1,map1_Rotation,'h');
map2_Rotation=getmapping(N2,'ri');
Att2_Rotation=lbp(I_gray,R2,N2,map2_Rotation,'h');
map3_Rotation=getmapping(N3,'ri');
Att3_Rotation=lbp(I_gray,R3,N3,map3_Rotation,'h');
figure;
subplot(1,3,1);plot(Att1_Rotation); title('Histogramme LBP rotation  avec (R,N)=(1,8)');
subplot(1,3,2);plot(Att2_Rotation); title('Histogramme LBP rotation  avec (R,N)=(2,12)');
subplot(1,3,3);plot(Att3_Rotation); title('Histogramme LBP rotation  avec (R,N)=(4,16)');

map1_riu2=getmapping(N1,'riu2');
Att1_riu2=lbp(I_gray,R1,N1,map1_riu2,'h');
map2_riu2=getmapping(N2,'riu2');
Att2_riu2=lbp(I_gray,R2,N2,map2_riu2,'h');
map3_riu2=getmapping(N3,'riu2');
Att3_riu2=lbp(I_gray,R3,N3,map3_riu2,'h');
figure;
subplot(1,3,1);plot(Att1_riu2); title('Histogramme LBP uniforme et rotation  avec (R,N)=(1,8)');
subplot(1,3,2);plot(Att2_riu2); title('Histogramme LBP uniforme et rotation  avec (R,N)=(2,12)');
subplot(1,3,3);plot(Att3_riu2); title('Histogramme LBP uniforme et rotation  avec (R,N)=(4,16)');



