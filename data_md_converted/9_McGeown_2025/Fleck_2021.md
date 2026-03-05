© Mary Ann Liebert, Inc. DOI: 10.1089/neu.2020.7018

# **Original Articles**

# Predicting Post-Concussion Symptom Recovery in Adolescents Using a Novel Artificial Intelligence

David E. Fleck, Nicholas Ernest, Ruth Asch, Caleb M. Adler, Kelly Cohen, Weihong Yuan, Brandon Kunkel,<sup>2</sup> Robert Krikorian,<sup>1</sup> Shari L. Wade,<sup>5</sup> and Lynn Babcock<sup>6</sup>

#### **Abstract**

This pilot study explores the possibility of predicting post-concussion symptom recovery at one week post-injury using only objective diffusion tensor imaging (DTI) data inputs to a novel artificial intelligence (AI) system composed of Genetic Fuzzy Trees (GFT). Forty-three adolescents age 11 to 16 years with either mild traumatic brain injury or traumatic orthopedic injury were enrolled on presentation to the emergency department. Participants received a DTI scan three days post-injury, and their symptoms were assessed by the Post-Concussion Symptom Scale (PCSS) at 6 h and one week post-injury. The GFT system was trained using one-week total PCSS scores, 48 volumetric magnetic resonance imaging inputs, and 192 DTI inputs per participant over 225 training runs. Each training run contained a randomly selected 80% of the total sample followed by a 20% validation run. Over a different randomly selected sample distribution, GFT was also compared with six common classification methods. The cascading GFT structure controlled an effectively infinite solution space that classified participants as recovered or not recovered significantly better than chance. It demonstrated 100% and 62% classification accuracy in training and validation, respectively, better than any of the six comparison methods. Recovery sensitivity and specificity were 59% and 65% in the GFT validation set, respectively. These results provide initial evidence for the effectiveness of a GFT system to make clinical predictions of trauma symptom recovery using objective brain measures. Although clinical and research applications will necessitate additional optimization of the system, these results highlight the future promise of AI in acute care.

**Keywords:** child; diffusion tensor imaging; fuzzy logic; machine learning; mild traumatic brain injury

#### Introduction

NONCUSSIONS account for more than 800,000 annual emergency department (ED) visits in the United States, and ED visits and hospital stays have been steadily increasing over the past decade, particularly in children and adolescents. 1,2 This increase likely can be attributed to a combination of greater public awareness and diagnosis.<sup>2</sup> The impairment and disability associated with concussion can be long lasting, with 30% of patients having persistent symptomatology at one month. 1,3

Clinical symptoms of concussion vary considerably patient-topatient and may be masked by, or inappropriately attributed to, a comorbid injury such as an orthopedic injury, making "classic" symptoms (e.g., dizziness, vomiting, headache, and confusion) poor diagnostic and prognostic indicators. Even with the aid of standard magnetic resonance imaging (MRI) and computed tomography (CT), the majority of patients with a concussion do not have identifiable abnormalities.<sup>4</sup> Therefore, alternative objective biological markers that transcend phenomenological observation are sorely needed to help clarify diagnoses, prevent repeat injury, inform patient and family counseling (including return-to-play or return-to-work/school decisions), and ultimately improve patient outcomes.

The diverse behavioral symptomology of concussion is not surprising given that each individual presents with a distinct set of circumstances including injury mechanism, force, and location that interact with unique neuroanatomy and physiology.<sup>5</sup> Despite this heterogeneity, several studies have identified diffuse axonal injury (DAI) as a unifying feature of concussion.<sup>6,7</sup> Disruption of white matter tract integrity has been hypothesized to correlate with the severity of neuropsychological impairment and more recently has been shown to correlate with concussion recovery.8

<sup>&</sup>lt;sup>1</sup>Department of Psychiatry and Behavioral Neuroscience, University of Cincinnati College of Medicine, Cincinnati, Ohio, USA.

<sup>&</sup>lt;sup>2</sup>Thales USA Inc., Cincinnati, Ohio, USA.

<sup>&</sup>lt;sup>3</sup>Department of Aerospace Engineering and Engineering Mechanics, University of Cincinnati College of Engineering and Applied Science, Cincinnati, Ohio, USA.

<sup>&</sup>lt;sup>4</sup>Imaging Research Center, Radiology, Cincinnati Children's Hospital Medical Center, Cincinnati, Ohio, USA.

Divisions of <sup>5</sup>Emergency Medicine, and <sup>6</sup>Physical Medicine and Rehabilitation, Department of Pediatrics, University of Cincinnati College of Medicine, Cincinnati Children's Hospital Medical Center, Cincinnati, Ohio, USA.

The shaking, rotational, or blast wave shearing forces that result in DAI, however, can occur independent of a contact head injury as well, or in the context of repeated, minor, blunt force or acceleration/deceleration injuries that do not necessarily result in loss of consciousness, amnesia, or altered mental state. Indeed, we have shown recently that white matter integrity, as indexed by diffusion tensor imaging (DTI) measures of fractional anisotropy (FA), is lower in portions of the internal capsule of former college football players, suggesting that white matter abnormalities can persist long after the cessation of brain trauma.

