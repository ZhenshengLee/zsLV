#coding:utf-8

import urllib2, urllib,sys,os
import codecs,re,string,json
from subprocess import *
from collections import Counter
from svmutil import *


#分词与词性标注  以json格式输出
def divPos(input):
    uri_base = "http://ltpapi.voicecloud.cn/analysis/?"
    api_key  = "l3z7P327MjUbYOpUyR7m4kmobn7eVVrsaJlUSxlb" 
    text= urllib.quote(input)
    #语言云的真正调用方法    
    uri_base = "http://ltpapi.voicecloud.cn/analysis/?"       
    data = {
            "api_key"   : "l3z7P327MjUbYOpUyR7m4kmobn7eVVrsaJlUSxlb",
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
    #测试句子，直接输入
    #dataa=raw_input('输入命令：'.decode('utf-8')).decode('gb2312').encode('utf-8')#程序中字符串为utf-8，交互中键盘敲入为gb2312
    #输入句子，调用分词标注函数，输出结果（json）
    """
    f0=open('corpusAdd','r')
    dataa=f0.read()
    f0.close()
    if dataa=='':
        return False
    """
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
            while wordPosition<len(wordListInSentenceList[s]) and '7' in wordListInSentenceList[s][wordPosition][-1]:
                
                nPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(nPosition)!=0:
                #
                words=[]
                for p in nPosition:
                    words.append(wordListInSentenceList[s][p][0])
                word=''.join(words)
                nTotal=[word,'n','7']
                wordListInSentenceList[s]=wordListInSentenceList[s][:nPosition[0]]+[nTotal]+wordListInSentenceList[s][nPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=nPosition[0]
                
            vPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '-3' in wordListInSentenceList[s][wordPosition][-1]:
                
                vPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(vPosition)!=0:
                #
                words=[]
                for v in vPosition:
                    words.append(wordListInSentenceList[s][v][0])
                word=''.join(words)
                vTotal=[word,'v','3']
                wordListInSentenceList[s]=wordListInSentenceList[s][:vPosition[0]]+[vTotal]+wordListInSentenceList[s][vPosition[-1]+1:]
                #print wordListInSentenceList[s]
                wordPosition=vPosition[0]
                
            fPosition=[]
            while wordPosition<len(wordListInSentenceList[s]) and '2' in wordListInSentenceList[s][wordPosition][-1]:
                
                fPosition.append(wordPosition)
                wordPosition+=1
            #print nPosition 
            if len(fPosition)!=0:
                #
                words=[]
                for p in fPosition:
                    words.append(wordListInSentenceList[s][p][0])
                word=''.join(words)
                fTotal=[word,'nd','2']
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
        property1=1-Counter(yuyiList)['0']/len(yuyiList)
        #是否有动词
        property2=1 if re.search(r'3_|4',yuyiStr) else 0
        
        #是否含有方向词
        property3=1 if '2' in yuyiList else 0
        #是否含有地名词
        property4=1 if '7' in yuyiList else 0
        #是否含有数词加量词的集合
        property5=1 if  re.search(r'6 8',yuyiStr)  else 0
        #方向词加动词的个数
        property6=len(re.findall(r'2 [34]',yuyiStr))
        #动词加地名词的个数
        property7=len(re.findall(r'3_? 7| 4 7',yuyiStr))
        #地名词加动词
        property8=len(re.findall(r'7 [34]',yuyiStr))
        #动词的个数
        property9=len(re.findall(r'3_| 4',yuyiStr))
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
        if 'h' in wordList[i][3]:
            beginLabel.append(i)
    beginLabel.append(len(wordList))
    
    for i in xrange(len(beginLabel)-1):
        splitWordList.append(wordList[beginLabel[i]:beginLabel[i+1]])
    #print splitWordList
    structureList=[]
    for unit in splitWordList:
        structure=['__']*6
        for i in xrange(len(unit)):
            if unit[i][-1]=='s': 
                structure[0]=unit[i][0]
            elif unit[i][-1]=='f':
                structure[1]=unit[i][0]
            elif '3' in unit[i][2]:
                structure[2]=unit[i][0]
            elif '4' in unit[i][2]:
                structure[2]=unit[i][0]
            elif unit[i][2]=='2':
                structure[3]=unit[i][0]
            elif unit[i][2]=='6' and i<len(unit)-1 and unit[i+1][2]=='8':            
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
            elif unit[i][2]=='9':
                structure[4]=unit[i][0]
            elif unit[i][2]=='5':
                structure[5]=unit[i][0]
            elif unit[i][2]=='6' and i<len(unit)-1 and unit[i+1][2]=='11':
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
                
        structureList.append(structure)
    return structureList

def fillElement(structureList):
    for i in range(len(structureList)):
        if structureList[i][0]=='__':
            if i != 0 and structureList[i-1][1] !='__':
                structureList[i][0]=structureList[i-1][1]
            else:
                structureList[i][0]='当下位置'
        if "停" in structureList[i][2] or "头" in structureList[i][2]:
            continue
        if structureList[i][1]=='__' and structureList[i][4]=='__':
            if "快" in structureList[i][5]:
                structureList[i][5]="加速"
                continue
            if "慢" in structureList[i][5]:
                structureList[i][5]="减速"
                continue
            if i !=len(structureList)-1 and structureList[i+1][0] !='__':
                structureList[i][1]=structureList[i+1][0]
        if structureList[i][2]=='__':
            if i !=0:
                structureList[i][2]=structureList[i-1][2]
            else:
                structureList[i][2]='走'
        if structureList[i][3]=='__' and structureList[i][1]=='__':
            #动作中含有方向
            if "后" in structureList[i][2]:
                structureList[i][3]='后'
            elif "左" in structureList[i][2]:
                structureList[i][3]='左'
            elif "右" in structureList[i][2]:
                structureList[i][3]='右'
            else:
                structureList[i][3]='前'
        #动作中含有速度
        if structureList[i][0]=='__':
            if "快" in structureList[i][2] or "急" in structureList[i][2]:
                structureList[i][5]='快速'
            elif "慢" in structureList[i][2] or "缓" in structureList[i][2]:
                structureList[i][5]='慢速'
            if structureList[i][5]=='__':
                structureList[i][5]='默认速度'
        
        #动作规范
        if "停" in structureList[i][2]:
            structureList[i][2]="停"
        elif "头" in structureList[i][2] or "转身" in structureList[i][2]:
            structureList[i][2]="掉头"
        elif "转" in structureList[i][2] or "拐" in structureList[i][2]:
            structureList[i][2]="转"
        elif "退" in structureList[i][2]:
            structureList[i][2]="退"
        else:
            structureList[i][2]="走"
        #地名词中C400
        begin=re.findall(r"([A-Za-z]).*(\d{3})",structureList[i][0])
        if begin != []:
            structureList[i][0]=begin[0][0]+begin[0][1]
        finish=re.findall(r"([A-Za-z]).*(\d{3})",structureList[i][1])
        if finish != []:
            structureList[i][1]=finish[0][0]+finish[0][1]
        #模糊速度规范
        if "快" in structureList[i][5] or "急" in structureList[i][5]:
            structureList[i][5]='快速'
        elif "慢" in structureList[i][5] or "缓" in structureList[i][5]:
            structureList[i][5]='慢速'
        #模糊距离规范
        if "点" in structureList[i][4] or "些" in structureList[i][4] or "步" in structureList[i][4]:
            structureList[i][4]='些许'
def testAll(dataa):
    #print "输出格式为： 动作过程（起点，终点，动作，方向，距离，速度）".decode('utf-8').encode('gbk')
    print "起点,终点,动作,方向,距离,速度".decode('utf-8').encode('gbk')
    distinguishWord(dataa)
    semanticTest()
    merge()

    if svmTest()>0:

        splitTest()
        startFinishTest()

        structureList=extract('startFinishOutput')
        #print structureList
        fillElement(structureList)
        
        for structure in structureList:
            print ','.join(structure).decode('utf-8').encode('gbk')
    #print "\n"
if __name__=="__main__":
    testAll(sys.argv[1].decode('gbk').encode('utf-8').replace(',',''))