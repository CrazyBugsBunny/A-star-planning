clear;clc;

s_node=1;
e_node=2;

c_label=cell(20,1);
c_label{1}={'Arad',1,366};
c_label{2}={'Bucharest',2,0};
c_label{3}={'Craiova',3,160};
c_label{4}={'Dobreta',4,242};
c_label{5}={'Eforie',5,161};
c_label{6}={'Fagaras',6,176};
c_label{7}={'Giurgiu',7,77};
c_label{8}={'Hirsova',8,151};
c_label{9}={'Lasi',9,226};
c_label{10}={'Lugoj',10,244};
c_label{11}={'Mehadia',11,241};
c_label{12}={'Neamt',12,234};
c_label{13}={'Orades',13,380};
c_label{14}={'Pitesti',14,101};
c_label{15}={'Rimnicu Vikea',15,193};
c_label{16}={'Sibiu',16,253};
c_label{17}={'Timisoara',17,329};
c_label{18}={'Urziceni',18,80};
c_label{19}={'Vasiui',19,199};
c_label{20}={'Zerind',20,374};

dis=zeros(20,20);
dis(1,16)=140;
dis(1,17)=118;
dis(1,20)=75;
dis(2,6)=211;
dis(2,7)=90;
dis(2,14)=101;
dis(2,18)=85;
dis(3,4)=120;
dis(3,14)=138;
dis(3,15)=145;
dis(4,11)=75;
dis(5,8)=85;
dis(6,16)=99;
dis(8,18)=98;
dis(9,12)=87;
dis(9,19)=92;
dis(10,11)=70;
dis(10,17)=111;
dis(13,16)=151;
dis(13,20)=71;
dis(14,15)=97;
dis(15,16)=80;
dis(18,19)=142;
dis=dis+dis';

all_dis=0;
path=[];

G=zeros(20,1);
H=zeros(20,1);
F=zeros(20,1);

father=zeros(20,1);
tot_dis=zeros(20,1);
openlist=[s_node];
closelist=[];
current_node=s_node;
father(s_node)=s_node;

while (1)
    minF=10e+5;
    fprintf('待搜索的城市：');
    for i=1:size(openlist,2)
        fprintf('%s\n',c_label{openlist(i)}{1,1});
        temp_G=dis(father(openlist(i)),openlist(i))+tot_dis(father(openlist(i)));
        temp_H=double(c_label{openlist(i)}{1,3});
        temp_F=temp_G+temp_H;
        if temp_F<minF
            current_node=openlist(i);
            minF=temp_F;
            tot_dis(openlist(i))=temp_G;
        end
    end
    openlist(find(openlist==current_node))=[];
    if isempty(find(closelist==current_node))
        closelist=[closelist,current_node];
    end
    opt_node=[];
    opt_node=find(dis(current_node,:)~=0);
    for j=1:size(opt_node,2)
        if isempty(find(closelist==opt_node(j)))
            if isempty(find(openlist==opt_node(j)))
                openlist=[openlist,opt_node(j)];
                father(opt_node(j))=current_node;
            else
                ref_G=temp_G+dis(father(current_node),opt_node(j));
                ref_H=double(c_label{opt_node(j)}{1,3});
                ref_F=ref_G+ref_H;
                if ref_F<minF
                    current_node=father(opt_node(j));
                    minF=ref_F;
                end
            end
        end
    end
    tot_dis(father(current_node))=tot_dis(father(father(current_node)))+dis(father(father(current_node)),father(current_node));    
   if ~(isempty(find(openlist==e_node)))%||size(openlist,2)==0%
        break;
   end
end

fprintf('从%s到%s的最短路径是：',c_label{s_node}{1,1},c_label{e_node}{1,1});
i=e_node;
while 1
    fprintf('%s<——',c_label{i}{1,1});
    i=father(i);
    if i==s_node
        break;
    end
end
fprintf('%s\n',c_label{s_node}{1,1});