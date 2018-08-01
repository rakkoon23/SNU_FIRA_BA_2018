# Assignment Number...: 8
# Student Name........: 오승환
# File Name...........: hw8_오승환
# Program Description.: 함수를 정의하고 활용하는 법을 익히고 패키지와 모듈을 불러오는 법을 익히는 법을 배우는 과제입니다.

#1
import datetime                                                     #datetime 모듈을 불러온다.
now = datetime.datetime.now()                                       #datetime.now 함수를 사용하여 현재 시간을 변수 now에 할당한다.
print(now.strftime('%Y-%m-%d %H:%M:%S'))                            #strftime 함수를 사용하여 정해진 형식에 맞게 now 변수에 저장된 시간을 출력한다.

#2
import calendar                                                     #calendar 모듈을 불러온다.
print(calendar.isleap(2050))                                        #isleap 함수를 사용하여 2050년이 윤년인지를 확인하고 출력한다.
print(calendar.weekday(2050, 7, 7))                                 #weekday 함수를 사용하여 해당 일자가 무슨 요일인지 확인하고 출력한다.

#3
from collections import Counter                                     #collections 모듈의 Counter 함수를 불러온다.

def vowel(a):                                                       #vowel 함수를 정의하고 매개변수로 a를 받는다.
    a_dict = dict(Counter(a))                                       #Counter 함수를 사용하여 a의 각 문자의 빈도를 세고 이를 딕셔너리로 변환하여 변수에 할당한다.
    vowels = ['a', 'e', 'i', 'o', 'u']                              #모음이 저장된 리스트를 변수에 할당한다.
    y = 0                                                           #변수 y에 값 0을 핟랑한다.
    for i in vowels:                                                #변수 vowels에 핟랑된 값들을 하나씩 불러오는 반복문을 실행한다.
        print('The number of {}: {}'.format(i, a_dict.get(i, 0)))   #딕셔너리에서 모음 키를 통해 빈도 값을 받아오고 이를 문구에 넣어 출력한다. 만약 값이 없다면 0을 출력한다.
        if a_dict.get(i,0) > y:                                     #만약 모음 키로 받은 빈도 값이 변수 y보다 크다면,
            y = a_dict.get(i)                                       #y에 해당 빈도 값을 할당한다.
            j = i                                                   #그리고 그 i를 변수 j에 할당한다.
    else:                                                           #for문이 정상적으로 종료되면,
        print(a.replace(j, j.upper()))                              #매개변수 a에서 변수 j에 저장된 값을 찾아서 대문자로 만들어주어 출력한다.

x = 'The regret after not doing something is bigger than that of doing something.' #문자열을 작성하고 변수 x에 할당한다.
vowel(x)                                                            #함수 vowel에 전달인자 x를 넣어 출력한다.