Until the advent of DTI, there was no neuroimaging technique available to visualize and characterize white matter network health and connectivity. Studies now show that DTI can be used to identify patients with concussion, but this discriminant ability has not been translated and applied to clinical recovery. One potential method for a more accurate clinical classification of concussion recovery, and possible DAI, is to combine multiple objective DTI measures in a data-driven analytical approach to differentiate groups based on the pattern of relationships among measures. These data can then be included as inputs in a bottom-up classification algorithm to find the best separation between groups.

In the past, linear pattern classifications have been conducted using inferential statistics or by taking advantage of machine learning approaches such as support vector machines. Only more recently has machine learning been applied to non-linear solutions of bioinformatics problems on a large-scale basis. These newer algorithms are tailored specifically to situations where the number of feature inputs vastly exceeds the sample size and can be used to make predictions on a graded scale in contrast to a dichotomous outcome. <sup>14</sup>

Using a novel Genetic Fuzzy Tree (GFT) machine learning algorithm, the aim of this pilot study was to explore the ability of objective, scalar DTI indices obtained within three days of injury to classify Post-Concussion Symptom Scale (PCSS)<sup>15</sup> recovery at one week post-injury in a diverse sample of adolescents admitted to the ED with traumatic injuries. In addition, the performance of traditional classification methods, including other machine learning algorithms, were compared with GFT in predicting PCSS recovery. For this initial study, given the advantages of GFT, we predicted that this approach would outperform the comparator methods in its ability to classify successfully PCSS-defined trauma recovery or non-recovery at one week post-injury.

## Methods

### Study design and setting

This is a secondary analysis of a prospective observational cohort study conducted in a large tertiary children's hospital ED between March 2011 and January 2012. <sup>16</sup>

#### **Participants**

Participant and MRI/DTI data characteristics of this sample have been described previously. <sup>17</sup> Briefly, 43 adolescents (11 to 16 years old) were enrolled prospectively from the ED within 6 h of a head or extremity injury. Concussion was defined as a head trauma involving either a blunt force or acceleration/deceleration injury with a Glasgow Coma Scale (GCS)<sup>18</sup> score of 14 to 15 on presentation to the ED with either loss of consciousness <30 min or amnesia, or alteration in mental state at the time of injury. Isolated extremity orthopedic injury was defined by an Abbreviated Injury Severity Score <4 with a radiograph, and no suggestion of mild traumatic brain injury (mTBI) (i.e., loss of consciousness, amnesia, or altered mental state). <sup>19,20</sup>

Adolescents with pre-existing neurological conditions, learning disabilities, behavioral disorders, or previous concussions were excluded. In addition, baseline behavioral, emotional, and social capacity was assessed by the child behavior checklist  $(CBCL)^{21}$  and adolescents with a T-score  $\leq$ 65 were excluded because of likelihood of pre-existing problems.

This study was approved by the local Institutional Review Board. Parents of participants gave written informed consent and adolescents provided written assent.

#### Clinical assessments

The PCSS data for the index presentation to the ED and a follow-up clinic visit at one week were examined. The PCSS is a 22-item inventory of symptoms associated with concussion and is graded on a seven-point Likert scale with ratings of 0 and 6 corresponding to "none" and "severe," respectively, and a maximal range from 0 to 132. The primary outcome was symptomatic recovery, defined as a PCSS score at one week post-injury of  $\leq 8$  for girls and  $\leq 6$  for boys, because higher scores are reported in females than males.

#### DTI acquisition and data processing

Neuroimaging data were obtained on a 3T Phillips scanner within 96 h of injury. Forty-two participants were scanned within 72 h post-injury, and one was scanned 72 to 96 h post-injury. The DTI data were acquired with a single-shot echo-planar imaging (EPI) sequence with parameters: repetition time/echo time (TR/TE)=9000/84 msec; field of view (FOV)=256 × 256 mm²; acquisition matrix=128 × 128; in-plane resolution=2 × 2 mm²; slice thickness=2 mm; slices=76; 61 non-colinear diffusion-weighted directions (b=1000 s/mm²); one volume of images with no diffusion sensitization; sensitivity encoding factor 2. High resolution three-dimensional (3D) T1-weighted anatomical images were acquired with a 3D turbo field echo (TFE) sequence with parameters: TR/TE=8.1/3.7 msec; FOV=256 × 256; acquisition matrix=256 × 256; sagittal in-plain resolution=1 × 1 mm²; slice thickness=1 mm; slices=180.

Head motion and eddy current artifact were corrected by aligning all 61 non-colinear diffusion-weighted images with the b0 image using an affine transformation (linear image registration tool) implemented in the Functional MRI of the Brain (FMRIB) Software Library (FSL) Diffusion Toolbox (Oxford, UK; www.fmrib.ox.ac.uk/fsl).

The high resolution T1-weighted images were down-sampled and registered to the 2 mm-iso T1 brain template in Montreal Neurological Institute (MNI) space. The inverse transformation was then calculated and used to transform the parcellated regions-of-interest (ROI) from the MNI space back to native space (to b0). In native space, diffusion tensor reconstruction was conducted using Diffusion Toolkit/TrackVis. 23,24

Diffusion tensor calculation was based on a linear least square fitting algorithm. <sup>24</sup> For each of the 48 white matter regions, as determined with the John Hopkins University ICBM-DTI-81 white matter labels atlas, <sup>25</sup> a voxel count was used to determine the volume of each ROI, and DTI measures including FA, mean diffusivity (MD), axial diffusivity (AD), and radial diffusivity (RD) were extracted using the *fslstat* function in the FSL software package. A total of 48 volumetric measures and 192 DTI measures were used as inputs for the machine learning analysis.

