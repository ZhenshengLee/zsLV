#-*- coding: utf-8 -*-
import sys,json
import codecs,re,string
from collections import Counter


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
#给每个句子贴上1或-1的标签
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

f=open('jsonData.txt','r')
jsonData=f.read()
f.close()
listData=json.loads(jsonData)
sentPropertyAll=sentProperty(listData)
sentLabel=label_initialize()
svm_input=svm_input(sentPropertyAll,sentLabel)
f1=open('svm_input.txt','w')
f1.writelines(svm_input)
f1.close()
