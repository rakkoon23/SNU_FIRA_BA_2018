# EDA for feature engineering

library(tidyverse)
library(feather)
library(data.table)
library(viridis)
library(DT)
library(lubridate)
library(magrittr)
library(fread)

setwd("C:/Users/renz/Desktop/BA/3학기/고급 빅데이터 분석/team project/music recommendation")

train <- fread("train.csv", encoding= "UTF-8", verbose=FALSE)
test <- fread("test.csv", encoding= "UTF-8", verbose=FALSE)
members <- fread("members.csv", encoding= "UTF-8", verbose=FALSE)
songs <- fread("songs.csv", encoding= "UTF-8", verbose=FALSE)
songs_info <- fread("song_extra_info.csv", encoding= "UTF-8", verbose=FALSE)

## ggplot setting for readable labels
readable_labs <- theme(axis.text=element_text(size=12),
                       axis.title=element_text(size=14),
                       plot.title = element_text(hjust = 0.5))

### Train.csv

# Function to dislpay count of each category of the column and plot how it affects target
target_vs_column <-function(df, col_name, x, y, title)
{
  temp_df <- df %>% 
    group_by_(col_name) %>% 
    summarize(count = n(), mean_target = mean(target)) %>% 
    arrange(desc(mean_target)) 
  
  df_plot <- temp_df %>%  
    ggplot(aes_string(col_name, "mean_target")) + 
    geom_col(aes(fill=count)) +
    scale_fill_gradient(low='turquoise', high = 'violet')+
    coord_flip() +
    labs(x = x,
         y = y,
         title= title) +
    readable_labs
  
  print(df_plot)
  return (temp_df)
  
}




# Function to group songs and user by count and check it agains mean_target
target_vs_colcount <- function(df, col_name, x, y, title)
{ 
  df %>% 
    group_by_(col_name) %>% 
    summarize(count = n(), mean_target = mean(target)) %>% 
    group_by(count) %>% 
    summarize(new_count = n(), avg_target = mean(mean_target)) %>% 
    rename(no_of_items = new_count, occurence = count) %>% 
    print %>% 
    arrange(desc(avg_target)) %>% 
    print %>% 
    ggplot(aes(occurence, avg_target)) +
    geom_line(color='turquoise') +
    geom_smooth(color='turquoise') +
    labs(x = x,
         y = y,
         title= title) +
    readable_labs
}