### Machine learning methodology

A linguistic machine learning system based on a cascading GFT design was used. As seen in Table 1, this methodology is an evolution of genetic algorithms and fuzzy systems that helps to mitigate scalability concerns of standard genetic fuzzy systems by breaking the problem space into many subdecisions. Variables that

832 FLECK ET AL.

Table 1. Methodologies Underlying the Final Genetic Fuzzy Tree Structure

are coupled directly are placed in the same part of the controller, while ''slightly'' coupled variables are, at least, placed in the same branch of the tree structure to offset any decrease in accuracy because of unaccounted for coupling between variables. Although any genetic algorithm can be utilized to train such systems, for the reasons stated above, the EVE learning system (Thales USA), a patent-pending GFT with a fitness function for optimizing or training similar GFTs through recursive application, was used in the present study.29–31

Both concussion and extremity-injury participant data were included to train the machine learning system, but trauma group was left undefined to provide a representative natural sample of inputs for the GFT, because symptoms on the PCSS are not specific to concussion and are common in ED settings.<sup>32</sup> Indeed, there was no statistical difference in the proportions of concussion and extremity injury participants with abnormal PCSS total scores at one week post-injury (12 [52.2%] vs. 7 [35.0%]; corrected p > 0.05). Moreover, by leaving the trauma groups undefined, no subjectively assessed clinical data were incorporated into the GFT model, consistent with our stated aim to assess objective measures only.

The system was trained, then, using one week post-injury total PCSS scores, 48 volumetric MRI inputs, and 192 DTI inputs (48 each for FA and MD, AD, and RD) per participant over 225 training runs. Central inputs included middle cerebellar peduncle, pontine crossing tract, genu of the corpus callosum, body of the corpus callosum, splenium of the corpus callosum and fornix.

Bilateral inputs included right and left hemisphere corticospinal tract, medial lemniscus, inferior cerebellar peduncle, superior cerebellar peduncle, cerebellar peduncle, anterior limb of the internal capsule, posterior limb of the internal capsule, retrolenticular region of the anterior capsule, anterior corona radiata, superior corona radiata, posterior corona radiata, posterior thalamic radiation, sagittal striatum, external capsule, cingulate gyrus, hippocampus, fornix/stria terminalis, superior longitudinal fasciculus, superior frontooccipital fasciculus, uncinated fasciculus, and tapetum.

Each training run contained a randomly selected \*80% of the total sample (n = 35). The model was constrained to five lateral levels or ''branches'' at the top layer including one each for MRI volumetrics, FA, MD, AD, and RD DTI data. The middle layers combined inputs from upper branches and were constrained to three inputs from a directly higher level, which resulted in up to 125 linguistic ''if-then statements'' controlling any given fuzzy inference system (FIS; this was done to limit the computational cost of any FIS in particular, not necessarily with respect to the cost of evaluating that FIS for a given set of inputs, but rather for the cost associated with training a FIS of such immense size).

In total, 11,550 fuzzy if-then rules were created. Each FIS classified states (i.e., MRI and DTI values) into a number of membership functions (i.e., very low, low, medium, high, very high). It then created if-then statements (e.g., if cingulate gyrus FA is very high, and hippocampus volume is low, then PCSS reduction is very high), and these logic-based rules were used to control the system. Over training, then, membership functions for each imaging input were continually tuned and optimized and the if-then rule bases derived from them were ''learned.'' The final FIS was a three-input system utilizing ''Mean of Maxima'' defuzzification methodology and outputted a binary classification of normal or abnormal PSCC scores independent of concussion or extremityinjury status.

Neuroimaging values were provided to EVE, which was utilized to train the system to identify each participant's binary PCSS based recovery classification (yes or no). For each of n participants, the absolute value of % PCSS reduction was summed with either 1 or 0 if correctly classified as recovered. Recovery prediction accuracy, sensitivity, and specificity were calculated. It should be noted that although the number of input variables greatly outnumbered the number of observations, fuzzy logic is robust in training for complex problems with small data sets.33,34

## Performance evaluation

The experimental runs examined the consistency of results across different participant combinations in training and validation. An 80/20 training/validation schedule was employed in each of 225 experimental runs. Each run included a different randomly selected distribution of the 43 participants with the stipulation that there be 15 and four non-recovered participants in each training and validation set, respectively. Performance was initially evaluated in GFT validation using a one-sample t test with the population mean set at 50% accuracy. Good performance was defined by a significantly greater likelihood of correct recovery classification relative to chance.

In addition, the 225 experimental runs were used to compare the GFT method to six common linear classification or machine learning methods including: naïve Bayes (NB), discriminant function analysis (DFA), radial basis function support vector machine (SVM), random forest (RF), extra trees classifier (ETC), and nearest neighbor (NN). Performance was evaluated in the training and validation sets using one-way analysis of variance (ANOVA), with follow-up Tukey honestly significant difference (HSD) tests, on mean accuracy. In the validation sets, specificity was evaluated qualitatively across methods within a 10-point sensitivity range, and sensitivity was evaluated across methods within a 10-point specificity range.

Good performance was defined primarily by a significant omnibus test as the result of more accurate performance by GFT relative to one or more of the comparison methods. Finally, accuracy distribution strata over the validation sets were examined to further characterize the data.

#### Results

