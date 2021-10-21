clear all;
close all;
clc;

[words1,MFs1,Cs1]=getFOUs1();
[words2,MFs2,Cs2]=getFOUs2();
[words3,MFs3,Cs3]=getFOUs3();

figure
set(gcf,'DefaulttextFontName','times new roman');
set(gcf,'DefaultaxesFontName','times new roman');
set(gcf,'DefaulttextFontAngle','italic');
set(gcf,'DefaulttextFontSize',7);

for i=1:11
    subplot(8,6,2*floor((i-1)/4)+i);
    fill(MFs1(i,[1:4 8 7 6 5 1]),[0 1 1 0 0 MFs1(i,9) MFs1(i,9) 0 0],[0.9 0.9 0.9]);
    hold on;
    plot(MFs1(i,1:4),[0 1 1 0],'k','linewidth',1);
    plot(MFs1(i,5:8),[0 MFs1(i,9) MFs1(i,9) 0],'k','linewidth',1);
    title(words1(i),'fontsize',7);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    axis([0 10 0 1]);
end
figure
set(gcf,'DefaulttextFontName','times new roman');
set(gcf,'DefaultaxesFontName','times new roman');
set(gcf,'DefaulttextFontAngle','italic');
set(gcf,'DefaulttextFontSize',7);

for i=1:13
    subplot(8,6,2*floor((i-1)/4)+i);
    fill(MFs2(i,[1:4 8 7 6 5 1]),[0 1 1 0 0 MFs2(i,9) MFs2(i,9) 0 0],[0.9 0.9 0.9]);
    hold on;
    plot(MFs2(i,1:4),[0 1 1 0],'k','linewidth',1);
    plot(MFs2(i,5:8),[0 MFs2(i,9) MFs2(i,9) 0],'k','linewidth',1);
    title(words2(i),'fontsize',7);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    axis([0 10 0 1]);
end
figure
set(gcf,'DefaulttextFontName','times new roman');
set(gcf,'DefaultaxesFontName','times new roman');
set(gcf,'DefaulttextFontAngle','italic');
set(gcf,'DefaulttextFontSize',7);

for i=1:5
    subplot(8,6,2*floor((i-1)/4)+i);
    fill(MFs3(i,[1:4 8 7 6 5 1]),[0 1 1 0 0 MFs3(i,9) MFs3(i,9) 0 0],[0.9 0.9 0.9]);
    hold on;
    plot(MFs3(i,1:4),[0 1 1 0],'k','linewidth',1);
    plot(MFs3(i,5:8),[0 MFs3(i,9) MFs3(i,9) 0],'k','linewidth',1);
    title(words3(i),'fontsize',7);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    axis([0 10 0 1]);
end

numStd=input('please enter number of Students : ');
numQues=input('please enter number of Questions  :  ');
numProf=input('please enter number of Professors :  ');


%{'fogholade nachiz'} --> 1
%{'fogholade kam'} --> 2
%{'kheily nachiz'} --> 3
%{'nachiz'} --> 4
%{'nesbatan nachiz'} --> 5
%{'kheily kam'} --> 6
%{'kam'} --> 7
%{'nesbatan kam'} --> 8
%{'motavaset'} --> 9
%{'nesbatan ziad'} --> 10
%{'ziad'} --> 11
%{'kheily ziad'} --> 12
%{'fogholade ziad'} --> 13

%reading weight of questions from Question sheet and fill Ws array.
%Ws is array of sorted words index of questions weights 
[~,Qinput]= xlsread('input.xlsx' , 'Questions');
[qrow,qcol] = size(Qinput);
Ws = ones (qrow,qcol);
for i = 1: qrow
    for j=1: qcol
        if(strcmp(Qinput(i,j),'fogholade nachiz') == 1)
            Ws(i,j)=1;
        elseif (strcmp(Qinput(i,j),'fogholade kam') == 1)
            Ws(i,j)=2;
        elseif (strcmp(Qinput(i,j),'kheily nachiz') == 1)
            Ws(i,j)=3;
         elseif (strcmp(Qinput(i,j),'nachiz') == 1)
            Ws(i,j)=4;
         elseif (strcmp(Qinput(i,j),'nesbatan nachiz') == 1)
            Ws(i,j)=5;
         elseif (strcmp(Qinput(i,j),'kheily kam') == 1)
            Ws(i,j)=6;
         elseif (strcmp(Qinput(i,j),'kam') == 1)
            Ws(i,j)=7;
         elseif (strcmp(Qinput(i,j),'nesbatan kam') == 1)
            Ws(i,j)=8;
         elseif (strcmp(Qinput(i,j),'motavaset') == 1)
            Ws(i,j)=9;
         elseif (strcmp(Qinput(i,j),'nesbatan ziad') == 1)
            Ws(i,j)=10;
         elseif (strcmp(Qinput(i,j),'ziad') == 1)
            Ws(i,j)=11;
         elseif (strcmp(Qinput(i,j),'kheily ziad') == 1)
            Ws(i,j)=12;
         elseif (strcmp(Qinput(i,j),'fogholade ziad') == 1)
            Ws(i,j)=13;
            
        end
    end
