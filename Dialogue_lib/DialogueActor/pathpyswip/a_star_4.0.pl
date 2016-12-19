:-dynamic 
   path_done/1,
   node/2,
   directly_link/4,
   last_starter/3.
   
:- consult('point_polygon.pl'),
   consult('directly_link.pl'),
   consult('area_4F.pl'),
   consult('node_4F.pl'),
   consult('in_area.pl').

path_plan1(X,Y,Z,XE,YE,ZE,CoorList):-           %坐标到坐标
   assert(node(starter,coor(X,Y,Z))),  
   point_polygon(coor(X,Y,Z),Start_Area,1), 
   findall(Node1,(in_area(Node1,Start_Area),\+(Node1==starter)),Nodes1),
   assert_directly_link(Nodes1,starter,Start_Area),
   assert(node(end,coor(XE,YE,ZE))),  
   point_polygon(coor(XE,YE,ZE),End_Area,1),
   findall(Node2,(in_area(Node2,End_Area),\+(Node2==end)),Nodes2),
   assert_directly_link(Nodes2,end,End_Area),
   find_path(starter,end,PathList),%write(PathList),nl,
   path2coor(PathList,CoorList), 
   free_starter_and_end,
   save_last_starter(X,Y,Z).
%path_plan1(58000,109000,0,3000,6600,0,CoorList).
%path_plan1(60000,94000,0,86000,85000,0,CoorList).

path_plan2(X,Y,Z,End,CoorList):-               %坐标到区域
   assert(node(starter,coor(X,Y,Z))),  
   point_polygon(coor(X,Y,Z),Start_Area,1), 
   findall(Node1,(in_area(Node1,Start_Area),\+(Node1==starter)),Nodes1),
   assert_directly_link(Nodes1,starter,Start_Area),
   findall(Node2,in_area(Node2,End),Nodes22),
   list_to_set(Nodes22,Nodes2),
   findall(Dis,(member(EndNode,Nodes2),find_path_dis(starter,EndNode,Dis)),DisList),
   min_list(DisList,Dis_Min),
   once((member(EndNode1,Nodes2),find_path_dis(starter,EndNode1,Dis_Min))),%write(EndNode1),nl,
   find_path(starter,EndNode1,PathList),
   path2coor(PathList,CoorList), 
   free_starter_and_end,
   save_last_starter(X,Y,Z).
%path_plan2(58000,109000,0,b404,CoorList).
 
path_plan3(X,Y,Z,last_starter,CoorList):-               %坐标到出发点
   exists_file('last_starter.pl'),
   consult('last_starter.pl'),
   last_starter(X1,Y1,Z1),
   path_plan1(X,Y,Z,X1,Y1,Z1,CoorList).  
%path_plan3(60000,94000,0,last_starter,CoorList).
   
free_starter_and_end:-                                             %释放path_try1所有事实
   directly_link(Node1,Node2,_,_),
   (Node1=starter;Node2=starter;Node1=end;Node2=end),!,
   retract(directly_link(Node1,Node2,_,_)),
   free_starter_and_end;
   true.   

path2coor([],[]).   
path2coor([Node|PathRest],[[X,Y,Z]|Rest]):-   
    node(Node,coor(X,Y,Z)),
	path2coor(PathRest,Rest).

save_last_starter(X,Y,Z):-
   assert(last_starter(X,Y,Z)), 
   open('last_starter.pl',write,Out),
   findall(last_starter(X,Y,Z),last_starter(X,Y,Z),Facts),
   writefact(Facts,Out),
   close(Out).

assert_directly_link([],_,_).   
assert_directly_link([Node1|RestNodes],Node0,Area):-
   distance(Node1,Node0,Dis),
   assert(directly_link(Node1,Node0,Area,Dis)),
   assert(directly_link(Node0,Node1,Area,Dis)),
   assert_directly_link(RestNodes,Node0,Area).
/*   
path_back_plan(X,Y,Z,CoorList):-  
   exists_file('last_starter.pl'),
   consult('last_starter.pl'), 
   last_starter(X0,Y0,Z0),
   point_polygon(coor(X0,Y0,Z0),End,1),
   retractall(last_starter),
   path_plan(X,Y,Z,End,CoorList0),
   append(CoorList0,[X0,Y0,Z0],CoorList).
*/   
find_path(Start,End,Path_list):-
   (
   exists_file('shortest_path.pl'),
   consult('shortest_path.pl'),                              %读取先验知识库
   check_memory(Start,End,Path_list),                        %尝试在先验知识中寻找答案
   free_path_done,!;
   a_star(Start,End),                                        %执行A星算法，将产生的结果存成事实，存于内存空间    
   (
   path_try1(Start,End,_,_),!,                               %判断求得的最小路径链段是否直接由起点和终点连接，若是，直接得到答案
   Path_list=[Start,End];
   path_try1(LastNode,End,_,_),                              %提取路径序列的初始化操作
   find_path_list(Start,LastNode,[LastNode,End],Path_list)   %借助A星算法产生的相邻点事实群，提取出所求最佳路径序列
   ),
   assert(path_done(Path_list)),                             %将新找到的最短路径序列存成事实
   %save_path_fact,                                           %将内存中的最短路径事实存入文件
   free_memory,!                                             %释放内存空间 
   ).