### Participant and clinical characteristics

There was no statistically significant difference between the recovered (n=24) and not recovered (n=19) groups in terms of mean age (12.9 years  $\pm$ 1.5 vs. 12.9 years  $\pm$ 1.8), male gender (21 [87.5%] vs. 15 [78.9%]), or African-American race (9 [37.5%] vs. 9 [52.9%]). Recovered and not recovered groups also exhibited statistical similarities in mean PCSS total score at the 6 h ED visit (23.8 $\pm$ 20.7 vs. 34.8 $\pm$ 17.8), the proportion of participants in each group with abnormal PCSS scores at the 6 h ED visit (17 [70.8%] vs. 19 [100%]), and the mean time to scan (2.17 $\pm$ 0.82 days vs. 1.89 $\pm$ 0.88).

By week 1, the recovered and not recovered groups showed significant differences in mean PCSS total scores  $(1.9\pm2.2 \text{ vs. } 18.8\pm1 \text{ } 4.9; \text{ corrected } p < 0.01)$ , suggesting greater symptom improvement in the recovered group. The PCSS scores, however, were reduced at week 1 in both the recovered and not recovered groups  $(23.8\pm20.7 \text{ vs. } 1.9\pm2.2 \text{ and } 34.8\pm17.8 \text{ vs. } 18.8\pm14.9, \text{ respectively; corrected } p < 0.01)$ , and 6 h and one week PCSS scores were significantly correlated (recovered r = 0.44, not recovered r = 0.50; p < 0.05).

## GFT post-training model

The final model resulted in 151 individual FISs (12,695-digit string length), each exerting control of the system and leading to the final prediction of PCSS-defined recovery at one week. The cascading GFT structure controlled an effectively infinite solution space of approximately  $5.13 \times 10^{15,579}$  rules needing to be trained that would be impossible using a single FIS system (i.e., every input into one FIS).

## GFT training and validation results

Two hundred twenty-five separate 80/20 training/validation splits were run to predict recovery status. As expected, the GFT method accurately classified participants as recovered or not recovered with 100% accuracy after training. Is also performed significantly better than change performance in the validation condition (62.3%; t[224] = 11.56, p < 0.001).

Mean validation accuracy, sensitivity, and specificity for the GFT and comparison methods are shown in Table 2. There was a significant difference in mean accuracy between methods overall (F[6, 1574] = 15.65, p < 0.001). Post hoc Tukey HSD tests revealed that GFT had significantly higher mean accuracy (62.3%) relative

TABLE 2. MEAN ACCURACY, SENSITIVITY, AND SPECIFICITY ACROSS 225 VALIDATION RUNS FOR THE GENETIC FUZZY TREE METHOD AND SIX COMPARISON METHODS

| Accuracy                                 | Sensitivity                                                                                            | Specificity                                                             |
|------------------------------------------|--------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| 62.3%                                    | 59.4%                                                                                                  | 65.1%                                                                   |
| 52.6% <sup>a</sup>                       | 38.0%                                                                                                  | 67.2%                                                                   |
| 54.4% <sup>a</sup>                       | 54.6%                                                                                                  | 54.2%                                                                   |
| 61.7%                                    | 37.0%                                                                                                  | 86.4%                                                                   |
| 57.1% <sup>a</sup>                       | 61.2%                                                                                                  | 52.9%                                                                   |
| 58.0% <sup>a</sup><br>54.2% <sup>a</sup> | 52.3%<br>44.4%                                                                                         | 63.7%<br>64.0%                                                          |
|                                          | 62.3%<br>52.6% <sup>a</sup><br>54.4% <sup>a</sup><br>61.7%<br>57.1% <sup>a</sup><br>58.0% <sup>a</sup> | 62.3% 59.4% 52.6% 38.0% 54.4% 54.6% 61.7% 37.0% 57.1% 61.2% 58.0% 52.3% |

<sup>&</sup>lt;sup>a</sup>Genetic Fuzzy Trees > comparison method, p < 0.05.

to NB, DFA, RF, ETC, and NN (52.6%, 54.4%, 57.1%, 58.0%, and 54.2%, respectively), but not SVM (61.7%) (p>0.05).

Although it is difficult to interpret sensitivity at different levels of specificity and *vice versa*, four methods—RF, GFT, DFA, and ETC—achieved sensitivities within a nine-point range (61.2%, 59.4%, 54.6%, and 52.3%, respectively). At these relatively fixed sensitivity levels, GFT achieved the highest specificity (65.1%). Likewise, four methods—NB, GFT, NN, and ETC—achieved specificities within a 3.5-point range (67.2%, 65.1%, 64.0%, and 63.7%, respectively). At these fixed specificity levels, GFT achieved the highest sensitivity (59.4%).

Accuracy distribution strata over the validation sets are shown in Table 3. The GFT had the greatest number of high-accuracy runs (i.e., bands 6, 7, and 8) that correctly classified eight (three runs), seven (21 runs), or six participants (58 runs), accounting for 60%, 34.4%, and 24.9% of within-strata runs, respectively. The GFT method also had among the fewest low-accuracy runs (i.e., bands 0, 1, and 2; five runs total), accounting for only 7.4% of runs in the lowest three accuracy bands. In other words, GFT achieved among the best performance at the top and bottom third of accuracy outcomes. Radial Basis Function SVM performed slightly better at the bottom third (two runs accounting for only 2.9% of total), but much less well at the top third of accuracy outcomes.

