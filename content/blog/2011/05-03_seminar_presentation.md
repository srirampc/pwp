---
title: Ph.D. Seminar Presentation
tags: [seminar, academic]
created_at: 2011-05-03
kind: article
excerpt: What I learned from my Ph.D seminar ?
disqus: true
---

Ph.D. Seminar is a mandatory 4-credit course required for getting
through the Ph.D qualifier. A grade of minimum 8 is required for
qualification. Title of my seminar is _Construction of Gene Networks
from Expression Profiles_. Seminar is mostly a literature review of
the topic. Structure learning had been of my interest for quite a
while, and I thought I would be wetting my feet with a review of Gene
networks construction. I discuss here mostly about the
preparation and soft-skills.

## Report Writing

The task of report writing is to make a summary of the papers read. I
read about 16 papers on the topic. I set myself a target of one week
to write a report. I even told my guide that I will send him the copy
of the report within a week. Having a hard deadline helps me focus. It
took 2 days longer.

For writing the report, I first started in the analog form. I wrote
the notes of each paper on a single sheet of paper - A4 sheets written
with a HB pencil, and pasted all the 16 sheets on the wall. When
writing in a single sheet, I was trying to answer 'What did I learn
from the paper that I can summarize in a single sheet ?'. I didn't
write the whole thing not without referring the report (though I
should have). Then, I moved around these sheets, changing the order,
until I got the order and the topics right. I found that this exercise
helped get the over-all picture. I think getting the big-picture is a
very important step in writing a decent report. It helps build a
narrative.

I used XeLaTeX to format the report. With XeLaTeX, one can use
open-type fonts. For serif text, I use, what I think is the most
readable typeface, the ['Minion Pro'][minion]. It is my favorite
type. Many science journals including 'Nature' use  Minion. For
sans-serif text, I use the ['Myriad Pro'][myriad] type. (Steve jobs
uses Myriad typeface in his keynote talks. Its Apple Inc.'s corporate
type). Both these fonts are  available, if you install Adobe Acrobat
Reader. (If I can, I would buy  the complete [Adobe Font
Folio][adobe-type] collection for 2600 USD)

LaTeX formatting for the report was inspired from
[uggedal's thesis][uggedal].
For figures in LaTeX, I used tikz. I initially thought, I
would use vector drawing software such as ink scape. But I
will find any excuse to do programming. I choose TikZ. TikZ, with its
clean interface, is flexible and much easier to draw than MetaPost (I
don't know anything about pstricks). Source code for my report and its
figures is [here][report-src] (Source added only to use it as an
example. No guarantee that it would even compile).

In hindsight, the problems I find in my report (and its making) are

1. Too elaborate introduction : Since my topic is biology, and I
   assumed a B.Tech CS student to be the representative of my audience
   (which normally the advice given M.Tech seminars), I had to write a
   whole chapter of 'Biochemistry 101'. It just increased the number
   of pages.
2. Too much time spend on formatting the report : As some one who
   would rather program than write, often my programmer
   devil sometimes emerged victorious against my writer
   angel. That lead to spending too much time figuring out how to
   write my latex macros, TikZ diagrams etc., and less than optimal
   time re-writing. I have to remember this : "All good writing is
   re-writing".
3. Elaborate explanations : In the end, I found the report too
   bloated. I gave to a friend to read and give me feedback, and she
   told me that the report is just too big. The difficulty with
   writing seminar report is the problem of telling Ramayana. They
   say, "You can tell the whole story of Ramayana for years and
   years. You can also tell Ramayana in the time one throws and
   catches a lemon (Lemon goes up - Rama shot. Lemon comes down -
   Ravana died. Did I spoil the ending for you ?)" The problem is
   striking a balance for the audience. I hope I get better with
   time.

## Seminar Preparation

I used Beamer to build my presentations. Since I had used TikZ to
write the report, it is easier to do simple animations with
Beamer. Simple animations are useful in building concepts. Instead of
starting with a complicated picture on a slide, one can build the
picture frame by frame - just adding parts of the complicated
picture each frame. Each part should be independent enough that they can
be explained separately, and each part has to be related only to those
parts already in the slide.

My presentation slides are [here][present-slides]. This is not the first
version. The first version was much longer and much bigger. When I
rehearsed the first time, it took 80 minutes! I am only allowed 20
minutes. I had to rehearse four times to get down to 20 minutes. I
recorded each presentation using the screen-cast software Camtasia. It
is a useful for catching the mistakes.

In hindsight, the problems I find in my preparation are:

1. Too big : It is big. I thought I could squeeze in every thing I
   wanted to say. One always over-estimates their ability - especially
   when one just starts learning. What I should have done is that I
   reduce what I have to say, rather than trying to squeeze more. The
   most important skill one needs is the guts to remove stuff. As
   Antoine de Saint Exupery said, " Perfection is achieved, not when
   there is nothing more to add, but when there is nothing left to
   take away."
2. Too much focus on the visuals: I spent quite a while on how the
   slide should look like and how each picture should assemble. I
   realize the time could have been useful in editing my content, and
   stream-lining it.
3. The voice : My voice has the monotonous frequency, which I think
   has a pretty good chance of tearing the examiner's ear drum upon
   the chance that it is natural frequency of the ear drum. I need to
   develop a rhetoric rhythm for my modulation - some sort of radio
   voice. Should I apply for a part-time acting course ?

## Seminar Presentation

What happened in the presentation is that my audience changed, and I
couldn't adapt myself. I prepared my presentation with an audience of
a B.Tech Computer Science student, but what I had was only my examiner
[Prof. Sunita Sarawagi][sarawagi]. I can't
blame anyone but myself. I knew she was going to be my examiner. Since
I wrote the report with a student audience in mind, I continued to
prepare my presentation so - being truthful to the report. She was
much more interested in the Machine Learning aspects of the problem (I
should have known, I am enrolled in her Machine Learning course).

Another trouble I had was that I was bogged down with a question I don't
know the answer. I managed with an improvised answer. But when I later
thought about it, I had a much better answer. I have to learn to
reduce this lead time of the thought process between Q and A.

Other than that, the presentation went fine (for some definition of
'fine').


[report-src]: /assets/src/seminar-report.zip
[present-slides]: /assets/docs/seminar-present.pdf
[sarawagi]: http://www.cse.iitb.ac.in/~sunita/
[uggedal]: http://bitbucket.org/uggedal/thesis/src/
[adobe-type]: http://www.adobe.com/products/fontfolio/
[minion]: http://en.wikipedia.org/wiki/Minion_%28typeface%29
[myriad]: http://en.wikipedia.org/wiki/Myriad_%28typeface%29
