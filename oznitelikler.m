function [X1 X2 X3 X4 X5 X6 X7 X8]=oznitelikler(image,image_temp, alt, ust)
%NOTE:

%Please perform the following steps in order

%-----------------------------------------------------------
% 1. Select the thermal image you will work with by pressing the "G�r�nt� A�" button.
% 2. Enter the "ALT" lower and "�ST" upper values (tempuratures) written in the thermal image into the relevant text boxes.
% 3. After pressing the "Kes" button, click your mouse twice to determine the area you will work on.
% 4. Enter the segmentation number in the two text boxes and click the "B�l�tleme" button.
% 5. After entering the Segmentation numbers to be analyzed, click the "Analize Ba�la" button.
%------------------------------------------------------------

% For more descriptive and theoretical information, you can review the article below.

% KATIRCIO�LU, F., C�NG�Z, Z., Yusuf, �. A. Y., G�REL, A. E., SARIDEM�R, S., & KOL�P,A. (2020)
% R22 ve Alternatifleri R438A ile R417A So�utucu Ak��kanlar� i�in K�z�l�tesi G�r�nt� ��leme Teknikleri Kullanarak, 
% So�utma Sistem Performans�n�n �ncelenmesi. Academic Platform Journal of Engineering and Science, 8(3), 500-513.
Temp=[];
Temp=image_temp;
for i=1:size(Temp,1)
    for j=1:size(Temp,2)
        if(Temp(i,j)>ust)
            Temp(i,j)=ust;
        end
        if(Temp(i,j)<alt)
            Temp(i,j)=alt;
        end
    end
end
%DENEME-------------
Temp1=round(Temp);
alt1=round(alt-1);
ust1=round(ust);
tekrar1=zeros(256,1);
tekrar2=zeros(256,1);
for i=1:size(Temp1,1)
    for j=1:size(Temp1,2)
        if(Temp1(i,j)>=0)
        if(Temp1(i,j)>ust)
            Temp1(i,j)=ust1;
        end
        value1=Temp1(i,j);
        tekrar1(value1+1)=tekrar1(value1+1)+1;
        end
        %-------------
        if(Temp1(i,j)<0)
        if(Temp1(i,j)<alt)
            Temp1(i,j)=alt1;
        end
        value2=abs(Temp1(i,j));
        tekrar2(value2+1)=tekrar2(value2+1)+1;
        end
    end
end

for i=1:size(Temp1,1)
    for j=1:size(Temp1,2)
        if(Temp1(i,j)>=0)
            if(tekrar1(Temp1(i,j)+1)>20)
            Temp1(i,j)=Temp1(i,j);
            else
                Temp(i,j)=mean(Temp1(:));
            end
        end
        if(Temp1(i,j)<0)
            if(tekrar2(abs(Temp1(i,j))+1)>3)
            Temp1(i,j)=Temp1(i,j);
            else
             Temp(i,j)=mean(Temp1(:));
            end
        end
    end
end
%--------------------------
I=rgb2gray(image);

% X1: Standart sapma
X1= std2(I);

% X2: Entropi
X2 = entropy(I);

%X3: Kontrast
% [count levels] = imhist(I); %Her bir gri seviye de�eri levels a kullan�m say�s� ise count a yaz�l�r.
max_deg =0;
min_deg =0;
max_deg =double(max(I(:))); %
min_deg =double( min(I(:)));
X3=double((max_deg-min_deg)/255);

% X4: Skewness
X4= mean(double(skewness(double(I))));

% X5: Maksimum y�zey s�cakl���
X5=max(Temp(:));


% X6: Minimum y�zey s�cakl���
X6=min(Temp(:));

% X7: Ortalama y�zey s�cakl���
X7=mean(Temp(:));

% X8: En yo�un y�zey s�cakl���
%----------------------------------
I1=round(Temp);
% Kullan�lacak olan de�i�kenler tan�mlan�p resmin boyutuna g�re s�f�rlan�yor
frekans=zeros(256,1);
frekans1=zeros(256,1);
% Her bir piksel de�erinin ka� kere oldu�unu sayarak kaydeder.
for i=1:size(I1,1)
    for j=1:size(I1,2)
        value=I1(i,j);
        if (value>=0)
       frekans(value+1)=frekans(value+1)+1; % �lgili gri seviye +1 saya� g�revi yaparak piksel say�s� bulunuyor
        else
        value=abs(value);
        frekans1(value+1)=frekans1(value+1)+1;
        end
    end
end

[count2, v] = max(frekans);
[count3, v1] = max(frekans1);%En b�y�k kullan�m say�s� ve s�ras� bulunur.
if (count2>count3)
    X8=v-1 ;%En yo�un gri seviye de�eri yaz�l�r.
else
    X8=(-v1+1); %En yo�un gri seviye de�eri yaz�l�r.
end
end

