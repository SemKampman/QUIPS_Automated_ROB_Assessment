J Neurosurg 139:1523-1533, 2023

# Predicting traumatic brain injury outcomes using a posterior dominant rhythm

Nathaniel A. Cleri, BS,<sup>1</sup> Jordan R. Saadon, MD,<sup>1</sup> Xuwen Zheng, BA,<sup>1</sup> Sujith A. Swarna, BS,<sup>1</sup> Jason Zhang, BS,1 Vaibhav Vagal, BS,1 Cassie Wang, MSE,1 Robert S. Kleyner, MD,1 Charles B. Mikell, MD,1 and Sima Mofakham, PhD1,2

Department of Neurosurgery, Renaissance School of Medicine at Stony Brook University, Stony Brook, New York; and <sup>2</sup>Department of Electrical and Computer Engineering, Stony Brook University, Stony Brook, New York

**OBJECTIVE** Predicting severe traumatic brain injury (sTBI) outcomes is challenging, and existing models have limited applicability to individual patients. This study aimed to identify metrics that could predict recovery following sTBI. The researchers strived to demonstrate that a posterior dominant rhythm on electroencephalography is strongly associated with positive outcomes and to develop a novel machine learning-based model that accurately forecasts the return of consciousness.

METHODS In this retrospective study, the authors assessed all intubated adults admitted with sTBI (Glasgow Coma Scale [GCS] score ≤ 8) from 2010 to 2021, who underwent EEG recording < 30 days from sTBI (n = 195). Seventy-three clinical, radiographic, and EEG variables were collected. Based on the presence of a PDR within 30 days of injury, two cohorts were created—those with a PDR (PDR[+] cohort, n = 51) and those without (PDR[-] cohort, n = 144)—to assess differences in presentation and four outcomes: in-hospital survival, recovery of command following, Glasgow Outcome Scale-Extended (GOS-E) score at discharge, and GOS-E score at 6 months post discharge. AutoScore, a machine learning-based clinical score generator that selects and assigns weights to important predictive variables, was used to create a prognostic model that predicts in-hospital survival and recovery of command following. Lastly, the MRC-CRASH and IMPACT traumatic brain injury predictive models were used to compare expected patient outcomes with true outcomes.

RESULTS At presentation, the PDR(-) cohort had a lower mean GCS motor subscore (1.97 vs 2.45, p = 0.048). Despite no difference in predicted outcomes (via MRC-CRASH and IMPACT), the PDR(+) cohort had superior rates of in-hospital survival (84.3% vs 63.9%, p = 0.007), recovery of command following (76.5% vs 53.5%, p = 0.004), and mean discharge GOS-E score (3.00 vs 2.39, p = 0.006). There was no difference in the 6-month GOS-E score. AutoScore was then used to identify the 7 following variables that were highly predictive of in-hospital survival and recovery of command: age, body mass index, systolic blood pressure, pupil reactivity, blood glucose, and hemoglobin (all at presentation), and a PDR on EEG. This model had excellent discrimination for predicting in-hospital survival (area under the curve [AUC] 0.815) and recovery of command following (AUC 0.700).

**CONCLUSIONS** A PDR on EEG in sTBI patients predicts favorable outcomes. The authors' prognostic model has strong accuracy in predicting these outcomes, and performed better than previously reported models. The authors' model can be valuable in clinical decision-making as well as counseling families following these types of injuries.

https://thejns.org/doi/abs/10.3171/2023.4.JNS23569

KEYWORDS traumatic brain injury; electroencephalography; posterior dominant rhythm; prognosis; survival; functional

EVERE traumatic brain injury (sTBI) is common and often results in devastating neurological injury.<sup>1-3</sup> Given this population's heterogeneity of injury and recovery patterns, many patients require long-term care, underscoring the exorbitant economic and societal burden

of sTBI. Even so, many patients demonstrate remarkable recovery and achieve a reasonable quality of life following their injury. Given the range of possible outcomes, it is difficult to predict recovery after traumatic brain injury

ABBREVIATIONS AUC = area under the curve; CRASH = Medical Research Council Corticosteroid Randomisation After Significant Head Injury; EEG = electroencephalography; EMR = electronic medical record; GCS = Glasgow Coma Scale; GOS-E = Glasgow Outcome Scale-Extended; IMPACT = International Mission for Prognosis and Analysis of Clinical Trials; PDR = posterior dominant rhythm; ROC = receiver operating characteristic; SAH = subarachnoid hemorrhage; SBP = systolic blood pressure; sTBI = severe TBI; TBI = traumatic brain injury.

SUBMITTED March 13, 2023. ACCEPTED April 21, 2023.

INCLUDE WHEN CITING Published online June 9, 2023; DOI: 10.3171/2023.4.JNS23569.

There are several models that prognosticate outcomes after TBI. These include models that incorporate imaging findings, initial laboratory studies, and/or demographic information.4–8 However, few are simple enough to achieve widespread clinical use, especially in low- and middleincome countries, where most TBIs occur.9 There are two models that are used most frequently: MRC-CRASH (Medical Research Council Corticosteroid Randomisation After Significant Head Injury; hereafter CRASH) and IMPACT (International Mission for Prognosis and Analysis of Clinical Trials).4,5 Both CRASH and IMPACT are based on data from the late 20th century and thousands of cases across North America.4,5 However, calibration of these models has revealed disagreement between observed and predicted outcomes.10,11 Some have argued that this discordance is a byproduct of more recent advancements in the treatment of TBI patients,11–13 thus underscoring the continued need for improving existing models to provide accurate predictions.

Presently, continuous electroencephalography (EEG) after acute brain injury is used to assess for nonconvulsive seizures or nonconvulsive status epilepticus, which occur in approximately 30% of the sTBI population and are associated with increased morbidity, mortality, longterm cognitive decline, and future seizure development, should patients survive their injury.14–18 Other indications for continuous EEG in this population include assessment of seizure therapy efficacy, ischemia identification, and level of consciousness assessment in pharmacologically induced comas.18 Moreover, continuous EEG in post-TBI seizure monitoring provides a unique opportunity to assess the global brain functional state in these patients. This is often done by examining the dominant frequencies present in the EEG recordings. On EEG, healthy adults generally display desynchronized activity, with relatively low-amplitude background rhythms consisting of mixed frequencies (alpha, beta, delta, and theta bands).19 Of the canonical frequency bands, higher frequencies such as the alpha (approximately 8–12 Hz) and beta (approximately 15–30 Hz) bands have been associated with recovery of consciousness.20 The posterior dominant rhythm (PDR) is an alpha-band signal that is most prominent in posterior EEG contacts, which is associated with quiet wakefulness when a patient is relaxed with their eyes closed. The PDR is decreased in amplitude and frequency compared with a normal EEG background and often entirely disappears with eye opening.19 Previous efforts to incorporate EEG data into TBI outcome predictions have demonstrated that increased alpha power and variability in EEG frequencies were associated with better functional outcomes.21 Other studies have reported a gradual increase in the PDR of approximately 1–2 Hz in the subacute period, as it returns to baseline following the acute posttraumatic slowing.22,23 As a marker for thalamocortical integrity, the presence of a PDR is associated with survival and better functional outcomes following moderate to severe TBI and other acute insults.24–26 Despite this, a TBI prognostic model incorporating this EEG signature has not been developed.

