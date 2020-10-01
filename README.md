## Monty Hall Game Show (Let's Make a Deal) or Monty Hall Problem 

Monty hall is a well-known game show. Although the rules of the show is pretty simple and easy to learn but the probability puzzle behind it has always bewildred me. The main point of confusion for me was my brain could accept what statistics was suggesting. In another way my brain was confidently and systematically lies to me and makes me believe something which is not true. That is why I decided to write this simple application in R (using R and Javascript) to help me understand my point of failures. I will explain the game and the mathematics and please pause after the game section and ask yourself what you think is true before going forward with the mathematical part and trying out the game.


#### Monty Hall Game

The rules of the games are simple. Suppose you are given the choice of three doors in front of you. Behind one door is a car; behind the other two doors are goats. The game starts by you picking a door (say door 1). The host, who know what is behind each door, will open anothe door which has a goat (say door 3). Then, you will have two options to 

a.  either stay with your initial choice
b.  change your mind and pick door 2

Alright, now let's pause here, will you do that? Or more generally, does switching your choice would change your chance of success?... 
Whatever you responded above, you are not alone! This has been a controversial discussion in statisitics community for a long time. For more information about the game and discussions, please feel free to check out the [Wiki page](https://en.wikipedia.org/wiki/Monty_Hall_problem). I will apply Bayes theorem to get the posterior probability for both doors 1 and 2 after seeing door 3 is a goat.   

#### Probability of success

Let X indicate the door picked initially by you, Y indicate the door that has car behind it, and Z is the door opened by the host. So X=1 means that that you chose door 1 and Y = 1 means that door 1 has car behind it. Now lets calculate the posterior probabilites for both doors 1 and 2 condition on the user select door1 and host opened door 3 with the goat:

$P(Y = 1 | X = 1, Z = 3) = P(Z = 3| X = 1, Y = 1)*P(Y = 1| X = 1)*P(X = 1) / (P(Z = 3 | X = 1)*P(X = 1))$

We can remove P(X = 1) from both nominator and denominator:
$P(Y = 1 | X = 1, Z = 3) = P(Z = 3| X = 1, Y = 1)*P(Y = 1| X = 1) / P(Z = 3 | X = 1)$

P(Z = 3| X = 1, Y = 1) is 1/2 as if you select the door with the car, host had two door options to open. P(Y = 1| X = 1) = 1/3 as your choice does not change the probability of the car in that door, unless you have some sort of telepathy!

Now let's calcualte P(Z = 3 | X = 1)

$P(Z = 3 | X = 1) = P(Z = 3 |X = 1, Y = 1)*P(Y = 1) + P(Z = 3 |X = 1, Y = 2)*P(Y = 2) + P(Z = 3 |X = 1, Y= 3)*P(Y= 3)$

$P(Z = 3 | X = 1) = 1/2 * 1/3 + 1 * 1/3 + 0 * 1/3 = 1/2$

Mapping the values into the equation for $P(Y = 1 | X = 1, Z = 3)$

$P(Y = 1 | X = 1, Z = 3) = (1/2 * 1/3)/(1/2) = 1/3$

So staying with your choice after seeing the door will not increase your chance of winning. By changing the door, you can increase your probability of success to 2/3!!

$P(Y = 2|X = 1, Z = 3) = 1 - P(Y = 1|X = 1, Z = 3) = 2/3$

#### Try it your self

Long story short, if you stay stubborn and not change your door, you would still have 1/3 chance of winning. But if you change the door, your chance of winning will increase to 2/3. Does your brain still struggles to accept this. Please try it yourself. I created a shiny app that you can play as much as you can. As the current free shiny servers are only let one concurrent users, you might not be able to stay on the game for a long time, Please feel free to clone this repository and run it on your computer if your rather.
