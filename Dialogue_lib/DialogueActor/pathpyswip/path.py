import sys
from pyswip import Prolog
def pathplan(start,end):
    prolog = Prolog() 
    prolog.consult('a_star_4.0.pl')
    startlist=start.split('+')
    len_start=len(startlist)
    endlist=end.split('+')
    len_end=len(endlist)
    if len_start==3 and len_end==3 :
        qqq = "once(path_plan1(" + startlist[0] + "," + startlist[1]+ "," + startlist[2]+ "," + endlist[0] + "," + endlist[1]+ "," + endlist[2] + ",Coorlist))"
        for result in prolog.query(qqq): 
            path = result["Coorlist"]
        print path
    elif len_start==3 and len_end==1 and end=='last_starter' :
        qqq = "once(path_plan3(" + startlist[0] + "," + startlist[1]+ "," + startlist[2]+ ",last_starter,Coorlist))"
        for result in prolog.query(qqq): 
            path = result["Coorlist"]
        print path
    else :
        qqq = "once(path_plan2(" + startlist[0] + "," + startlist[1]+ "," + startlist[2]+ "," + end + ",Coorlist))"
        for result in prolog.query(qqq): 
            path = result["Coorlist"]
        print path
if __name__=="__main__":
    pathplan(sys.argv[1],sys.argv[2])