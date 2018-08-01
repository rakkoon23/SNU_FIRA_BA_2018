# Assignment Number...: 1
# Student Name........: 오승환
# File Name...........: hw1_오승환
# Program Description.: 기본적인 자료형과 input 함수를 활용하는 법을 익히는 과제입니다.

season = input("What is your favorite season? ")                                    #input 함수를 사용하여 값을 입력받아 변수에 할당한다.
print(season)                                                                       #print 함수를 사용하여 변수 season에 할당된 값을 출력한다.

date = input("Which date were you born? ")

print(type(date))
print(type(float(date)))                                                            #float 함수를 사용하여 변수 date의 자료형을 float 타입으로 변경한다.

print("My favorite season is", season + ".", "I was born on the", date + "th.")     #print 함수를 사용하여 좋아하는 계절과 태어난 날짜를 한 문장으로 결합한다.
#"My favorite season is" 문자열과 변수 season을 결합할 때는 띄어써야 하므로 comma를 사용하였다.
#변수 season과 마침표를 결합할 때는 결합시 띄어쓰기를 하지 않는 '+' 기호를 사용하였다.
#마침표와 뒤의 문자열과 결합할 때는 띄어쓰기를 위해 comma를 사용하였다.
#"I was born on the" 문자열과 변수 date를 결합할 때는 띄어써야 하므로 comma를 사용하였다.
#변수 date와 뒤의 문자열 "th."를 결합할 때는 결합시 띄어쓰기를 하지 않는 '+' 기호를 사용하였다.
