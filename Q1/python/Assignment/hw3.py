# Assignment Number...: 3
# Student Name........: 오승환
# File Name...........: hw3_오승환
# Program Description.: 문자열 서식 활용 방법, 리스트와 튜플 생성 방법, 리스트와 튜플 슬라이싱 방법을 활용하는 과제입니다.

steak = 30000                                                       #변수 steak에 정수 30000을 할당한다.
VAT = 0.15                                                          #변수 VAT에 소수 0.15를 할당한다.
total_price = steak + (steak * VAT)                                 #변수 steak와 변수 VAT를 곱한 값과 변수 steak의 값을 더하여 이를 변수 total_price에 할당한다.
print('스테이크의 원래 가격은 {} 원입니다. 하지만 VAT가 {}%로, 계산하셔야 할 가격은 {} 원입니다.'.format(steak, int(VAT*100), int(total_price)))
#출력해야 할 문자열을 작성하고 format()의 위치 전달인자를 사용하여 대체필드에 각 변수의 값들을 넣었다.
#이때 변수 steak는 그대로 출력하고
#변수 VAT는 곱하기 100을 하고 정수로 변환하였고
#변수 total_price도 정수로 변환하였다.

s = '@^TrEat EvEryonE yOu meet likE you want tO be treated.$%'      #변수 s에 문자열을 할당하였다.
s = s.strip('@^$%')                                                 #strip() 메소드를 사용하여 양쪽에 위치한 특수문자들을 제거하고 이를 변수 s에 재할당했다.
s = s.capitalize()                                                  #capitalize() 메소드를 사용하여 첫 글자만 대문자로 변환하고 나머지는 소문자로 변환하고 이를 변수 s에 재할당했다.
print(s)                                                            #print 함수를 사용하여 변수 s를 출력했다.

numbers = (2, 18, 26, 89, 45, 39, 14)                               #소괄호와 콤마를 사용하여 여러 정수를 요소로 가지는 튜플을 생성하고 이를 변수 numbers에 할당했다.
print(numbers)                                                      #print 함수를 사용하여 변수 numbers를 출력했다.
print(len(numbers))                                                 #len 함수를 사용하여 변수 numbers에 포함된 요소의 개수를 확인하고 이를 print 함수로 출력했다.

fruits = ['apple', 'orange', 'strawberry', 'pear', 'kiwi']          #대괄호를 사용하여 리스트를 생성하였고 이를 변수 fruits에 할당했다.
print(fruits)                                                       #print 함수를 사용하여 변수 fruits를 출력했다.

fruits_sub = fruits[:3]                                             #분할 연산자를 사용하여 변수 fruit의 첫 세 요소만 분할하여 변수 fruits_sub에 할당했다.
print(fruits_sub)                                                   #print 함수를 사용하여 변수 fruits_sub을 출력했다.