library(tidyverse)
library(ggplot2)
library (mosaic)

# Problem 1
source('https://tinyurl.com/y4krd9uy') # simple_anova function

ggplot(load_summer, aes(x=temp, y=COAST)) +
  geom_point() + 
  facet_wrap(~weekday) +
  geom_smooth(method = 'lm',se=FALSE) +
  labs(title = "Peak Power Consumption in Gulf",
       x= " Temp. " ,
       y= "Power Consumption (MW)")

lmsummer = lm(COAST ~ temp+weekday+temp:weekday, data=load_summer)
coef(lmsummer) %>% round(0)

simple_anova(lmsummer)
boot_lmsummer = do(10000)*lm(COAST ~ temp+weekday+temp:weekday, data=resample(load_summer))
confint(boot_lmsummer) %>%
  mutate_if(is.numeric, round, digits=3)

# Problem 2
library(stringr)

# Part 1 
ggplot(apartments, aes(x= distance_from_tower, y= twobed_rent))+
  geom_point() +
  geom_smooth(method = 'lm',se=FALSE) +
  labs(title = "Price VS Distance ",
       x= " Distance from UT Tower " ,
       y= "Cost of Monthly Rent")


lmapt = lm(twobed_rent ~ distance_from_tower, data=apartments)
coef(lmapt)
lmaptrent = do(10000)* lm(twobed_rent ~ distance_from_tower, data=resample(apartments))
confint(lmaptrent) %>%
  mutate_if(is.numeric, round, digits=3)

#Adjusted 
lmadj = lm(twobed_rent ~ distance_from_tower + twobed_sf + furnished + laundry_in_unit
         + electricity+ water + pool, data=apartments)
coef(lmadj) 
lmadjapts = do(10000)* lm(twobed_rent ~ distance_from_tower + twobed_sf + furnished 
                        + laundry_in_unit + electricity 
                        + water + pool, data=resample(apartments))
confint(na.omit(lmadjapts)) %>%
  mutate_if(is.numeric, round, digits=3)

# Part 2
ggplot(apartments, aes(x= twobed_sf, y= twobed_rent))+
  geom_point() +
  geom_smooth(method = 'lm',se=FALSE) +
  labs(title = "Rent incr. w/ add. sq ft.",
       x= " Size of Bedroom in sq ft. ",
       y= "Monthly Rent Cost ")


lm4 = lm(twobed_rent ~ twobed_sf, data=apartments)
coef(lm4) 
lm4apts = do(10000)* lm(twobed_rent ~ twobed_sf, data=resample(apartments))
confint(lm4apts) %>%
  mutate_if(is.numeric, round, digits=3)

#Adjusted
lm5 = lm(twobed_rent ~ twobed_sf + distance_from_tower  + furnished + laundry_in_unit
         + electricity+ water + pool, data = apartments)
coef(lm5) 
lm5apts = do(10000)* lm(twobed_rent ~ twobed_sf + distance_from_tower  + furnished + laundry_in_unit
                        + electricity+ water + pool, data=resample(apartments))
confint(na.omit(lm5apts)) %>%
  mutate_if(is.numeric, round, digits=3)


# Problem 3 
source('https://tinyurl.com/y4krd9uy') # simple_anova function

ggplot(redline, aes(x= minority, y= policies))+
  geom_point() +
  geom_smooth(method = 'lm',se=FALSE) +
  labs(title = "FAIR Policies vs Minorities",
       x= " Minority residents in % " ,
       y= "# of FAIR policies")


lm6 = lm(policies ~ minority +fire +age +income, data=redline)
coef(lm6) 
simple_anova(lm6)
boot_policy= do(10000)*lm(policies ~ minority +fire +age +income, data=resample(redline))
confint(boot_policy) %>%
  mutate_if(is.numeric, round, digits=3)



