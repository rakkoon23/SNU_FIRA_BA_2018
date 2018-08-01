# Assignment Number...: 5
# Student Name........: 오승환
# File Name...........: hw5_오승환
# Program Description.: if-else문과 for, while문을 활용하는 법을 익히는 과제입니다.

class IsNotPrime(Exception): pass                                           #class를 통해 IsNotPrime 예외문을 설정한다.


x = True                                                                    #무한루프를 위해 변수 x에 True 값을 할당한다.
while x:                                                                    #while문을 통해 x값이 True일 때는 다음의 코드들을 실행한다.
    try:                                                                    #try문을 통해 실행할 문장들과 예외문을 설정한다.
        num = int(input('임의의 양의 정수를 입력하세요: '))                    #input 함수를 통해 임의의 양의 정수를 입력받고 int 함수를 통해 정수로 변환한 뒤 변수 num에 할당한다.
        i = 2                                                               #변수 i의 초기값은 2로 한다.
        if (type(num) == int) and (1 < num):                                #if문과 and를 이용하여 변수 num의 자료형이 정수형이고 그리고 1보다 크다면,
            while i < num:                                                  #while문을 이용하여 변수 num이 변수 i보다 크다면,
                if (num % i) == 0:                                          #if문을 이용하여 변수 num을 변수 i로 나누었을 때의 나머지가 0과 같다면,
                    raise IsNotPrime()                                      #IsNotPrime 에러를 발생시킨다.
                i += 1                                                      #변수 i에 1을 더한 후 재할당한다.
        else:                                                               #if문에 설정한 조건들이 하나라도 거짓이라면,
            raise ValueError                                                #ValueError를 발생시킨다.
    except ValueError:                                                      #ValueError 예외문을 작성한다.
        print('ValueError: 1보다 큰 양의 정수를 입력하세요.')                  #print 함수를 사용하여 에러명과 문구를 출력한다.
    except IsNotPrime:                                                      #IsNotPrime 예외문을 작성한다.
        print('{} x {} = {}'.format(i, int(num/i), num))                    #format 메소드와 위치전달인자, 변수 i, 변수 num을 이용하여 소수가 아닌 이유를 출력한다.
        print('이 숫자는 소수가 아닙니다.')                                    #print 함수를 사용하여 해당 문구를 출력한다.
        break                                                               #해당 순환문을 종료하는 break를 사용한다.
    else:                                                                   #try문이 정상적으로 종료됐다면,
        print('이 숫자는 소수입니다.')                                        #print 함수를 사용하여 해당 문구를 출력한다.
        x = False                                                           #무한루프의 종료를 위해 x의 값을 False로 변경한다.

#1
a = int(input('enter a: '))                                                 #input 함수를 사용하여 값을 받고 변수 a에 할당한다.
b = int(input('enter b: '))                                                 #input 함수를 사용하여 값을 받고 변수 b에 할당한다.
c = int(input('enter c: '))                                                 #input 함수를 사용하여 값을 받고 변수 c에 할당한다.
if (a > b) and (a > c):                                                     #if문과 and를 사용하여 만약 a가 b보다 크고 그리고 a가 c보다 크다면,
    print(b + c)                                                            #print 함수를 사용하여 b와 c의 합을 출력한다.
elif (b > a) and (b > c):                                                   #elif문과 and를 사용하여 만약 b가 a보다 크고 그리고 b가 c보다 크다면,
    print(a + c)                                                            #print 함수를 사용하여 a와 c의 합을 출력한다.
elif (c > a) and (c > b):                                                   #elif문과 and를 사용하여 만약 c가 a보다 크고 그리고 c가 b보다 크다면,
    print(a + b)                                                            #print 함수를 사용하여 a와 b의 합을 출력한다.

#2
city = ['Seoul', 'New York', 'Beijing']                                     #각 도시의 이름 문자열을 리스트에 넣고 변수 city에 할당한다.
size = [605, 789, 16808]                                                    #각 도시의 면적 문자열을 리스트에 넣고 변수 size에 할당한다.

input_city = input('Enter the name of the city: ')                          #input 함수를 사용하여 도시 입력 문구를 출력 후 도시명을 입력받은 후 변수 input_city에 할당한다.

if input_city == city[0]:                                                   #if문을 사용하여 만약 input_city에 할당된 값이 변수 city의 첫 번째 값과 같다면,
    print('The size of {} is {}'.format(input_city, size[0]))               #format 메소드와 위치전달인자를 사용하여 size 리스트의 첫 번째 값을 출력한다.
elif input_city == city[1]:                                                 #if문을 사용하여 만약 input_city에 할당된 값이 변수 city의 두 번째 값과 같다면,
    print('The size of {} is {}'.format(input_city, size[1]))               #format 메소드와 위치전달인자를 사용하여 size 리스트의 두 번째 값을 출력한다.
elif input_city == city[2]:                                                 #if문을 사용하여 만약 input_city에 할당된 값이 변수 city의 세 번째 값과 같다면,
    print('The size of {} is {}'.format(input_city, size[2]))               #format 메소드와 위치전달인자를 사용하여 size 리스트의 세 번째 값을 출력한다.
else:                                                                       #만약 if와 두 개의 elif문에 해당되지 않는다면,
    print('Unknown city')                                                   #print 함수를 사용하여 해당 문구를 출력한다.

#3
import math                                                                 #math 라이브러리를 호출한다.
fac_list = list(range(0,10))                                                #range함수와 list 생성자를 통해 0부터 9까지의 값들로 이루어진 리스트를 생성하고 변수 fac_list에 할당한다.
for i in fac_list:                                                          #for문을 사용하여 변수 fac_list에 담긴 값들을 하나씩 꺼낸다.
    print(math.factorial(i))                                                #math 라이브러리와 factorial 함수를 사용하여 i의 팩토리얼을 구하고 print 함수를 사용하여 출력한다.

#4
import math                                                                 #math 라이브러리를 호출한다.
fac_list = list(range(0,10))                                                #range함수와 list 생성자를 통해 0부터 9까지의 값들로 이루어진 리스트를 생성하고 변수 fac_list에 할당한다.
i = 0                                                                       #i의 초기값을 0으로 설정해준다.
while i < 10:                                                               #while문을 i의 값이 0부터 9까지만 반복하도록 설정한다.
    print(math.factorial(i))                                                #math 라이브러리와 factorial 함수를 사용하여 i의 팩토리얼을 구하고 print 함수를 사용하여 출력한다.
    i += 1                                                                  #i에 1을 더한 후 재할당한다.