Thus, we reasoned that a discernable PDR found on EEG monitoring of sTBI patients would indicate better outcomes both in the hospital and following discharge. To investigate this, we retrospectively analyzed a cohort of sTBI patients admitted to our university hospital and evaluated their outcomes based on whether they displayed a PDR during EEG monitoring. We then compared these outcomes with predictions from existing calculators such as IMPACT and CRASH to evaluate the utility of this EEG finding in prognostication. Finally, we developed a novel prognostic model for sTBI outcome prediction that incorporates the presence of a PDR and examined the model's performance.

## **Methods**

#### **Ethics Statement**

This retrospective study was approved by the Stony Brook University Institutional Review Board, and consent was waivered due to the retrospective nature of the study.

#### **Data Analysis**

All data were analyzed using IBM SPSS Statistics version 26 (IBM Corp.). We compared means and frequencies using independent-samples t-tests and chi-square or Fisher's exact tests, respectively. The significance level was set at 5% (two-tailed) for all analyses.

### **Patient Selection**

All information was gathered retrospectively from the electronic medical record (EMR). We reviewed the records of 633 adult (≥ 18 years of age) patients with sTBI (initial Glasgow Coma Scale [GCS] score ≤ 8)27 who presented to our institution's level I trauma center between 2010 and 2021. A total of 246 patients underwent EEG during their hospital stay. During the study period, EEG monitoring was used as medically indicated to detect nonconvulsive seizures or nonconvulsive status epilepticus after acute brain injury, which are not clinically apparent in severely injured patients requiring intensive care unit admission.17 We excluded patients whose initial EEG study was obtained ≥ 30 days after admission (n = 8) and patients who were extubated at the time of EEG recording (n = 43), resulting in a final study population of 195 patients. We then separated these patients based on the presence of a PDR on EEG, yielding two cohorts: patients without a PDR (PDR[−], n = 144) and those with a PDR (PDR[+], n = 51). Figure 1 visualizes this process. All EEG recordings were reviewed by board-certified neurologists or clinical neurophysiologists, and they identified the PDR as an 8- to 13-Hz rhythm most evident on posterior channels.

#### **Patient Characteristics**

Baseline demographic, clinical, radiological, and electrophysiological data were collected for all patients to assess potential differences between cohorts and to create a novel prognostic model. The most relevant presenting variables are displayed in Table 1. Imaging findings were gathered from the initial head CT scan reports performed by qualified radiologists. EEG characteristics were collected from reports written by qualified epileptologists. Additional presenting clinical and radiographic data are displayed in [Supplementary Table 1.](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569) Overall, we consid-

**FIG. 1.** Patient selection and categorization flowchart.

ered 73 variables. Finally, we recorded and compared usage frequencies of the various sedating medications administered to patients during EEG recording (Table 2). This aspect of our study had no missing data.

## **Outcome Assessment**

We evaluated patient outcomes between the PDR(+) and PDR(−) cohorts by assessing in-hospital survival, recovery of command following, Glasgow Outcome Scale– Extended (GOS-E) score at discharge, and GOS-E score at 6 months post discharge. These measures were chosen to provide a comprehensive summary of patient outcomes following sTBI and to compare them with the IMPACT and CRASH model predictions.4,5 GOS-E scores were strictly determined based on EMR documentation consistent with the GOS-E–defined framework.<sup>7</sup> Information was gathered from any physician, nursing, physical and occupational therapy, and other ancillary staff EMR documentation. For the 6-month GOS-E score assessment, we accepted documentation within 4 weeks of the 6-month time point. At this time point, 49 patients (25% of the total study population) were lost to follow-up and thus lacked EMR documentation past discharge. For statistical analysis, GOS-E scores were also dichotomized as unfavorable (1–4; dead, vegetative, and severe disability) and favorable (5–8; moderate disability and good recovery).

### **CRASH and IMPACT Predictions**

To assess whether the CRASH or IMPACT models would have predicted different outcomes between the PDR(−) and PDR(+) cohorts, we calculated CRASH-CT, IMPACT-Core, IMPACT-CT, and IMPACT-Lab outcome probabilities for each patient using the publicly available prediction calculators.4,5 We chose to calculate CRASH-CT outcome probabilities only, not CRASH-Core, as it has greater discriminative power than the CRASH-Core model for predicting 14-day mortality and 6-month unfavorable outcomes, and because head CT information was available for our entire patient population.10 Table 3 displays the actual patient outcomes, and the CRASH- and IMPACT-predicted outcomes.

#### **Prognostic Model Creation and Analysis**

