#coding:utf-8
#分词与词性标注  以json格式输出
import urllib2,urllib,sys,os
import codecs,re,string,json
from subprocess import *
from collections import Counter
import mdptoolbox
from numpy  import *
import aiml
def divPos(input):
    uri_base = "http://api.ltp-cloud.com/analysis/"
    api_key  = "98H7b393hUPX5tQwEgXwpgPc6m0c1jLTVgJkJymu" 
    text= urllib.quote(input)
    #语言云的真正调用方法    
    uri_base = "http://api.ltp-cloud.com/analysis/"       
    data = {
            "api_key"   : "98H7b393hUPX5tQwEgXwpgPc6m0c1jLTVgJkJymu",
            "text"      : text,
            "format"    : "json",
            "has_key"   : "false",
            "pattern"   : "pos",               

            }
    params = urllib.urlencode(data)
    try:
        request  = urllib2.Request(uri_base)
        response = urllib2.urlopen(request, params)
        content  = response.read().strip()
        
        return content 
    except urllib2.HTTPError, e:
        print >> sys.stderr, e.reason
#json格式转化成plain格式
def jsonToPlain(contentJson):
    #只保留分词和标注输出
    #posResult=[word for word in sentence[0] for sentence in content for ]
    resultList=[]
    for paragraph in contentJson:
        sentenceList=[]
        if paragraph[0][-1][-1]== "wp":
            sent=paragraph[0][:-1]
        else:
            sent=paragraph[0]
        length=len(sent)
        wordIndex=0
        while wordIndex<length:
            if u"转" in sent[wordIndex][1]:
                sent[wordIndex][2]="v"
            if wordIndex+2<len(sent) and u"q" == sent[wordIndex][2] and u"每" == sent[wordIndex+1][1] and u"q" == sent[wordIndex+2][2]:
                merge=[wordIndex,sent[wordIndex][1]+sent[wordIndex+1][1]+sent[wordIndex+2][1],sent[wordIndex][2]]
                sent=sent[:wordIndex]+[merge]+sent[wordIndex+3:]
                length=len(sent)
            sentenceList.append(sent[wordIndex][1]+'\t'+sent[wordIndex][2])
            wordIndex+=1
        sentence='\n'.join(sentenceList).encode('utf-8')
        sentence1=re.sub( r'(nh|ni|nl|ns|nz)' , 'n' , sentence )
        resultList.append(sentence1+'\n'*2)

    return resultList

#分词调用程序
def distinguishWord(dataa):
    f0=open('allTest','a')
    f0.write(dataa+"\n")
    f0.close()
    output=divPos(dataa)

    #将分词标注结果输出到txt文档中
    f1=open('distinguishWordJson','w')
    f1.write(output)
    f1.close()
    
    contentJson=json.loads(output)

    resultList=jsonToPlain(contentJson)
    f2=open('distinguishWordPlain','w')
    f2.writelines(resultList)
    f2.close()
    
    return True

def save():
    
    f6=open('semanticOutput','r')
    output1=f6.read()
    f6.close()    
    
    f7=open('splitOutput','r')
    output2=f7.read()
    f7.close() 
    
    f8=open('savesemanticOutput','a')
    f8.write(output1)
    f8.close()
    
    f9=open('savesplitOutput','a')
    f9.write(output2)
    f9.close()

def train(template,trainTxt,model):      
    #returnCode = call('crf_learn.exe template crfTrain1.txt model1')
    call('crf_learn.exe '+template+' '+trainTxt+' '+ model)
def test(model,testTxt,testOutput):
    """
    -v1:输出标签的概率值
    -n :输出几层不同概率只的选项 用处不大
    -t:输出model的txt版本
    -f：是一阀值，只有某词的频率大于该值 才有用
    -c：跟拟合度有关的一个参数
    -h: 可以随时打开帮助看看
    
    """
    #Popen('crf_test.exe -m model1 crfTest1.txt >output1.txt', shell = True, stdout = PIPE).stdout
    Popen('crf_test.exe -m '+model+' '+ testTxt +'>'+testOutput, shell = True, stdout = PIPE).communicate()
    #Popen('crf_test.exe -m '+model+' '+ testTxt +'>'+testOutput, shell = True, stdout = PIPE).communicate()
def evaluate(testOutput,testResult):
    
    evalue=Popen('conlleval.pl -d "\t" -r < '+testOutput+' > '+testResult,
                 shell = True, stdout = PIPE).stdout
    #https://argcv.com/articles/2104.c#respond   参考资料，参数使用很全
    #print evalue.read()

def semanticTrain():#http://www.hankcs.com/nlp/the-crf-model-format-description.html  不错的资料
    train('semanticTemplate','semanticTrain','semanticModel')
def semanticTest():
    test('semanticModel','distinguishWordPlain','semanticOutput')
    #test('model','crfTest1.txt','output1.txt')
def semanticEvaluate():
    evaluate('semanticEvaluate','semanticEvaluateOutput')