Between-method accuracy differences were statistically significant at classification strata 3 to 7. At strata 6 and 7, omnibus differences were the result of GFT significantly outperforming NB, DFA, SVM, RF, and NN. At nearer chance-level strata (i.e., bands 3, 4, and 5), omnibus differences were primarily because of the limited range of SVM performance where a full 194/225 runs classified 5/8 participants correctly (i.e., band 5).

#### **Discussion**

For this pilot study, we sought to examine whether a novel machine learning system based on GFTs is capable of accurately classifying a diverse sample of pediatric participants with traumatic injuries into recovered or not recovered groups based on PCSS scores at one week post-injury using only objective MRI and DTI measures. Results suggest that the GFT system was capable of predicting recovery at one week better than chance, and more capable than six commonly used comparison methods. These effects are not likely attributable to clinical covariates, because the groups were statistically similar in demographic characteristics.

The post-training GFT model exerted completely accurate control over an effectively infinite solution space. Comparative

834 FLECK ET AL.

Table 3. Number of Participants (of Eight Possible) Correctly Classified in Each of 225 Validation Runs for the Genetic Fuzzy Tree Method and Six Comparison Methods with Between-Method Statistical Comparisons

Number of Participants Correctly Classified (Accuracy Strata)

|        | 0 (0%) | 1 (12.5%) | 2 (25%)  | 3 (37.5%)    | 4 (50%)                | 5 (62.5%)               | 6 (75%)                | 7 (87.5%)     | 8 (100%) |
|--------|--------|-----------|----------|--------------|------------------------|-------------------------|------------------------|---------------|----------|
| Method | N (%)  | N (%)     | N (%)    | N (%)        | N (%)                  | N (%)                   | N (%)                  | N(%)          | N (%)    |
| GFT    | 0 (0)  | 0 (0.0)   | 5 (2.2)  | 26 (11.6)    | 46 (20.4)              | 66 (29.3)               | 58 (25.8)              | 21 (9.3)      | 3 (1.3)  |
| NB     | 0 (0)  | 2 (0.9)   | 14 (6.2) | 45 (20.0)    | 78 (34.7) <sup>b</sup> | 53 (23.6)               | 26 (11.6) <sup>a</sup> | $7(3.1)^{a}$  | 0 (0.0)  |
| DFA    | 0 (0)  | 2 (0.9)   | 14 (6.2) | 44 (19.6)    | 56 (24.9)              | 67 (29.8)               | $36 (16.0)^{a}$        | $6(2.7)^{a}$  | 0 (0.0)  |
| SVM    | 0 (0)  | 0 (0.0)   | 2 (0.9)  | $4(1.8)^{a}$ | $13 (5.8)^a$           | 194 (86.2) <sup>b</sup> | 11 (4.9) <sup>a</sup>  | $1 (0.4)^{a}$ | 0 (0.0)  |
| RF     | 0 (0)  | 0 (0.0)   | 9 (4.0)  | 27 (12.0)    | $73 (32.4)^{b}$        | 71 (31.6)               | $35 (15.6)^{a}$        | $9 (4.0)^{a}$ | 1 (0.4)  |
| ETC    | 0 (0)  | 2 (0.9)   | 8 (3.6)  | 31 (13.8)    | 59 (26.2)              | 67 (29.8)               | 45 (20.0)              | 12 (5.3)      | 1 (0.4)  |
| NN     | 0 (0)  | 1 (0.4)   | 9 (4.0)  | 39 (17.3)    | 72 (32.0)              | 77 (34.2)               | $22 (9.8)^{a}$         | $5(2.2)^{a}$  | 0 (0.0)  |
| p<     | NS     | NS        | NS       | 0.001        | 0.001                  | 0.001                   | 0.001                  | 0.001         | NS       |

GFT, Genetic Fuzzy Trees; NB, Naïve Bayes; DFA, Discriminant Function Analysis; SVM, Radial Basis Function Support Vector Machine; RF, Random Forest; ETC, Extra Trees Classifier; NN, Nearest Neighbor; NS, not statistically significant.

Correction for multiple comparisons 0.05/6, 0.007.

 $^{a}$ GFT > comparison method, p < 0.05;  $^{b}$ GFT < comparison method, p < 0.05.

validation results indicated that the GFT method provided numerically greater predictive accuracy than the six competing models and statistically greater accuracy than all but one comparison method (i.e., SVM). Sensitivity and specificity of the GFT method to recovery were also qualitatively superior to the comparison methods when considered at similar levels. Finally, the GFT method achieved among the best performance at the top and bottom third of the accuracy outcome strata.

These findings provide strong initial evidence for the predictive utility of GFTs for traumatic injury, but additional work is needed to validate and optimize the system further for use in clinical decision support. This is particularly evident by relatively low recovery sensitivity and specificity, at least by traditional clinical standards. Nonetheless, the present results hold promise to help address a number of unmet clinical challenges in acute care.

Extrapolating from these results, the analysis of acute imaging using this novel technology could better segment those who have rapid post-concussion symptom recovery versus those who have a prolonged course. Because there is a lack of objective prognostic criteria related to concussion, the prediction of those who are at risk of prolonged recovery is based on the interaction of host, environment, and injury-related variables, such as history of previous concussion or migraines, or complaints of headache or fatigue.

