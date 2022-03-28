PEW RESEARCH CENTER
Wave 85 American Trends Panel 
Dates: March 8-March 14, 2021
Mode: Web 
Sample: Full panel
Language: English and Spanish
N=12,045

***************************************************************************************************************************
NOTES

The W85 dataset contains a computed variable called KNOWSUM_W85 that contains the number of correct answers to questions KNOVACC1-KNOWCLIMATE. The maximum number of correct answers is 5. SPSS syntax is included below. 

The W85 dataset contains coded open-end responses for MAINSORCE_OE_W85. Those coded open-end responses are contained in the MAINSOURCE_OE_CODED_W85 variable.

For a small number of respondents with high risk of identification, certain values have been randomly swapped with those of lower risk cases with similar characteristics.

***************************************************************************************************************************
WEIGHTS 


WEIGHT_W85 is the weight for the sample. Data for all Pew Research Center reports are analyzed using this weight.


***************************************************************************************************************************
Releases from this survey:

March 23, 2021 "Large Majorities of Newsmax and OAN News Consumers Also Go to Fox News"
https://www.pewresearch.org/journalism/2021/03/23/large-majorities-of-newsmax-and-oan-news-consumers-also-go-to-fox-news/

March 26, 2021 "Attention to COVID-19 news drops, but Democrats still substantially more interested than Republicans"
https://www.pewresearch.org/fact-tank/2021/03/26/attention-to-covid-19-news-drops-but-democrats-still-substantially-more-interested-than-republicans/

April 28, 2021 "At 100 Day Mark: Coverage of Biden Has Been Slightly More Negative Than Positive, Varied Greatly by Outlet Type"
https://www.pewresearch.org/journalism/2021/04/28/at-100-day-mark-coverage-of-biden-has-been-slightly-more-negative-than-positive-varied-greatly-by-outlet-type/

April 28, 2021 "Q&A: How Pew Research Center studied press coverage of the Biden administration’s early days"
https://www.pewresearch.org/fact-tank/2021/04/28/qa-how-pew-research-center-studied-press-coverage-of-the-biden-administrations-early-days/

May 7, 2021 "Broad agreement in U.S. – even among partisans – on which news outlets are part of the ‘mainstream media’"
https://www.pewresearch.org/fact-tank/2021/05/07/broad-agreement-in-u-s-even-among-partisans-on-which-news-outlets-are-part-of-the-mainstream-media/

May 12, 2021 "Immigration was a top focus of early Biden coverage, especially among outlets with right-leaning audiences"
https://www.pewresearch.org/fact-tank/2021/05/12/immigration-was-a-top-focus-of-early-biden-coverage-especially-among-outlets-with-right-leaning-audiences/

May 17, 2021 "More Americans now see the media’s influence growing compared with a year ago"
https://www.pewresearch.org/fact-tank/2021/05/17/more-americans-now-see-the-medias-influence-growing-compared-with-a-year-ago/

June 9, 2021 "What makes a news story trustworthy? Americans point to the outlet that publishes it, sources cited"
https://www.pewresearch.org/fact-tank/2021/06/09/what-makes-a-news-story-trustworthy-americans-point-to-the-outlet-that-publishes-it-sources-cited/

July 1, 2021 "Republicans less likely to trust their main news source if they see it as ‘mainstream’; Democrats more likely"
https://www.pewresearch.org/fact-tank/2021/07/01/republicans-less-likely-to-trust-their-main-news-source-if-they-see-it-as-mainstream-democrats-more-likely/


***************************************************************************************************************************
SYNTAX

The following SPSS syntax can be used to reproduce variable KNOWSUM_W85.

COMPUTE KNOWSUM_W85=0.
IF KNOWVACC1_W85 EQ 1 KNOWSUM_W85=KNOWSUM_W85+1.
IF KNOWVACC2_W85 EQ 3 KNOWSUM_W85=KNOWSUM_W85+1.
IF KNOWMIN_W85 EQ 4 KNOWSUM_W85=KNOWSUM_W85+1.
IF KNOWBORDER_W85 EQ 1 KNOWSUM_W85=KNOWSUM_W85+1.
IF KNOWCLIMATE_W85 EQ 3 KNOWSUM_W85=KNOWSUM_W85+1.
VARIABLE LABELS KNOWSUM_W85 Total number of correct answers to KNOWVACC1-KNOWCLIMATE.
EXECUTE.