#将普通的字符串格式的输入转化成json列表形式
def plainToJson(semanticOutput):
    fCrfTrain=open(semanticOutput,'r')
    article=fCrfTrain.read()
    if article[:3] == codecs.BOM_UTF8:
            article = article[3:]  
    fCrfTrain.close()

    sentenceLabel=re.compile(r"(.*?)\n\n",re.S)
    sentenceList=re.findall(sentenceLabel,article)

    #print sentenceList[0:10]

    wordListInSentenceList=[]
    for sentence in sentenceList:
        wordList=sentence.split('\n')
        wordPosYuyiList=[]
        for word in wordList:
            wordPosYuyi=word.split('\t')
            wordPosYuyiList.append(wordPosYuyi)
        wordListInSentenceList.append(wordPosYuyiList)
    return wordListInSentenceList
#普通的字符串格式的输入（带有边缘概率需要处理）转化成json列表形式
def proPlainToJson(semanticOutput):
    fCrfTrain=open(semanticOutput,'r')
    article=fCrfTrain.read()
    if article[:3] == codecs.BOM_UTF8:
            article = article[3:]  
    fCrfTrain.close()

    sentenceLabel=re.compile(r"(.*?)\n\n",re.S)
    sentenceList=re.findall(sentenceLabel,article)

    #print sentenceList[0:10]

    wordListInSentenceList=[]
    for sentence in sentenceList:
        wordList=sentence.split('\n')
        
        wordPosYuyiProList=[]
        for word in wordList[1:]:
            wordPosYuyiPro=word.split('\t')
            newWordPosYuyiPro=wordPosYuyiPro[:-1]+[wordPosYuyiPro[-1].split('/')[0]]
            wordPosYuyiProList.append(newWordPosYuyiPro)
        wordListInSentenceList.append([float(wordList[0][2:])]+wordPosYuyiProList)
    return wordListInSentenceList
