# Assignment Number...: 2
# Student Name........: 오승환
# File Name...........: hw2_오승환
# Program Description.: 문자열 자료형의 변수를 생성하고 슬라이싱하는 과제입니다.

cellphone = 'Samsung Galaxy8'                                   #문자열 자료형으로 된 핸드폰 정보를 변수 cellphone에 할당한다.
print(cellphone)                                                #print 함수를 사용하여 변수 cellphone을 출력한다.
company = cellphone[0:7]                                        #분할 연산자([])를 사용하여 변수 cellphone에서 핸드폰 제조사를 슬라이싱하고 이를 변수 company에 할당한다.
print(company)                                                  #print 함수를 사용하여 변수 company를 출력한다.
model = cellphone[8:len(cellphone)]                             #분할 연산자([])와 len함수를 사용하여 핸드폰의 모델명을 슬라이싱하고 이를 변수 model에 할당한다.
print(model)                                                    #print 함수를 사용하여 변수 model을 출력한다.
print(type(company))                                            #print 함수와 type 함수를 사용하여 변수 company의 자료형을 출력한다.
print(type(model))                                              #print 함수와 type 함수를 사용하여 변수 model의 자료형을 출력한다.
print('It had been that way for days and days.\n And then, just before the lunch bell rang, he walked into our class room.\n Stepped through that door white and softly as the snow.')
#문자열을 작성하고 문자열의 마지막에 새줄바꿈 문자인 \n을 넣고 2, 3번 문장의 첫 줄은 공백을 넣는다. 그리고 이를 print 함수로 출력한다.