We used the AutoScore program in RStudio (version 4.2.1; https://posit.co) to create our prognostic model.28,29 AutoScore is a machine learning–based systematic and automatic clinical score generator that has demonstrated superiority (predictive performance and interpretability) over other conventional methods of clinical score and predictive model creation (i.e., logistic regression, stepwise regression, least absolute shrinkage, selection operator, and random forest).28

First, we used the AutoScore binary program to rank each collected variable in isolation for its ability to predict in-hospital survival and recovery of command following separately. The entire data set from the total study population (n = 195) was randomly split into a training/validation set (70%) and a testing set (30%). AutoScore then produced two parsimony plots that listed the most predictive variables for each outcome from most to least determinant. We then identified 7 variables highly conserved as the most determinant variables across both outcomes to create a single model capable of predicting in-hospital survival and recovery of command following. The 7 variables were age, BMI, systolic blood pressure (SBP), pupil reactivity, glucose, hemoglobin, and a PDR. The final prognostic model scoring chart is displayed in Table 4. Individual patients can be scored using Table 4, and their score can be converted into the probability of achieving the outcome of interest using Fig. 2A. Figure 2B shows the proportion of our final study population that achieved

**TABLE 1. Patient demographics, clinical, imaging, and EEG information**

|                                                   | All Patients  | PDR(−)         | PDR(+)         | p Value* |
|---------------------------------------------------|---------------|----------------|----------------|----------|
| No. of patients                                   | 195           | 144            | 51             |          |
| Demographics                                      |               |                |                |          |
| Mean age at injury, yrs                           | 48.83 (20.02) | 47.03 (19.34)  | 53.88 (21.23)  | 0.046    |
| Mean BMI                                          | 26.31 (5.10)  | 26.58 (5.35)   | 25.55 (4.26)   | 0.169    |
| Male sex                                          | 146 (74.9%)   | 111 (77.1%)    | 35 (68.6%)     | 0.232    |
| Race, NIH standard                                |               |                |                |          |
| Asian                                             | 3 (1.5%)      | 3 (2.1%)       | 0              | 0.568    |
| Black or African American                         | 27 (13.8%)    | 22 (15.3%)     | 5 (9.8%)       | 0.331    |
| White                                             | 150 (76.9%)   | 106 (73.6%)    | 44 (86.3%)     | 0.065    |
| Native Hawaiian or Other Pacific Islander         | 0             | 0              | 0              |          |
| American Indian or Alaska Native                  | 0             | 0              | 0              |          |
| Ethnicity, NIH standard                           |               |                |                |          |
| Hispanic or Latino                                | 27 (13.8%)    | 22 (15.3%)     | 5 (9.8%)       | 0.331    |
| Pupil reactivity                                  |               |                |                |          |
| Bilateral reactivity                              | 136 (69.7%)   | 97 (67.4%)     | 39 (76.5%)     | 0.224    |
| Unilateral reactivity                             | 14 (7.2%)     | 10 (6.9%)      | 4 (7.8%)       | 0.762    |
| Nonreactive                                       | 45 (23.1%)    | 37 (25.7%)     | 8 (15.7%)      | 0.145    |
| Presentation vitals, labs, & imaging information  |               |                |                |          |
| Mean SBP, mmHg                                    | 133.8 (33.78) | 131.64 (34.10) | 139.90 (32.42) | 0.126    |
| Mean glucose, mg/dL                               | 173.52 (74.1) | 178.90 (80.09) | 158.33 (51.27) | 0.038    |
| Mean hemoglobin, g/dL                             | 12.91 (2.22)  | 13.00 (2.21)   | 12.63 (2.24)   | 0.311    |
| Mean Injury Severity Score                        | 31.59 (13.7)  | 32.67 (14.10)  | 28.55 (12.28)  | 0.051    |
| Mean initial GCS score                            | 4.17 (1.64)   | 4.03 (1.56)    | 4.55 (1.79)    | 0.054    |
| Mean initial GCS motor subscore                   | 2.09 (1.51)   | 1.97 (1.45)    | 2.45 (1.64)    | 0.048    |
| Mean initial GCS eye subscore                     | 1.08 (0.32)   | 1.07 (0.31)    | 1.10 (0.36)    | 0.615    |
| Mean Marshall CT score                            | 3.73 (1.49)   | 3.80 (1.49)    | 3.55 (1.50)    | 0.309    |
| Hemorrhage type                                   |               |                |                |          |
| Any SAH                                           | 131 (67.2%)   | 103 (71.5%)    | 28 (54.9%)     | 0.030    |
| Right SAH                                         | 110 (56.4%)   | 89 (61.8%)     | 21 (41.2%)     | 0.011    |
| Any epidural hemorrhage                           | 15 (7.7%)     | 12 (8.3%)      | 3 (5.9%)       | 0.763    |
| Petechial/punctuate hemorrhages                   | 31 (15.9%)    | 26 (18.1%)     | 5 (9.8%)       | 0.166    |
| Obliteration of 3rd ventricle &/or basal cisterns | 58 (29.7%)    | 44 (30.6%)     | 14 (27.5%)     | 0.677    |
| Nonevacuated hematoma                             | 12 (6.2%)     | 10 (6.9%)      | 2 (3.9%)       | 0.735    |
| Midline shift                                     | 57 (29.2%)    | 42 (29.2%)     | 15 (29.4%)     | 0.974    |
| Major extracranial injury                         | 128 (65.6%)   | 96 (66.7%)     | 32 (62.7%)     | 0.612    |
| EEG statistics                                    |               |                |                |          |
| Mean time to initial EEG after sTBI, days         | 4.18 (4.9)    | 3.93 (4.7)     | 4.88 (5.4)     | 0.267    |
| Median time to initial EEG after sTBI, days       | 2 [4]         | 2 [4]          | 3 [6]          |          |
| Minimum time to initial EEG after sTBI, days      | 0             | 0              | 0              |          |
| Maximum time to initial EEG after sTBI, days      | 25            | 25             | 24             |          |

NIH = National Institutes of Health.

a given score in the model. We calculated the model's performance metrics for predicting in-hospital survival and recovery of command following and internally cross-validated the model using a 10-sample bootstrapped analysis in AutoScore.28 Table 5 displays the model's performance metrics for both the initial training/validation and final testing sets. The receiver operating characteristic (ROC) curves for both models are displayed in Fig. 3. To assess for differences between observed and predicted outcomes, we also calibrated the model using the Hosmer-Lemeshow test in IBM SPSS (IBM Corp.) (Table 5).

Binary logistic regressions were also performed in

Values are expressed as number (%) of patients, mean (SD), or median [IQR].

<sup>\*</sup> Independent-samples t-test for continuous variables and chi-square or Fisher's exact test for frequencies.

**TABLE 2. Comparison of sedating medications administered to patients during EEG recording**

| Medication       | PDR(−) (n = 144) | PDR(+) (n = 51) | p Value* |
|------------------|------------------|-----------------|----------|
| Levetiracetam    | 80 (55.6%)       | 29 (56.9%)      | 0.872    |
| Propofol         | 74 (51.4%)       | 11 (21.6%)      | <0.001   |
| Dexmedetomidine  | 6 (4.2%)         | 3 (5.9%)        | 0.699    |
| Fentanyl         | 68 (47.2%)       | 13 (25.5%)      | 0.007    |
| Amantadine       | 0                | 1 (2.0%)        | 0.262    |
| Clobazam         | 0                | 1 (2.0%)        | 0.262    |
| Diazepam         | 1 (0.7%)         | 0               | >0.999   |
| Fosphenytoin     | 8 (5.6%)         | 4 (7.8%)        | 0.516    |
| Lacosamide       | 0                | 1 (2.0%)        | 0.262    |
| Lorazepam        | 1 (0.7%)         | 3 (5.9%)        | 0.056    |
| Midazolam        | 0                | 2 (3.9%)        | 0.067    |
| Phenytoin        | 2 (1.4%)         | 0               | >0.999   |
| Quetiapine       | 0                | 1 (2.0%)        | 0.262    |
| Sodium valproate | 0                | 2 (3.9%)        | 0.067    |
| Trazodone        | 0                | 1 (2.0%)        | 0.262    |
| Clonidine        | 1 (0.7%)         | 1 (2.0%)        | 0.456    |
| No medications   | 7 (4.9%)         | 6 (11.8%)       | 0.106    |

Values are expressed as number (%) of each cohort actively receiving the said medication during EEG recording.

IBM SPSS to ascertain the effects of the 7 chosen variables on in-hospital survival and recovery of command following. This was done to compare our model with more traditional univariate methods. The results are outlined below and further detailed in [Supplementary Tables](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569) [2 and 3](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569).

## **Results**

#### **General Characteristics**

Patient characteristics for our entire population and the PDR(−) and PDR(+) cohorts are detailed in Table 1 and [Supplementary Table 1](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569). There were no significant differences in mean BMI, sex, race, ethnicity, or mechanism of injury between the two cohorts. However, the PDR(+) cohort was significantly older (p = 0.046) and had a significantly higher GCS motor subscore (p = 0.048). The PDR(−) cohort was significantly more likely to have rightsided subarachnoid hemorrhage (SAH) on CT (p = 0.011) or any SAH (p = 0.030). The PDR(−) cohort also had significantly higher mean glucose (p = 0.038). There were no other significant differences in presentation between the PDR(−) and PDR(+) cohorts. Notably, there was no significant difference in the mean number of days to initial EEG between cohorts.

## **Superior Outcomes in PDR(+) Patients**

Table 3 shows actual patient outcome results and CRASH and IMPACT outcome predictions (expressed as the mean probability [%] of the outcome of interest) for all patients and the PDR(−) and PDR(+) cohorts. We investigated four outcomes of interest: in-hospital survival, recovery of command following, GOS-E score at discharge, and GOS-E score at 6 months post discharge. For the 6-month GOS-E score comparison, 33 (22.9%) PDR(−) patients and 16 (31.4%) PDR(+) patients were lost to follow-up and lacked EMR documentation past discharge (p

**TABLE 3. Comparison of actual and predicted patient outcomes**

|                                                       | All Patients (n = 195) | PDR(−) (n = 144) | PDR(+) (n = 51) | p Value* |
|-------------------------------------------------------|------------------------|------------------|-----------------|----------|
| True outcomes                                         |                        |                  |                 |          |
| In-hospital survival                                  | 135 (69.2%)            | 92 (63.9%)       | 43 (84.3%)      | 0.007    |
| Mean discharge GOS-E score                            | 2.55 (1.37)            | 2.39 (1.33)      | 3.00 (1.4)      | 0.006    |
| Favorable discharge GOS-E score                       | 10 (5.1%)              | 5 (3.5%)         | 5 (9.8%)        | 0.131    |
| Mean 6-mo GOS-E score†                                | 3.42 (2.47)            | 3.31 (2.49)      | 3.77 (2.40)     | 0.326    |
| Favorable 6-mo GOS-E score†                           | 48 (32.9%)             | 38 (34.2%)       | 10 (28.6%)      | 0.534    |
| Recovery of command following                         | 116 (59.5%)            | 77 (53.5%)       | 39 (76.5%)      | 0.004    |
| Mean length of stay, days                             | 38.69 (54.6)           | 39.52 (59.6)     | 36.33 (37.4)    | 0.659    |
| Predicted outcomes                                    |                        |                  |                 |          |
| Mean CRASH-CT 14-day mortality probability            | 40.69 (26.8)           | 40.79 (26.92)    | 40.41 (26.57)   | 0.930    |
| Mean CRASH-CT 6-mo unfavorable outcome probability    | 72.53 (20.0)           | 72.53 (19.45)    | 72.53 (21.82)   | 0.999    |
| Mean IMPACT-Core 6-mo mortality probability           | 49.25 (20.70)          | 49.74 (20.96)    | 47.86 (20.08)   | 0.571    |
| Mean IMPACT-Core 6-mo unfavorable outcome probability | 63.31 (19.7)           | 63.47 (20.02)    | 62.88 (18.95)   | 0.853    |
| Mean IMPACT-CT 6-mo mortality probability             | 42.74 (20.2)           | 43.19 (20.43)    | 41.49 (19.77)   | 0.603    |
| Mean IMPACT-CT 6-mo unfavorable outcome probability   | 58.76 (20.0)           | 58.94 (20.23)    | 58.25 (19.31)   | 0.831    |
| Mean IMPACT-Lab 6-mo mortality probability            | 37.84 (18.2)           | 38.96 (18.41)    | 34.67 (17.50)   | 0.141    |
| Mean IMPACT-Lab 6-mo unfavorable outcome probability  | 57.07 (20.0)           | 57.67 (20.20)    | 55.35 (19.63)   | 0.473    |

Values are expressed as number (%) of patients or mean (SD).

<sup>\*</sup> Chi-square or Fisher's exact test.

<sup>\*</sup> Independent-samples t-test for continuous variables and chi-square or Fisher's exact test for frequencies.

<sup>†</sup> A total of 146 patients were included for 6-month GOS-E score comparison (49 [25%] patients were lost to follow-up).

**TABLE 4. Novel prognostic model scoring table**

|                                                          | In-Hospital<br>Survival<br>Score | Recovery of<br>Command<br>Following Score |
|----------------------------------------------------------|----------------------------------|-------------------------------------------|
| Age at injury, yrs                                       |                                  |                                           |
| <34                                                      | 25                               | 18                                        |
| ≥34 to <52                                               | 23                               | 18                                        |
| ≥52 to <64                                               | 22                               | 14                                        |
| ≥64                                                      | 0                                | 0                                         |
| BMI, kg/m2                                               |                                  |                                           |
| <23.1                                                    | 12                               | 14                                        |
| ≥23.1 to <26                                             | 10                               | 14                                        |
| ≥26 to <28.3                                             | 1                                | 0                                         |
| ≥28.3                                                    | 0                                | 5                                         |
| SBP, mm Hg                                               |                                  |                                           |
| <110                                                     | 0                                | 0                                         |
| ≥110 to <132                                             | 3                                | 9                                         |
| ≥132 to <152                                             | 7                                | 14                                        |
| ≥152                                                     | 17                               | 14                                        |
| Pupil reactivity                                         |                                  |                                           |
| Bilateral or unilateral reactivity                       | 16                               | 5                                         |
| Nonreactive                                              | 0                                | 0                                         |
| Glucose, mg/dL                                           |                                  |                                           |
| <135                                                     | 2                                | 18                                        |
| ≥135 to <163                                             | 7                                | 5                                         |
| ≥163 to <205                                             | 3                                | 14                                        |
| ≥205                                                     | 0                                | 0                                         |
| Hemoglobin on presentation, g/dL                         |                                  |                                           |
| <11.6                                                    | 0                                | 0                                         |
| ≥11.6 to <13                                             | 2                                | 14                                        |
| ≥13 to <14.4                                             | 0                                | 9                                         |
| ≥14.4                                                    | 7                                | 8                                         |
| Posterior dominant rhythm on<br>EEG (<30 days from sTBI) |                                  |                                           |
| Yes                                                      | 18                               | 14                                        |
| No                                                       | 0                                | 0                                         |
| Sum total score                                          |                                  |                                           |

To score an individual patient, choose the row for each variable that corresponds to the said patient. Then, sum their 7 subscores in the final row labeled "Sum total score." The sum total score can be converted into the probability of the corresponding outcome using Fig. 2A.

> 0.05). Importantly, there was no difference in length of stay. However, the PDR(+) cohort displayed significantly better outcomes overall. The PDR(+) cohort displayed increased rates of in-hospital survival (84.3% vs 63.9%, p = 0.007) and recovery of command following (76.5% vs 53.5%, p = 0.004). Regarding functional status, PDR(+) patients had significantly higher mean GOS-E scores at discharge (p = 0.006); however, there was no significant difference in mean GOS-E 6 months post discharge, but many patients were lost to follow-up.

#### **Overprediction of Mortality and Unfavorable Outcomes by Previous TBI Prognostic Models**

Next, we investigated whether the IMPACT and CRASH models could capture the same differences we observed when stratifying according to EEG findings. We generated outcome probabilities for the PDR(+) and PDR(−) cohorts from both the CRASH and IMPACT predictive calculators (Table 3).4,5 There were no significant differences in predicted outcomes for the two groups from CRASH-CT, IMPACT-Core, IMPACT-CT, and IMPACT-Lab (Table 3).4,5

### **Prognostic Model Performance**

We then created a prognostic model capable of predicting the probability of both in-hospital survival and recovery of command following using individual patient characteristics. Based on AutoScore's importance rankings and parsimony plots, the presence of a PDR was the 7th and 9th most important variable (of the 73 collected) for predicting in-hospital survival and recovery of command following, respectively. The discriminative power of a prognostic model is measured using the area under the curve (AUC) obtained from the ROC curve (Fig. 3). After 10-fold cross-validation via bootstrapping and performance evaluation using the randomized 30% testing set, the AUC was excellent for predicting in-hospital survival (AUC 0.815) and recovery of command following (AUC 0.700). Additionally, for both outcomes (in-hospital survival and recovery of command following), our model also demonstrated relatively high sensitivity (0.756 and 0.824, respectively), specificity (0.824 and 0.542), positive predictive value (0.912 and 0.718), and negative predictive value (0.583 and 0.688) on the testing set (Table 5).

Binary logistic regressions were also performed to ascertain the effects of the 7 chosen variables on in-hospital survival and recovery of command following. The results are displayed in [Supplementary Tables 2 and 3.](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569) With use of these methods, a PDR was significantly predictive of in-hospital survival (OR 3.320, p = 0.014) and recovery of command following (OR 2.752, p = 0.014).

#### **Potential Pharmacological Confounders**

To explore the effect of potential pharmacological confounders, we assessed the percentage of patients in each cohort that actively received sedating medications during EEG acquisition (Table 2). Significantly more patients in the PDR(−) cohort received propofol (p < 0.001) and fentanyl (p = 0.007). There were no other significant differences in potentially sedating drug use during EEG recording.

#### **Propofol Subgroup Analysis**

To further investigate whether our effects were because of sedatives, we compared the outcomes between the propofol-sedated patients in the PDR(+) (n = 11) and PDR(−) (n = 74) cohorts. This analysis showed that the propofolsedated PDR(+) cohort had a significantly higher mean discharge GOS-E score (3.73 vs 2.58, p = 0.044) and was significantly more likely to have a favorable GOS-E score at discharge (100% [n = 11] vs 62.2% [n = 46], p = 0.013)

**FIG. 2.** Converting the sum total score to the probability of achieving each outcome. **A:** The sum total score (x-axis) for each outcome can be converted to a probability (y-axis) of achieving the said outcome. For example, a sum total score of 25 for in-hospital survival would represent an approximately 20% chance of that patient surviving to discharge. Points indicate attainable final scores. **B:** Histograms displaying the proportion of our study population that would receive each score.

compared with the propofol-sedated PDR(−) cohort. There was no significant difference (all p > 0.05) between the propofol-sedated PDR(+) and PDR(−) cohorts in rates of in-hospital survival (100% [n = 11] vs 73.0% [n = 54]), recovery of command following (90.9% [n = 10] vs 59.5% [n = 44]), favorable 6-month GOS-E score (54.5% [n = 6] vs 43.2% [n = 32]), or mean 6-month GOS-E score (5.50 vs 3.75).

## **Discussion**

#### **PDR Predicts Positive Post-TBI Outcomes**

We sought to determine whether a PDR seen on EEG soon after TBI was a determinant of favorable outcomes (survival, good recovery, etc.). Our results have important implications. First, the PDR(−) cohort was slightly more injured than the PDR(+) cohort, based on only a few met-

rics, as evidenced by a higher rate of SAH and significantly lower admission GCS motor subscore (Table 1). However, on further analysis, there was no difference in the overall GCS score, the GCS eye subscore, or Injury Severity Score. There was also no difference in the Marshall CT score—a CT-based TBI prognostic classifier that considers the necessity for major neurosurgical intervention (hematoma/mass lesion evacuation)—and there was no difference in the rates of major extracranial injuries, defined as a nonneurological injury that in itself would require hospitalization, between cohorts.8 It should also be noted that all patients included had sTBIs with initial GCS scores ≤ 8. Additionally, the mean admission GCS motor subscore for both cohorts was < 3, implying that most patients had extremely poor examination results. Moreover, there were no significant differences in other presenting clinical and radiographic findings, specifically pupil reactivity, midline

**TABLE 5. Predictive model performance**

|                                     | Training/Validation Set                            |                                                              | Testing Set                                         |                                                              |  |
|-------------------------------------|----------------------------------------------------|--------------------------------------------------------------|-----------------------------------------------------|--------------------------------------------------------------|--|
|                                     | In-Hospital Survival (best<br>score threshold ≥40) | Recovery of Command Following<br>(best score threshold ≥ 54) | In-Hospital Survival (best<br>score threshold ≥ 53) | Recovery of Command Following<br>(best score threshold ≥ 60) |  |
| AUC                                 | 0.803 (0.721–0.885)                                | 0.779 (0.696–0.861)                                          | 0.815 (0.689–0.941)                                 | 0.700 (0.563–0.838)                                          |  |
| Sensitivity                         | 0.894                                              | 0.793                                                        | 0.756 (0.634–0.878)                                 | 0.824 (0.706–0.941)                                          |  |
| Specificity                         | 0.628                                              | 0.709                                                        | 0.824 (0.647–1)                                     | 0.542 (0.333–0.75)                                           |  |
| Positive predictive value           | 0.84                                               | 0.803                                                        | 0.912 (0.829–1)                                     | 0.718 (0.628–0.818)                                          |  |
| Negative predictive value           | 0.730                                              | 0.696                                                        | 0.583 (0.462–0.75)                                  | 0.688 (0.520–0.867)                                          |  |
|                                     | In-Hospital Survival                               | Recovery of Command Following                                |                                                     |                                                              |  |
| Hosmer-Lemeshow<br>calibration test |                                                    |                                                              |                                                     |                                                              |  |
| Chi-square value                    | 3.884                                              | 8.553                                                        |                                                     |                                                              |  |
| p value                             | 0.867                                              | 0.381                                                        |                                                     |                                                              |  |

Performance metrics are based on the training/validation set and the final testing set. Values in parentheses are 95% confidence intervals calculated based on only the final testing set. The best score threshold is the sum total score cutoff yielding the best performance metrics (automatically calculated by AutoScore). The Hosmer-Lemeshow test is based on the entire study population (n = 195).

**FIG. 3.** ROC curves for each model. **A:** ROC curve for determining in-hospital survival when our model is assessed using the 70% training/validation set. **B:** ROC curve for determining recovery of command following when our model is assessed using the 70% training/validation set. **C:** ROC curve for determining in-hospital survival when our model is assessed using the 30% testing set. **D:** ROC curve for determining recovery of command following when our model is assessed using the 30% testing set.

shift, obliteration of third ventricles and/or basal cisterns, epidural hemorrhage, and more (Table 1 and [Supplemen](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569)[tary Table 1](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569)). All these findings are reported to be highly determinant of TBI outcomes.4,5,9–11 Lastly, the PDR(−) cohort had a higher mean glucose on admission, which has been linked to worse TBI outcomes.30

Furthermore, none of the six CRASH and IMPACT predictive models used to compare the PDR(−) and PDR(+) cohorts predicted the PDR(+) to have significantly better outcomes (Table 3). This contrasts with our observed findings that the PDR(+) cohort was significantly more likely to achieve in-hospital survival, recover the ability to follow commands during hospitalization, and have a favorable GOS-E score at discharge. This indicates that not only were patients with an early PDR noted on EEG more likely to survive, but also at discharge they had superior functional capacity, signaling increased potential to recover. This complements the finding that no significant difference in length of stay was seen between cohorts. Thus, we conclude that the PDR(+) cohort had more favorable outcomes than the PDR(−) cohort.

Notably, important differences exist between our model and the CRASH and IMPACT models. First, the CRASH and IMPACT models predict 6-month outcomes based solely on data from the initial presentation. Conversely, our model uses presenting information (age, BMI, SBP, glucose, hemoglobin, and pupil reactivity) and information after patients have been treated (PDR on EEG). Our aim in using the CRASH and IMPACT models to compare the PDR(−) and PDR(+) cohorts was not to prove our model's superiority, but rather, we hoped to show that prognosticating based on presenting findings alone may underpredict favorable outcomes. While we excluded patients with EEG recordings obtained > 30 days from sTBI, most patients in our study underwent EEG very soon after injury (see Table 1). We believe that our model accurately predicts favorable in-hospital outcomes after sTBI, and that using it alongside other validated models will immensely aid clinical decision-making.

Moreover, in isolation, the presence of a PDR on EEG < 30 days from injury was the 7th and 9th most discriminant individual variable for predicting in-hospital survival and recovery of command following, respectively, of the 72 other variables considered. Across both outcomes, a PDR on EEG remained a top predictive indicator of favorable outcomes after sTBI. When more traditional univariate methods were performed for comparison with our AutoScore-generated model, again, the PDR remained significantly and highly predictive of both outcomes. Taken together, our results support a role in assessing the presence of a PDR, a routine component of seizure monitoring, in prognosticating TBI.

### **Addressing Potential Pharmacological Confounders**

When assessing potential pharmacological confounders, we found that the PDR(−) cohort was significantly more likely to be treated with propofol and/or fentanyl during EEG recording. When we further investigated this via a propofol-only subgroup analysis, the PDR(+) patients who received propofol had significantly better functional outcomes (GOS-E score) at discharge. Although there were no significant differences in in-hospital survival, recovery of command following, and 6-month GOS-E score, the marginally significant p values and a clear favorable trend toward improved outcomes in the PDR(+) patients who received propofol compared with their PDR(−) counterparts would still suggest the validity of using this EEG signature for sTBI prognostication in propofol-receiving patients.

Furthermore, fentanyl causes significant slowing of the alpha/PDR but not its disappearance.31,32 While these medications have potential dampening effects on the PDR, future prospective studies that control for their use may prove difficult, as these medications are commonly used following TBI to decrease potentially harmful agitation and/or to complement lifesaving treatment for increased intracranial pressure.33

#### **Predictive Model Performance**

While the historical usefulness of the CRASH and IMPACT predictive models is unquestionable, advancements in TBI treatment have improved considerably since the late 20th century. Thus, a novel prognostic model, possessing clinician friendliness and economic generalizability is needed. Our model is suitable for this purpose. Our proposed model had excellent discrimination for predicting both in-hospital survival and recovery of command following. When tested, our model's expected (predicted) outcomes did not significantly differ from observed outcomes, indicating excellent calibration (Table 5). We hope to externally validate our model with other data sets, as has been done with the CRASH and IMPACT models, in low-, middle-, and high-income countries.10–13 Our model also has relatively high sensitivity, specificity, positive predictive value, and negative predictive value for predicting both outcomes (Table 5). An interactive predictive calculator of our model is in development on our laboratory website (https://renaissance.stonybrookmedicine.edu/ neurosurgery/mofakham-mikell-lab). Overall, we believe that our model is extremely capable of predicting TBI outcomes in countries of varying socioeconomic status, with the benefit of being clinician-friendly, as the clinical data points are routinely assessed in all TBI patients, and EEG recording to assess for a PDR is more cost-effective than repeated CT imaging.

#### **Predictive Model Patient Example**

To describe our model's use, we present the following patient from our study population. After the presentation of a variable incorporated in our model, the corresponding subscores will be listed in parentheses as in-hospital survival points/recovery of command following points. A 47-year-old (23/18) man presented following a motor vehicle accident with a GCS score of 3. On presentation, his SBP was 151 mm Hg (7/14), his glucose was 126 mg/dL (2/18), and his hemoglobin was 14.7 g/dL (7/8). His pupils were unilaterally reactive (16/5), and his BMI was 28.34 kg/m<sup>2</sup> (0/5). Four days after sTBI, he was found to have a PDR on EEG (18/14).

To use our model, we sum the 7 subscores and convert the sum total scores to the probability of achieving the corresponding outcome. This patient's sum total score for in-hospital survival is 73, which correlates to a 95.5% probability of this outcome. His sum total score for recovery of command following is 82, which correlates to an 80.9% probability of this outcome. This patient recovered command following abilities on hospital day 23 and was discharged to a rehabilitation facility 48 days after sTBI.

#### **Limitations**

Our prognostic model's main limitation is the lack of external validation. The data used to construct our model were obtained from a single center. While we believe our sample size and period (2010–2021) provide sufficient power to propose this model, we acknowledge that external validation is vital to proving its validity and accuracy. We also acknowledge that our model was created using a retrospective cohort of sTBI patients and that testing in a prospective group of patients is critical for model validation. In the future, we aim to test our model on prospective groups of patients at our institution and others through collaboration.

How we calculated GOS-E scores should also be considered. While CRASH assessed patients prospectively through telephone calls, we retrospectively analyzed EMR documentation to perform GOS-E score evaluation.4 Our method was similar to that used in the IMPACT models.4,5 Importantly, in the IMPACT models, 3-month GOS scores were substituted when 6-month GOS score assessments were not available (n = 1611; 19% of patients),<sup>5</sup> while we used documentation within 4 weeks of the 6-month post discharge date when documentation on that date was unavailable. For some patients (n = 49; 25% of the study population), we were unable to calculate a GOS-E score at 6 months post discharge. In all cases, this was because of a lack of follow-up; however, we found no significant difference in lack of follow-up between the PDR(+) and PDR(−) cohorts.

#### **Future Research**

Future studies should externally validate our findings and prognostic model in larger cohorts of patients from high-, middle-, and low-income countries. Moreover, prospective validation of our model is necessary to further support its accuracy and clinical use. Furthermore, future studies should prospectively investigate how various sedating medications, or a lack thereof, may alter the presence of a PDR following TBI. While quantitative EEG and EEG power spectral analysis appear promising as diagnostic tools for TBI,34 these specialized analyses might not be available at all institutions. Despite this, further research should also investigate the use of EEG power spectral analysis and quantitative EEG metrics to predict post-TBI outcomes.

## **Conclusions**

This study demonstrated that a PDR improves the accuracy of predicting in-hospital survival and favorable functional outcomes, such as the recovery of command following abilities, after sTBIs. We also incorporated the presence of this EEG signature into a novel predictive model that has high accuracy and precision for predicting these outcomes. As sTBI treatments change rapidly, clinical decision-making tools need to evolve accordingly. Overall, we believe that our results and predictive model will benefit clinicians and decision-makers.

## **Acknowledgments**

We thank the Department of Neurological Surgery at Stony Brook University Hospital for supporting this research and for their tireless treatment of our patients. We also thank Kevin Gilotra, BS, and Claire Polizu, BS, for their contributions to this investigation. Lastly, we would like to thank the Stony Brook University Hospital Departments of Neurology and Radiology for their electrophysiologic and radiologic interpretations used in this study.

This work was funded by the Growing Convergence Research program from the National Science Foundation (award no. 2021002), a FUSION-TRO award from the Renaissance School of Medicine at Stony Brook University (award no. 63845), and SEED grant funding from the Office of the Vice President for Research at Stony Brook University (award no. 93214).

## **References**

- 1. TBI data. CDC.gov. Accessed May 5, 2023. https://www.cdc. gov/traumaticbraininjury/data/
- 2. Galgano M, Toshkezi G, Qiu X, Russell T, Chin L, Zhao LR. Traumatic brain injury: current treatment strategies and future endeavors. *Cell Transplant*. 2017;26(7):1118-1130.
- 3. Capizzi A, Woo J, Verduzco-Gutierrez M. Traumatic brain injury: an overview of epidemiology, pathophysiology, and medical management. *Med Clin North Am*. 2020;104(2):213- 238.
- 4. Perel P, Arango M, Clayton T, et al. Predicting outcome after traumatic brain injury: practical prognostic models based on large cohort of international patients. *BMJ*. 2008;336(7641): 425-429.
- 5. Steyerberg EW, Mushkudiani N, Perel P, et al. Predicting outcome after traumatic brain injury: development and international validation of prognostic scores based on admission characteristics. *PLoS Med*. 2008;5(8):e165.
- 6. Winans NJ, Liang JJ, Ashcroft B, et al. Modeling the return to consciousness after severe traumatic brain injury at a large academic level 1 trauma center. J *Neurosurg*. 2020;133(2): 477-485.
- 7. Wilson L, Boase K, Nelson LD, et al. A Manual for the Glasgow Outcome Scale-Extended Interview. *J Neurotrauma*. 2021;38(17):2435-2446.
- 8. Marshall LF, Marshall SB, Klauber MR, et al. A new classification of head injury based on computerized tomography. *J Neurosurg*. 1991;75(suppl):S14-S20.
- 9. Perel P, Edwards P, Wentz R, Roberts I. Systematic review of prognostic models in traumatic brain injury. *BMC Med Inform Decis Mak*. 2006;6:38.
- 10. Wongchareon K, Thompson HJ, Mitchell PH, Barber J, Temkin N. IMPACT and CRASH prognostic models for traumatic brain injury: external validation in a South-American cohort. *Inj Prev*. 2020;26(6):546-554.
- 11. Majdan M, Lingsma HF, Nieboer D, Mauritz W, Rusnak M, Steyerberg EW. Performance of IMPACT, CRASH and

- Nijmegen models in predicting six month outcome of patients with severe or moderate TBI: an external validation study. *Scand J Trauma Resusc Emerg Med*. 2014;22:68.
- 12. Roozenbeek B, Maas AIR, Menon DK. Changing patterns in the epidemiology of traumatic brain injury. *Nat Rev Neurol*. 2013;9(4):231-236.
- 13. Stein SC, Georgoff P, Meghan S, Mizra K, Sonnad SS. 150 years of treating severe traumatic brain injury: a systematic review of progress in mortality. *J Neurotrauma*. 2010;27(7): 1343-1353.
- 14. Annegers JF, Grabow JD, Groover RV, Laws ER Jr, Elveback LR, Kurland LT. Seizures after head trauma: a population study. *Neurology*. 1980;30(7 Pt 1):683-689.
- 15. Sculier C, Gaínza-Lein M, Sánchez Fernández I, Loddenkemper T. Long-term outcomes of status epilepticus: a critical assessment. *Epilepsia*. 2018;59(suppl 2):155-169.
- 16. Ding K, Gupta PK, Diaz-Arrastia R. Epilepsy after traumatic brain injury. In: Laskowitz D, Grant G, eds. *Translational Research in Traumatic Brain Injury*. CRC Press/Taylor & Francis Group; 2016:299-314.
- 17. Comanducci A, Boly M, Claassen J, et al. Clinical and advanced neurophysiology in the prognostic and diagnostic evaluation of disorders of consciousness: review of an IFCNendorsed expert group. *Clin Neurophysiol*. 2020;131(11): 2736-2765.
- 18. Herman ST, Abend NS, Bleck TP, et al. Consensus statement on continuous EEG in critically ill adults and children, part I: indications. *J Clin Neurophysiol*. 2015;32(2):87-95.
- 19. Britton JW, Frey LC, Hopp JL, et al, Frey LC, ed. *Electroencephalography (EEG): An Introductory Text and Atlas of Normal and Abnormal Findings in Adults, Children, and Infants.* American Epilepsy Society; 2016.
- 20. Mofakham S, Fry A, Adachi J, et al. Electrocorticography reveals thalamic control of cortical dynamics following traumatic brain injury. *Commun Biol*. 2021;4(1):1210.
- 21. Pauli R, O'Donnell A, Cruse D. Resting-state electroencephalography for prognosis in disorders of consciousness following traumatic brain injury. *Front Neurol*. 2020;11:586945.
- 22. Koufen H, Dichgans J. Frequency and course of posttraumatic EEG-abnormalities and their correlations with clinical symptoms: a systematic follow up study in 344 adults (author's transl). Article in German. *Fortschr Neurol Psychiatr Grenzgeb*. 1978;46(4):165-177.
- 23. Nuwer MR, Hovda DA, Schrader LM, Vespa PM. Routine and quantitative EEG in mild traumatic brain injury. *Clin Neurophysiol*. 2005;116(9):2001-2025.
- 24. Selioutski O, Roberts D, Hamilton R, et al. Continuous EEG monitoring predicts a clinically meaningful recovery among adult inpatients. *J Clin Neurophysiol*. 2019;36(5):358-364.
- 25. Lee H, Mizrahi MA, Hartings JA, et al. Continuous electroencephalography after moderate to severe Traumatic Brain Injury. *Crit Care Med*. 2019;47(4):574-582.
- 26. Curley WH, Comanducci A, Fecchio M. Conventional and investigational approaches leveraging clinical EEG for prognosis in acute disorders of consciousness. *Semin Neurol*. 2022;42(3):309-324.
- 27. Teasdale G, Jennett B. Assessment of coma and impaired consciousness. A practical scale. *Lancet*. 1974;2(7872):81-84.
- 28. Xie F, Chakraborty B, Ong MEH, Goldstein BA, Liu N. AutoScore: a machine learning-based automatic clinical score generator and its application to mortality prediction using electronic health records. *JMIR Med Inform*. 2020;8(10): e21798.
- 29. *RStudio: Integrated Development for R*. Posit Software; 2023. Accessed May 4, 2023. https://posit.co
- 30. Shi J, Dong B, Mao Y, et al. Review: Traumatic brain injury and hyperglycemia, a potentially modifiable risk factor. *Oncotarget*. 2016;7(43):71052-71061.
- 31. Vijayan S, Ching S, Purdon PL, Brown EN, Kopell NJ. Thal-

- amocortical mechanisms for the anteriorization of α rhythms during propofol-induced unconsciousness. *J Neurosci*. 2013; 33(27):11070-11075.
- 32. Scott JC, Ponganis KV, Stanski DR. EEG quantitation of narcotic effect: the comparative pharmacodynamics of fentanyl and alfentanil. *Anesthesiology*. 1985;62(3):234-241.
- 33. Bratton SL, Chestnut RM, Ghajar J, et al. Guidelines for the management of severe traumatic brain injury. XI. Anesthetics, analgesics, and sedatives. *J Neurotrauma*. 2007;24(suppl 1):S71-S76.
- 34. Ianof JN, Anghinah R. Traumatic brain injury: an EEG point of view. *Dement Neuropsychol*. 2017;11(1):3-5.

#### **Disclosures**

The authors report no conflict of interest concerning the materials or methods used in this study or the findings specified in this paper.

## **Author Contributions**

Conception and design: Mofakham, Cleri, Saadon, Zheng, Mikell. Acquisition of data: Cleri, Saadon, Zheng, Swarna, Zhang, Vagal, Wang, Kleyner. Analysis and interpretation of data: Mofakham, Cleri, Saadon, Zheng, Swarna, Zhang, Vagal, Wang, Kleyner, Mikell. Drafting the article: Mofakham, Cleri, Saadon, Zheng, Mikell. Critically revising the article: Mofakham, Cleri, Mikell.

Reviewed submitted version of manuscript: all authors. Approved the final version of the manuscript on behalf of all authors: Mofakham. Statistical analysis: Mofakham, Cleri, Saadon, Zheng, Mikell. Administrative/technical/material support: Mofakham, Mikell. Study supervision: Mofakham, Mikell.

## **Supplemental Information**

#### Online-Only Content

Supplemental material is available with the online version of the article.

*Supplementary Tables 1–3.* [https://thejns.org/doi/suppl/](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569) [10.3171/2023.4.JNS23569.](https://thejns.org/doi/suppl/10.3171/2023.4.JNS23569)

#### Previous Presentations

This paper was previously presented as a rapid-fire podium talk at the annual conference of the American Association of Neurological Surgeons in Los Angeles, California, on April 24, 2023.

## **Correspondence**

Sima Mofakham: Renaissance School of Medicine at Stony Brook University, Stony Brook, NY. sima.mofakham@ stonybrookmedicine.edu.