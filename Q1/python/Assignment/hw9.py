# Assignment Number...: 9
# Student Name........: 오승환
# File Name...........: hw9_오승환
# Program Description.: csv 파일을 불러와 읽는 방법을 익히고 txt 파일을 파싱하는 방법을 익히는 과제입니다.

#1
data = open('cars.csv', mode='r', encoding='utf-8')                     #open 함수를 이용해 cars.csv 파일을 읽기전용으로 불러오고 변수 data에 할당한다.
for line in data:                                                       #for문을 활용해 cars.csv 파일의 각 줄을 출력한다.
    print(line)
data.close()                                                            #파일을 닫는다.

#2
data2 = open('cars.csv', mode='r', encoding='utf-8')                    #open 함수를 이용해 cars.csv 파일을 읽기전용으로 불러오고 변수 data2에 할당한다.
a = []                                                                  #빈 리스트를 변수 a에 할당한다.
while True:                                                             #while을 이용해 무한루프를 돌린다.
    b = data2.readline().split(',')                                     #data2의 각 라인을 comma로 구분하여 불러오고 변수 b에 할당한다.
    if b == ['']:                                                       #만약 변수 b에 담긴 값이 다음과 같다면,
        break                                                           #해당 순환문을 종료한다.
    c = tuple(b)                                                        #변수 b에 담긴 값을 tuple로 만들어서 c에 할당한다.
    a.append(c)                                                         #변수 c의 값을 리스트 a에 추가한다.
print(a)                                                                #변수 a에 담긴 값을 출력한다.
data2.close()                                                           #파일을 닫는다.

#3
data3 = open('My way.txt', mode='r', encoding='utf-8')                  #open 함수를 이용해 My way.txt 파일을 읽기 전용으로 불러오고 변수 data3에 할당한다.
for line in data3:                                                      #for문을 이용하여 data3에 담긴 각 라인을 하나씩 불러온다.
    print(line)                                                         #각 라인을 출력한다.
data3.close()                                                           #파일을 닫는다.

#4
data4 = open('My way.txt', mode='r', encoding='utf-8')                  #open 함수를 이용해 My way.txt 파일을 읽기 전용으로 불러와서 변수 data4에 할당한다.
list1 = []                                                              #변수 list1에 빈 리스트를 할당한다.
for line in data4:                                                      #for문을 이용해 data4의 값들을 하나씩 꺼낸다.
    list1.append(line)                                                  #line의 값을 list1에 하나씩 추가한다.
else:                                                                   #만약 for문이 정상적으로 종료되면,
    print(list1[2])                                                     #list1의 세 번째 항목을 출력한다.
data4.close()                                                           #파일을 닫는다.

data5 = open('My way.txt', mode='a', encoding='utf-8')                  #open 함수를 이용해 My way.txt 파일을 쓰기 전용으로 불러와서 변수 data5에 할당한다.
data5.write("\nI'll state my case, of which I'm certain")               #해당 문구를 data5의 마지막에 추가한다.
data5.close()                                                           #파일을 닫는다.

data6 = open('My way.txt', mode='r', encoding='utf-8')                  #open 함수를 이용해 My way.txt 파일을 읽기 전용으로 불러와서 변수 data6에 할당한다.
line6 = data6.read().split('\n')                                        #전체 내용을 read 함수를 이용해 불러오고 새줄바꿈 기호를 구분자로 나눈다. 그리고 이를 변수 line6에 할당한다.
for i in range(len(line6)):                                             #변수 line6의 길이만큼 for문을 돌리고
    print(line6[i])                                                     #변수 line6에 저장된 각 문장을 출력한다.