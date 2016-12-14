import sys
from pyswip import Prolog
def pathplan(x,y,z,end):
    prolog = Prolog() 
    prolog.consult('point_polygon.pl') 
    prolog.consult('area_4F.pl') 
    prolog.consult('node_4F.pl')
    prolog.consult('a_star_3.0.pl') 
    prolog.consult('directly_link.pl') 
    qqq = "path_plan(" + x + "," + y+ "," + z+ "," + end + ",Coorlist)"
    for result in prolog.query(qqq): 
        path = result["Coorlist"]
	for i in range(len(path)/3-1):
		path[3*i+2]=str(path[3*i+2])+"aa"
    print path		
if __name__=="__main__":
    pathplan(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])