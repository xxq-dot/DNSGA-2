% ��ʼ����Ⱥ
clear all;
clc
popnum = 100;
m = 2; %����ֵ����
D = 10; %x������
xmin = 0;
xmax = 1;

% FDA1 �Ĳ�������
% pc = 0.5; %ģ������ƽ������
% hc = 10; %����ֲ�ָ��
% pm = 0.1; %����ʽ�������
% hm = 20; %����ֲ�ָ��
% taot = 30;% ʱ��t���̶ֹ�ʱ�ĵ�������
% nt = 10; %�����仯ǿ��

% % FDA2�Ĳ�������
% pc = 0.6; %ģ������ƽ������
% hc = 10; %����ֲ�ָ��
% pm = 0.1; %����ʽ�������
% hm = 20; %����ֲ�ָ��
% taot = 20;% ʱ��t���̶ֹ�ʱ�ĵ�������

% FDA3 �Ĳ�������
pc = 0.5; %ģ������ƽ������
hc = 10; %����ֲ�ָ��
pm = 0.1; %����ʽ�������
hm = 20; %����ֲ�ָ��
taot = 50;% ʱ��t���̶ֹ�ʱ�ĵ�������
nt = 10; %�����仯ǿ��
gen = 1;
for i = 1:popnum
    for j = 1 : D 
        pop(i,j) = xmin + rand * (xmax-xmin);
    end
end
f = value(pop,length(pop),taot,nt,gen,D);
% FDA2�ĺ���ֵ
%f = value(pop,length(pop),taot,gen,D);
pop=[pop,f];
[non_dominant_sortpop, rankinfo]=non_dominant_sort(pop,m,D);
nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
parent=generate_offsprings(nsdcpop,m,D,popnum);
figure(1)
plot(parent(:,D+1),parent(:,D+m),'B+')
% FDA1��������
% iter = 300;
% FDA2��������
% iter = 200;
% FDA3��������
iter = 200;
for gen = 1 : iter
    gen
    offspring=genetic_operate(parent,m,D,hc,hm,xmax,xmin);
    pop = [parent(:,1:D);offspring(:,1:D)];
    f = value(pop,length(pop),taot,nt,gen,D);
    % FDA2�ĺ���ֵ
    % f = value(pop,length(pop),taot,gen,D);
    pop=[pop,f];
    [non_dominant_sortpop, rankinfo]=non_dominant_sort(pop,m,D);
    nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
    parent=generate_offsprings(nsdcpop,m,D,popnum);
    % % �����������
    % ���ѡ��100����
    k = randperm(popnum);
    % ��⻷���仯����Ⱥ����ѡ�ĸ�����
    N = popnum * 0.1;
    % �����ѡ��10������
    E = parent((1:D),:);
    % ��⻷���Ƿ����仯����ֵ
    n = 0.00001;
    % ��ѡ���ĸ���ĺ���ֵ
    newf = value(E(:,1:10),N,taot,nt,gen+1,D);
    % FDA2�ĺ���ֵ
    % newf = value(E(:,1:10),N,taot,gen+1,D);
    % �ɸ���ĺ���ֵ
    oldf = E(:,D+1:D+2);
    % �����������
    sum=0;
    for i = 1 : N
        avgf(i) = 1/N * abs((oldf(i,1) - newf(i,1))+ (oldf(i,2) - newf(i,2)));
        sum = sum + avgf(i);
    end
    dete = sum;
    if dete > n
        figure(2)
        plot(parent(:,D+1),parent(:,D+m),'r.') ;
        pause(0.1)
        hold on
        disp('���������˱仯');
        % ���ֶ����Ե����뷽ʽ
        % NSGA-2-A ����Ԥ��ģ��
        % ��Ӧ�����仯ʱ����������������浱ǰ��Ⱥ�ĸ�����newnum
        % FDA1��newnum
        %newnum = popnum * 0.2;
        % FDA2��newnum
        %newnum = popnum * 0.35;
        % FDA3��newnum
%         newnum = popnum * 0.3;
%         for i = 1:newnum
%             for j = 1 : D
%                 newpop(i,j) = xmin + rand * (xmax-xmin);
%             end
%         end
%         newparent = [newpop;parent((newnum+1:popnum),1:D)];
%         f = value(newparent,length(newparent),taot,nt,gen,D);
%         %FDA2�ĺ���ֵ
%         %f = value(newparent,length(newparent),taot,gen,D);
%         newparent=[newparent,f];
%         [non_dominant_sortpop, rankinfo]=non_dominant_sort(newparent,m,D);
%         nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
%         parent=generate_offsprings(nsdcpop,m,D,popnum);
%     end
     % NSGA-2-B ����Ԥ��ģ��
     pm = 0.2;
     hm = 4;
     % FDA1�Ĳ���
     % newnum = popnum * 0.4;
     % FDA2�Ĳ���
     % newnum = popnum * 0.8;
     % FDA3�Ĳ���
     newnum = popnum * 0.6;
     for i = 1:newnum
         for j = 1 : D
             newpop(i,j) = xmin + rand * (xmax-xmin);
         end
     end
     newparent= genetic_operate(newpop,m,D,hc,hm,xmax,xmin);
     f = value(newparent,length(newparent),taot,nt,gen,D);
     % FDA2�ĺ���ֵ
     %f = value(newparent,length(newparent),taot,gen,D);
     newparent=[newparent,f];
     [non_dominant_sortpop, rankinfo]=non_dominant_sort(newparent,m,D);
     nsdcpop=crowding_distance(non_dominant_sortpop,m,D,rankinfo);
     parent=generate_offsprings(nsdcpop,m,D,popnum);
    end
end
hold on
% A=load('ZDT6.txt');
% f1=A(:,1);
% f2=A(:,2);
% plot(f1,f2,'g');
% title('result');
% legend('NSGA-II','ideal');
% funcval=f;  
% opt=A;
%    for j=1:m %��ȡ�����Сֵ
%        maxopt(j)=max(opt(:,j));
%        minopt(j)=min(opt(:,j));
%    end
%    distance=zeros(1,size(funcval,1));
%    sumfval=zeros(1,size(opt,1));
%    dsum=0;      
%    for j=1:size(opt,1)
%    for i=1:size(funcval,1)
%         for z=1:m
%          sumfval(i)= sumfval(i)+((opt(j,z)-funcval(i,z))/(maxopt(z)-minopt(z)))^2;
%         end
%          distance(i)=sqrt(sumfval(i));
%          sumfval(:)=0;
%    end
%       distance(j)=min(distance);
%       dsum=dsum+distance(j);
%    end   
%      IGD=dsum/size(opt,1);
%      fprintf('IGD=%f\n',IGD);