--- 
title: "MSKCC Biostatistics Course"
date: "Last Updated: March 17, 2025"
site: bookdown::bookdown_site
output:
  bookdown::gitbook:
    config:
      sharing:
        facebook: false
        twitter: false
documentclass: book
rmd_files: ["index.Rmd", "01-week1.Rmd", "02-week2.Rmd", "03-week3.Rmd", "04-week4.Rmd", "05-week5.Rmd", "06-week6.Rmd", "07-week7.Rmd", "08-week8.Rmd", "09-answers.Rmd", "10-exam.Rmd"]
bibliography: [packages.bib]
biblio-style: apalike
link-citations: yes
description: "Statistics Course"
always_allow_html: true
---



# General Course Materials {-}

## Course Outline {-}

Course Schedule for CRMC Biostatistics Seminar
Course Leader: Andrew Vickers

All classes are on Wednesday evenings from **05:30pm - 07:00pm**.<br>
5:30 - 6:10: Dr. Vickers will go over the R assignments.<br>
6:10 - 7:00: Open office hours

The course website is https://emilyvertosick.github.io/Statistics-Course/  

Reading is from "What is a p-value anyway?" unless otherwise stated.
Readings below are to be done **before** the class.
R assignments are done **after** the class.

-----------------------------------------------------
Date / Location     Topic and Assignments
---------------     ---------------------------------
**1/15/2025**\       **Class I:** What is statistics?\
**RRL-101**\         **Reading:** "How To Read This Book", Chapter 1\
                    **Assignment:** Questions 1 and 4

**1/22/2025**\      **Class II:** Describing Data\
**RRL-101**\        **Reading:** Chapters 2-6 and chapter 20\
                    **Assignment:** All questions for chapters 2, 3, 4 and 6; questions 1 and 3 for chapter 5; question 1 for chapter 20
                    
**1/29/2025**\      **Class III:** Data Distributions\
**RRL-101**\        **Reading:** Chapters 7-9\
                    **Assignment:** Chapter 7, question 2; chapter 8, question 1; chapter 9, questions 1 and 3
                    
