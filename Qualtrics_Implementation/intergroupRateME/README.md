# Qualtrics Implementation of Intergroup RateME

Here you will find the Qualtrics Implementation of the **Intergroup RateME** task. There are two ways of taking the code to Qualtrics: by importing the QSF file and directly copying the code from the repository. Then, minor edits are required to adapt the task to your experimental settings. Please remind that there are previous configuration steps that you need to do so the code works properly. These stepes are detailed [here](../).

## Implementation using QSF file (fast)

You can implement the code by copying the qsf file found in this directory. Then, you will need to edit the intergroup setting, namely, the questions to be rated, the name of the groups, the images of the groups, and the names of the (fictitious) players. These edits should be performed in the html and the javascript (js) files.

### Outgroups Questions editing

The first questions that need to be edited are the ones where the participant rates the outgroups (Q1, ... , Q6). To do it, click on the question text and go to HTML View. There are multiple elements that can be edited here:

1. The **question** to be rated. To edit it, go to the line `<p class="question main-text">` and chage the text right after it. Please be sure that the line ends with `</p>`.
2. The **names of the outgroups**. To edit them look for the lines with `<p class="name">Belgium</p>` and substitute the name of the countries with the groups you are using (not the participant's group).
3. The **images of the outgroups**. For this you need to copy the path to the images in your Qualtrics library and paste it after "src=" in `<img src="https://youraccount.eu.qualtrics.com/ControlPanel/Graphic.php?IM=outgroup2" alt="Belgium" class="flag">`. Note that you need to keep the link between the double quotes. Additionally, you need to change the text in "alt=" to the name of the group.

No edits in the js files are needed here.

### Rating Tables editing

The edits in the rating table screens are very similar to the ones in outgroup questions, with the exception that here the names are of players of the groups instead of of the grups themselves and that the participant's group and name has to be included too.

1. The **question** to be rated. To edit it, go to the line `<p class="main-text">Would you like to visit this country?</p>` and chage the text between > and <.
2. The **names of the players**. To edit them look for the lines with `<p class="name">Emma</p>` and change the name of the player. Be careful not to introduce any name in `<p id="playerName" class="name"></p>`, because this is the player name and should be obtained from the "Name" question of the previous block.
3. The **images of the groups**. For this you need to copy the path to the images in your Qualtrics library and paste it after "src=" in `<img src="https://youraccount.eu.qualtrics.com/ControlPanel/Graphic.php?IM=outgroup2" alt="Belgium" class="flag">`. Note that you need to keep the link between the double quotes. Additionally, you need to change the text in "alt=" to the name of the group. Here the image of the player's group should be changed too.

In these questions the js code needs edits too. For that, click on the `</>` button of the question and change:



## Implementation using the code (slow)

In interpersonal RateME the ratings are about a minimium set of (personal) features of each player. We used age, preferred music style, hobbies, and preferred vacation plan but they can be changed. So the first thing tha participant has to do is fill his/her profile so he/she believes is being rated. Then, they will see each other player's profile and rate them in six different questions. Finally, they will be in a "table" with 5 other players and they will be able to see how all of them rate each question about the rest. The interpersonal RateME task has demonstrated to produce similar effects to the Cyberball task in terms of inducing exclusion wiht the contents that can be found in this repository, so it is a ready to use tool without the need of any changes.


## Previous Steps

The stars used for the ratings come from contentful (). You first need to create a contentful account (it's free), and then add the next line of code in Look and Feel -> Header -> .



## 🚧 Under Development

The task has recently been developed, so it is still a work in progress. Report any bugs you find and if you need help for implementing it don't hesitate to contact me at lmarcos1@researchmar.cat.

## 🔗 Connect With Us

Embark on this exploratory journey into the landscape of moral and ethical evaluation. Stay tuned for updates, share your insights, and consider contributing to the `RateME-behavioral` project.

---
