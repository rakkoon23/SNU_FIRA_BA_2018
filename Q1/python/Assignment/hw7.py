# Assignment Number...: 7
# Student Name........: 오승환
# File Name...........: hw7_오승환
# Program Description.: 파이썬 제어문을 활용하여 프로그램을 구성하는 과제입니다.

#서울 살이
#신입사원의 서울 살이
#돈
#   기본값을 제공합니다.
#   돈은 매일 30씩 제공됩니다.
#   돈이 0이 되면 사망합니다.
#행복
#   음식을 먹거나 친구를 만나면 행복이 증가합니다.
#   행복이 0이 되면 사망합니다.
#   친구를 만나면 행복이 증가합니다.
#포만감
#   포만감이 0이 되면 사망합니다.
#   밥을 먹으면 포만감이 증가합니다.
#친구 만나기
#   친구를 만나면 행복이 증가하지만, 돈이 감소합니다.
#밥 먹기
#   밥을 먹으면 행복이 증가하지만, 돈이 감소합니다.
#쇼핑
#   쇼핑을 하면 돈이 랜덤하게 감소하고 행복이 랜덤하게 증가합니다.
#여자친구 만나기
#   "여자친구가 없습니다."라는 멘트와 함께 갑자기 기분이 시무룩해집니다. 이유 없이 행복이 감소합니다.

def start(): #def로 start 함수를 정의.
    print('[신입사원의 서울살이]') #게임의 제목을 출력.
    print('''\
    게임 설명
        당신은 이제 막 상경한 신입사원입니다. 쥐꼬리만한 월급으로 서울에서 살아남아야 합니다.
        일정하게 주어지는 월급으로 행복감과 배고픔을 유지하면서 서울에서 살아남으세요!''') #게임 설명을 출력.
    print('''\
    게임 규칙
        돈
          -돈은 매일 조금씩 제공됩니다.
          -돈이 0이 되면 사망합니다.
        행복
          -음식을 먹거나, 친구를 만나거나, 쇼핑을 하면 행복이 증가합니다.
          -특정 행동을 하면 행복이 감소합니다.
          -행복이 0이 되면 사망합니다.
        포만감
          -밥을 먹으면 포만감이 증가합니다.
          -포만감이 0이 되면 사망합니다.
          -포만감은 매일 조금씩 감소합니다.
        친구 만나기
          -친구를 만나면 행복이 증가하지만, 돈이 감소합니다.
        쇼핑
          -쇼핑을 하면 행복이 랜덤하게 증가하고 돈이 랜덤하게 감소합니다.      
        ''')

def meet_friend():                                              #meet_friend라는 함수를 정의.
    global happiness                                            #전역변수를 불러온다.
    happiness += 30                                             #친구를 만나면, 행복에 30을 더하고 이를 재할당한다.
    global money                                                #전역변수를 불러온다.
    money -= 50                                                 #친구를 만나면, 돈을 50 빼고 이를 재할당한다.
    print('\n친구를 만났습니다. 기분은 좋지만 돈은 줄어듭니다.\n')   #친구를 만난 상황에 대한 설명을 출력.

def eat():                                                      #eat이라는 함수를 정의
    global happiness                                            #전역변수를 불러온다.
    happiness += 30                                             #밥을 먹으면 행복에 30을 더하고 이를 재할당한다.
    global money                                                #전역변수를 불러온다.
    money -= 50                                                 #밥을 먹으면 돈에서 50을 빼고 이를 재할당한다.
    global hunger                                               #전역변수를 불러온다.
    hunger += 30                                                #밥을 먹으면 포만감을 30 빼고 이를 재할당한다.
    print('\n밥을 먹었습니다. 포만감이 들어 기분은 좋지만, 돈은 줄어듭니다.\n') #밥을 먹은 상황에 대한 설명을 출력.

from random import uniform                                      #랜덤 수를 생성하기 위해 uniform을 불러온다.

def random_num():                                               #랜덤한 수를 생성하는 함수를 정의.
    num = int(uniform(10, 50))                                  #함수 uniform을 통하여 10부터 50까지의 랜덤한 수를 생성하고 변수 b에 할당한다.
    return num                                                  #변수 b에 할당된 값을 리턴한다.

def shopping():                                                 #shopping 함수를 정의한다.
    global random_num                                           #전역함수를 불러온다.
    num1 = random_num()                                         #랜덤한 수를 생성하여 변수 num1에 할당.
    num2 = random_num()                                         #랜덤한 수를 생성하여 변수 num2에 할당.
    global happiness                                            #전역변수를 불러온다.
    happiness += num1                                           #쇼핑을 하면 num1만큼 행복을 증가시키고 이를 재할당한다.
    global money                                                #전역변수를 불러온다.
    money -= num2                                               #쇼핑을 하면 num2만큼 돈을 감소시키고 이를 재할당한다.
    print('\n쇼핑을 했습니다. 행복하긴 하지만, 돈이 줄어듭니다.\n')  #쇼핑을 한 상황에 대한 설명을 출력.