%  find_path(a620d1,b505d1,PathList).
   
find_path_dis(Start,End,Dis):-
   ((
   exists_file('shortest_path.pl'),
   consult('shortest_path.pl'),                              %读取先验知识库
   check_memory(Start,End,Path_list),                        %尝试在先验知识中寻找答案
   free_path_done,!;
   a_star(Start,End),                                        %执行A星算法，将产生的结果存成事实，存于内存空间    
   (
   path_try1(Start,End,_,_),!,                               %判断求得的最小路径链段是否直接由起点和终点连接，若是，直接得到答案
   Path_list=[Start,End];
   path_try1(LastNode,End,_,_),                              %提取路径序列的初始化操作
   find_path_list(Start,LastNode,[LastNode,End],Path_list)   %借助A星算法产生的相邻点事实群，提取出所求最佳路径序列
   )),
   path_to_dis(Path_list,0,Dis),
   assert(path_done(Path_list)),                             %将新找到的最短路径序列存成事实
   %save_path_fact,                                           %将内存中的最短路径事实存入文件
   free_memory,!                                             %释放内存空间 
   ).

path_to_dis([_],Dis,Dis).
path_to_dis([Node1,Node2|Rest],Dis0,Dis):-
   distance(Node1,Node2,Dis1),
   Dis2 is Dis0 + Dis1,
   path_to_dis([Node2|Rest],Dis2,Dis).
   
check_memory(Start,End,Wanted_path):-                        %尝试在先验知识中寻找答案
   findall(PathList,path_done(PathList),PathLists),
   check_lists(PathLists,Start,End,Wanted_path),!.

check_lists([],_,_,_):-fail.
check_lists([PathList|Rest],Start,End,Wanted_path):-         %逐项搜索
   member(Start,PathList),
   member(End,PathList),
   (
   check_a_list(PathList,Start,End,Wanted_path),!;
   reverse(PathList,PathList1),
   check_a_list(PathList1,Start,End,Wanted_path)
   ),!;
   check_lists(Rest,Start,End,Wanted_path).

check_a_list(PathList,Start,End,Wanted_path):-               %对单项掐头去尾，筛选出需要的路径段
   append(_,[Start|T1],PathList),
   append(Middle,[End|_],T1),
   append([Start],Middle,T2),
   append(T2,[End],Wanted_path).   
   
save_path_fact:-                                             %将内存中的最短路径事实存入文件
   open('shortest_path.pl',write,Out),
   findall(path_done(Path),path_done(Path),Paths),
   writefact(Paths,Out),
   close(Out).

writefact([],_).                                           %将事实逐项输入流
writefact([X|Rest],Out):-
   write(Out,X),
   put_char(Out,.),                                          %在每个事实后加入句点
   nl(Out),
   writefact(Rest,Out).
	
free_memory:-                                                %释放内存空间
   free_path_try1,
   free_path_try2,
   free_path_done.

free_path_try1:-                                             %释放path_try1所有事实
   path_try1(_,_,_,_),!,
   retract(path_try1(_,_,_,_)),
   free_path_try1;
   true.
free_path_try2:-                                             %释放path_try2所有事实
   path_try2(_,_,_,_),!,
   retract(path_try2(_,_,_,_)),
   free_path_try2;
   true.
free_path_done:-                                             %释放path_done所有事实
   path_done(_),!,
   retract(path_done(_)),
   free_path_done;
   true.
   
a_star(Start,End):-                                          %A星算法
   h(Start,End,H),
   F is 0+H,
   assert(path_try1(_,Start,0,F)),                           %用起点Start，初始化集合Open和Close
   path(End,Start,[Start],[]).
	
path(End,End,_,_):-!.
path(End,Current,Open,Close):-                               %write(***********************************),nl,write('Current: '),write(Current),nl,
   add_new_neighbour(End,Current,Open,Close,Open1,Close1),%寻找这一轮ParentNode所相连的点，插入相关事实，并将新相连点融入Open集合并去重，旧父节点从Open移入Close
                                                             %write('Open: '),write(Open1),nl,write('Close: '),write(Close1),nl,
   try1_to_try2(Current),                                    %把上一轮已经使用完的的path_try1转为新事实名path_try2储存起来，防止干扰下一步找出新ParentNode
   select_new_current(NewCurrent),                           %根据F值最小找出新的ParentNode                 
                                                             %write('NewCurrent: '),write(NewCurrent),nl,
  % out,                                                      %通过回溯表征此时内存中的事实path_try1和path_try2
   path(End,NewCurrent,Open1,Close1).                        %进行下一轮的递归，直至找到的新的ParentNode和目标点End一致
   
