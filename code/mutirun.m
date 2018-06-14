function [Y,I]=mutirun(SOC,num)
global I0;global I00;global dt;global t;global C;global options;global p;
global Iini;
global tri;
%I00=-0.5;
run=num;
s=0;
Iini = I0;
for k=1:run
%     I0=(-1)^(k-1)*Iini;
  
%     if mod(k,4)==0
%         I0=1;
%     end;

%========piece wise:4============
% if mod(k,1)==0
%     I0 = -2;
% end;
% if mod(k,2)==0
%     I0 = 3;
% end;
% if mod(k,3)==0
%     t=0.3/0.5;
% end;
% if mod(k,4)==0
%     t=0.55/0.5;
% end;

%=======piece wise:2===============
if mod(k,1) == 0
    I0 =  0.5;
end;
if mod(k,2) == 0
    I0 = -1;
end;

    [T,Y{k},TE,YE,IE]=ode45(@resis,0:dt:t,SOC,options); 
    if ~isempty(YE)
        Y{k}(end,:)=[];
    end
    
    for i=1:p
        I{k}(:,i)=diff(Y{k}(:,i))/dt*C(i);
    end;
    j=0;
    for m=1:length(Y{k}(:,1))
        %         if mod(k,2)==1
        %         if Y{k}(m,1)<0||Y{k}(m,2)<0
        %             break;
        %         end;
        %         end;
        %         if mod(k,2)==0
        %         if Y{k}(m,1)>1||Y{k}(m,2)>1
        %             break;
        %         end;
        %         end;
        if Y{k}(m,1)<0||Y{k}(m,2)<0||Y{k}(m,1)>1||Y{k}(m,2)>1
            break;
        end;
    end;
    I{k}=I{k}(1:m-1,:);
    Y{k}=Y{k}(1:m-1,:);%%定义SOC从（1,1）开始，则没有j-1=0的情况
  
%     if mod(k,2)==1
%         Y{k}=[Y{k};Y{k}(m-1,:)*[1-s/2 s/2;s/2 1-s/2]];
%     end;
    for i=1:p
        SOC(i)=Y{k}(length(Y{k}(:,i)),i);
    end;
    
end;
