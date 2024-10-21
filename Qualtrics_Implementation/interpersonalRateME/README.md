# Interpersonal RateME Qualtrics Implementation



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

## Previous Steps

The stars used for the ratings come from contentful (). You first need to create a contentful account (it's free), and then add the next line of code in Look and Feel -> Header -> .


## 🚧 Under Development

The task has recently been developed, so it is still a work in progress. Report any bugs you find and if you need help for implementing it don't hesitate to contact me at lmarcos1@researchmar.cat.

## 🔗 Connect With Us

Embark on this exploratory journey into the landscape of moral and ethical evaluation. Stay tuned for updates, share your insights, and consider contributing to the `RateME-behavioral` project.

---
