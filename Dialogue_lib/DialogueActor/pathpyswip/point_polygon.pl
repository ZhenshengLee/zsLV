%P1   coor(216,64,0)   inside
%P2   coor(113,100,0)  outside
%P3   coor(135,170,0)  inside   %(用P6替换P3)
%P4   coor(231,226,0)  inside
%P5   coor(158,289,0)  inside 
%P6   coor(200,170,0)  inside
% point_polygon(Coor,random,InOrOut). 
% point_polygon(coor(216,64,0),test,InOrOut).
% point_polygon(coor(113,100,0),test,InOrOut).
% point_polygon(coor(135,170,0),test,InOrOut).    fail 5 6在10前面
% point_polygon(coor(231,226,0),test,InOrOut).    success
% point_polygon(coor(158,289,0),test,InOrOut).
% point_polygon(coor(200,170,0),test,InOrOut).

% point_polygon(coor(222,100,0),test,InOrOut).  在test顶点
% point_polygon(coor(200,289,0),test,InOrOut).  在test边上
% point_polygon(coor(216,64,0),test,InOrOut).   在test内部
% point_polygon(coor(113,100,0),test,InOrOut).  在test外部

%area(random,[coor(240,22,_),coor(222,100,_),coor(347,31,_),coor(366,170,_),coor(302,226,_),coor(383,226,_),coor(337,352,_),coor(289,289,_),coor(185,289,_),coor(96,325,_),coor(182,170,_),coor(85,183,_)]).
%area(test,[coor(240,22,_),coor(222,100,_),coor(347,31,_),coor(366,170,_),coor(302,226,_),coor(383,226,_),coor(337,352,_),coor(289,289,_),coor(185,289,_),coor(96,325,_),coor(182,170,_),coor(146,170,_),coor(80,200,_)]).

point_polygon(Coor,Area,InOrOut):-         %判断点与多边形区域的位置关系，并通过标志参数InOrOut的值来表征
   area(Area,[Head1|Tail]),                %匹配出多边形区域对应的顶点坐标序列                     
   append([Head1|Tail],[Head1],List),      %将坐标序列首项添加至序列尾部
   coor_transform(Coor,List,NewList),      %对坐标序列做相对坐标变换，使之变换为相对于原点的坐标序列   
   (
   member(coor(0,0,_),NewList) ->   %!,     %判定点是否为多边形顶点，若是，给标志参数InOrOut赋值-1
   InOrOut is -1;
   intersection_number(NewList,0,InOrOut)   %逐项判断原点与各新线段的位置关系及交点数，累加得出交点总数  
   ).                                          % write('N: '),write(N),nl,
%   round_mod(N,InOrOut)).                  %取整后判断交点数的奇偶性，推理出其位置关系                       

round_mod(N,InOrOut):-
   R is round(N),                                                  
   InOrOut is R mod 2.
   
   
coor_transform(_,[],[]).
coor_transform(Coor,[Coor1|Tail],[NewCoor1|NewTail]):-
   Coor=coor(X,Y,_),
   Coor1=coor(X1,Y1,_),
   XX1 is X1-X,
   YY1 is Y1-Y,  
   NewCoor1=coor(XX1,YY1,_),   
   coor_transform(Coor,Tail,NewTail).

quadrant(coor(X,Y,_),Quad):-                                        %推理出点坐标所在象限
   X>=0,Y>0,!,
   Quad=1;
   X<0,Y>0,!,
   Quad=2;
   X<0,Y<0,!,
   Quad=3;
   X>=0,Y<0,!,
   Quad=4;
   X<0,Y=0,!,
   Quad=8;
   X>0,Y=0,
   Quad=16.

quadrant_difference(Coor1,Coor2,Abs):-                              %获取两端点象限之差
   quadrant(Coor1,Quad1),
   quadrant(Coor2,Quad2),
   Abs is abs(Quad1-Quad2).
   
intersection_number([_],N,InOrOut):-
    round_mod(N,InOrOut),!.                                         %取整后判断交点数的奇偶性，推理出其位置关系          
