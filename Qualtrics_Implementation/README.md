# Qualtrics Implementation

Here you will find the Qualtrics Implementation of the RateME task in both **Interpersonal** and **Intergroup** versions. The code is written in html, css and javascript, which are common web developing languages. Although minor code edits are required to adapt the task to different experimental settings, we provide a detailed explanation of how this code works.

## Design Overview

As detailed before, inside each experiment directory you will find three subdirectories, html, css and js (javascript). Here is a brief description of each of the languages within this project:

- HTML (Hypertext Markup Language): HTML is the backbone of web pages. It uses tags to structure content, such as headings, paragraphs, lists, links, images, and more. These tags provide the framework for organizing information and are essential for creating a structured layout that web browsers can interpret and display to users. We used html files for structuring the elements that will be presented to the participant in each of the questions. 

- CSS (Cascading Style Sheets): CSS is used to style the appearance of HTML elements on web pages. It allows developers to control the layout, colors, fonts, spacing, and other visual aspects of a webpage. In this project we introduced the css content directly into Qualtrics Look and Feel -> Style -> Custom CSS. For basic modifications of the RateME task, CSS code does not need to be modified. 

- JavaScript: JavaScript is a scripting language that enables interactive and dynamic behavior on web pages. It runs in the browser and allows developers to manipulate HTML and CSS, handle user interactions, and create responsive and interactive features. We use it to display dynamic and responsive elements, such as filling the stars when clicking on them. Also, it is used to save embedded data that can be used in other questions.

It is important to note that in Qualtrics, each question has html content and javascript functioning. Meanwhile, CSS is added in the Look and Feel section for ALL questions.


## Interpersonal and Intergroup RateME

You will find the code for the two different versions of RateME: interpersonal and intergroup. Both of them aim to induce feelings of exclusion in participants by ratings from other (fictiotious) players. The difference between both tasks is that while in the interpersonal RateME the characteristics that other players rate are directly related to the participant (e.g. do you think this person is nice?), in the intergroup RateME the ratings are about a group of the participant (e.g. "would you like to live in this country?" for the participant's country). Besides, in the intergroup version other players are represented by other groups (hence the intergroup setting). Both tasks are organized in the same manner with small differences. Participants first rate the other players/groups and then they can see the ratings of all players, where they can be either included (all players/groups get the same rates) or excluded (all players/groups get greater scores than the participant/'s). The different steps between the two tasks are detailed below.

### Interpersonal RateME

In interpersonal RateME the ratings are about a minimium set of (personal) features of each player. We used age, preferred music style, hobbies, and preferred vacation plan but they can be changed. So the first thing tha participant has to do is fill his/her profile so he/she believes is being rated. Then, they will see each other player's profile and rate them in six different questions. Finally, they will be in a "table" with 5 other players and they will be able to see how all of them rate each question about the rest. The interpersonal RateME task has demonstrated to produce similar effects to the Cyberball task in terms of inducing exclusion wiht the contents that can be found in this repository, so it is a ready to use tool without the need of any changes.

### Intergroup RateME

In intergroup RateME the ratings are performed by prejudices, that is, no explicit information about the other groups is provided. So in this case the participants will directly rate other groups. However, in this task they will see each question and rate all groupss about it (in contrast to rate all questions about each participant). In the "table" they will be with 5 other players of different groups and they will be able to see how all of them rate each queation about the rest of the groups. The intergroup RateME task is a flexible tool that can be applied to multiple intergroup settings. In the example here groups are different countries from the EU, and the participant is from UK. The groups are represented by flags and in the "table" the other players are supposed to be residents in the external countries.


## How to implement: Previous steps

The ratings are presented with stars. The star icons used are from fontawesome (https://fontawesome.com/). You first need to create a contentful account (it's free), and then create a kit that has the "solid" and "regular" styles of the star icon.Once the kit is created, click on the set up tag and copy the code line. The line code should look like this but with the name of the kit in ########.

<script src="https://kit.fontawesome.com/########.js" crossorigin="anonymous"></script>.

Go to Qualtrics and paste the code line in Look and Feel -> General -> Header.

## How to implement: General instructions

The code in each language is implemented in different ways:

- HTML: Each question is in a different file of this repository, so the next instructions apply to one question/file. On a Qualtrics block, click on "Add new question" button, and select the "Text/Graphic" type of question. Then click on the question content and then on "HTML View" (at the top-right of the content window). Finally, copy the code in the file of this repository (e.g. avatarSelection.html) to the content window in HTML View.

- JavaScript: As in HTML, each question has its own JavaScript code. In fact, most of the .html files have a .js counterpart. To implement the js code, go to a question after adding the HTML. Then, on Question Behavior click on JavaScript and a window will pop up. Finally, copy the whole content of the .js file in this repository into this window (substitute whatever is inside with the content of the .js file). 

- CSS: There is a single CSS code per experiment, so you only have to copy it once. For that, go to Look and Feel in the left icon bar of Qualtrics. Then click on Look and Feel and finally in Custom CSS. Copy the CSS file content here and there is no need to modify it. 

There are two ways to implement this codes. The fastest is to import de **qsf** files that are stored in each task directory. Then, minor modifications are required in the code as it is detailed in the instructions. The slowest is to create questions and copy the code into each of them from this repository.

## 🚧 Under Development

The task has recently been developed, so it is still a work in progress. Report any bugs you find and if you need help for implementing it don't hesitate to contact me at lmarcos1@researchmar.cat.

---
