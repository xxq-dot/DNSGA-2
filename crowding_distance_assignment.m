function idistance = crowding_distance_assignment(popnum,F,f,m)
idistance = zeros(1,popnum);
% �õ���Ⱥ�ж��ٸ��ȼ�
N = length(F);
for i = 1 : N
    F1 = F(i).f;
    ff = f(F1,:);
    distance = zeros(1,size(ff,1));
    % ��ÿ�еĺ���ֵ��������
    for j = 1 : m
          % [ff1,index] = sort(ff); 
          [ff1,index] = sort(ff(:,j)); 
        for k = 1 : length(index)
            kindex = find(index== k);
            % �߽����ľ�������Ϊ�����
            if kindex==1 || kindex==length(index)
                distance(k) = Inf;
            else
                % ��ÿ�еĺ���ֵ�������
                distance(k) = distance(k) + ff1(kindex+1)-ff1(kindex-1);
            end
        end           
    end
    % �õ�ÿ����Ŷ�Ӧ��ӵ������
   idistance(F1) = distance;
end
