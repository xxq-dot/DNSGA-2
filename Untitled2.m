   % ģ������ƽ���
     pc = 0.9; %�������
     hc = 20;
     offspringc = [];
     % popnum/2 ��Ϊ�˱����Ӵ���Ⱥ��ģ����100
     for j = 1 : popnum/2
         s = randperm(popnum);
         %����Ҫ���²���1-n�İ���n������������У������n��100�������s1�ӵڶ��ε�����ʼ��1-200������Ҫ���֣�����ֱ����ǰ���
         % ����0~1 ֮��������
         se1=s(1);
         se2=s(2);
         u = rand(1);
           if u < 0.5
                 B = (2 * u)^(1/(hc + 1));
             else 
                 B = (1/(2*(1-u)))^(1/(hc + 1));
           end
           if u < pc
               % s1 = randperm(100)
               % ��һ���Ӵ�����                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        s1 = randperm(size(x,1)
               offsp1 = 0.5 *[(1-B)* parent(se1,:) + (1+B)* parent(se2,:)];
                for k = 1 : D 
                   offsp1(1,k) = max(offsp1(1,k),xmin+0.0001);
                   offsp1(1,k) = min(offsp1(1,k),xmax-0.0001);
                end
               offsp2 = 0.5 *[(1-B)* parent(se2,:) + (1+B)* parent(se1,:)];
               % ���Ƶڶ��������������
                for k = 1 : D 
                   offsp2(1,k) = max(offsp2(1,k),xmin+0.0001);
                   offsp2(1,k) = min(offsp2(1,k),xmax-0.0001);
                end
               %�����޵Ŀ��������⣬offsp2(1,1)��Χ��[xmin1,xmax1],offsp2(1,2)��Χ��[xmin2,xmax2]
               offspringc = [offspringc;offsp1;offsp2];
           else
               % �����棬������
               offspringc = [offspringc;parent(se1,:);parent(se2,:)];
           end
     end
     % ����
     % ����ʽ����
     pm = 0.5;
     hm = 20;
     offspringm = [];
     %��������ı�Ų��ܼ�����i,��Ϊ�ⲿ�ĵ���ѭ���õľ���i
     for j = 1 : popnum 
         r = rand(1);
         if r < 0.5
             mu = (2 * r)^(1/(hm + 1))-1;
         else
             mu = 1 - [2 * (1-r)]^(1/(hm + 1));
         end
         if r < pm
             offspringm1= offspringc(j,:) + mu * (xmax-xmin);
             for k = 1 : D
                  offspringm1(1,k) = max( offspringm1(1,k),xmin+0.0001);
                  offspringm1(1,k) = min( offspringm1(1,k),xmax-0.0001);
             end   
             offspringm = [offspringm;offspringm1]; 
         else
             % �����б���
             offspringm = [offspringm;offspringc(j,:)];    
         end
     end  