def meet_girlfriend():                                          #meet_girlfriend 함수를 정의.
    global happiness                                            #전역변수를 불러온다.
    happiness -= 30                                             #해당 기능을 호출하면 행복을 30 감소시키고 이를 재할당한다.
    print('''\n여자친구가 없습니다. 갑자기 기분이 시무룩해집니다.\n''') #해당 상황에 대한 설명을 출력.

def death():                                                    #death 함수를 정의.
    global life                                                 #전역변수를 불러온다.
    life = 0                                                    #사망 조건이 충족되면 life를 0으로 바꾼다.
    print('30일이 경과하여 신입사원이 사망하였습니다.')              #사망 상황에 대한 설명을 출력한다.

def prompt():                                                   #prompt 함수를 정의.
    print('''\n[가능한 행동들]
1 - 밥 먹기
2 - 친구 만나기
3 - 쇼핑하기
4 - 여자친구 만나기\n''')                                         #매 턴마다 출력할 문구를 출력한다.
    a = input("신입사원에게 어떤 명령을 내릴까요?: ")               #input함수를 통해 명령어를 입력받고 이를 변수 a에 할당한다.
    return a                                                    #변수 a를 리턴한다.

def checkstats():                                               #checkstats 함수를 정의.
    print('[신입사원의 현재 상태]')                               #제목을 출력한다.
    print('돈: {}'.format(money))                               #format 메소드와 print 함수를 사용하여 변수 money를 출력한다.
    print('행복: {}'.format(happiness))                         #format 메소드와 print 함수를 사용하여 변수 happiness를 호출한다.
    print('포만감: {}'.format(hunger))                          #format 메소드와 print 함수를 사용하여 변수 hunger를 호출한다.

def daily_check():                                             #함수 daily_check를 정의.
    global checkstats                                          #전역함수 checkstats를 불러온다.
    checkstats()                                               #checkstats 함수를 실행한다.
    global hunger                                              #전역변수를 불러온다.
    hunger -= 15                                               #매 턴마다 포만감을 15씩 감소시키고 이를 재할당한다.
    global money                                               #전역변수를 불러온다.
    money += 30                                                #매 턴마다 돈을 30 증가시키고 이를 재할당한다.
    x = True                                                   #무한루프를 위해 x에 True를 할당한다.
    while x:                                                   #x가 True일 때 무한루프를 돌린다.
        input_prompt = prompt()                                #입력받은 명령어를 변수에 할당한다.
        if input_prompt == '1':                                #만약 입력받은 명령어가 '1'이라면,
            eat()                                              #eat 함수를 실행한다.
            x = False                                          #그리고 해당 순환문을 종료한다.
        elif input_prompt == '2':                              #만약 입력받은 명령어가 '2'라면,
            meet_friend()                                      #meet_friend 함수를 실행한다.
            x = False                                          #그리고 핻항 순환문을 종료한다.
        elif input_prompt == '3':                              #만약 입력받은 명령어가 '3'이라면,
            shopping()                                         #shopping 함수를 실행한다.,
            x = False                                          #그리고 핻항 순환문을 종료한다.
        elif input_prompt == '4':                              #만약 입력받은 명령어가 '4'라면,
            meet_girlfriend()                                  #meet_girlfriend 함수를 실행한다.
            x = False                                          #그리고 핻항 순환문을 종료한다.
        else:                                                  #만약 입력된 명령어가 '1', '2', '3', '4' 중 하나도 없다면,
            print('\n1번, 2번, 3번, 4번 중 하나를 선택해주세요.\n') #해당 문구를 출력한다.
            continue                                           #그리고 다시 순환문을 돌린다.

start()                                                        #게임 및 규칙 설명
money = 300                                                    #돈의 기본값은 300이다.
happiness = 70                                                 #행복의 기본값은 70이다.
hunger = 100                                                   #배고픔의 기본값은 100이다.
girlfriend = 0                                                 #여자친구 없음.

life = 30                                                      #life에 30을 할당한다.
for i in range(life):                                          #life에 할당된 만큼 for문을 돌린다.
    print('     ### Day {} ###\n'.format(i))                   #format 메소드와 print 함수를 통해 며칠인지를 출력한다.
    if hunger > 0:                                             #만약 배고픔이 0 이상이라면,
        if happiness > 0:                                      #만약 행복이 0 이상이라면,
            if money > 0:                                      #만약 돈이 0 이상 있다면,
                daily_check()                                  #해당 함수를 실행한다.
            else:                                              #돈이 0이거나 0보다 적다면,
                print('돈이 0이 되어 신입사원이 사망하였습니다.')  #해당 문구를 출력한다.
                break                                          #그리고 해당 순환문을 종료한다.
        else:                                                  #행복이 0이거나 0보다 적다면,
            print('행복감이 0이 되어 신입사원이 사망하였습니다.')   #해당 문구를 출력한다.
            break                                              #그리고 해당 순환문을 종료한다.
    else:                                                      #포만감이 0이거나 0보다 적다면,
        print('포만감이 0이 되어 신입사원이 사망하였습니다.')       #해당 문구를 출력한다.
        break                                                  #그리고 해당 순환문을 종료한다.
else:                                                          #만약 for문이 정상적으로 종료되었다면,
    death()                                                    #해당 함수를 실행한다.
