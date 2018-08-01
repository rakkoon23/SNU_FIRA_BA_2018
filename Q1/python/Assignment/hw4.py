# Assignment Number...: 4
# Student Name........: 오승환
# File Name...........: hw4_오승환
# Program Description.: 조건문과 반복문을 활용하는 방법을 익히는 과제입니다.

restaurant_list = [{'상호': 'A', '메뉴': '피자', '가격': 20000},
                   {'상호': 'B', '메뉴': '치킨', '가격': 18000},
                   {'상호': 'C', '메뉴': '짜장면', '가격': 5000},
                   {'상호': 'D', '메뉴': '초밥', '가격': 15000},
                   {'상호': 'E', '메뉴': '치킨', '가격': 23000},
                   {'상호': 'F', '메뉴': '족발', '가격': 30000}]
#식당 목록을 참조하여 개별 식당 데이터는 딕셔너리로, 전체 식당 목록은 리스트로 묶는다.
#그리고 이를 변수 restaurant_list에 할당한다.

want_to_eat = input('먹고 싶은 음식을 입력하세요 : ')                       #input 함수를 사용하여 먹고 싶은 음식을 묻고 이를 변수 want_to_eat에 할당한다.

menu = []                                                                #대괄호를 사용하여 빈 리스트를 생성하고 이를 변수 menu에 할당한다.
for a in range(len(restaurant_list)):                                    #0부터 변수 restaurant_list의 원소의 개수만큼 반복하여 a에 담는다. 그리고 이를 변수 restaurant_list의 원소의 개수만큼 반복한다.
    if want_to_eat in restaurant_list[a].get('메뉴'):                     #if문과 get메소드를 사용하여 만약 변수 want_to_eat에 할당된 값이 변수 restaurant_list의 a번째의 '메뉴' 키의 값에 있다면
        menu.append(a)                                                   #이 a를 append 메소드를 사용하여 menu 리스트에 담는다.

if 0 < len(menu):                                                        #if 조건문을 사용하여 변수 menu의 원소의 개수가 0보다 크다면 다음 for문을 실행한다.
    for b in menu:                                                       #변수 menu에 담긴 원소들을 b에 하나씩 담는다.
        print('식당 {}, 가격 {} 원'.format(restaurant_list[b].get('상호'),
                                      restaurant_list[b].get('가격')))   #format 메소드와 위치전달인자를 사용하여 변수 restaurant_list의 b번째 있는 '상호' 키의 값과 '가격' 키의 값을 대체 필드에 넣어 출력한다.
else:                                                                    #만약 변수 menu의 원소의 개수가 0보다 크지 않다면
    print('결과가 없습니다.')                                              #'결과가 없습니다.'라는 문자열을 출력한다.