Difficulty with ascertaining these variables in most emergent settings and suboptimal test characteristics limit the routine application of such decision tools. Imaging data captured soon after injury could be used to augment prediction of those who may benefit from additional resources to support recovery, as well as those who would be the ideal study participants for assessment of interventions.

Regarding the design of the current GFT, unlike another recent GFT system utilizing the EVE learning system,<sup>26</sup> this GFT utilized a new morphing structure approach in which both top and bottom layers of the tree structure are learned. Moreover, because of improvements in core software tools, faster run times enabled more training cycles with improved processing performance, despite extensive input to the system, because of the novel GFT structure. In general, the current GFT, and recent similar GFTs, have shown superior performance in classification<sup>26</sup> and similar classical machine learning problems.<sup>29–34</sup> They also handle very large numbers of inputs, making them effective for biobehavioral research predicting various outcomes beyond dichotomous recovery, including side effect profiles, symptom remission status and medication ad-

herence level, for example. The automated decision making design of GFTs is robust to even very complex, graded classifications based on subjective and/or objective data.

As with all research, interpretation of the present study is limited by a number of considerations. The first limitation is that these initial classification results have not yet been validated using an independent cohort of participants. The cost to identify a second, independent validation sample would have been prohibitive for this pilot study, but may be possible in the future.

A second limitation is the possibility that the training set was "overfit." Although overfitting can be a problem in any machine learning application, the relatively good validation results suggest that overfitting, if present, was less of a problem for the GFT than for the comparison methods.

Third, the current sample size was relatively small, especially for a deep learning application that would be expected to perform optimally with a large dataset. In the future, it may be possible to enlarge the current data set by artificially adding more data through "random interpolation" using the range of measured values. 35,36

Fourth, although GFT outperformed other machine learning comparator methods, it was not compared with conventional clinical outcome prediction systems. This represents an important area for future work.

Finally, to use all available data, and considering that PCSS scores were elevated in the majority of participants at the index ED visit regardless of trauma type (indicating poor PCSS diagnostic specificity consistent with previous reports on the PCSS and other self-report concussion scales <sup>14,37,38</sup>), concussion and isolated extremity orthopedic injury groups were considered together rather than in isolation. While future, larger machine learning studies should attempt to disentangle trauma type, the lack of diagnostically specific outcome measures currently available for trauma subtyping will need to be first overcome.

Nonetheless, although the present results are not specific to concussion, they are generalizable to the larger population of children and adolescents who experience physical trauma and suggest that even complicated outcomes, where all the influences are unknown (such as uncertainty between concussion and orthopedic injury), may be predictable using only objective brain measures in a novel cascading GFT design.

Moreover, it has become clear that most concussions occur without a loss of consciousness, <sup>19,39</sup> and that concussion symptoms

may not be apparent for days post-injury.40 As a result, up to onethird of sports-related concussions alone go undiagnosed.<sup>41</sup> Previous studies also suggest that changes in DTI FA can be chronic,42,43 suggesting that previous head injuries in the current extremity injury participants (the majority of whom were injured playing sports, i.e., 77%, and had played sports previously), could have affected the DTI findings and/or placed these participants at greater concussion risk.

Clinical evidence supports the notion that orthopedic injuries can have an mTBI component,20 and long-term sequelae have been associated with a history of repetitive ''minor'' head impacts without loss of consciousness.<sup>44</sup> These explanations are consistent with our previous work demonstrating that DTI abnormalities can persist long after the cessation of repeated head impacts in college football players,45 and that soccer players have decreased graymatter density in bilateral anterior temporal cortex, likely as a consequence of repeatedly ''heading'' the ball.46

Although the current results are insufficient to apply in a clinical system at present, the superiority of the GFT method relative to other common methods provides promise for future development of an objective, non-invasive test to aid in the prediction of concussion and related trauma outcomes. The low computational cost of GFT systems should allow for ready optimization, including the output of key predictors for evaluation to facilitate research and clinical applications in the future.

## Funding Information

This study was funded in part by National Center for Research Resources and the National Center for Advancing Translational Sciences, National Institutes of Health, through Grant KL2 TR000078 (KL2 RR026315, Babcock); Cincinnati Children's Hospital Medical Center Division of Emergency Medicine Supplement Award (Babcock); and University of Cincinnati Sports Health Innovation Award (Fleck).

## Author Disclosure Statement

Dr. Adler has received research support from Activas, Alkermes, Allergan, Cephalon, Forest, Janssen, Johnson and Johnson, Lundbeck, Merck, Otsuka, Pfizer, Shire, Sunovion, Supernus, Syneurex and Takeda. He has been a consultant to or member of the scientific advisory boards of Assurex Health, Neurocrine and Sunovion. For the remaining authors, no competing financial interests exist.

## References