## Source_system_tab
# source_system_tab에 따라 재청취율이 어떻게 달라지는지 시각화.
target_vs_column(train_with_not_value, col_name = "source_system_tab",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_system_tab vs Target')

# train에서 "" or null 값을 Not Value로 변환
train_with_not_value = train
train_with_not_value$source_system_tab = ifelse(train_with_not_value$source_system_tab == "", "Not Value", train_with_not_value$source_system_tab)
train_with_not_value$source_system_tab = ifelse(train_with_not_value$source_system_tab == "null", "Not Value", train_with_not_value$source_system_tab)
train_with_not_value$source_screen_name = ifelse(train_with_not_value$source_screen_name == "", "Not Value", train_with_not_value$source_screen_name)
train_with_not_value$source_type = ifelse(train_with_not_value$source_type == "", "Not Value", train_with_not_value$source_type)

sum(train_with_not_value$source_system_tab == "Not Value")

# 그리고 다시 시각화.
target_vs_column(train_with_not_value, col_name = "source_system_tab",
                 x = 'Source_system_tab',
                 y = '평균 재청취율(Mean of Target)',
                 title = 'system_tab별 평균 재청취율과 빈도')
sum(train_with_not_value$source_system_tab == "Not Value") # 24,849

a = sum(train_with_not_value$source_system_tab == "Not Value") + sum(train_with_not_value$source_screen_name == "Not Value") + sum(train_with_not_value$source_type == "Not Value") 
a / nrow(train_with_not_value)


# 해당 곡이 my library에서 재생되었다면, 한 달 이내에 다시 재생될 확률이 radio보다 높다.
# 이는 상식적으로 생각해보면 당연한 결과이다.
# 어떤 노래가 my library에 담겨 있다면, 사용자가 좋아하는 노래일 가능성이 높다.
# 하지만, radio에서 재생된 곡들은 사용자의 호감과는 상관 없이 일방적으로 선별된 노래만을 듣는 것이기 때문에 my library에 있는 곡들에 대한 재청취율이 높은 것이다.
# discover는 재생 자체는 많이 됐는데 재청취율은 낮았다는 뜻인 것 같다.


target_vs_column <-function(df, col_name, x, y, title)
{
  temp_df <- df %>% 
    group_by_(col_name) %>% 
    summarize(count = n(), mean_target = mean(target)) %>% 
    arrange(desc(mean_target)) 
  
  df_plot <- temp_df %>%  
    ggplot(aes_string(col_name, "mean_target")) + 
    geom_col(aes(fill=count)) +
    scale_fill_gradient(low='turquoise', high = 'violet')+
    coord_flip() +
    labs(x = x,
         y = y,
         title= title) +
    readable_labs
  
  print(df_plot)
  return (temp_df)
  
}









  

# 재생 수 기준 상위 78명
target_vs_column(filtered_msno_2000, col_name = "source_system_tab",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_system_tab vs Target (top 30)')


## Source_screen_name
# source_screen_name에 따라 재청취율이 어떻게 달라지는지 시각화.
target_vs_column(train, col_name = "source_screen_name",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_screen_name vs Target')

# same graph with Not value
target_vs_column(train_with_not_value, col_name = "source_screen_name",
                 x = 'source_screen_name',
                 y = '평균 재청취율(Mean of Target)',
                 title = 'screen_name별 평균 재청취율과 빈도')

# Payment는 아마도 개별 노래를 구매하는 것을 말하는 것 같다(확인 필요).
# 이런 경우 해당 노래에 대한 유저의 호감은 높은 편일 것이다.
# 따라서 재청취율도 Payment가 가장 높았다.
# 하지만, 빈도가 12회밖에 없어서 실제로 큰 의미는 없어 보인다.
# 실제로 재청취율이 가장 높은 것은 my library라 보는 것이 맞을 것이다.
# 하지만, 노래가 재생된 횟수 자체는 Local playlist more가 압도적으로 높았다.
# 
# Q. 1번과 2번의 그래프에서 my library의 재청취율이 높은 것을 보고
# 이 사람은 KKBox 유저들이 live streaming보다 downloaded music을 더 선호하는 것처럼 보인다고 말했다.
# 이 말을 통해 유추하건대 my library는 live streaming이 아니라 downloaded music인 건가?
# 
# screen name에는 총 2개의 playlist가 있다.
# online playlist more, local playlist more
# 추측컨대 online playlist는 다른 사람이 올린 playlist 같아 보인다.
# 그럼 local playlist는 내가 만든 playlist인 건가?
# 
#   또, my_library_search는 내 library에서 검색을 해서 재청취를 했다는 것인데
# my library에서 검색을 했다는 것은 그만큼 my library가 많다는 것이고
# my library가 많다는 것은 그만큼 KKBox를 많이 사용하는 유저라는 것이라 추측할 수 있다.

# 재생 수 기준 상위 78명.
target_vs_column(filtered_msno_2000, col_name = "source_screen_name",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_screen_name vs Target (top 78)')

## Source_type
# source_type에 따라 재청취율이 어떻게 달라지는지 시각화
target_vs_column(train, col_name = "source_type",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_type vs Target')

# same graph with Not value
target_vs_column(train_with_not_value, col_name = "source_type",
                 x = 'source_type',
                 y = '평균 재청취율(Mean of Target)',
                 title = 'source_type별 평균 재청취율과 빈도')

+#+ local library보다 local playlist에서의 재청취율이 조금 더 높았다.
# 재생 횟수 자체는 local library가 훨씬 많았다.
# 
# Q. local library와 local playlist의 차이점은 뭘까?
# 
# Q. 피피티 만들 때는 그래프를 내림차순 정렬할 필요가 있어 보인다.
# Q. y축에서 빈칸은 NA값을 의미하는 건가?

# 재생 수 기준 상위 78명.
target_vs_column(filtered_msno_2000, col_name = "source_type",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_type vs Target (top 78)')

## Song count vs Target
target_vs_colcount(train, 
                   "song_id", 
                   "Song Occurence", 
                   "Target", 
                   "Song Occurence vs Target")

## same graph with not value
target_vs_colcount(train_with_not_value, 
                   "song_id", 
                   "노래별 청취 유저수", 
                   "재청취율", 
                   "노래별 청취 유저수와 재청취율")




# 위 표에서 occurence는 등장횟수(재생횟수?)이고 no_of_items는 해당 등장횟수에 해당하는 곡들의 개수이다.
# occurence가 1인 것들의 no_of_items는 166,766이고 avg_target은 0.377인데
# 이는 딱 한 번만 등장한 곡들이 166,766개이고 이들의 재청취율은 0.377이라는 뜻이다.
# 이와 반대로 2752번 등장한 어떤 곡은 재청취율이 85%나 된다.
# 이를 통해 알 수 있는 것은, 등장횟수가 높을 수록 재청취율도 높아진다는 것이다.
# 
# Q. 그렇다면, 두 변수의 상관계수는 어떻게 될까?
# 아래의 방법으로 상관계수를 구했다.
# 상관계수 0.66
a = train %>% 
  group_by_("song_id") %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  group_by(count) %>% 
  summarize(new_count = n(), avg_target = mean(mean_target)) %>% 
  arrange(desc(avg_target))
a %>% 
  arrange(count)
a
cor(a$count, a$avg_target)


## User count vs Target
target_vs_colcount(train_with_not_value, 
                   "msno", 
                   "유저별 청취 곡 수", 
                   "재청취율", 
                   "유저별 청취 곡 수와 재청취율")
# 이 그래프를 통해 유추할 수 있는 것은 세 가지다.
# 첫째, 노래를 자주 듣는 유저라고 해서 평균 재청취율이 높진 않다.
# 둘째, 노래를 적게 듣는 유저들이 있는 구간에서는 노래를 많이 들을 수록 재청취율도 높이ㅏ진다.
# 셋째, 노래를 정말 많이 듣는 유저는 재청취를 하기보다 다양한 노래를 듣는 경우가 있는 것 같다.
# 왜냐하면, 유저 등장빈도가 높은 쪽으로 갈 수록 재청취율은 오히려 조금씩 하락했다.
# 
# Q. 매장이나 길거리 상인들이 라디오를 틀어놓는 경우가 이런 경우에 해당하지 않을까?
# 왜냐하면, 라디오는
# 이 구간의 사람들의 재생이 어디서 많이 되었는지를 확인해보면 더 확실한 답을 얻을 수 있을 것 같다.
# 
# Q. 또, 만약 나중에 모델링을 할 때 구간별로 다르게하면 어떨까?
# 크게 세 구간으로 나누어서 노래를 적게 듣는 사람, 평균과 비슷하게 듣는 사람, 정말 많이 듣는 사람.
# 
# 등장빈도가 2,000회가 넘는 유저들만 인덱싱하는 코드.
for_test = train_with_not_value %>% 
  group_by_("msno") %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  group_by(count) %>% 
  summarize(new_count = n(), avg_target = mean(mean_target)) %>% 
  rename(no_of_user = new_count, occurence = count) %>% 
  arrange(desc(occurence))
print(for_test, n=80) # 78개부터 빈도가 2,000을 넘음.
tail(for_test, 10)

for_test$avg_target

sum(unique(train))
sum(for_test$no_of_user)

# 평균 재청취율 기준으로 내림차순 정렬됨.
# 전체 유저들의 평균 재청취율 요약 통계량
summary(for_test$avg_target)

# 재청취율 기준 상위 30명의 재청취율 요약 통계량
summary(for_test$avg_target[1:30])




sd(for_test$avg_target)
sd(for_test$avg_target[1:30])

# 등장빈도가 2,000넘는 유저의 아이디를 찾아보았다.
top_2000 = sort(table(train[,'msno']), decreasing=TRUE)[1:30]
top_2000 = as.data.frame(top_2000)

# 열 이름 변경
names(top_2000)[1] = "msno"
names(top_2000)[2] = "Freq"
names(top_2000)

# top_2000에서 msno만 담기
msno_2000 = top_2000[,1]
# msno_2000 = as.character(msno_2000)
# msno_2000


# Train 데이터에서 상위 78에 대한 데이터만 추출.
filtered_msno_2000 = filter(train, msno %in% msno_2000)
filtered_msno_2000

# 아래와 같이 검산해보니 맞게 한 게 맞다.
# filtered_msno_2000['msno'] %>%
#   unique() %>%
#   nrow()
# 78개

# train 데이터에서 상위 78명이 차지하는 행 개수는 20만개.
# 이는 train 데이터의 2%에 해당한다.
nrow(filtered_msno_2000)
nrow(filtered_msno_2000) / nrow(train) * 100

names(filtered_msno_2000)

# 시각화를 해봤다. 
# Q. 전체 데이터와 다른 점은 뭐지?

# source_system_tab
ggplot(filtered_msno_2000, aes(source_system_tab)) +
  geom_bar()

# source_screen_name
ggplot(filtered_msno_2000, aes(source_screen_name)) +
  geom_bar() +
  coord_flip()

# source_type
ggplot(filtered_msno_2000, aes(source_type)) +
  geom_bar() +
  coord_flip()





# train에서 target의 값(0, 1)의 개수는 비슷하다
train %>% 
  group_by(target) %>% 
  count



### Members.csv

members_colgroup <- function(df,col_name, x, y, title, xmin, xmax, ymin, ymax)
{
  
  temp_df <- df %>% 
    group_by_(col_name) %>% 
    count() %>% 
    arrange(desc(n))
  
  df_plot <- temp_df %>% 
    ggplot(aes_string(col_name, "n")) + 
    geom_col(fill='goldenrod2') + 
    labs(x = x,
         y = y,
         title = title) +
    xlim(xmin, xmax) +
    ylim(ymin, ymax) +
    readable_labs
  
  print(df_plot)
  return(temp_df)
  
}


members_date_count <- function(df, col_name, x, y, title)
{
  df %>% 
    group_by_(month = month(col_name), year = year(col_name)) %>% 
    count() %>% 
    ungroup %>% 
    mutate(date = as.Date(paste(as.character(year), as.character(month), '01', sep='-')))
  ggplot(aes(date, n))+
    geom_line(color='goldenrod2', size=1) +
    labs(x = x,
         y = y,
         title= title) +
    xlim(xmin, xmax) +
    readable_labs
}


## Distribution of Age
members_colgroup(members, "bd", "Age", "Frequency", "Age Distribution", 1, 100, 0, 1000)

# 사용자의 나이대는 10대~20대가 가장 많았다.
# 0 이하와 101세 이상은 제외하였다.

## Distribution of city
members_colgroup(members, "city", "City", "Frequency", "City Distribution", 0, 25, 0, 20000)

members %>% 
  group_by_("city") %>% 
  count() %>% 
  arrange(desc(n))

# 1번 도시의 사용자들이 압도적으로 많았다.
# 하지만, 19,445라는 숫자는 나이가 0인 사람과 일치하는 숫자이기 때문에 무언가 의심스럽다.
# 만약 데이터를 수집하는 과정에서 나이가 불분명한 경우 0으로 표시했다면,
# 거주지 데이터도 비슷한 이유로 1로 표시했을 가능성도 있다.
# 하지만, 그냥 홍콩, 대만처럼 KKBox를 많이 사용하는 지역일 가능성도 있다.

# Q. 1번 도시 거주자의 나이가 0인 비율이 얼마나 되는지 확인해 봐도 좋을 듯.


## Distribution of gender
members %>% 
  group_by(gender) %>% 
  count

# 남녀의 비율은 비슷하다.
# 하지만, NA값이 너무 많다.


## Distribution of registered_via
members_colgroup(members, "registered_via", "Registration Method", "Frequency", "Registration method Distribution", 0, 16, 0, 15000)

# 3, 4, 7, 9의 방법을 통해 등록한 사람이 압도적으로 많다.


## Setting date type
members %<>% 
  mutate(registration_init_time = ymd(registration_init_time),
         expiration_date = ymd(expiration_date))


## Signup vs Expiration
# members_date_count(members, "registration_init_time", "Signup Date", "Number of Users", "Signup vs User Count")
reg_count <- members %>% 
  group_by(month = month(registration_init_time), year = year(registration_init_time)) %>% 
  count() %>% 
  ungroup %>% 
  mutate(date = as.Date(paste(as.character(year), as.character(month), '01', sep='-'))) %>% 
  arrange(desc(n)) %>% 
  print


# expiration date count
exp_count <- members %>% 
  group_by(month = month(expiration_date), year = year(expiration_date)) %>% 
  count() %>% 
  ungroup %>% 
  mutate(date = as.Date(paste(as.character(year), as.character(month), '01', sep='-'))) %>% 
  arrange(desc(n)) %>% 
  print

# 전체 유저의 1/3에 해당하는 약 1만명이 2017년 9월에 만료된다.


reg_count %>% 
  left_join(exp_count, by="date") %>% 
  ggplot() +
  geom_line(aes(date, n.x), color='goldenrod2') +
  geom_line(aes(date, n.y), color='mediumorchid') +
  labs(y="Frequency", title="Registration and Expiration Distribution") +
  scale_shape_discrete(labels = c("등록일", "만료일")) +
  readable_labs 
  


# n.x(노란색 선)는 reg_count이고 n.y(보라색 선)는 exp_count이다.
# 즉, 노란색 선은 등록에 대한 분포이고
# 보라색 선은 만료에 대한 분포이다.
# 등록은 fluctuation이 있지만, 점진적으로 증가하다가 2016년 말부터 크게 증가했다.
# 하지만, 이에 비례하여 만료도 크게 증가했다.
# 특히 2017년 9월에 1만명에 가까운 사람이 만료 예정인 것이 눈에 띈다.


## Missingness in members

members %>% 
  mutate(cga = if_else(((city == 1) & (bd == 0) & (gender == "")), 1, 0),
         cg =  if_else(((city == 1) & (gender == "")), 1, 0),
         ca = if_else(((city == 1) & (bd == 0)), 1, 0),
         ga =  if_else(((bd == 0) & (gender == "")), 1, 0)) %>% 
  summarize(city_gender_age = sum(cga),
            city_gender = sum(cg),
            city_age = sum(ca),
            gender_age =sum(ga))

# city_gender_age는 city가 1, 나이가 0, 성별이 빈칸으로 기입된 행의 개수다.
# 이런 방식으로 나올 수 있는 4개의 경우의 수에 대해 카운트한 것이 위의 코드다.
# 숫자가 대부분 비슷한 것을 확인할 수 있다.
# 아마 KKBox에 회원가입을 할 때 이러한 정보들은 필수항목이 아닌 것이라 추측된다.


### Songs.csv

# 카운트 기준으로 상위 100개를 출력하는 함수
top_100 <- function(df, col_name)
{
  temp_df <- df %>% 
    group_by_(col_name) %>% 
    count %>% 
    arrange(desc(n)) %>% 
    print
  
  return(temp_df)
}


## Top 100 artists
artist_count <- top_100(songs, "artist_name")

## Top 100 lyricist
lyricist_count <- top_100(songs, "lyricist")

## Top 100 composers
composer_count <- top_100(songs, "composer")

## Top 100 languages
language_count <- top_100(songs, "language")



length(unique(songs$language))
ggplot(songs, aes_string("language")) +
  geom_bar() +
  readable_labs

# -1 lanugage에 대해 분석
minus_songs = filter(songs, language == -1)
nrow(minus_songs)
head(minus_songs)
names(minus_songs)
head_songs = head(minus_songs, 100)
a = merge(x=head_songs, y=songs_info, all.x=TRUE)
head(a$lyricist, 100)
tail(a,20)
sum(a$lyricist == "")


# 성별로 target 변수가 어떻게 달라지는지 확인
names(members)
members2 <- fread("members2.csv", encoding= "UTF-8", verbose=FALSE) # 성별 채워진 데이터
merged = merge(train_with_not_value, members2, by = "msno")  
nrow(merged)  
merged %>% 
  group_by(gender) %>% 
  mutate(count = n())

names(merged)

merged %>% 
  group_by(gender) %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  arrange(desc(mean_target))

# Train에서 언어별로 노래의 분포가 어떻게 달라지는지 확인
merged = merge(x = train_with_not_value, y = songs, by = "song_id", all.x = TRUE)

merged %>% 
  group_by(song_id) %>% 
  group_by(language) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count))

# korea
korea = filter(merged, language == 31)
nrow(korea)
unique(korea$artist_name) %>% head(30)

# usa
usa = filter(merged, language == 52)
nrow(usa)
unique(usa$artist_name) %>% head(100)

# taiwan
taiwan = filter(merged, language == 3)
nrow(taiwan)
unique(taiwan$artist_name) %>% head(100)

## Top Genre's
genre_count <- songs %>% 
  separate(genre_ids, c("one", "two", "three", "four", "five", "six", "seven", "eight"), extra="merge") %>% 
  select(one:eight)%>% 
  gather(one:eight, key="nth_id", value="genre_ids", na.rm=TRUE) %>% 
  group_by(genre_ids) %>% 
  count %>% 
  arrange(desc(n)) %>% 
  print()


## Distribution of length
songs %>% 
  mutate(song_length = song_length/6e4) %>% 
  ggplot(aes(song_length)) +
  geom_histogram(binwidth = 0.25, fill='darkorchid3') +
  labs(x='노래의 길이', y = '노래의 개수', title = 'Distribution of song length') +
  xlim(0, 15) +
  readable_labs

# 노래의 길이에 따른 평균 재청취율
songs %>% names()
train %>% names()
a = songs %>% select(song_id, song_length)
b = train %>% select(msno, song_id, target)
merged = merge(a, b, by = "song_id")
nrow(merged)

length(unique(a$song_length))

merged %>% 
  group_by(song_id) %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  group_by(song_length) %>% 
  summarize(new_count = sum(count), new_target = mean(mean_target)) %>% 
  arrange(desc(mean_target))




# 노래의 길이에 대한 요약통계량
summary(songs$song_length / 6e4) 
mean(songs$song_length / 6e4) 

songs %>% arrange(desc(song_length)) %>% tail()

songs_info[which(songs_info$song_id == "pqHugp6+1A1nvxwDjucOA00lFQBs2bE2OJU9c13/lfc=")]

# 대부분 2.5 ~ 5분 사이의 곡들이 많다.


### Test.csv
test = as.tibble(test)


test_train_plot <- function(train, test, col_name, x, y)
{
  test %>% 
    group_by_(col_name) %>% 
    summarize(count = n()) %>% 
    left_join(train %>% 
                group_by_(col_name) %>% 
                summarize(count = n()) , by=col_name) %>% 
    mutate(ratio = count.x/count.y) %>% 
    rename(test_cnt = count.x, train_cnt = count.y) %>% 
    arrange(ratio) %>% 
    print %>% 
    ggplot() +
    geom_col(aes_string(col_name, "train_cnt"), fill='red', alpha = 0.5) +
    geom_col(aes_string(col_name, "test_cnt"), fill='blue', alpha = 0.5) +
    coord_flip() +
    labs(x = x, y= y)+
    readable_labs
}

# 빨간색 막대가 train, 파란색 막대가 test 데이터이다.

## source_system_tab
test_train_plot(train, test, col_name = "source_system_tab", 'Source system tab', 'Test/Train record Count')


## Source_screen_name
test_train_plot(train, test, col_name = "source_screen_name", "Source Screen Name", "Test/Train Count")


## Source_type
test_train_plot(train, test, col_name = "source_type", "Source Type", "Test/Train Count")


### Feature Engineering

## Songs feature
# <> is from magrittr package that is used for assiging it back the result
songs %<>% 
  left_join(artist_count, by='artist_name') %>% 
  left_join(lyricist_count, by='lyricist') %>% 
  left_join(composer_count, by='composer') %>% 
  left_join(language_count, by='language') %>% 
  rename(art_cnt = n.x, lyr_cnt = n.y, cmp_cnt = n.x.x, lng_cnt = n.y.y)
# Q. language_count에서 에러남.

# Multiple Joins with a smaller data set is much cheaper than lookup
songs %<>% 
  add_column(no_of_genre = 1:dim(.)[1],
             avg_genre_cnt = 1:dim(.)[1]) %>% 
  separate(genre_ids, c("one", "two", "three", "four", "five", "six", "seven", "eight"), extra="merge") %>% 
  left_join(genre_count, by = c("one" = "genre_ids")) %>% 
  left_join(genre_count, by = c("two" = "genre_ids"), suffix = c(".one", ".two")) %>% 
  left_join(genre_count, by = c("three" = "genre_ids")) %>% 
  left_join(genre_count, by = c("four" = "genre_ids"), suffix = c(".three", ".four")) %>% 
  left_join(genre_count, by = c("five" = "genre_ids")) %>% 
  left_join(genre_count, by = c("six" = "genre_ids"), suffix = c(".five", ".six")) %>% 
  left_join(genre_count, by = c("seven" = "genre_ids")) %>% 
  left_join(genre_count, by = c("eight" = "genre_ids"), suffix = c(".seven", ".eight")) 

songs %<>% 
  replace_na(list(n.one = 0, n.two = 0, n.three = 0, n.four = 0,
                  n.five = 0, n.six = 0, n.seven = 0, n.eight = 0)) %>% 
  mutate(no_of_genre = (if_else(n.one == 0, 0, 1) + if_else(n.two == 0, 0, 1) +
                          if_else(n.three == 0, 0, 1) + if_else(n.four == 0, 0, 1) +
                          if_else(n.five == 0, 0, 1) + if_else(n.six == 0, 0, 1) +
                          if_else(n.seven == 0, 0, 1) + if_else(n.eight == 0, 0, 1)),
         avg_genre_cnt = (n.one + n.two + n.three + n.four +
                            n.five + n.six + n.seven + n.eight)/no_of_genre) %>% 
  select(song_id, song_length, language, art_cnt:lng_cnt, no_of_genre, one, n.one, avg_genre_cnt)


## Train features
count_frame <- function(df, col_name, new_name)
{
  return(df %>% 
           group_by_(col_name) %>% 
           count %>% 
           rename_(.dots=setNames('n', new_name)))
}

train_song_cnt <- count_frame(train, 'song_id', 'song_cnt')
train_sst <- count_frame(train, 'source_system_tab', 'sst_cnt')
train_ssn <- count_frame(train, 'source_screen_name', 'ssn_cnt')
train_st <- count_frame(train, 'source_type', 'st_cnt')


# Reducing the number of categories into four categories based on interest (approximation)
# 0 - high interest - local and search
# 1 - random on internet
# 2 - random
# 3 - social

train %<>% 
  mutate(sst = ifelse((source_system_tab %in% c('my library', 'search')), 0, 
                      ifelse((source_system_tab %in% c('discover', 'explore', 'radio')), 1,
                             ifelse((source_system_tab %in% c('null', '', 'notification', 'settings')), 2, 3)))) %>%
  mutate(ssn = ifelse((source_screen_name %in% c('Payment', 'My library', 'My library_Search',
                                                 'Local playlist more', 'Search')), 0,
                      ifelse((source_screen_name %in% c('Album more', 'Artist more', 'Concert', 'Discover Chart',
                                                        'Discover Feature', 'Discover Genre', 'Discover New',
                                                        'Explore', 'Radio')), 1,
                             ifelse((source_screen_name %in% c('People global', 'People local', 'Search Home',
                                                               'Search Trends', ' Self Profile more')), 2, 3)))) %>% 
  mutate(st = ifelse((source_type %in% c('local-library', 'local-playlist')), 0,
                     ifelse((source_type %in% c('artist', 'album', 'my-daily-playlist',
                                                'online-playlist', 'radio', 'song-based-playlist',
                                                'top-hits-for-artist', 'topic-article-playlist', 'song')), 1, 2))) 
# source_system_tab, source_screen_name, source_type이 각각 카테고리 변수이고
# 레벨이 너무 많으니까, 카테고리를 몇개씩 그룹화한 것임.
# 즉, 카테고리 숫자를 줄였다.


### Train features vs Target

## Source type
target_vs_column(train, col_name = "st",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_system_tab vs Target')


## Source screen name
target_vs_column(train, col_name = "ssn",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_system_tab vs Target')


## Source system tab
target_vs_column(train, col_name = "sst",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_system_tab vs Target')


############### just for test ###############

unique(train$source_system_tab)
unique(train$source_screen_name)
unique(train$source_type)



as.data.frame(table(train$source_screen_name))

## discover
discover = train[train$source_system_tab == "discover"]
unique(discover$source_screen_name)
nrow(discover)

nrow(train)
nrow(discover)

unique(discover$source_screen_name)
unique(train$source_screen_name)






### source_system_tab 그래프 함수
plot_system_tab = function(x){

  # 확인하고자 하는 source_system_tab을 가져옴.
  unique_tab = unique(train$source_system_tab)[x]
  
  # train에서 해당 source_system_tab에 해당하는 행만 가져옴.
  col_name = train[train$source_system_tab == unique_tab]
  
  # ggplot으로 시각화하고 90도 회전.
  graph = ggplot(col_name, aes(col_name$source_screen_name)) +
    geom_bar() +
    ggtitle(paste0("source_system_tab: ", unique_tab)) +
    readable_labs +
    coord_flip()
  print(graph)
  
  # 해당 폴더에 저장.
  ggsave(paste0("source_system_tab_", unique_tab, ".png"),
         path = ".\\code\\plot\\source_system_tab",
         width = 15,
         height = 10,
         units = c("cm"))
}

# 모든 그래프 저장
unique_rows = unique(train$source_system_tab)
for (i in 1:length(unique_rows)){
  plot_system_tab(i)
  print(i)
}



## 1. discover
discover = train[train$source_system_tab == "discover",]
unique(discover$source_screen_name)



## 2. my_library
my_library = train[train$source_system_tab == "my library",]
unique(my_library$source_screen_name)

ggplot(my_library, aes(my_library$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 3. explore
explore = train[train$source_system_tab == "explore",]
unique(explore$source_screen_name)


# 4. search
search = train[train$source_system_tab == "search",]
unique(search$source_screen_name)

ggplot(search, aes(search$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 5. ""
empty = train[train$source_system_tab == "",]
unique(empty$source_screen_name)

ggplot(empty, aes(empty$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 6. radio
radio = train[train$source_system_tab == "radio",]
unique(radio$source_screen_name)

ggplot(radio, aes(radio$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 7. listen with
listen_with = train[train$source_system_tab == "listen with",]
unique(listen_with$source_screen_name)

ggplot(listen_with, aes(listen_with$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 8. notification
notification = train[train$source_system_tab == "notification",]
unique(notification$source_screen_name)

ggplot(notification, aes(notification$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 9. null
null = train[train$source_system_tab == "null",]
unique(null$source_screen_name)

ggplot(null, aes(null$source_screen_name)) +
  geom_bar() +
  coord_flip()


# 10. settings
settings = train[train$source_system_tab == "settings",]
unique(settings$source_screen_name)

ggplot(settings, aes(settings$source_screen_name)) +
  geom_bar() +
  coord_flip()


## source_screen_name
# 그래프를 출력하고 폴더에 저장하는 함수
plot_screen_name = function(x){
  
  # 확인하고자 하는 source_screen_name을 가져옴.
  unique_name = unique(train$source_screen_name)[x]
  
  # train에서 해당 source_screen_name에 해당하는 행만 가져옴.
  col_name = train[train$source_screen_name == unique_name]
  
  # ggplot으로 시각화하고 90도 회전.
  graph = ggplot(col_name, aes(col_name$source_system_tab)) +
    geom_bar() +
    ggtitle(paste0("source_screen_name: ",unique_name)) +
    readable_labs +
    coord_flip()
  print(graph)
  
  # 그래프를 해당 폴더에 저장.
  ggsave(filename = paste0("source_screen_name_", unique_name, ".png"),
         path = ".\\code\\plot\\source_screen_name",
         width = 15,
         height = 10,
         units = c("cm"))

}


# for문으로 모든 그래프 한 번에 그리기
unique_screen_rows = unique(train$source_screen_name)
for (i in 1:length(unique_screen_rows)){
  plot_screen_name(i)
  print(i)
}


# 1. Explore
plot_screen_name(1)

# 2. Local playlist more
plot_screen_name(2)

# 3. ""
plot_screen_name(3)

# 4. My library
plot_screen_name(4)

# 5. Online playlist more
plot_screen_name(5)

# 6. Album more
plot_screen_name(6)

# 7. Discover Feature
plot_screen_name(7)

# 8. Unknown
plot_screen_name(8)

# 9. Discover chart
plot_screen_name(9)

# 10. Radio
plot_screen_name(10)

# 11. Artist more
plot_screen_name(11)

# 12. Search
plot_screen_name(12)

# 13. Others profile more
plot_screen_name(13)

# 14. Search Trends
plot_screen_name(14)

# 15. Discover Genre
plot_screen_name(15)

# 16. My library_search
plot_screen_name(16)

# 17. Search Home
plot_screen_name(17)

# 18. Discover New
plot_screen_name(18)

# 19. Self profile more
plot_screen_name(19)

# 20. Concert
plot_screen_name(20)

# 21. Payment
plot_screen_name(21)

#############################################


## source_type

a = unique(train$source_type)[6]
train[train$source_system_tab == a]
train[train$source_screen_name == a]



train_song_id = train['song_id']
test_song_id = test['song_id']
songs['song_id', 'genre_id']




# train에서 각 노래별 재생횟수 확인
train_test = train %>% 
  group_by_("song_id") %>% 
  summarize(count = n()) %>% 
  arrange(desc(count))

# train 데이터 합치기
train = merge(train_test, train, by = "song_id")

#검산
# train_test %>% head()
# sum(train$song_id == train_test$song_id[1])

# train 데이터 합친 후 검산
# train %>% names()
# train %>% arrange(desc(count)) %>% head()
# sum(train$count == 13973)

# test에서 각 노래별 재생횟수 확인.
test_test = test %>% 
  group_by_("song_id") %>% 
  summarize(count = n()) %>% 
  arrange(desc(count))

# test 데이터와 합치기
test = merge(test_test, test, by = "song_id")

# test 데이터와 합친 후 검산
# test = merge(test_test, test, by = "song_id")
# test %>% names()
# test %>% arrange(desc(count)) %>% head(20)
# sum(test$count == 8320)

# 검산
# test_test %>% head()
# sum(test$song_id == test_test$song_id[1])


# train_real %>% names()
# hist(train_real$count)
# hist(test_real$count)
# sum(train_real$count < 100)
# sum(test_real$count < 100)

# 두 데이터를 병합.
train_real = merge(train_test, train, by = "song_id")

# 4분위수 확인
quantile(train_real$count, c(0.25, 0.5, 0.75))
# 25% : 70
# 50% : 467
# 75% : 1893


# train_real의 count를 quantile로 나눔.
# train_real = train_real %>% 
#   mutate(count_quantile = ifelse(count <= 70, 0,
#                                  ifelse((count > 70) & (count <= 467), 1,
#                                         ifelse((count > 467) & (count <= 1893), 2,
#                                                ifelse(count > 1893, 3, NA)))))
table(train_real$count_quantile)
View(train_real)
hist(train_real$count)


# 곡의 인기도!!
ggplot(train_real, aes(count)) +
  geom_histogram(fill='goldenrod2') +
  ggtitle("곡의 인기도") +
  xlab("해당 노래를 들은 사용자의 수") +
  ylab("해당 곡의 수") +
  theme(plot.title = element_text(size = 16, face = "bold", vjust=2))
  

ggplot(train_real, aes(count)) +
  geom_density()


a = filter(songs, genre_ids == "465|921")
b = filter(songs, genre_ids == "921|465")
nrow(a)
nrow(b)
a_songs = a %>% head()
b_songs = b %>% head()
a_merged = merge(x=a, y=songs_info, by = "song_id", all.x = TRUE)
b_merged = merge(x=b, y=songs_info, by = "song_id", all.x = TRUE)
a_merged$name
b_merged$name

a_merged$name %>% head()
b_merged$name %>% head()

songs$genre_ids %>% head(10)



playlist <- train %>% select(song_id)
dsf <-test %>% select(song_id)
playlist <- rbind(playlist, dsf)
genre <- songs %>% select(song_id, genre_ids)
playlist <- merge(playlist, genre, by='song_id', all.X=TRUE)
# sum(playlist $ genre_ids=="") #160426개 장르X


# 장르가 두 개 이상이면, 그 중 두개만 남겨두는 코드 짜봐.
multi_genre=playlist[grep("\\|", playlist$genre_ids),c("song_id","genre_ids")]




# a = strsplit(playlist$genre_ids[5], fixed=TRUE, split="|")


genre_id = matrix(0, nrow=nrow(playlist), ncol=4)
genre_id[1, 2]


a = strsplit(playlist$genre_ids[5], fixed=TRUE, split="|")
a[[1]][1]
a

#1
playlist_test = playlist %>% head(100)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in nrow(playlist_test)){
  ids = strsplit(playlist_test$genre_ids[i], fixed=TRUE, split="|")
  if (length(ids[[1]]) > 2 ){
    genre_id[i, 1] <- ids[[1]][1]
    genre_id[i, 2] <- ids[[1]][2]
    genre_id[i, 3] <- ids[[1]][3]
  } else if (length(ids[[1]]) > 1){
    genre_id[i, 1] <- ids[[1]][1]
    genre_id[i, 2] <- ids[[1]][2]
  } else if (length(ids[[1]]) == 1){
    genre_id[i, 1] <- ids[[1]][1]
  }
  genre_id[i, 4] <- length(ids[[1]])
}

#2
playlist_test = playlist %>% head(100)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in nrow(playlist_test)){
  ids = strsplit(playlist_test$genre_ids[i], fixed=TRUE, split="|")
  ifelse(length(ids[[1]]) > 2,
         for (x in length(1:3)){
           genre_id[i, x] <- ids[[1]][x]},
         ifelse(length(ids[[1]]) > 1, 
                for(y in length(1:2)){
                  genre_id[i, y] <- ids[[1]][y]},
                ifelse(length(ids[[1]]) == 1,
                       genre_id[i, 1] == ids[[1]][1], 0)))
  genre_id[i, 4] = length(ids[[1]])
}

#3
playlist_test = playlist %>% head(100)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in nrow(playlist_test)){
  ids = strsplit(playlist_test$genre_ids[i], fixed=TRUE, split="|")
  if (length(ids[[1]]) > 2 ){
    for (x in length(1:3)){
      genre_id[i, x] <- ids[[1]][x]
    }
  } else if (length(ids[[1]]) > 1){
    for (y in length(1:2)){
      genre_id[i, y] <- ids[[1]][y]
    }
  } else if (length(ids[[1]]) == 1){
    genre_id[i, 1] <- ids[[1]][1]
  }
  genre_id[i, 4] <- length(ids[[1]])
}
genre_id







if (grepl("|", playlist_test$genre_ids[5])){
  print("있음")
} else {
  print("없음")
}
  



#4
playlist_test = playlist %>% head(100)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in nrow(playlist_test)){
  if (grepl("\\|", playlist_test$genre_ids[i]){
        ids = strsplit(playlist_test$genre_ids[i], fixed=TRUE, split="|")
         if (length(ids[[1]]) > 2 ){
           genre_id[i, 1] <- ids[[1]][1]
           genre_id[i, 2] <- ids[[1]][2]
           genre_id[i, 3] <- ids[[1]][3]
           } else if (length(ids[[1]]) > 1){
             genre_id[i, 1] <- ids[[1]][1]
             genre_id[i, 2] <- ids[[1]][2]
             } else if (length(ids[[1]]) == 1){
               genre_id[i, 1] <- ids[[1]][1]
               }
         genre_id[i, 4] <- length(ids[[1]])
         }
    else { genre_id[i, 1] <- playlist_test$genre_ids[i] }
}

#5 Version 1 (수정 필요)
playlist_test = playlist %>% head(150)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in (1:nrow(playlist_test))){
  if (grepl("\\|", playlist_test$genre_ids[i])) {
    ids = strsplit(playlist_test$genre_ids[i], fixed = TRUE, split="|")
    if (length(ids[[1]]) > 2){
      genre_id[i, 1] <- ids[[1]][1]
      genre_id[i, 2] <- ids[[1]][2]
      genre_id[i, 3] <- ids[[1]][3]
    } else if (length(ids[[1]]) > 1){
      genre_id[i, 1] <- ids[[1]][1]
      genre_id[i, 2] <- ids[[1]][2]
    } else if (length(ids[[1]]) == 1){
      genre_id[i, 1] <- ids[[1]][1]
    }
    genre_id[i, 4] <- length(ids[[1]])
  } else {
    genre_id[i, 1] <- playlist_test$genre_ids[i]
    genre_id[i, 4] <- 1
  }
}


# Version 1 검증
genre_id = matrix(0, nrow=nrow(playlist), ncol=4)
for (i in (1:nrow(playlist))){
  if (grepl("\\|", playlist$genre_ids[i])) {
    ids = strsplit(playlist$genre_ids[i], fixed = TRUE, split="|")
    if (length(ids[[1]]) > 2){
      genre_id[i, 1] <- ids[[1]][1]
      genre_id[i, 2] <- ids[[1]][2]
      genre_id[i, 3] <- ids[[1]][3]
    } else if (length(ids[[1]]) > 1){
      genre_id[i, 1] <- ids[[1]][1]
      genre_id[i, 2] <- ids[[1]][2]
    } else if (length(ids[[1]]) == 1){
      genre_id[i, 1] <- ids[[1]][1]
    }
    genre_id[i, 4] <- length(ids[[1]])
  } else {
    genre_id[i, 1] <- playlist$genre_ids[i]
    genre_id[i, 4] <- 1 #수정필요
  }
}
genre_id

# Version 2 (완성)
playlist_test = playlist %>% head(150)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in (1:nrow(playlist_test))){
  if (grepl("\\|", playlist_test$genre_ids[i])) {
    ids = strsplit(playlist_test$genre_ids[i], fixed = TRUE, split="|")
    if (length(ids[[1]]) > 2){
      genre_id[i, 1] <- ids[[1]][1]
      genre_id[i, 2] <- ids[[1]][2]
      genre_id[i, 3] <- ids[[1]][3]
    } else if (length(ids[[1]]) > 1){
      genre_id[i, 1] <- ids[[1]][1]
      genre_id[i, 2] <- ids[[1]][2]
    } else if (length(ids[[1]]) == 1){
      genre_id[i, 1] <- ids[[1]][1]
    }
    genre_id[i, 4] <- length(ids[[1]])
  } else if (playlist_test$genre_ids[i] == "") {
    genre_id[i, 4] <- 0
  } else {
    genre_id[i, 1] <- playlist_test$genre_ids[i]
    genre_id[i, 4] <- 1
  }
}

# Version 2 (최종 검증)
genre_id = matrix(0, nrow=nrow(playlist), ncol=4) # 빈 매트릭스 생성.
for (i in (1:nrow(playlist))){
  if (grepl("\\|", playlist$genre_ids[i])) { # 해당 원소에 "|"가 포함된다면,
    ids = strsplit(playlist$genre_ids[i], fixed = TRUE, split="|") # "|"를 기준으로 분할하여 ids에 할당.
    if (length(ids[[1]]) > 2){ # 만약 원소의 개수가 3개 이상이라면,
      genre_id[i, 1] <- ids[[1]][1] # 첫 번째 원소를 매트릭스의 1번 열에 할당.
      genre_id[i, 2] <- ids[[1]][2] # 두 번째 원소.
      genre_id[i, 3] <- ids[[1]][3] # 세 번째 원소.
    } else if (length(ids[[1]]) > 1){ # 만약 원소의 개수가 2개라면,
      genre_id[i, 1] <- ids[[1]][1] # 첫 번째 원소를 매트릭스의 1번 열에 할당.
      genre_id[i, 2] <- ids[[1]][2] # 두 번째 원소.
    } else if (length(ids[[1]]) == 1){ # 만약 원소의 개수가 1개라면,
      genre_id[i, 1] <- ids[[1]][1] # 첫 번째 원소를 매트릭스의 1번 열에 할당.
    }
    genre_id[i, 4] <- length(ids[[1]]) # 4번째 열에는 ids의 원소 개수를 할당.
  } else if (playlist$genre_ids[i] == "") { # 만약 원소가 없고 빈칸이라면,
    genre_id[i, 4] <- 0 # 0을 매트릭스의 4번 열에 할당.
  } else { # 만약 해당 원소에 "|"가 포함되지 않는다면,
    genre_id[i, 1] <- playlist$genre_ids[i] # 첫 번째 원소를 매트릭스의 1번 열에 할당.
    genre_id[i, 4] <- 1 # 4번째 열에는 1을 할당.
  }
}


# Version 2 문자열->정수형
playlist_test = playlist %>% head(150)
genre_id = matrix(0, nrow=nrow(playlist_test), ncol=4)
for (i in (1:nrow(playlist_test))){
  if (grepl("\\|", playlist_test$genre_ids[i])) {
    ids = strsplit(playlist_test$genre_ids[i], fixed = TRUE, split="|")
    if (length(ids[[1]]) > 2){
      genre_id[i, 1] <- as.integer(ids[[1]][1])
      genre_id[i, 2] <- as.integer(ids[[1]][2])
      genre_id[i, 3] <- as.integer(ids[[1]][3])
    } else if (length(ids[[1]]) > 1){
      genre_id[i, 1] <- as.integer(ids[[1]][1])
      genre_id[i, 2] <- as.integer(ids[[1]][2])
    } else if (length(ids[[1]]) == 1){
      genre_id[i, 1] <- as.integer(ids[[1]][1])
    }
    genre_id[i, 4] <- length(ids[[1]])
  } else if (playlist_test$genre_ids[i] == "") {
    genre_id[i, 4] <- 0
  } else {
    genre_id[i, 1] <- as.integer(playlist_test$genre_ids[i])
    genre_id[i, 4] <- 1
  }
}


# 새로운 매트릭스에 genre_id를 분할해서 할당하고 몇개의 장르가 있는지 카운트. 
genre_id = matrix(0, nrow=nrow(playlist), ncol=4) # 빈 매트릭스 생성.
for (i in (1:nrow(playlist))){ 
  if (grepl("\\|", playlist$genre_ids[i])) { # 해당 원소에 "|"가 포함된다면,
    ids = strsplit(playlist$genre_ids[i], fixed = TRUE, split="|") # "|"를 기준으로 분할하여 ids에 할당.
    if (length(ids[[1]]) > 2){ # 만약 원소의 개수가 3개 이상이라면,
      genre_id[i, 1] <- as.integer(ids[[1]][1]) # 첫 번째 원소를 매트릭스의 1번 열에 할당.
      genre_id[i, 2] <- as.integer(ids[[1]][2]) # 두 번째 원소.
      genre_id[i, 3] <- as.integer(ids[[1]][3]) # 세 번째 원소. 
    } else if (length(ids[[1]]) > 1){ # 만약 원소의 개수가 2개라면,
      genre_id[i, 1] <- as.integer(ids[[1]][1]) # 첫 번째 원소를 매트릭스의 1번 열에 할당.
      genre_id[i, 2] <- as.integer(ids[[1]][2]) # 두 번째 원소.
    } else if (length(ids[[1]]) == 1){ # 만약 원소의 개수가 1개라면,
      genre_id[i, 1] <- as.integer(ids[[1]][1]) # 첫 번째 원소를 매트릭스의 1번 열에 할당.
    }
    genre_id[i, 4] <- length(ids[[1]]) # 4번째 열에는 ids의 원소 개수를 할당.
  } else if (playlist$genre_ids[i] == "") { # 만약 원소가 없고 빈칸이라면,
    genre_id[i, 4] <- 0 # 0을 매트릭스의 4번 열에 할당.
  } else { # 만약 해당 원소에 "|"가 포함되지 않는다면,
    genre_id[i, 1] <- as.integer(playlist$genre_ids[i]) # 첫 번째 원소를 매트릭스의 1번 열에 할당.
    genre_id[i, 4] <- 1 # 4번째 열에는 1을 할당.
  }
}


# artist_name의 개수 카운트
artist_count = 
  str_count(songs$artist_name, "\\|") + 
  str_count(songs$artist_name, "\\&") +
  str_count(songs$artist_name, " feat") +
  str_count(songs$artist_name, ",") + 1

# composer의 개수 카운트
composer_count = 
  str_count(songs$composer, "\\|") +
  str_count(songs$composer, "\\/") +
  str_count(songs$composer, ";") + 1

# 검산
# composer_count
# a = which(composer_count > 10)[1000]
# composer_count[a]
# songs$composer[a]

# lyricist의 개수 카운트
lyricist_count = 
  str_count(songs$lyricist, "\\|") +
  str_count(songs$lyricist, "\\/") +
  str_count(songs$lyricist, ";") + 1

# 검산
# lyricist_count
# a = which(lyricist_count > 10)[300]
# lyricist_count[a]
# songs$lyricist[a]




# songs$composer[146]
# composer_count =
#   str_count(songs$composer[146], "\\|") +
#   str_count(songs$composer[146], "\\/") +
#   str_count(songs$composer[146], ";") + 1
# composer_count
# 
# songs$composer[101]
# composer_count =
#   str_count(songs$composer[101], "\\|") +
#   str_count(songs$composer[101], "\\/") +
#   str_count(songs$composer[101], ";") + 1
# composer_count
# 
# songs$composer[17]
# composer_count =
#   str_count(songs$composer[17], "\\|") +
#   str_count(songs$composer[17], "\\/") +
#   str_count(songs$composer[17], ";") + 1
# composer_count





## bd 처리
bd_test = members$bd
bd_test = ifelse(bd_test <= 0, -1, bd_test) # 나이가 0인 것들은 -1로 변환
bd_test = ifelse(bd_test > 75, -1, bd_test) # 나이가 75 이상인 것들은 -1로 변환
bd_test = ifelse(bd_test < 0, -1, bd_test) # 나이가 0 미만인 것들은 -1로 변환
sum(bd_test == -1)

bd_test = ifelse(bd_test == -1, NA, bd_test) # NA처리
sum(is.na(bd_test))
mean(bd_test, na.rm=TRUE) # 28.84
hist(bd_test)

bd_test = ifelse(is.na(bd_test), 29, bd_test) # NA를 평균으로 대체
mean(bd_test)
hist(bd_test)

# bd를 mice로 예측
members_mice = members
members_mice$bd = ifelse(members_mice$bd <= 0, -1, members_mice$bd) # 나이가 0인 것들은 -1로 변환
members_mice$bd = ifelse(members_mice$bd > 75, -1, members_mice$bd) # 나이가 75 이상인 것들은 -1로 변환
members_mice$bd = ifelse(members_mice$bd < 0, -1, members_mice$bd) # 나이가 0 미만인 것들은 -1로 변환
sum(members_mice$bd == -1) # -1 값 확인

members_mice$bd = ifelse(members_mice$bd == -1, NA, members_mice$bd) # -1 값을 결측치로 변환.
sum(is.na(members_mice$bd)) # 결측치 개수 확인.
members_mice = as.data.frame(members_mice) # 데이터 프레임으로 변환.


bd_imp = mice(members_mice, m=5, method = "cart", maxit = 40, seed = 1) # 결측치 예측.
comp_bd_imp = complete(bd_imp) # 추정된 값을 채움..
sum(is.na(comp_bd_imp)) # 결측치 개수 0 확인.
summary(comp_bd_imp$bd) # 평균이 27.77로 떨어짐.
hist(comp_bd_imp$bd) # 히스토그램.


# gender (실패)
table(members$gender)
gender_mice = members
gender_mice$gender = ifelse(gender_mice$gender == "", NA, gender_mice$gender)
gender_mice = as.data.frame(gender_mice)
sum(is.na(gender_mice))
gender_mice = gender_mice[,-1]
names(gender_mice)

gender_imp = mice(gender_mice, m=5, method="sample", maxit = 150, seed = 1)
comp_gender_imp = complete(gender_imp)
comp_gender_imp$gender
sum(is.na(comp_gender_imp$gender))

methods(mice)

library(dplyr)
### members와 train을 합쳐서 그 후 gender를 예측해보자.
merged = merge(train, members, by="msno")
nrow(merged)
merged$msno %>% unique() %>% length()
sum(merged$gender == "") # 결측치 개수
merged$gender = ifelse(merged$gender == "", NA, merged$gender)
merged = as.data.frame(merged)
merged$gender = as.factor(merged$gender)
names(merged)


merged_imp = mice(merged, m=5, method = "cart", maxit = 20, seed = 1)
comp_merged_imp = complete(merged_imp)



m = merge(train, members, by = "msno")
m = merge(m, songs, by = "song_id")
names(m)
sum(m[m == ""])

m[m == ""] = NA # 공백을 NA로 대체

sum(is.na(m)) # 830만개의 결측치 개수



## songs.csv

# genre_ids
library(mice)
library(VIM)


songs_imp = songs # 테스트를 위해 raw 데이터 복사.

songs_imp = as.data.frame(songs_imp) # 데이터 프레임으로 변환

songs_imp$genre_ids = ifelse(songs_imp$genre_ids == "", NA, songs_imp$genre_ids) # 공백은 결측 처리
sum(is.na(songs_imp$genre_ids)) # 결측치 개수 확인

songs_imp = songs_imp[,-c(1,2,6)] # song_id와 song_length 열 제거
names(songs_imp)

imp = mice(songs_imp, m=5, printFlag=FALSE, meth = "rf", maxit = 20, seed=1)
summary(imp)

comp.imp = complete(imp)
sum(is.na(comp.imp))

?methods
methods(mice)



ggplot(members, aes(registered_via)) +
  geom_bar()


ggplot(members, aes(registration_init_time)) +
  geom_density()



## 나이가 0, 성별이 빈칸, 도시가 1인 값들이 결측치임을 검증.

# 각 변수별 결측치 확인
sum(members$gender == "") # 19902
sum(members$city == 1) # 19445
sum(members$bd == 0) # 19932

# 각 변수별 결측치의 비율
sum(members$gender == "") / length(members$gender) * 100 # 57% 
sum(members$bd == 0) / length(members$bd) * 100 # 57%
sum(members$city == 1) / length(members$city) * 100 # 56%

# 동시에 결측이 발생하는 경우 확인.
new_members = members %>% 
    mutate(cga = if_else(((city == 1) & (bd == 0) & (gender == "")), 1, 0), # 세개 모두 결측인 경우.
           cg =  if_else(((city == 1) & (gender == "")), 1, 0), # 도시와 성별만 결측인 경우.
           ca = if_else(((city == 1) & (bd == 0)), 1, 0), # 도시와 나이만 결측인 경우.
           ga =  if_else(((bd == 0) & (gender == "")), 1, 0)) %>%  # 나이와 성별만 결측인 경우.
    summarize(city_gender_age = sum(cga), # 각 변수별 합산
              city_gender = sum(cg),
              city_age = sum(ca),
              gender_age =sum(ga))
new_members
# 세 개의 변수가 모두 결측인 경우: 18,356
# city, gender가 결측인 경우: 18,441
# city, age가 결측인 경우: 18,516
# gender, age가 결측인 경우: 19,481

# 세 개의 변수가 결측이 비슷하게 발생했다.
# 따라서 city가 1, age가 0, gender가 빈칸인 데이터들은 
# 해당 값이 의미가 있는 데이터들이 아니라 결측치임을 알 수 있다.

# 시각화
# vis_members = members
# vis_members = vis_members %>%
#   mutate(city_na = ifelse(city == 1, 1, 0),
#          age_na = ifelse(bd == 0, 1, 0),
#          gender_na = ifelse(gender == "", 1, 0))
# sum(vis_members$city_na)
# sum(vis_members$age_na)
# sum(vis_members$gender_na)

# 결측치 시각화
library(DataExplorer) # missing value 시각화를 위한 라이브러리
vis_members = members

# 결측치를 모두 NA 값으로 바꿈.
vis_members$gender = ifelse(vis_members$gender == "", NA, vis_members$gender)
vis_members$city = ifelse(vis_members$city == 1, NA, vis_members$city)
vis_members$bd = ifelse(vis_members$bd == 0, NA, vis_members$bd)
vis_members$bd = ifelse(vis_members$bd < 0, NA, vis_members$bd)
vis_members$bd = ifelse(vis_members$bd > 75, NA, vis_members$bd)

plot_missing(vis_members) +
  guides(fill=FALSE) +
  labs(x = "Variables") +
  ggtitle("Missing values in Members.csv") +
  theme(plot.title = element_text(size = 20, face = "bold", vjust=2))

?ggtitle

# count by city
ggplot(members, aes(city)) +
  geom_bar() +
  scale_x_continuous(breaks = seq(0, 25, by = 1)) +
  ggtitle("Count by city") +
  theme(plot.title = element_text(size = 16, face = "bold", vjust=2))

# count by gender
ggplot(members, aes(gender)) +
  geom_bar() +
  ggtitle("Count by gender") +
  theme(plot.title = element_text(size = 16, face = "bold", vjust=2))

#  count by age
ggplot(members, aes(bd)) +
  geom_bar() +
  xlim(-1,100) +
  ggtitle("Count by age") +
  xlab("age")
  theme(plot.title = element_text(size = 16, face = "bold", vjust=2))

  


## train 변수의 모든 NA를 제거하는 코드
  
# 테스트를 위해 train을 새로운 변수에 할당.
new_train = train

# 각 변수의 공백들을 모두 NA로 변환
new_train$source_system_tab = ifelse(new_train$source_system_tab == "", NA, new_train$source_system_tab)
new_train$source_screen_name = ifelse(new_train$source_screen_name == "", NA, new_train$source_screen_name)
new_train$source_type = ifelse(new_train$source_type == "", NA, new_train$source_type)
sum(is.na(new_train))  # 454,714

# train 변수의 모든 NA를 제거
new_train = drop_na(new_train)

nrow(new_train) # 6,961,652

a = nrow(train) - nrow(new_train)
a / nrow(train)
nrow(new_train) / nrow(train) * 100


sum(train$source_system_tab == "") /  nrow(train) * 100





table(songs$language)
ggplot(songs, aes(language)) +
  geom_bar()


a = sum(members$bd > 75) + sum(members$bd <= 0)
a / nrow(members) * 100 # 58%

sum(members$gender == "") / nrow(members) * 100 # 57.85%

sum(members$city == 1) / nrow(members) * 100 # 57%


table(songs$language)
ggplot(songs, aes(language)) +
  geom_bar()

sum(songs$language == -1) / nrow(songs)
sum(songs$language == -1)

sum(songs$language == -1)
table(songs$language)
sum(is.na(songs$language))

new_songs = songs



###### train과 test데이터 merge
?merge
names(train)
names(test)



# target == 1인 사람들만 다시 보기
# names(train)
# sum(train$target == 1) / nrow(train) * 100 # target == 1인 사람들은 약 50%
# train_target = filter(train, target == 1) # target == 1인 사람들만 변수에 할당
# nrow(train_target) # 검산
# 
# train_target %>% 
#   group_by(source_system_tab) %>% 
#   mutate(sum_song_id = n()) %>% 
#   ggplot(aes(x = source_system_tab, y = sum_song_id)) +
#   geom_bar(stat = "identity")
# 생각해보니까 맨 위에서 avg_target을 확인했기 때문에 이 그래프는 필요 없음.

str(songs_info)
names(songs_info)
songs_info$name %>% head()
nrow(songs_info)

sum(songs_info$song_id == "")
sum(songs_info$name == "")
sum(songs_info$isrc == "")

head(songs_info$song_id)
head(songs_info$name)
head(songs_info$isrc)

a= max(songs$song_length) / 1000
(a/60)/60




## Train에서 공백을 모두 Not Value로 변환 후, 
## 상위 0.1%에 해당하는 30명의 재생위치 확인해보기



# membership length
standard_time <- function(i){
  # i is numeric of form 20170101 => to 2017-01-01
  dd<-as.character(i)
  paste0(substr(dd, 1, 4), "-", 
         substr(dd, 5, 6), "-",
         substr(dd, 7, 8))
}

# from 2017-01-01 extract to 2017(year) OR 01(month)
members[, registration_year := as.integer(substr(
  standard_time(registration_init_time), 1, 4))]
members[, registration_month := as.integer(substr(
  standard_time(registration_init_time), 6,7))]
members[, expiration_year := as.integer(substr(
  standard_time(expiration_date), 1, 4))]
members[, expiration_month := as.integer(substr(
  standard_time(expiration_date), 6,7))]

members[, registration_init_time :=
             as.Date(standard_time(registration_init_time))]
members[, expiration_date :=
             as.Date(standard_time(expiration_date))]

members[, registration_init_time := julian(registration_init_time)]
members[, expiration_date := julian(expiration_date)]
members[, length_membership := 
             expiration_date - registration_init_time]

members$length_membership %>% head()
hist(members$length_membership)
sum(members$length_membership < 10)
sum(members$length_membership > 1000)

names(members)
a = train %>% select(msno, target)
b = members %>% select(msno, length_membership)

merged = merge(a, b, by = "msno")
names(merged)

merged = merged %>% 
  group_by(msno) %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  arrange(desc(mean_target))

merged_again = merge(merged, b, by = "msno")
merged_again %>% head()

names(merged_again)

ggplot(merged_again, aes(x = length_membership, y = mean_target))+
  geom_line(color='turquoise') +
  geom_smooth(color='turquoise') +
  xlim(0, 6000)




# 아티스트별 재청취율
names(train_with_not_value)
a = train_with_not_value %>% select(msno, song_id, target)
b = songs %>% select(song_id, artist_name)
merged = merge(a, b, by = "song_id")



target_vs_colcount(merged, 
                   "artist_name", 
                   "아티스별 청취 유저수", 
                   "재청취율", 
                   "아티스별 청취 유저수와 재청취율")
names(merged)
sum(is.na(merged$artist_name))

new_merged = merged %>% 
  group_by(artist_name) %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  group_by(count) %>% 
  summarize(new_count = n(), avg_target = mean(mean_target))

ggplot(new_merged, aes(new_count, avg_target)) +
  geom_line(color='turquoise') +
  geom_smooth(color='turquoise')

target_vs_colcount <- function(df, col_name, x, y, title)
{ 
  df %>% 
    group_by_(col_name) %>% 
    summarize(count = n(), mean_target = mean(target)) %>% 
    group_by(count) %>% 
    summarize(new_count = n(), avg_target = mean(mean_target)) %>% 
    rename(no_of_items = new_count, occurence = count) %>% 
    print %>% 
    arrange(desc(avg_target)) %>% 
    print %>% 
    ggplot(aes(occurence, avg_target)) +
    geom_line(color='turquoise') +
    geom_smooth(color='turquoise') +
    labs(x = x,
         y = y,
         title= title) +
    readable_labs
}












######################################################