add_new_neighbour(End,Current,Open,Close,NewOpen,NewClose):-
   findall(Neighbour,(g(Current,Neighbour,_),not(member(Neighbour,Close))),Neighbours),!,	
                                                             %找出所有的新连接点，条件有二：相连；不在Close中
   add_path_try1(Neighbours,Current,Open,End),               %根据规则将新点分类进行操作，存入事实库
   append(Open,Neighbours,OpenTemp),                         %将新找到的点并入Open
   list_to_set(OpenTemp,Open1),                              %对上一步的新Open进行去重
   open_to_close(Current,Open1,Close,NewOpen,NewClose).      %本轮已借助ParentNode找到新NewParentNode，将旧ParentNode由Open转入Close
   
add_path_try1([],_,_,_):-!.  
add_path_try1([Neighbour|Rest],Current,Open,End):-
    path_try1(_,Current,G0,_),                               %匹配到上一个ParentNode的相关事实信息                                
	g(Current,Neighbour,G_delta),                            %更新新找到点的G和F值
	h(Neighbour,End,H1),  
	G1 is G0+G_delta,
	F1 is G1+H1,                               
	(
	not(member(Neighbour,Open)),!,                           %如果新点不在Open中，说明事实库没有相同点，直接将新点事实存入内存数据库即可
	assert(path_try1(Current,Neighbour,G1,F1))               
	                                                         %,write('path_try1: '),write(Current),write(','),write(Neighbour),write(','),write(G1),write(','),write(F1),nl
	;
	path_try1(_,Neighbour,G2,_),                             %如果新点在Open中，说明事实库有相同点，取两者中F值较小的点，更新其对应的事实
	G1<G2,!,                                                 %若新点更小，则对原事实进行修改或替换；反之，无需操作
	retract(path_try1(_,Neighbour,G2,_)),
	assert(path_try1(Current,Neighbour,G1,F1))               
	                                                         %,write('path_try1: '),write(Current),write(','),write(Neighbour),write(','),write(G1),write(','),write(F1),nl
	;
	true
    ), 	
	add_path_try1(Rest,Current,Open,End).

open_to_close(Current,Open1,Close1,Open2,Close2):-           %将旧ParentNode由Open转入Close
   select(Current,Open1,Open2),!,                            %从Open1中去除ParentNode，剩余的为Open2
   append([Current],Close1,Close2).	                         %将ParentNode加入Close1，得到Close2

try1_to_try2(Current):-                                      %把已经使用完的上一轮的path_try1转为新事实名path_try2储存起来
   path_try1(LastCurrent,Current,G1,F1),
   assert(path_try2(LastCurrent,Current,G1,F1)),
   retract(path_try1(_,Current,_,_)).

select_new_current(NewCurrent):-                             %找出F值最小的新ParentNode
   findall([Node,F],(path_try1(_,Node,_,F)),NodeWithFs),     %write(NodeWithFs),nl,
   min(NodeWithFs,[NewCurrent,F]),!.
    
min([[NewCurrent,F]],[NewCurrent,F]).                        %从列表中找出F最小的元素对
min([[Node1,F1],[Node2,F2]|Rest],[NewCurrent,F]):-
   F1>=F2,!,
   min([[Node2,F2]|Rest],[NewCurrent,F]);
   min([[Node1,F1]|Rest],[NewCurrent,F]).	

out:-                                                        %通过回溯表征此时内存中的事实path_try1和path_try2
   write('Facts: '),nl,
   findall(path_try1(ParentNode,ChildNode,G,F),path_try1(ParentNode,ChildNode,G,F),Facts),
   write(Facts),nl,
   findall(path_try2(ParentNode1,ChildNode1,G1,F1),path_try2(ParentNode1,ChildNode1,G1,F1),Facts1),
   write(Facts1),nl.

find_path_list(Start,End,Path_list1,Path_list):-            %借助A星算法产生的相邻点的事实群，提取出所求最佳路径序列
   path_try2(Start,End,_,_),!,
   Path_list=[Start|Path_list1];
   path_try2(LastNode,End,_,_), 
   Path_list2=[LastNode|Path_list1],
   find_path_list(Start,LastNode,Path_list2,Path_list).

g(Node1,Node2,Dis):-
   directly_link(Node1,Node2,_,Dis).
h(Node1,Node2,Dis):-
   distance(Node1,Node2,Dis).

distance(Node1,Node2,Dis):-
   node(Node1,coor(X1,Y1,_)),
   node(Node2,coor(X2,Y2,_)),
   Dis is sqrt((Y1-Y2)*(Y1-Y2)+(X1-X2)*(X1-X2)).
 