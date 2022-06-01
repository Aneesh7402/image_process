clc
close all
warning off

[file, path] = uigetfile('*.jpg', 'Pick the image to be processed');
if isequal(file,0) || isequal(path,0)
    disp('Process terminated!! File not retrieved')
else
    file=strcat(path,file);
    orgImage=imread(file);
    k=input('Enter the k value: ');
    figure(1);
    imshow(orgImage);
    title('Original Image');
    figure(2);
    subplot(1,2,1)
    imshow(orgImage);
    title('Image before Clustering');
    redvalue=orgImage(:, :, 1);
    greenvalue=orgImage(:, :, 2);
    bluevalue=orgImage(:, :, 3);
    dataset=double([redvalue(:), greenvalue(:), bluevalue(:)]);
    
    [m ,n]=kmeans(dataset,k);
    
    
    m=reshape(m,size(orgImage,1),size(orgImage,2));
     
    hex=rgb2hex(n);
    n=n/255;
    clusteredImage=label2rgb(m,n);
    subplot(1,2,2);
    imshow(clusteredImage);
    title('Image after Clustering');
    freq=[];
    temp=0;
    for i = 1:k
        for a=1:size(orgImage,1)
            for b=6:size(orgImage,2)
                if(m(a,b)==i)
                    temp=temp+1;
                end
            end
        end
        freq=[freq temp];
        temp=0;
    end
     clred=clusteredImage(:, :, 1);
   
    clred=clred(:)';
    clrgreen=clusteredImage(:, :, 2);

    clrgreen=clrgreen(:)';
    clblue=clusteredImage(:, :, 3);
    clblue=clblue(:)';
    
    
    ogred=orgImage(:, :, 1);
    
    ogred=ogred(:)';
    oggreen=orgImage(:, :, 2);
    
    oggreen=oggreen(:)';
    ogblue=orgImage(:, :, 3);
  
    ogblue=ogblue(:)';
    figure(3);
    subplot(1,2,2);
   
    scatter3(clred,clrgreen,clblue,'filled');
     
    title('Scatter plot after clustering');
    subplot(1,2,1);
   
    scatter3(ogred,oggreen,ogblue);
     title('Scatter plot before clustering');
     
    figure(4);
    
   
    p=pie(freq);
     title('Pie chart');
   
    colormap([n]);
    [clfreq ,clno]=max(freq);
    
    disp(n(clno,:));
    pText = findobj(p,'Type','text');
    percentValues = get(pText,'String'); 
    txt = hex; 
    str=' : ';
    combinedtxt = strcat(txt,str);
    combinedtxt1=strcat(combinedtxt,percentValues);
    for i=1:k
        pText(i).String = combinedtxt1(i);
    end
   
     
end
function [ hex ] = rgb2hex(rgb)


assert(nargin==1,'This function requires an RGB input.') 
assert(isnumeric(rgb)==1,'Function input must be numeric.') 
sizergb = size(rgb); 
assert(sizergb(2)==3,'rgb value must have three components in the form [r g b].')
assert(max(rgb(:))<=255& min(rgb(:))>=0,'rgb values must be on a scale of 0 to 1 or 0 to 255')

if max(rgb(:))<=1
    rgb = round(rgb*255); 
else
    rgb = round(rgb); 
end

hex(:,2:7) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
hex(:,1) = '#';
end