end


%Ws=[11
%    12
%   13
%  10
% 11
% 12
%  7
%  3
% 13
% 8]; % Question weights

 Ws=Ws';
%reading weight of professors from Professors sheet and fill Ws1 array.
%Ws1 is array of sorted words index of professor weights 
[~,Pinput]= xlsread('input.xlsx' , 'Professors');
[prow,pcol] = size(Pinput);
Ws1 = ones (prow,pcol);
for i = 1: prow
    for j=1: pcol
        if(strcmp(Pinput(i,j),'fogholade nachiz') == 1)
            Ws1(i,j)=1;
        elseif (strcmp(Pinput(i,j),'fogholade kam') == 1)
            Ws1(i,j)=2;
        elseif (strcmp(Pinput(i,j),'kheily nachiz') == 1)
            Ws1(i,j)=3;
         elseif (strcmp(Pinput(i,j),'nachiz') == 1)
            Ws1(i,j)=4;
         elseif (strcmp(Pinput(i,j),'nesbatan nachiz') == 1)
            Ws1(i,j)=5;
         elseif (strcmp(Pinput(i,j),'kheily kam') == 1)
            Ws1(i,j)=6;
         elseif (strcmp(Pinput(i,j),'kam') == 1)
            Ws1(i,j)=7;
         elseif (strcmp(Pinput(i,j),'nesbatan kam') == 1)
            Ws1(i,j)=8;
         elseif (strcmp(Pinput(i,j),'motavaset') == 1)
            Ws1(i,j)=9;
         elseif (strcmp(Pinput(i,j),'nesbatan ziad') == 1)
            Ws1(i,j)=10;
         elseif (strcmp(Pinput(i,j),'ziad') == 1)
            Ws1(i,j)=11;
         elseif (strcmp(Pinput(i,j),'kheily ziad') == 1)
            Ws1(i,j)=12;
         elseif (strcmp(Pinput(i,j),'fogholade ziad') == 1)
            Ws1(i,j)=13;
            
        end
    end
end

 %Ws1=[ 12 13 10 8 12 13 ]; % Professors weights

% result is a 3D matrix used for loading relevant FOU of each student
result = zeros(numStd,numProf,9);

%read each student data and fill result matrix with relevant FOU
for s=1 : numStd

[~,input] = xlsread('input.xlsx' , strcat ('student',int2str(s)));

[row,col] = size(input);

%std1 is array of sorted words index of student's answers 

std1= ones(row,col);

for i= 1: row
    for j=1: col
        if(strcmp(input(i,j),'gheire ghabele ghabool') == 1)
            std1(i,j)=1;
        elseif (strcmp(input(i,j),'kheily zaeif') == 1)
            std1(i,j)=2;
        elseif (strcmp(input(i,j),'zaeif') == 1)
            std1(i,j)=3;
         elseif (strcmp(input(i,j),'nesbatan zaeif') == 1)
            std1(i,j)=4;
         elseif (strcmp(input(i,j),'motavaset') == 1)
            std1(i,j)=5;
         elseif (strcmp(input(i,j),'ghabele ghabool') == 1)
            std1(i,j)=6;
         elseif (strcmp(input(i,j),'nesbatan khoob') == 1)
            std1(i,j)=7;
         elseif (strcmp(input(i,j),'khoob') == 1)
            std1(i,j)=8;
         elseif (strcmp(input(i,j),'kheily khoob') == 1)
            std1(i,j)=9;
         elseif (strcmp(input(i,j),'aali') == 1)
            std1(i,j)=10;
         elseif (strcmp(input(i,j),'kheily aali') == 1)
            std1(i,j)=11;
            
        end
    end
end

for j=1 : numProf
    Xs= std1(:,j);
    Xs = Xs';
    %LWA between answer of each student and weight of questions
    LWA=LWA9(MFs1(Xs,:),MFs2(Ws,:));
    %loading resulted FOU to result matrix
    for c=1 : 9
        result(s,j,c)=LWA (1,c);
    end
end
temp = zeros(1,9);

similarity=zeros(numProf,11);
%calculating the similarity result between resulted FOUs and words specified
%for the quality of answers
for j=1 : numProf
    for c=1 :9
        temp(1,c)=result(s,j,c);
    end
    for i=1:11
    similarity(j,i) = Jaccard(temp,MFs1(i,:));
    end