intersection_number([Coor1,Coor2|Tail],N0,InOrOut):- 
                                                                     % write('N0: '),write(N0),nl,
   origin_line([Coor1,Coor2],M),                                     % write('M: '),write(M),nl,
   (
   (M=2_1;M=2_2;M=2_3),!,
   InOrOut is -1,
  write('The point lies on the edge.'),nl;   
   (
   (M=0_1;M=0_2;M=0_3;M=0_4;M=0_5),!,
   N1 is N0;
   (M=1_1;M=1_2),!,
   N1 is N0+1;
   M=3_1,!,
   N1 is N0+0.5;
   M=3_2,
   N1 is N0-0.5
   ),
   intersection_number([Coor2|Tail],N1,InOrOut)
   ).  

/*relation(Point,Line,Relation).*/
origin_line([Coor1,Coor2],M):-         
   quadrant_difference(Coor1,Coor2,0),  %线段两端点位于相同象限，无交点
   M=0_1.
  
origin_line([Coor1,Coor2],M):-          
   quadrant_difference(Coor1,Coor2,3),   %线段两端点位于一四象限，一个交点
   Coor1=coor(X1,_,_),
   Coor2=coor(X2,_,_),            
   (
   X1=0,X2=0,!,
   M=2_1;                                 %点在多边形垂直于水平射线的边上
   M=1_1                                  %线段两端点位于一四象限，一个交点
   ).                                   
                                
origin_line([Coor1,Coor2],M):-         
   quadrant_difference(Coor1,Coor2,1),  %线段两端点位于其他相邻象限，无交点
   M=0_2.
   
origin_line([Coor1,Coor2],M):-         
   quadrant_difference(Coor1,Coor2,2),  %线段两端点位于相对象限
   Coor1=coor(X1,Y1,_),
   Coor2=coor(X2,Y2,_),
   X is (X1*Y2-X2*Y1)/(Y2-Y1),          %由两点式结算得出，并将y=0代入，求解x值
   (
   X>0,!,
   M=1_2;                                 %线段两端点位于相对象限，y=0时，x为正，一交点
   X=0,!,
   M=2_2;                                 %线段两端点位于相对象限，y=0时，x为0，点在边上
   X<0,
   M=0_3).                                 %线段两端点位于相对象限，y=0时，x为负，无交点

origin_line([Coor1,Coor2],M):- 
   quadrant_difference(Coor1,Coor2,8),     %点在水平边上
   M=2_3.

origin_line([Coor1,Coor2],M):- 
   quadrant_difference(Coor1,Coor2,TQ),
   (TQ=4;TQ=5;TQ=6;TQ=7),                         %其中一端点在x轴负半轴，无交点
   M=0_5.   

origin_line([Coor1,Coor2],M):- 
   quadrant_difference(Coor1,Coor2,TQ),
   (TQ=12;TQ=13;TQ=14;TQ=15),                     %其中一端点在x轴负半轴，一个交点
   Coor1=coor(_,Y1,_),
   Coor2=coor(_,Y2,_),
   (
   Y1<Y2,!,                             %点的水平射线有过顶点，向上+0.5
   M=3_1;
   Y1=Y2,!,                             %点的水平射线有过顶点，水平不变
   M=0_4;
   Y1>Y2,                               %点的水平射线有过顶点，向下-0.5
   M=3_2
   ).
   
   
/*   
origin_line([Coor1,Coor2],M):- 
   Coor1=coor(X1,Y1,_),
   Coor2=coor(X2,Y2,_),
   (
   (Y1=0,Y2=0,X1*X2<0),!,
   M=2_3;                                 %点在水平边上
   (
   (Y1=0,X1>0;
   Y2=0,X2>0),
   (
   Y1<Y2,!,                             %点的水平射线有过顶点，向上+0.5
   M=3_1;
   Y1=Y2,!,                             %点的水平射线有过顶点，水平不变
   M=0_4;
   Y1>Y2,                               %点的水平射线有过顶点，向下-0.5
   M=3_2
   )
   ),!;
   M=0_5).                                %其他情况无交点
*/