#将名词和方向词合并 输出json格式
def n_f(wordListInSentenceList):
    for s in xrange(len(wordListInSentenceList)):
        wordPosition=0
        while wordPosition<len(wordListInSentenceList[s]):
            nPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '-Place' in wordListInSentenceList[s][wordPosition][-1]:
                
                nPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(nPosition)!=0:
                #
                words=[]
                for p in nPosition:
                    words.append(wordListInSentenceList[s][p][0])
                word=''.join(words)
                nTotal=[word,'n','Place']
                wordListInSentenceList[s]=wordListInSentenceList[s][:nPosition[0]]+[nTotal]+wordListInSentenceList[s][nPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=nPosition[0]
            
            aPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '-AT' in wordListInSentenceList[s][wordPosition][-1]:
                
                aPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(aPosition)!=0:
                #
                words=[]
                for a in aPosition:
                    words.append(wordListInSentenceList[s][a][0])
                word=''.join(words)
                aTotal=[word,'a','AT']
                wordListInSentenceList[s]=wordListInSentenceList[s][:aPosition[0]]+[aTotal]+wordListInSentenceList[s][aPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=aPosition[0]
                                        
            naPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '-NAT' in wordListInSentenceList[s][wordPosition][-1]:
                
                naPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(naPosition)!=0:
                #
                words=[]
                for na in naPosition:
                    words.append(wordListInSentenceList[s][na][0])
                word=''.join(words)
                naTotal=[word,'a','NAT']
                wordListInSentenceList[s]=wordListInSentenceList[s][:naPosition[0]]+[naTotal]+wordListInSentenceList[s][naPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=naPosition[0]
                    
            vPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '-DurativeVerb' in wordListInSentenceList[s][wordPosition][-1]:
                
                vPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(vPosition)!=0:
                #
                words=[]
                for v in vPosition:
                    words.append(wordListInSentenceList[s][v][0])
                word=''.join(words)
                vTotal=[word,'v','DurativeVerb']
                wordListInSentenceList[s]=wordListInSentenceList[s][:vPosition[0]]+[vTotal]+wordListInSentenceList[s][vPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=vPosition[0]
                
            fPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '-Direction' in wordListInSentenceList[s][wordPosition][-1]:
                
                fPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(fPosition)!=0:
                #
                words=[]
                for p in fPosition:
                    words.append(wordListInSentenceList[s][p][0])
                word=''.join(words)
                fTotal=[word,'nd','Direction']
                wordListInSentenceList[s]=wordListInSentenceList[s][:fPosition[0]]+[fTotal]+wordListInSentenceList[s][fPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=fPosition[0]
            #print wordPosition
            wordPosition+=1
    return

#将合并后的json格式转化成plain格式输出    
def jsonToPlain1(contentJson):
    #只保留分词和标注输出
    #posResult=[word for word in sentence[0] for sentence in content for ]
    resultList=[]
    for paragraph in contentJson:
        sentenceList=[]
        for word in paragraph:
            sentenceList.append(word[0]+'\t'+word[1]+'\t'+word[2])
        sentence='\n'.join(sentenceList)
        resultList.append(sentence+'\n'*2)
    return resultList

def merge():
    wordListInSentenceList=plainToJson('semanticOutput')#crfTrain.txt  包含词  词性  语义 的plain文件
    n_f(wordListInSentenceList)


    data=json.dumps(wordListInSentenceList)
    f3=open('n_f_outputTestJson','w')                #jsonData.txt对应crfTrain的合并结果
    f3.writelines(data)
    f3.close()

    result=jsonToPlain1(wordListInSentenceList)
    f4=open('n_f_outputTest','w')           #n_f.data对应jsonData.txt  plain格式
    f4.writelines(result)
    f4.close()
    
#所有句子的特征列表
def sentProperty(listData):
    property_all=[]
    for sentence in listData:
        #句子中的语义列表
        yuyiList=[ word[-1] for word in sentence]
        yuyiStr=' '+' '.join(yuyiList)
        #除0外的词占句子的比例
        property1=1-Counter(yuyiList)['Other']/len(yuyiList)
        #是否有动词
        property2=1 if re.search(r'DurativeVerb|MomentaryVerb',yuyiStr) else 0
        
        #是否含有方向词
        property3=1 if 'Direction' in yuyiList else 0
        #是否含有地名词
        property4=1 if 'Place' in yuyiList else 0
        #是否含有数词加量词的集合
        property5=1 if  re.search(r'Num DistanceUnit',yuyiStr)  else 0
        #方向词加动词的个数
        property6=len(re.findall(r'Direction (DurativeVerb|MomentaryVerb)',yuyiStr))
        #动词加地名词的个数
        property7=len(re.findall(r'(DurativeVerb|MomentaryVerb) Place',yuyiStr))
        #地名词加动词
        property8=len(re.findall(r'Place (DurativeVerb|MomentaryVerb)',yuyiStr))
        #动词的个数
        property9=len(re.findall(r'(DurativeVerb|MomentaryVerb)',yuyiStr))
        #关键词类别个数占句子长度的比例
        property10=len(set(yuyiList))/len(yuyiList)
        
        property_all.append([property1,property2,property3,property4,property5,property6,property7,property8,property9,property10])
    return property_all

#给每个句子贴上1或-1的标签，自己标出来
def label_initialize():
    set_label_1=[1]*60
    label_0=[7,53,54,55,56,57,58,59]
    for label in label_0:
        set_label_1[label]=-1
    return set_label_1

#将句子的特征和1、-1标签弄成svm的输入格式
def svm_input(property_all,label_tag):
    svm_format=[]
    for index in xrange(len(property_all)):               
        column=str(label_tag[index])
        for property_index in xrange(len(property_all[index])):
            column+='\t'+str(property_index+1)+':'+str(property_all[index][property_index])   
        svm_format.append(column+'\n')
    return svm_format

def svmProperty(n_f_input):
#从合并后的带有语义标注的预料中  提取出svm的特征向量  以及自己标注的标签 存放在一个文本文档中
    f5=open(n_f_input,'r')  #jsonData
    jsonData1=f5.read()
    f5.close()
    listData=json.loads(jsonData1)
    sentPropertyAll=sentProperty(listData)

    #sentLabel=label_initialize()
    #sentLabel=[0]*len(sentPropertyAll)
    
    return sentPropertyAll

#训练模型  
def svmTrain():
    sentPropertyAll=svmProperty('jsonData')
    sentLabel=label_initialize()
    m=svm_train(sentLabel,sentPropertyAll,'-c 4')
    svm_save_model('svmModel', m)
    
#进行测试
def svmTest():
    #y,x=svm_read_problem('svm_input_test.txt')
    x=svmProperty('n_f_outputTestJson')
    y=[0]*len(x)
    m = svm_load_model('svmModel')
    p_label,p_acc,p_val=svm_predict(y,x,m)
    return p_label

def splitTrain():
    train('splitTemplate','splitTrain','splitModel')

def splitTest():
    test('splitModel','n_f_outputTest','splitOutput')
def startFinishTrain():
    train('startFinishTemplate','startFinishTrain','startFinishmodel')
def startFinishTest():
    test('startFinishmodel','splitOutput','startFinishOutput')

def isanum(str):
    try:
        float(str)
        return True
    except ValueError:
        return False
digitDict ={u'零':0, u'一':1, u'二':2, u'三':3, u'四':4, u'五':5, u'六':6, u'七':7, u'八':8, u'九':9, u'十':10, u'百':100, u'千':1000, 
       u'万':10000,u'亿':100000000,u'０':0, u'1':1, u'2':2, u'3':3, u'4':4, u'5':5, u'6':6, u'7':7, u'8':8, u'9':9}
def getResultForDigit(a, encoding="utf-8"):
    if isinstance(a, str):
        a = a.decode(encoding)
    count = 0 
    result = 0
    tmp = 0
    Billion = 0  
    while count < len(a):
        tmpChr = a[count]
        tmpNum = digitDict.get(tmpChr, None)
        #如果等于1亿
        if tmpNum == 100000000:
            result = result + tmp
            result = result * tmpNum
            #获得亿以上的数量，将其保存在中间变量Billion中并清空result
            Billion = Billion * 100000000 + result 
            result = 0
            tmp = 0
        #如果等于1万
        elif tmpNum == 10000:
            result = result + tmp
            result = result * tmpNum
            tmp = 0
        #如果等于十或者百，千
        elif tmpNum >= 10:
            if tmp == 0:
                tmp = 1
            result = result + tmpNum * tmp
            tmp = 0
        #如果是个位数
        elif tmpNum is not None:
            tmp = tmp * 10 + tmpNum
        count += 1
    result = result + tmp
    result = result + Billion
    return result

def extract(output):
    wordList=plainToJson(output)[0]
    splitWordList=[]
    beginLabel=[]
    for i in xrange(len(wordList)):
        if 'B' in wordList[i][3]:
            beginLabel.append(i)
    beginLabel.append(len(wordList))
    
    for i in xrange(len(beginLabel)-1):
        splitWordList.append(wordList[beginLabel[i]:beginLabel[i+1]])
    #print splitWordList
    structureList=[]
    for unit in splitWordList:
        structure=['__']*7
        for i in xrange(len(unit)):
            #if unit[i][-1]=='s': 
                #structure[0]=unit[i][0]
            #if unit[i][-1]=='f':
               # structure[1]=unit[i][0]
            if 'Place' in unit[i][2]:
                structure[1]=unit[i][0]
            if 'DurativeVerb' in unit[i][2]:
                structure[2]=unit[i][0]
            elif unit[i][2]=='MomentaryVerb':
                structure[2]=unit[i][0]
            if unit[i][2]=='Direction':
                structure[3]=unit[i][0]
            if unit[i][2]=='Num' and i<len(unit)-1 and unit[i+1][2]=='DistanceUnit':            
                if  isanum(unit[i][0]):
                    digit=unit[i][0]
                else:
                    digit=str(getResultForDigit(unit[i][0]))
                    if digit=='0'or unit[i+1][0]=="点" or unit[i+1][0]=="些":
                        digit=unit[i][0]
                if unit[i+1][0]=='厘米' or unit[i+1][0]=='公分':
                    structure[4]=str(float(digit)/100)
                elif unit[i+1][0]=='分米':
                    structure[4]=str(float(digit)/10)
                elif unit[i+1][0]=='米':
                    structure[4]=digit
                else:
                    structure[4]=digit+unit[i+1][0]
            if unit[i][2]=='Distance':
                structure[4]=unit[i][0]
            if unit[i][2]=='Speed':
                structure[5]=unit[i][0]
            if unit[i][2]=='Num' and i<len(unit)-1 and unit[i+1][2]=='SpeedUnit':
                if  isanum(unit[i][0]):
                    digit=unit[i][0]
                else:
                    digit=str(getResultForDigit(unit[i][0]))
                    if digit=='0'or unit[i+1][0]=="点" or unit[i+1][0]=="些":
                        digit=unit[i][0]
                if unit[i+1][0]=='厘米每秒' or unit[i+1][0]=='公分每秒':
                    structure[5]=str(float(digit)/100)
                elif unit[i+1][0]=='分米每秒':
                    structure[5]=str(float(digit)/10)
                elif unit[i+1][0]=='米每秒':
                    structure[5]=digit
                elif unit[i+1][0]=='迈' or unit[i+1][0]=='码':
                    structure[5]=str(float(digit)*0.278)
                else:
                    structure[5]=digit+unit[i+1][0]
            if unit[i][2]=='AT':
                structure[6]=unit[i][2]
            if unit[i][2]=='NAT':
                structure[6]=unit[i][2]
        structureList.append(structure)
    return structureList

def fillElement(structureList):#提取结构化指令之后的要素规范化
    for i in range(len(structureList)):
        if structureList[i][0]=='__':
            if i != 0 and structureList[i-1][1] !='__':
                structureList[i][0]=structureList[i-1][1]
            else:
                structureList[i][0]='当下位置'
        #if "停" in structureList[i][2] or "头" in structureList[i][2]:
            #continue
        if structureList[i][4]=='__':
            if "快" in structureList[i][5]:
                structureList[i][5]="加速"
                continue
            if "慢" in structureList[i][5]:
                structureList[i][5]="减速"
                continue
            if i !=len(structureList)-1 and structureList[i+1][0] !='__':
                structureList[i][1]=structureList[i+1][0]
        #if structureList[i][2]=='__':
            #if i !=0:
                #structureList[i][2]=structureList[i-1][2]
            #else:
                #structureList[i][2]='走'
        #if "去" in structureList[i][2] or "到" in structureList[i][2]:
            #structureList[i][2]='前'
        if structureList[i][2]!='__' or structureList[i][2]!='__':
            if "后" in structureList[i][3] or "后" in structureList[i][2]:
                structureList[i][2]='后'
            if "前" in structureList[i][3] or "前" in structureList[i][2]:
                structureList[i][2]='前'
            if "左" in structureList[i][3] or "左" in structureList[i][2]:
                structureList[i][2]='左'
            if "右" in structureList[i][3] or "右" in structureList[i][2]:
                structureList[i][2]='右'
        if structureList[i][4]!='__':
            structureList[i][4]=structureList[i][4]+'米'
        
        if "停" in structureList[i][2]:
            structureList[i][2]="停"
        
        if "退" in structureList[i][2]:
            structureList[i][2]="退"
    
        if ("拧" in structureList[i][2] or "开" in structureList[i][2]) and structureList[i][1]=='__':
            structureList[i][1]=structureList[i][2].replace("开","")
            print structureList[i][2]
            structureList[i][2]="开"
            
        if "头" in structureList[i][2] or "转身" in structureList[i][2]:
            structureList[i][2]="掉头"
            
        if "到" in structureList[i][2] or "去" in structureList[i][2] or "走" in structureList[i][2] or "找" in structureList[i][2]:
            structureList[i][2]="到"
            
            
        if "推" in structureList[i][2]:
            structureList[i][2]="推"

        if "搬" in structureList[i][2]:
            structureList[i][2]="搬"
            
        if "拿" in structureList[i][2]:
            structureList[i][2]="拿"

        if "抬" in structureList[i][2]:
            structureList[i][2]="抬"
            
        if "看" in structureList[i][2] or "拍" in structureList[i][2]:
            structureList[i][2]="拍照"
        
        if "录" in structureList[i][2]:
            structureList[i][2]="录象"  
            
        if "采集" in structureList[i][2]:
            structureList[i][2]="采集"
        
        if structureList[i][2]=='__' and structureList[i][1]!='__':
            structureList[i][2]='到'   
        
        #if structureList[i][3]=='__' and structureList[i][1]=='__':
            #动作中含有方向
            #if "后" in structureList[i][3]:
                #structureList[i][3]='后'
                #structureList[i][2]='后'
            #elif "左" in structureList[i][3]:
                #structureList[i][3]='左'
                #structureList[i][2]='左'
            #elif "右" in structureList[i][3]:
                #structureList[i][3]='右'
                #structureList[i][2]='右'
            #else:
                #structureList[i][3]='前'
                #structureList[i][2]='前'
        #动作中含有速度
        if structureList[i][0]=='__':
            if "快" in structureList[i][2] or "急" in structureList[i][2]:
                structureList[i][5]='加速'
            elif "慢" in structureList[i][2] or "缓" in structureList[i][2]:
                structureList[i][5]='减速'
        
        #if structureList[i][2]!='__':
            #structureList[i][2]=='走'
            
        
        #动作规范
        #if "停" in structureList[i][2]:
            #structureList[i][2]="停"
        #elif "头" in structureList[i][2] or "转身" in structureList[i][2]:
            #structureList[i][2]="掉头"
        #elif "转" in structureList[i][2] or "拐" in structureList[i][2]:
            #structureList[i][2]="转"
        #elif "退" in structureList[i][2]:
            #structureList[i][2]="退"
        #else:
            #structureList[i][2]="走"
        #地名词中C400
        #begin=re.findall(r"([A-Za-z]).*(\d{3})",structureList[i][0])
        #if begin != []:
            #structureList[i][0]=begin[0][0]+begin[0][1]
        #finish=re.findall(r"([A-Za-z]).*(\d{3})",structureList[i][1])
        #if finish != []:
            #structureList[i][1]=finish[0][0]+finish[0][1]
        #模糊速度规范
        #if re.match( r'(快|急|迅速|马上|立即|)' ,structureList[i][5] ) != None:        
            #structureList[i][5]='快速'
        #elif "慢" in structureList[i][5] or "缓" in structureList[i][5]:
            #structureList[i][5]='慢速'
        #模糊距离规范
        if "点" in structureList[i][4] or "些" in structureList[i][4]: 
            structureList[i][4]='1米'
        if "步" in structureList[i][4]:
            if filter(str.isdigit,structureList[i][4])!='':
                structureList[i][4]=filter(str.isdigit,structureList[i][4]) + '米'
            else:
                structureList[i][4]='1米'
#提取MDP需要的结构化指令，以及MDP各个状态元素的值            
def stateextract(structureList,storelist,statelist):
    if structureList[0][1]!='__':
        storelist.append(structureList[0][1])
        statelist.append(1)
    else:
        storelist.append(structureList[0][1])
        statelist.append(0)
    if structureList[0][2]!='__':
        storelist.append(structureList[0][2])
        statelist.append(1)
    else:
        storelist.append(structureList[0][2])
        statelist.append(0)
    if structureList[0][4]!='__':
        storelist.append(structureList[0][4])
        statelist.append(1)
    else:
        storelist.append(structureList[0][4])
        statelist.append(0)
    if structureList[0][5]!='__':
        storelist.append(structureList[0][5])
        statelist.append(1)
    else:
        storelist.append(structureList[0][5])
        statelist.append(0)
    if structureList[0][6]=='__':
        storelist.append(structureList[0][6])
        statelist.append(0)
    elif structureList[0][6]=='AT':
        storelist.append(structureList[0][6])
        statelist.append(1)
    elif structureList[0][6]=='NAT':
        storelist.append(structureList[0][6])
        statelist.append(2)

def mdptrain(policy):
#训练MDP模型P为转移概率矩阵，R为回报矩阵，一共81一个状态以此为速度、距离、动作、终点组成。    
    
    P = ones( (10,144,144) )/144
    #R = array( [ [100,0,0,0,0], [100,0,0,0,-100], [100,0,0,0,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100], [0,0,100,0,0], [0,0,0,0,200], [0,100,0,100,-100] ] )
    
    R = array( [[50,-10,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,50,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,50,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,50,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,50,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,-10,200], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,50,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,-10,-10,50,-10], [-10,-10,-10,-10,-10,-10,50,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,50,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,50,-10,-10,-10], [-10,50,-10,-10,-10,-10,-10,-10,-10,-10], [-10,-10,-10,-10,-10,-10,50,-10,-10,-10]] )
    vi = mdptoolbox.mdp.RelativeValueIteration(P, R)
    #vi = mdptoolbox.mdp.ValueIteration(P, R, 0.95)
    vi.verbose
    vi.run()
    policy+=list(vi.policy)

'''def policycs(policy,statelist,policy_c,storelist):
    state_c=(statelist[0]*2**3+statelist[1]*2**2+statelist[2]*2**1+statelist[3])*3+statelist[4]
    print policy[state_c]
    if policy[state_c]==0:
        policy_c[0]='提示'
    elif policy[state_c]==1:
        policy_c[0]='再提示'
    elif policy[state_c]==2:
        policy_c[0]='确认'
    elif policy[state_c]==3:
        policy_c[0]='再确认'
    elif policy[state_c]==4:
        policy_c[0]='完成'
    for i in range(len(storelist)):
        if storelist[i]!='__':
            policy_c[0]+=storelist[i]
    print state_c
    print policy_c[0]'''
def store(storelist,laststore,statelist):
#非否定情况下保存下来的历史信息与当前信息的融合
    if laststore[0]!='__' and storelist[0]=='__':
        storelist[0]=laststore[0]
        statelist[0]=1
    if laststore[1]!='__' and storelist[1]=='__':
        storelist[1]=laststore[1]
        statelist[1]=1
    if laststore[2]!='__' and storelist[2]=='__':
        storelist[2]=laststore[2]
        statelist[2]=1
    if laststore[3]!='__' and storelist[3]=='__':
        storelist[3]=laststore[3]
        statelist[3]=1
    #elif laststore[4]!='__' and storelist[4]=='__':
        #storelist[4]=laststore[4]
        #if storelist[4]]
def natstore(storelist,laststore,statelist):
#否定情况下保存下来的历史信息与当前信息的融合
    if laststore[0]!='__' and storelist[0]=='__' and (storelist[1]!='__' or storelist[2]!='__' or storelist[3]!='__') :
        storelist[0]=laststore[0]
        statelist[0]=1
    if laststore[1]!='__' and storelist[1]=='__' and (storelist[0]!='__' or storelist[2]!='__' or storelist[3]!='__') :
        storelist[1]=laststore[1]
        statelist[1]=1
    if laststore[2]!='__' and storelist[2]=='__' and (storelist[0]!='__' or storelist[1]!='__' or storelist[3]!='__') :
        storelist[2]=laststore[2]
        statelist[2]=1
    if laststore[3]!='__' and storelist[3]=='__' and (storelist[0]!='__' or storelist[1]!='__' or storelist[2]!='__') :
        storelist[3]=laststore[3]
        statelist[3]=1
def changes(statelist):
    if statelist[4]==1:
        for j in range(4):
            if statelist[j]!=0:
                statelist[j]=2

def policycs(policy,statelist,policy_c,storelist):
    state_c=statelist[0]*3*3*4+statelist[1]*3*3+statelist[2]*3+statelist[3]
    if policy[state_c]==0:
        policy_c[0]='提示'
    elif policy[state_c]==1:
        policy_c[0]='总确认'
        for i in range(4):
            if storelist[i]!='__':
                policy_c[0]+=storelist[i]
    elif policy[state_c]==2:
        policy_c[0]='速度确认'
        policy_c[0]+=storelist[3]
    elif policy[state_c]==3:
        policy_c[0]='距离确认'
        policy_c[0]+=storelist[2]
    elif policy[state_c]==4:
        policy_c[0]='动作确认'
        policy_c[0]+=storelist[1]
    elif policy[state_c]==5:
        policy_c[0]='目的确认'
        policy_c[0]+=storelist[0]
    elif policy[state_c]==6:
        policy_c[0]='未收录项目总确认'
        for i in range(4):
            if storelist[i]!='__':
                policy_c[0]+=storelist[i]
    elif policy[state_c]==7:
        policy_c[0]='未收录动作确认'
        policy_c[0]+=storelist[1]
    elif policy[state_c]==8:
        policy_c[0]='未收录目的确认'
        policy_c[0]+=storelist[0]
    elif policy[state_c]==9:
        policy_c[0]='完成'
        for i in range(4):
            if storelist[i]!='__':
                policy_c[0]+=storelist[i]

def loc(structureList,statelist,storelist):
    f6=open('location')
    Location=f6.readlines()
    structureList[0][1]=structureList[0][1].decode('utf-8')
    sum1=[0]*len(Location)
    if structureList[0][1]!=u'__':
        if statelist[0]==1:
            for i in range(len(Location)):
                Location[i]=Location[i].replace('\n',"").decode('utf-8')
                if Location[i]==structureList[0][1]:
                    statelist[0]=1
                    break
                else:
                    statelist[0]=3
                    
            if statelist[0]==3:
                for j in range(len(Location)):
                    for k in range(min(len(Location[j]),len(structureList[0][1]))):
                        if Location[j][k]==structureList[0][1][k]:
                            sum1[j]=sum1[j]+1
                            
                if max(sum1)!=0:
                    index1=sum1.index(max(sum1))
                    storelist[0]=Location[index1].encode('utf-8')
                    statelist[0]=1
                else:
                    storelist[0]="无匹配"
                    statelist[0]=3

        
def act(structureList,statelist,storelist):
    f7=open('action')
    Action=f7.readlines()
    structureList[0][2]=structureList[0][2].decode('utf-8')
    sum2=[0]*len(Action)
    if structureList[0][2]!=u'__':
        if statelist[1]==1:
            for i in range(len(Action)):
                Action[i]=Action[i].replace('\n',"").decode('utf-8')
                if Action[i]==structureList[0][2]:
                    statelist[1]=1
                    break
                else:
                    statelist[1]=3
                    
            if statelist[1]==3:
                for j in range(len(Action)):
                    for k in range(min(len(Action[j]),len(structureList[0][2]))):
                        if Action[j][k]==structureList[0][2][k]:
                            sum2[j]=sum2[j]+1
                    
                if max(sum2)!=0:
                    index2=sum2.index(max(sum2))
                    storelist[1]=Action[index2].encode('utf-8')
                    statelist[1]=1
                else:
                    storelist[1]="无匹配"
                    statelist[1]=3
                
def testAll(dataa,step,cmNum):
    laststore=['__']*5
    policy=[]
    mdptrain(policy)
    liststructure=[]
    structureList=[]
    allinquiry=""
    prompt=""
    respond=[]
    allrespond=""
    step=int(sys.argv[2])
    cmNum=int(sys.argv[3])

    #导航指令输入
    if step==0:
        '''CRF'''
        distinguishWord(dataa)
        semanticTest()
        merge()
    
        splitTest()
        startFinishTest()
        save()
        structureList=extract('startFinishOutput')
        fillElement(structureList)
        liststructure=structureList
        
        f3=open('liststructure','w')
        for i in range(len(liststructure)):
            for j in range(7):
                liststructure[i][j]=liststructure[i][j]+'\n'
                f3.writelines(liststructure[i][j])
        f3.close()
        
        f5=open('respond','w')
        f5.writelines('')
        f5.close
                 
        print len(liststructure)

    elif step==1:
        '''MDP'''
        storelist=[]
        statelist=[]
        policy_c=['']
        cmNum=int(sys.argv[3])
        
        f4=open('liststructure')
        liststructure=f4.readlines()
        structureList.append(liststructure[cmNum*7:cmNum*7+7])
        f4.close()
        
        for i in range(len(structureList[0])):
            structureList[0][i]=structureList[0][i].replace('\n','')

        
        stateextract(structureList,storelist,statelist)
        if storelist[4]!='NAT':
            store(storelist,laststore,statelist)
            #print statelist
        else:
            natstore(storelist,laststore,statelist)

        loc(structureList,statelist,storelist)
        act(structureList,statelist,storelist)

        changes(statelist)
        laststore=storelist
        
        for i in range(len(storelist)):
            storelist[i]=storelist[i].replace('\n','')

        policycs(policy,statelist,policy_c,storelist)
        k = aiml.Kernel()
        k.learn("cn-startup.xml")
        k.respond("load aiml cn")
        
        if '确认' in policy_c[0]:
            if cmNum==0:
                print k.respond(policy_c[0])
            else:
                f5=open('respond','r')
                respond=f5.readlines()
                f5.close()
                for j in range(len(respond)):
                    respond[j]=respond[j].replace('好的，','').replace('我','',1).replace('这','').replace('就','').replace('马上','').replace('\n','')
                    if j!=0 and respond[j]!='':
                        respond[j]="然后" + respond[j]
                    allinquiry=allinquiry + respond[j]
                print "请问是要让我先" + allinquiry +"然后"+ k.respond(policy_c[0]).replace('请问','').replace('是','').replace('要','').replace('让','').replace('我','',1)

                
            if "无匹配" in policy_c[0]:
                for i in range(len(laststore)):
                    laststore[i]='__'
                    storelist[i]='__'    
       
        if '提示' in policy_c[0]:
            if cmNum==0:
                print k.respond(policy_c[0])
            else:
                f5=open('respond','r')
                respond=f5.readlines()
                f5.close()
                    
                for j in range(len(respond)):
                    respond[j]=respond[j].replace('好的，','').replace('我','',1).replace('这','').replace('就','').replace('马上','').replace('\n','')
                    if j!=0 and respond[j]!='':
                        respond[j]="然后" + respond[j]
                    prompt=prompt + respond[j]
                print "你好，请问我先" + prompt + "然后怎么做？"

            for i in range(len(laststore)):
                laststore[i]='__'
                storelist[i]='__' 
                    
            f7=open('laststore','w')    
            for i in range(len(laststore)):
                laststore[i]=laststore[i]+'\n'
                f7.writelines(laststore[i])
            f7.close()    
                    
            
    
        f3=open('laststore','w')
        for i in range(len(laststore)):
            laststore[i]=laststore[i]+'\n'
            f3.writelines(laststore[i])
        f3.close()
        

    elif step==2:
        '''CRF'''
        distinguishWord(dataa)
        semanticTest()
        merge()
    
        splitTest()
        startFinishTest()
        save()
        structureList=extract('startFinishOutput')
        fillElement(structureList)
        '''MDP'''
        storelist=[]
        statelist=[]
        policy_c=['']
        
        
        f5=open('laststore','r')
        laststore=f5.readlines()
        f5.close()
        for i in range(len(laststore)):
            laststore[i]=laststore[i].replace('\n','')       
        stateextract(structureList,storelist,statelist)
        if storelist[4]!='NAT':
            store(storelist,laststore,statelist)
            #print statelist
        else:
            natstore(storelist,laststore,statelist)
        loc(structureList,statelist,storelist)
        act(structureList,statelist,storelist)
        changes(statelist)
        laststore=storelist

        for i in range(len(storelist)):
            storelist[i]=storelist[i].replace('\n','')
        policycs(policy,statelist,policy_c,storelist)
   
        k = aiml.Kernel()
        k.learn("cn-startup.xml")
        k.respond("load aiml cn")

        if '确认' in policy_c[0]:
            if cmNum==0:
                print "_"
                print k.respond(policy_c[0])
            else:
                print "_"
                f5=open('respond','r')
                respond=f5.readlines()
                f5.close()
                
                for j in range(len(respond)):
                    respond[j]=respond[j].replace('好的，','').replace('我','',1).replace('这','').replace('就','').replace('马上','').replace('\n','')
                    if j!=0 and respond[j]!='':
                        respond[j]="然后" + respond[j]
                    allinquiry=allinquiry + respond[j]
                print "请问是要让我先" + allinquiry +"然后"+ k.respond(policy_c[0]).replace('请问','').replace('是','').replace('要','').replace('让','').replace('我','',1)

                
            if "无匹配" in policy_c[0]:
                for i in range(len(laststore)):
                    laststore[i]='__'
                    storelist[i]='__'
                    
            f7=open('laststore','w')
            for i in range(len(laststore)):
                laststore[i]=laststore[i]+'\n'
                f7.writelines(laststore[i])
            f7.close()
            
        if '完成' in policy_c[0]:
            if "两" in storelist[2]:
                storelist[2]=storelist[2].replace('两','2')
            print storelist[0].replace('\n',''),storelist[1].replace('\n',''),storelist[2].replace('\n',''),storelist[3].replace('\n',''),storelist[4].replace('\n','')
            laststore=storelist
            f7=open('laststore','w')
            for i in range(len(laststore)):
                laststore[i]=laststore[i]+'\n'
                f7.writelines(laststore[i])
            f7.close()
            
            laststore=['__']*5
            
            f5=open('respond','r')
            respond=f5.readlines()
            f5.close()

            
            respond.append(k.respond(policy_c[0]))

            
            f0=open('respond','w')

            for i in range(len(respond)):
                respond[i]=respond[i]+'\n'
                f0.writelines(respond[i])
            f0.close()

        else:

            if '提示' in policy_c[0]:
                print "_"
                if cmNum==0:
                    print k.respond(policy_c[0])
                else:
                    f5=open('respond','r')
                    respond=f5.readlines()
                    f5.close()
                    
                    for j in range(len(respond)):
                        respond[j]=respond[j].replace('好的，','').replace('我','',1).replace('这','').replace('就','').replace('马上','').replace('\n','')
                        if j!=0 and respond[j]!='':
                            respond[j]="然后" + respond[j]
                        prompt=prompt + respond[j]
                    print "你好，请问我先" + prompt + "然后怎么做？"

                for i in range(len(laststore)):
                    laststore[i]='__'
                    storelist[i]='__' 
                    
                f7=open('laststore','w')    
                for i in range(len(laststore)):
                    laststore[i]=laststore[i]+'\n'
                    f7.writelines(laststore[i])
                f7.close()    
                    
        
    elif step==3:
        f5=open('respond','r')
        respond=f5.readlines()
        f5.close()
        if len(respond)!=1:
            for i in range(len(respond)):
                respond[i]=respond[i].replace('好的，','').replace('我','',1).replace('这','').replace('就','').replace('马上','').replace('\n','')
                if i!=0 and respond[i]!='':
                    respond[i]="然后" + respond[i]
                allrespond=allrespond + respond[i]
            print "好的，我先" + allrespond
        else:
            print respond[0]
        
    elif step==4:
        print "网络好像不给力，请稍后再试！"
        
        
    #print "\n"
if __name__=="__main__":
    testAll(sys.argv[1].decode('gbk').encode('utf-8'),sys.argv[2],sys.argv[3])