- 1. Faul, M., Xu, L., Wald, M.M., and Coronado, V. (2010). Traumatic Brain Injury in the United States. Centers for Disease Control and Prevention, National Center for Injury Prevention and Control: Atlanta, GA.
- 2. Marin, J.R., Weaver, M.D., Yealy, D.M., and Mannix, R.C. (2014). Trends in visits for traumatic brain injury to emergency departments in the United States. JAMA 311, 1917–1919.
- 3. Zemek, R.L., and Yeates, K.O. (2017). Rates of persistent postconcussive symptoms. JAMA 317, 1375–1376.
- 4. Huang, M.X., Theilmann, R.J., Robb, A., Angeles, A., Nichols, S., Drake, A., D'Andrea, J., Levy, M., Holland, M., Song, T., Ge, S., Hwang, E., Yoo, K., Cui, L., Baker, D.G., Trauner, D., Coimbra R., and Lee, R.R. (2009). Integrated imaging approach with MEG and DTI to detect mild traumatic brain injury in military and civilian patients. J. Neurotrauma 26, 1213–1226.
- 5. Mitra, J., Shen, K.K., Ghose, S., Bourgeat, P., Fripp, J., Salvado, O., Pannek, K., Taylor, D.J., Mathias, J.L., and Rose, S. (2016). Statistical machine learning to identify traumatic brain injury (TBI) from structural disconnections of white matter networks. Neuroimage 129, 247–259.

- 6. Bigler, E.D., and Maxwell, W.L. (2012). Neuropathology of mild traumatic brain injury: relationship to neuroimaging findings. Brain Imaging Behav. 6, 108–136.
- 7. Taber, K.H., and Hurley, R.A. (2013). Update on mild traumatic brain injury: neuropathology and structural imaging. J. Neuropsychiatry Clin. Neurosci. 25, 1–5.
- 8. Yin,B., Li, D.D., Huang, H., Gu, C.H., Bai, G.H., Hu, L.X., Zhuang, J.F., and Zhang, M. (2019). Longitudinal changes in diffusion tensor imaging following mild traumatic brain injury and correlation with outcome. Front. Neural Circuits 13, 28
- 9. Smith, D.H., and Meaney, D.F. (2000). Axonal damage in traumatic brain injury. Neuroscientist 6, 483–495.
- 10. Adler, C.M., DelBello, M.P., Weber, W., Williams, M., Duran, L.R.P., Fleck, D., Boespflug, E., Eliassen, J., Strakowski, S.M., and Divine, J. (2018). MRI evidence of neuropathic changes in former college football players. Clin. J. Sport Med. 28, 100–105.
- 11. Hayes, J.P., Bigler, E.D., and Verfaellie, M. (2016). Traumatic brain injury as a disorder of brain connectivity. J. Int. Neuropsychol. Soc. 22, 120–137.
- 12. Douglas, D.B., Iv, M., Douglas, P.K., Anderson, A., Vos, S.B., Bammer, R., Zeineh, M., and Wintermark, M. (2015). Diffusion tensor imaging of TBI: potentials and challenges, Top. Magn. Reson. Imaging 24, 241–251.
- 13. Linden, D.E. (2012). The challenges and promise of neuroimaging in psychiatry, Neuron 73, 8–22.
- 14. Vidyasagar, M. (2015). Identifying predictive features in drug response using machine learning: opportunities and challenges. Annu. Rev. Pharmacol. Toxicol. 55, 15–34.
- 15. Lovell, M.R., Iverson, G.L., Collins, M.W., Podell, K., Johnston, K.M., Pardini, D., Pardini, J., Norwig, J., and Maroon, J.C. (2006). Measurement of symptoms following sports-related concussion: reliability and normative data for the post-concussion scale. Appl. Neuropsychol. 13, 166–174.
- 16. Babcock, L., Yuan, W., Leach, J., Nash, T., and Wade, S. (2015). White matter alterations in youth with acute mild traumatic brain injury. J. Pediatr. Rehabil. Med. 8, 285–296.
- 17. Yuan, W., Wade, S.L., and Babcock, L. (2015). Structural connectivity abnormality in children with acute mild traumatic brain injury using graph theoretical analysis. Hum. Brain Mapp. 36, 779–792.
- 18. Teasdale, G., and Jennett, B. (1974). Assessment of coma and impaired consciousness. A practical scale. Lancet 2, 81–84.
- 19. Asken, B.M., Snyder, A.R., Smith, M.S., Zaremski, J.L., and Bauer, R.M. (2017). Concussion-like symptom reporting in non-concussed adolescent athletes. Clin. Neuropsychol. 31, 138–153.
- 20. Jodoin, M., Rouleau, D.M., Charlebois-Plante, C., Benoit, B., Leduc, S., Laflamme, G.Y., Gosselin, N., Larson-Dupuis, C., De Beaumont, L. (2016). Incidence rate of mild traumatic brain injury among patients who have suffered from an isolated limb fracture: upper limb fracture patients are more at risk. Injury 47, 1835–1840.
- 21. Achenbach, T.M. and Rescorla, L.A. (2001). Manual for the ASEBA School-Age Forms & Profiles. University of Vermont, Research Center for Children, Youth, & Families: Burlington, VT.
- 22. Kontos, A.P., Elbin, R.J., Schatz, P., Covassin, T., Henry, L., Pardini, J., and Collins, M.W. (2012). A revised factor structure for the Post-Concussion Symptom Scale: baseline and postconcussion factors. Am. J. Sports Med. 40, 2375–2384.
- 23. Hess, C.P., Mukherjee, P., Han, E.T., Xu, D., and Vigneron D.B. (2006). Q-ball reconstruction of multimodal fiber orientations using the spherical harmonic basis. Magn. Reson. Med. 56, 104–117.
- 24. Wang, R., Benner, T, Sorensen, A.G., and Wedeen, V.J (2007). Diffusion toolkit: a software package for diffusion imaging data processing and tractography. Proc. Int. Soc. Mag. Reson. Med. 15, 3720.
- 25. Mori, S., Oishi, K., Jiang, H., Jiang L., Li, X., Akhter, K., Hua, K., Faria, A.V., Mahmood, A., Woods, R., Toga, A.W., Pike, G.B., Neto, P.R., Evans, A., Zhang, J., Huang, H., Miller, M.I., van Zijl, P., and Mazziotta, J. (2008). Stereotaxic white matter atlas based on diffusion tensor imaging in an ICBM template. Neuroimage 40, 570–582.
- 26. Fleck, D.E., Ernest, N., Adler, C.M., Cohen, K., Eliassen, J.C., Norris, M., Komoroski, R.A., Chu, WJ., Welge, J.A., Blom, T.J., DelBello, M.P., and Strakowski, S.M. (2017). Prediction of lithium response in first-episode mania using the LITHium Intelligent Agent (LITHIA): pilot data and proof-of-concept. Bipolar Disord. 19, 259–272.
- 27. Goldberg, D. (1989). Genetic Algorithms in Search, Optimization, and Machine Learning. Addison-Wesley: New York.