end
   disp('************************************************************************************');
   fprintf('\n');
%printing each professor idea about each student
for i=1 : numProf
    [maxS,index]=max(similarity(i,:));
  %  decode = words1(index);
   fprintf('professor %d idea about student %d is : %s \n  ', i ,s, words1{index} );
   disp('************************************************************************************');
   fprintf('\n');
end  
end %end of main for  

%LWA between resulted FOUs and weight of professors
final=zeros(numStd , 9);
total = zeros(numProf,9);
answer=zeros(numStd,9);

for z=1 : numStd
    for v=1 : numProf
        for k=1 : 9
            total(v,k)=result(z,v,k);
        end
    end
     FLWA=LWA9(total(:,:),MFs2(Ws1,:));
     % loading final FOUs to answer matrix
     answer(z,:)=FLWA; 
end
%calculate the similarity of final FOUs with words specified for the
%quality of answers
SecSim = zeros(numStd,11);
for q=1 : numStd
    for w=1 : 11
        SecSim(q,w)=Jaccard(answer(q , :), MFs1(w,:));
    end
end
%calculating, how much each student is similar to each rubric word and
%loading the result to finalSim matrix using subset method
finalSim=zeros(numStd,5);
for q=1 : numStd
    for w=1 : 5
        finalSim(q,w)=SubSet(answer(q , :), MFs3(w,:));
    end
end
   disp('------------------------------------------------------------------------------------');
   disp('------------------------------------------------------------------------------------');
   disp('------------------------------------------------------------------------------------');
  
   %sorting students from the perspective of each professor
 for j =1: numProf
     for e=1 : numStd
         for c=1 : 9
             temp(1,c) = result(e,j,c);
         end
         [PCs(e),PCls(e),PCrs(e)]=centroidIT2(temp);
     end
     fprintf('Sorting students from the perspective of Professor %d \n ',j );
     [PCs,Pindex] = sort(PCs)

      fprintf('(From Low To High)  >>>\n\n');

     for h=1 : numStd
       fprintf('  Student  %d \n',Pindex(h));
       disp('***************************************************************************************');
       fprintf('\n');
    end
    disp('-------------------------------------------------------------------------------------------');
    disp('-------------------------------------------------------------------------------------------');
    disp('-------------------------------------------------------------------------------------------');

 end
 %printing total idea about each student
 for l=1 : numStd
    [maxFinal,indexFinal]=max(SecSim(l,:));
   fprintf('Total idea about student %d is : %s \n  ',l, words1{indexFinal} );
   disp('***************************************************************************************');
   fprintf('\n');
end  
    
   disp('-------------------------------------------------------------------------------------------');
   disp('-------------------------------------------------------------------------------------------');
   disp('-------------------------------------------------------------------------------------------');
% printing the group of rubric words each student belongs to.
for l=1 : numStd
    [maxFinal,indexFinal]=max(finalSim(l,:));
   fprintf(' student %d belongs to group : %s \n  ',l, words3{indexFinal} );
   disp('***************************************************************************************');
   fprintf('\n');
end  
   disp('------------------------------------------------------------------------------------');
   disp('------------------------------------------------------------------------------------');
   disp('------------------------------------------------------------------------------------');
   
%sorting final FOUs of students based on their center of centroids
for u=1: numStd
        [FCs(u),FCls(u),FCrs(u)]=centroidIT2(answer(u,:));
end

[FCs,Sindex] = sort(FCs)

fprintf('Sorting Students (From Low To High)  >>>\n\n');

for h=1 : numStd
    fprintf('  Student  %d \n',Sindex(h));
    disp('***************************************************************************************');
    fprintf('\n\n\n');
    

end
     fprintf('Mansour Davoudi 9731568');

figure
set(gcf,'DefaulttextFontName','times new roman');
set(gcf,'DefaultaxesFontName','times new roman');
set(gcf,'DefaulttextFontAngle','italic');
set(gcf,'DefaulttextFontSize',7);
%showing final FOU of each student
for i=1:numStd
    subplot(8,6,2*floor((i-1)/4)+i);
    fill(answer(i,[1:4 8 7 6 5 1]),[0 1 1 0 0 answer(i,9) answer(i,9) 0 0],[0.9 0.9 0.9]);
    hold on;
    plot(answer(i,1:4),[0 1 1 0],'k','linewidth',1);
    plot(answer(i,5:8),[0 answer(i,9) answer(i,9) 0],'k','linewidth',1);
    title(strcat ('student',int2str(i)),'fontsize',7);
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    axis([0 10 0 1]);
end

        

