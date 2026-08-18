# Qualtrics Implementation of Intergroup RateME

Here you will find the Qualtrics implementation of the **Intergroup RateME** task. There are two ways of taking the code to Qualtrics: by importing the QSF file or by directly copying the code from the repository. In both cases, minor edits are required to adapt the task to your experimental settings. Please note that there are previous configuration steps that you need to complete for the code to work properly. These steps are detailed [here](../).

## Implementation using QSF file (fast)

You can implement the code by importing the QSF file found in this directory. Then, you will need to edit the intergroup setting, namely, the questions to be rated, the name of the groups, the images of the groups, and the names of the (fictitious) players. These edits should be performed in the HTML and JavaScript (JS) files.

### Outgroups Questions editing

The first questions that need to be edited are the ones where the participant rates the outgroups (Q1, ..., Q6). To do so, click on the question text and go to **HTML View**. There are multiple elements that can be edited here:

1. The **question** to be rated. To edit it, go to the line `<p class="question main-text">` and change the text right after it. Please be sure that the line ends with `</p>`.

2. The **names of the outgroups**. To edit them, look for the lines with `<p class="name">Belgium</p>` and substitute the country names with the groups you are using (not the participant's group).

3. The **images of the outgroups**. Copy the path to the images in your Qualtrics library and paste it after `src=` in the corresponding `<img>` element, for example:
   `<img src="https://youraccount.eu.qualtrics.com/ControlPanel/Graphic.php?IM=outgroup2" alt="Belgium" class="flag">`.

   Keep the image URL between the double quotes. Additionally, change the text in `alt=` to the name of the corresponding group.

No edits in the JS files are needed for the outgroup questions.

### Rating Tables editing

The edits in the rating table screens are very similar to those in the outgroup questions, with the exception that the names are those of players belonging to the different groups. The participant's own group and player also need to be included.

1. The **question** to be rated. To edit it, go to the line `<p class="main-text">Would you like to visit this country?</p>` and change the text between `>` and `<`.

2. The **names of the players**. To edit them, look for lines such as `<p class="name">Emma</p>` and change the player name. **Do not enter a name in `<p id="playerName" class="name"></p>`**, because this element is populated dynamically with the participant's player name obtained from the `Name` question in the previous block.

3. The **images of the groups**. Copy the path to the images in your Qualtrics library and paste it after `src=` in the corresponding `<img>` element, for example:
   `<img src="https://youraccount.eu.qualtrics.com/ControlPanel/Graphic.php?IM=outgroup2" alt="Belgium" class="flag">`.

   Keep the image URL between the double quotes and change the text in `alt=` to the name of the corresponding group. The image corresponding to the participant's own group must also be changed.

In these questions, the JS code needs to be edited as well. Click on the `</>` button of the question and modify the configuration variables indicated in the code. These variables determine the information associated with the players/groups and the way the rating table is initialized. Keep the rest of the code unchanged unless you need to modify the task's functionality.

## Implementation using the code (slow)

Instead of importing the QSF file, you can implement the experiment manually by copying the HTML and JavaScript code from the repository into Qualtrics. This approach requires more steps because the QSF file normally creates and configures all the required Qualtrics questions automatically.

In the code-based implementation, **Q1–Q6 are not created automatically**. Each of the six outgroup-rating questions must therefore be created manually as an independent Qualtrics question. The same applies to the rating-table screens: instead of editing the questions already included in the QSF file, you need to create the corresponding Qualtrics questions and insert the provided templates.

### General structure

The experiment should contain the same logical blocks as the QSF implementation. The main difference is that, when working directly with the code, you need to create the Qualtrics elements yourself.

For each screen, create the corresponding Qualtrics question and then copy the contents of the appropriate template into it. The two types of screens use different templates:

* **Outgroup-rating questions:** `ratingOutgroupsTemplate.html` and `ratingOutgroupsTemplate.js`
* **Rating tables:** `tableTemplate.html` and `tableTemplate.js`

The templates provide the HTML structure and JavaScript functionality required by the task. Do not mix the templates between question types.

### Outgroups Questions

There are six outgroup-rating questions in the experiment: **Q1, Q2, Q3, Q4, Q5, and Q6**.

Unlike in the QSF implementation, these six questions are **not instantiated automatically**. You must create six independent Qualtrics questions.

For each question:

1. Create a new Qualtrics question in the appropriate position in the survey flow.

2. Use a question type that allows you to insert custom HTML and JavaScript. The question must be configured so that the custom code can be executed by Qualtrics.

3. Open the question's **HTML View**.

4. Copy the complete contents of `ratingOutgroupsTemplate.html` from the repository and paste them into the question's HTML.

5. Edit the HTML to specify the content for that particular question:

   * Change the **question text** in `<p class="question main-text">`.
   * Change the **names of the outgroups** in the corresponding `<p class="name">...</p>` elements.
   * Replace the **image URLs** with the images stored in your Qualtrics library.
   * Update the `alt` attributes so that they contain the corresponding group names.

6. Open the question's **JavaScript editor** by clicking the `</>` button.

7. Copy the complete contents of `ratingOutgroupsTemplate.js` into the JavaScript editor.

8. Repeat this process for **Q1 through Q6**, creating six independent Qualtrics elements.

Each question should therefore contain its own copy of the HTML and JS code. Changes made to one question do not automatically propagate to the other five, so make sure that the configuration of all six questions matches your experimental design.

The six questions should be placed in the same order as in the QSF implementation unless your experimental design requires a different order.

### Rating Tables

The rating-table screens must also be created manually when implementing the task using the code.

For each rating-table screen:

1. Create a new Qualtrics question at the appropriate position in the survey flow.

2. Open the question's **HTML View**.

3. Copy the complete contents of `tableTemplate.html` from the repository and paste them into the question.

4. Edit the HTML to match your experimental design:

   * Change the **question text** in the `<p class="main-text">...</p>` element.
   * Change the **names of the fictitious players** in the corresponding `<p class="name">...</p>` elements.
   * Do **not** manually enter a name in `<p id="playerName" class="name"></p>`. This element is populated dynamically using the participant's name obtained from the previous `Name` question.
   * Replace the **group images** with the corresponding images from your Qualtrics library.
   * Update the `alt` attributes to contain the corresponding group names.
   * Make sure that the image representing the participant's own group is also replaced.

5. Open the question's **JavaScript editor** by clicking the `</>` button.

6. Copy the complete contents of `tableTemplate.js` into the JavaScript editor.

7. Modify the configuration values in the JS code that are specific to your experiment. In particular, make sure that the information used to identify the groups, players, and participant-specific information corresponds to the questions and Embedded Data variables used in your survey.

8. Repeat these steps for every rating-table screen required by the experiment.

### Important differences from the QSF implementation

When implementing the experiment from the code rather than from the QSF file, keep the following differences in mind:

| QSF implementation                              | Code implementation                                             |
| ----------------------------------------------- | --------------------------------------------------------------- |
| Q1–Q6 are already created in the QSF            | Q1–Q6 must be created manually                                  |
| The HTML is already inserted into each question | Copy `ratingOutgroupsTemplate.html` into each question          |
| The JS is already inserted into each question   | Copy `ratingOutgroupsTemplate.js` into each question            |
| Rating-table questions are already created      | Create each rating-table question manually                      |
| Rating-table HTML is already inserted           | Copy `tableTemplate.html` into each rating-table question       |
| Rating-table JS is already inserted             | Copy `tableTemplate.js` into each rating-table question         |
| Question structure is configured automatically  | Question type, order, and placement must be configured manually |

### Recommended implementation procedure

To minimize errors, implement the survey in the following order:

1. Complete the general Qualtrics configuration described [here](../).
2. Create the questions that provide the participant's group and name, as required by the task.
3. Create the six independent outgroup-rating questions (Q1–Q6).
4. Insert `ratingOutgroupsTemplate.html` and `ratingOutgroupsTemplate.js` into each of these six questions.
5. Configure the question text, group names, and group images for each question.
6. Create the required rating-table questions.
7. Insert `tableTemplate.html` and `tableTemplate.js` into each rating-table question.
8. Configure the player names, group images, question text, and experiment-specific JavaScript variables.
9. Check that the dynamic participant information, particularly the participant's name and group, is correctly retrieved from the preceding questions.

The code-based implementation should produce the same task structure and behavior as the QSF implementation. The main difference is that the QSF file automates the creation of the Qualtrics questions, whereas the code-based implementation requires the experimenter to create and configure each Qualtrics element manually.


## 🚧 Under Development

The task has recently been developed, so it is still a work in progress. Report any bugs you find and if you need help for implementing it don't hesitate to contact me at lmarcos1@researchmar.cat.

---
