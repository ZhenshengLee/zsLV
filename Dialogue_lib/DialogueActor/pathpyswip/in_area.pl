in_area(Node,Area):-
    node(Node,Coor0),
    area(Area,[Head1,Head2|Tail]),                    
    append([Head1,Head2|Tail],[Head1,Head2],NewList), 
    judge_clockwise(NewList,0,R), 
    inpolygon(Coor0,NewList,R).	

judge_clockwise([Coor1,Coor2,Coor3],R0,R):-       
    Coor1=coor(X1,Y1,_),
    Coor2=coor(X2,Y2,_),
    Coor3=coor(X3,Y3,_),
    AA is (Y1-Y2)*(X3-X2)+(X2-X1)*(Y3-Y2),
    AA > 0,!,R is R0+1;                                     %大于0逆时针+1，小于0顺时针-1,等于0方向不变，值也不变
    AA = 0,!,R is R0;
    R is R0-1.
judge_clockwise([Coor1,Coor2,Coor3|Tail],R0,R):- 
    Coor1=coor(X1,Y1,_),
    Coor2=coor(X2,Y2,_),
    Coor3=coor(X3,Y3,_),
    AA is (Y1-Y2)*(X3-X2)+(X2-X1)*(Y3-Y2),               %AA为边向量逆时针旋转90度生成的新向量，与下一边向量的点积
    (
    AA > 0,!,R1 is R0+1;                                   %大于0逆时针+1，小于0顺时针-1,等于0方向不变，值也不变 
    AA = 0,!,R1 is R0;
    R1 is R0-1
    ),
    judge_clockwise([Coor2,Coor3|Tail],R1,R).

inpolygon(_,[_,_],_).
inpolygon(Coor0,[Coor1,Coor2|Tail],R):-
    Coor0=coor(X0,Y0,_),
    Coor1=coor(X1,Y1,_),
    Coor2=coor(X2,Y2,_),
    (
    R > 0,!,DD is (X1-X0)*(Y2-Y1)+(Y1-Y0)*(X1-X2);
    R = 0,!,DD is 0;
    DD is (X1-X0)*(Y1-Y2)+(Y1-Y0)*(X2-X1)
    ),
    EE is sqrt((Y1-Y2)*(Y1-Y2)+(X1-X2)*(X1-X2)),
    TT is DD/EE,                                            %要乘以其单位法向量，即要在原有基础上除以法向量模长
    TT >= -20, 
    inpolygon(Coor0,[Coor2|Tail],R).