836 FLECK ET AL.

28. Ross, T. (1995). Fuzzy Logic with Engineering Applications. Wiley & Sons: New York.

- 29. Ernest, N., Carroll, D., Schumacher, C., Clark, M., Cohen, K., and Lee, G. (2016). Genetic fuzzy based artificial intelligence for unmanned combat aerial vehicle control in simulated air combat missions. J. Def. Manag. 6, 144.
- 30. Ernest, N., Cohen, K., Garcia, E., Schumacher, C., and Casbeer, D. (2015). Multi-agent cooperative decision making using genetic cascading fuzzy systems. AIAA SciTech Conference, Kissimmee, FL.
- 31. Ernest, N., Cohen, K., Schumacher, C., and Casbeer, D. (2014). Learning of intelligent controllers for autonomous unmanned combat aerial vehicles by genetic cascading fuzzy methods. SAE Aerospace Systems and Technology Conference, Cincinnati, OH.
- 32. McLeod, T.C., and Leach, C.J. (2012). Psychometric properties of self-report concussion scales and checklists. J. Athl. Train. 47, 221– 223.
- 33. Cordon, O., Herrera, F., Hoffman, F., and Magdalena, L. (2001). Genetic Fuzzy Systems: Evolutionary Tuning and Learning of Fuzzy Knowledge Bases. World Scientific.
- 34. Ernest, N. (2015). Genetic fuzzy trees for intelligent control of unmanned combat aerial vehicles. Electronic dissertation, University of Cincinnati, Cincinnati, OH.
- 35. DeVries, T., and Taylor, G.W. (2017). Dataset Augmentation in Feature Space. arXiv e-prints.
- 36. Raj, B. (2018). Data augmentation: how to use deep learning when you have limited data, Part 2.
- 37. Lau, B.C., Collins, M.W., and Lovell, M.R. (2011). Sensitivity and specificity of subacute computerized neurocognitive testing and symptom evaluation in predicting outcomes after sports-related concussion. Am. J. Sports Med. 39, 1209–1216.
- 38. Shahtaji, A., Galloway, S., and Murphy, L. (2020). Diagnostic tests for concussion, in: Concussion Management for Primary Care: Evidence Based Answers to Cases and Questions. D.S. Patel (ed). Springer: Switzerland.

- 39. Tator, C. (2012). Sport concussion education and prevention. J. Clin. Sport Psychol. 6, 293–301.
- 40. Olson, A., Ellis, M., Selci, E., and Russell, K. (2020). Delayed symptom onset following pediatric sport-related concussion. Front. Neurol. 11, 220.
- 41. Meehan, W.P., Mannix, R.C., O'Brien, M.J., and Collins, M.W. (2013). The prevalence of undiagnosed concussions in athletes. Clin. J. Sport Med. 23, 339–342.
- 42. Borja, M.A., Chung, S., and Lui, Y.W. (2018). Diffusion MR imaging in mild traumatic brain injury. Neuroimaging Clin. N. Am. 28, 117–126.
- 43. Schmidt, J., Hayward, K.S., Brown, K.E., Zwicker, J.G., Ponsford, J., van Donkelaar, P., Babul;, S., and Boyd, L.A. (2018). Imaging in pediatric concussion: a systematic review. Pediatrics 141, e20173406.
- 44. Alosco, M., and Stern, R. (2019). Youth exposure to repetitive head impacts from tackle football and long-term neurologic outcomes: a review of the literature, knowledge gaps and future directions, and societal and clinical implications. Semin. Pediatr. Neurol. 30, 107–116.
- 45. Adler, C.M., DelBello, M.P., Weber, W., Williams, M., Patino Duran, L.R., Fleck, D.E., Boespflug, E., Eliassen, J., Strakowski, S.M., and Divine, J. (2018). MRI evidence of neuropathic changes in former college football players. Clin. J. Sport Med. 28, 100–105.
- 46. Adams, J., Adler, C.M., Jarvis, K., DelBello, M.P., and Strakowski, S.M. (2007). Evidence of anterior temporal atrophy in college-level soccer players. Clin. J. Sport Med. 17, 304–306.

Address correspondence to: David E. Fleck, PhD Department of Psychiatry and Behavioral Neuroscience University of Cincinnati Cincinnati, OH USA

E-mail: david.fleck@uc.edu