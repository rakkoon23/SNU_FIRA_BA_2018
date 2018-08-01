# Assignment Number...: 10
# Student Name........: 오승환
# File Name...........: hw10_오승환
# Program Description.: 파일을 열고 자료를 처리하는 법을 익히는 과제입니다.

import string                                               #string 모듈을 불러온다.
strip = string.whitespace                                   #string 모듈의 화이트스페이스를 strip 변수에 할당한다.
f = open('subway.txt', mode='r', encoding='utf-8-sig')      #해당 파일을 읽기 전용으로 불러와서 변수 f에 할당한다.
lines = list(f.readlines())                                 #각 행을 문자열 자료형으로 갖고 전체 내용은 리스트에 담아서 변수 lines에 할당한다.
f.close()                                                   #파일을 닫는다.

b = []                                                      #빈 리스트를 만들고 변수 b에 할당한다.
col_names = lines[0].split(',')                             #콤마를 구분자로 하여 나누고 lines의 첫 번째 행을 변수 col_names에 할당한다.
for i in range(1, len(lines)):                              #첫 행을 빼기 위해 1부터 lines의 전체 길이까지 for문을 돌린다.
    lines_values = lines[i].split(',')                      #lines의 첫 번째 행을 콤마를 구분자로 하여 나누고 변수 lines_values에 할당한다.
    a = {}                                                  #빈 딕셔너리를 만들고 변수 a에 할당한다.
    for j in range(len(col_names)):                         #변수 col_names의 길이만큼 for문을 돌린다.
        col_name = col_names[j].strip(strip)                #화이트스페이스를 제거한 col_names의 j번째 요소를 변수 col_name에 할당한다.
        lines_value = lines_values[j].strip(strip)          #화이트스페이스를 제거한 lines_values의 j번째 요소를 변수 lines_value에 할당한다.
        a[col_name] = lines_value                           #키를 col_name으로, 값을 lines_value로 하는 원소를 딕셔너리 a에 담는다.
    b.append(a)                                             #하나의 행의 길이만큼 돌아가면 b에 a를 핟랑한다.

print('\n'+'#'*10, '테스트1', '#'*10)                        #print 함수를 사용하여 테스트1이라는 제목을 작성한다.
print('월요일의 하차 정보만 모은 목록')                        #print 함수를 사용하여 제목을 작성한다.
days = [x for x in b if x.get('요일') == '월']               #변수 b의 목록 중 '요일' 키의 값이 '월'인 항목들을 변수 days에 할당한다.
print(days)                                                 #print 함수를 사용하여 변수 days를 출력한다.

print('\n'+'#'*10, '테스트2', '#'*10)                        #print 함수를 사용하여 테스트2라는 제목을 작성한다.
print('7시에서 8시 하차 인원이 1700명 이상인 날짜의 목록')       #print 함수를 사용하여 제목을 작성한다.
seven = [y.get('날짜') for y in b if y.get('구분') == '하차' if int(y.get('7')) >= 1700] #변수 b의 목록에서 '구분' 키의 값이 '하차'이고 '7' 키의 값이 1700보다 큰 것들 중 '날짜' 키의 값들을 변수 seven에 할당한다.
print(seven)                                                 #print 함수를 사용하여 변수 seven을 출력한다.

print('\n'+'#'*10, '테스트3', '#'*10)                         #print 함수를 사용하여 테스트3이라는 제목을 작성한다.
print('날짜가 4의 배수인 날짜 중 8시에서 9시 하차 인원은 짝수인 날들의 날짜 목록') #print 함수를 사용하여 제목을 작성한다.
complex_list = [z.get('날짜') for z in b if int(z.get('날짜')) % 4 == 0 if z.get('구분') == '하차' if int(z.get('8')) % 2 == 0]
#변수 b의 목록에서 '날짜' 키의 값이 4로 나누었을 때 0이고 '구분'키의 값이 '하차'이고 '8' 키의 값이 2로 나누었을 때 0인 것들의 '날짜' 키의 값들을 변수 complex_list에 할당한다.
print(complex_list)                                          #print 함수를 사용하여 변수 complex_list를 출력한다.
