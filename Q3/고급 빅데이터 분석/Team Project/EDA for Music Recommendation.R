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
target_vs_column(train, col_name = "source_system_tab",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_system_tab vs Target')

# 해당 곡이 my library에서 재생되었다면, 한 달 이내에 다시 재생될 확률이 radio보다 높다.
# 이는 상식적으로 생각해보면 당연한 결과이다.
# 어떤 노래가 my library에 담겨 있다면, 사용자가 좋아하는 노래일 가능성이 높다.
# 하지만, radio에서 재생된 곡들은 사용자의 호감과는 상관 없이 일방적으로 선별된 노래만을 듣는 것이기 때문에 my library에 있는 곡들에 대한 재청취율이 높은 것이다.
# discover는 재생 자체는 많이 됐는데 재청취율은 낮았다는 뜻인 것 같다.


## Source_screen_name
# source_screen_name에 따라 재청취율이 어떻게 달라지는지 시각화.
target_vs_column(train, col_name = "source_screen_name",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_screen_name vs Target')

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


## Source_type
# source_type에 따라 재청취율이 어떻게 달라지는지 시각화
target_vs_column(train, col_name = "source_type",
                 x = 'Frequency',
                 y = 'Target',
                 title = 'Count of source_type vs Target')

# local library보다 local playlist에서의 재청취율이 조금 더 높았다.
# 재생 횟수 자체는 local library가 훨씬 많았다.
# 
# Q. local library와 local playlist의 차이점은 뭘까?
# 
# Q. 피피티 만들 때는 그래프를 내림차순 정렬할 필요가 있어 보인다.
# Q. y축에서 빈칸은 NA값을 의미하는 건가?


## Song count vs Target
target_vs_colcount(train, "song_id", "Song Occurence", "Target", "Song Occurence vs Target")

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
a
cor(a$count, a$avg_target)



## User count vs Target
target_vs_colcount(train, "msno", "User Occurence", "Target", "User Occurence vs Target")
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
for_test = train %>% 
  group_by_("msno") %>% 
  summarize(count = n(), mean_target = mean(target)) %>% 
  group_by(count) %>% 
  summarize(new_count = n(), avg_target = mean(mean_target)) %>% 
  arrange(desc(count))
print(for_test, n=80) # 78개부터 빈도가 2,000을 넘음.

# 등장빈도가 2,000넘는 유저의 아이디를 찾아보았다.
top_2000 = sort(table(train[,'msno']), decreasing=TRUE)[1:78]
top_2000 = as.data.frame(top_2000)

# 열 이름 변경
names(top_2000)[1] = "msno"
names(top_2000)[2] = "Freq"
names(top_2000)

# top_2000에서 msno만 담기
msno_2000 = top_2000[,1]
# msno_2000 = as.character(msno_2000)
# msno_2000

# 여기까지 하고 포기.


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
  labs(y="Frequency", title="Registration and Expiration Distribution")+
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
  labs(x='Song Length', y = 'Frequency', title = 'Distribution of song length') +
  xlim(0, 15)

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

ggplot(discover, aes(discover$source_screen_name)) +
  geom_bar() +
  coord_flip()





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