**2/5/2025**\       **Class IV:** Confidence Intervals\
**RRL-101**\        **Reading:** Chapters 10-12\
                    **Assignment:** All questions for chapters 10 and 11; question 1 in chapter 12\
                    **Extra for those doing R assignment:** [Statistics Notes: Diagnostic tests 3: receiver operating characteristic plots](https://www.bmj.com/content/309/6948/188.full)
                    
**2/12/2025**\       **Class V:** Hypothesis Testing\
**RRL-101**\        **Reading:** Chapters 13-17\
                    **Assignment:** Chapters 13, 15 and 16, all questions; chapter 14, question 1; chapter 17, questions 1-3
                    
**2/19/2025**\      **Class VI:** Regression\
**RRL-101**\            **Reading:** Chapters 18-19\
                    **Assignment:** Chapter 18, questions 1-4; chapter 19, questions 1-2
                    
**2/26/2025**\       **Class VII:** Survival Data\
**RRL-101**\            **Reading:** Chapters 21-24 and chapter 28\
                    **Assignments:** Chapter 21, question 1; chapter 23, question 1; chapter 24, questions 1, 2 and 4
                    
**3/5/2025**\       **Class VIII:** Errors in Statistics (all class meets)\
**RRL-101**\            **Reading:** Chapters 30-34\
                    **Optional extra reading:**
                    [The scandal of poor medical research](https://www.bmj.com/content/308/6924/283.full), 
                    [Math as Mass Hypnosis: On Mortgage-Backed Securities, Maritime Warfare, and Medical Research](https://www.medscape.com/viewarticle/714772)\
                    **Assignments:** All questions for chapters 30 and 33
                    
**3/12/2025**\      Make-up day, if needed

-----------------------------------------------------

## Andrew's Contact Details {-}

If you are stuck, feel free to get in contact seven days a week, 7am – 10pm. 

Call me on my cell phone 347 244 6934 

If it is non-urgent, email me on vickersa@mskcc.org

Some typical problems and what to do about them:

1. _I can't access R / RStudio / the website isn't working._ Contact the help desk!
2. _I want to do a regression but can't work out the right R command._ Contact me by phone.
3. _I don't know whether to do a regression or a correlation._ Pick one or the other and raise this as a question in class.
4. _I don't understand the R output._ Call me if you are totally in the dark; otherwise do your best and raise this as a question in class.
5. _I was going to do the assignment, but my dog got ill and I had laptop problems and can I do the assignment for Tuesday instead?_ Yawn.
6. _I don't understand the question._ Call me.
7. _I am not sure I understand the difference between a regression and a correlation._ Raise this in class.

## Passing the Course {-}

You can only get "credit" for this course if you pass. I am occasionally asked to write a letter for a former student stating that they "took part in the MSKCC biostatistics course". Now because I don't take register or have a sign-up sheet, I can't possibly know who took part and who didn't. So I only write letters saying that a former student passed.

To pass, you have to meet three conditions:

1. Be officially signed up
2. Pass the exam
3. Answer the feedback

**About the exam**

The exam is given at the end of the course. It is posted on the course website and is an "open book" exam: you do this in your own time and send me your answers. Some notes and thoughts about the exam:

1. There are only a few questions. It shouldn't take longer than a couple of hours to do and I give you two weeks to complete it.
2. The questions I give are far easier than the typical statistical problems you are likely to encounter in the course of a research career. 
3. I mark very liberally, and have a low pass mark (50%).
4. Anyone who fails the exam is given an opportunity to resubmit.

**Working groups**

I am perfectly happy for you to work in small groups as long as:

1. You are clear and explicit about this up front
2. All members of a group contribute equally
3. You don’t take advantage

Note that we have had problems with plagiarism before. It is absolutely straightforward for me to detect this using simple software. 

## Data Checking Procedures {-}

**Checklist for checking papers: Urology Biostatistics**

This process should be performed when both the statistician and primary contact are satisfied with the paper, and before the paper is reviewed at the biostatistics workshop.

1) Check every number in the text and in every table against software printout from running R code files.

2) Check every figure (e.g. graph) against software printout from running R code files.

3) Where appropriate (e.g. for key analyses or for any paper with a large impact on clinical practice), run analyses by hand by creating additional R code files titled “check analyses [descriptor].R”. In particular, re-calculate time variables for survival analysis.

4) Check each number in manuscript against checked tables, figures, or software printout.

5) Read through statistical methods section for accuracy and completeness.
    a. Is every analysis stated clearly?  
    b. If the analysis is not straight forward, is the rationale behind the analysis clearly stated?
    c. Is survival time data (when clock starts, when clock ends, what is the event, rules for censoring [e.g. for cancer-specific survival]) described clearly?

6) Read through entire paper.
    a. Are all of the statements in the results section backed up?
    b. Is the conclusion reasonable?

7) Check abstract (methods, numbers, conclusion) against paper.

## Guidelines for presentation of statistics {-}

Please review these guidelines on the course website.

[Guidelines for Reporting of Statistics for Clinical Research in Urology](https://github.com/emilyvertosick/Statistics-Course/blob/master/Guidelines%20for%20Reporting%20of%20Statistics%20for%20Clinical%20Research%20in%20Urology.pdf?raw=true)

[Guidelines for Reporting of Figures and Tables for Clinical Research in Urology](https://github.com/emilyvertosick/Statistics-Course/blob/master/Guidelines%20for%20Reporting%20of%20Figures%20and%20Tables.pdf?raw=true)

[Guidelines for Reporting Observational Research in Urology: The Importance of Clear Reference to Causality](https://github.com/emilyvertosick/Statistics-Course/blob/master/Guidelines%20for%20Reporting%20Observational%20Research%20in%20Urology.pdf?raw=true)
