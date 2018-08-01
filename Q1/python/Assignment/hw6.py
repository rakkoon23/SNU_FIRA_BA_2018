# Assignment Number...: 6
# Student Name........: 오승환
# File Name...........: hw6_오승환
# Program Description.: 새로운 함수를 정의하는 방법과 람다함수를 익히는 과제입니다.

#1
def area_triangle(h, w):                            #def를 통해 함수를 만들고 두 개의 매개변수를 받는다.
    return 0.5 * h * w                              #두 개의 매개변수를 서로 곱하고 다시 0.5를 곱한 값을 리턴한다.
print(area_triangle(10, 15))                        #위에서 정의한 함수에 임의의 값을 넣어 실험해본다.

#2
def distance(a, b):                                 #def를 통해 함수를 만들고 두 개의 매개변수를 받는다.
    x = 0                                           #초기값 설정을 위해 변수 x에 0을 할당한다.
    for i in range(len(a)):                         #a의 원소 개수만큼 반복하는 for문을 만든다.
        x += pow(a[i]-b[i], 2)                      #a의 첫번째 원소와 b의 첫번째 원소를 제곱하고 변수 x와 더한 후 이를 변수 x에 재할당한다.
    return x ** 0.5                                 #루트를 씌우기 위해 0.5를 제곱하고 해당 값을 리턴한다.
a = (1, 2)                                          #변수 a에 임의의 값 1, 2를 할당한다.
b = (5, 7)                                          #변수 b에 임의의 값 5, 7을 할당한다.
print(distance(a, b))                               #위에서 정의한 함수에 임의의 값을 넣어 실험해본다.

#3
def count(n):                                       #def를 통해 함수를 만들고 한 개의 매개변수를 받는다.
    if n == 0:                                      #if문을 활용해 만약 n이 0이라면,
        return print('zero!!')                      #해당 문자열을 출력한다.
    else:                                           #만약 n이 0이 아니라면,
        print(n)                                    #n을 출력한다.
        return count(n-1)                           #그리고 n의 값에서 1을 빼고 다시 count 함수를 실행한다.
count(5)                                            #위에서 정의한 함수에 임의의 값을 넣어 실험해본다.

#4
area_triangle_id = lambda h, w: 0.5 * h * w         #람다함수를 통해 h, w를 매개변수로 설정하고 표현식은 두 개의 매개변수의 곱에 0.5를 곱한 값을 리턴하는 것으로 한다.
print(area_triangle_id(10, 15))                     #위에서 정의한 함수에 임의의 값을 넣어 실험해본다.
