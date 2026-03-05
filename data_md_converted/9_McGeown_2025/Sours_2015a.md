BRAIN CONNECTIVITY Volume 5, Number 7, 2015 © Mary Ann Liebert, Inc. DOI: 10.1089/brain.2014.0333

# Investigation of Multiple Frequency Ranges Using Discrete Wavelet Decomposition of Resting-State Functional Connectivity in Mild Traumatic Brain Injury Patients

Chandler Sours,<sup>1,2</sup> Haoxing Chen,<sup>3</sup> Steven Roys,<sup>1,2</sup> Jiachen Zhuo,<sup>1,2</sup> Amitabh Varshney,<sup>4</sup> and Rao P. Gullapalli<sup>1,2</sup>

#### **Abstract**

The aim of this study was to investigate if discrete wavelet decomposition provides additional insight into resting-state processes through the analysis of functional connectivity within specific frequency ranges within the default mode network (DMN) that may be affected by mild traumatic brain injury (mTBI). Participants included 32 mTBI patients (15 with postconcussive syndrome [PCS+] and 17 without [PCS-]). mTBI patients received resting-state functional magnetic resonance imaging (rs-fMRI) at acute (within 10 days of injury) and chronic (6 months postinjury) time points and were compared with 31 controls (healthy control [HC]). The wavelet decomposition divides the time series into multiple frequency ranges based on four scaling factors (SF1: 0.125-0.250 Hz, SF2: 0.060-0.125 Hz, SF3: 0.030-0.060 Hz, SF4: 0.015-0.030 Hz). Within each SF, wavelet connectivity matrices for nodes of the DMN were created for each group (HC, PCS+, PCS-), and bivariate measures of strength and diversity were calculated. The results demonstrate reduced strength of connectivity in PCS+ patients compared with PCS- patients within SF1 during both the acute and chronic stages of injury, as well as recovery of connectivity within SF1 across the two time points. Furthermore, the PCSgroup demonstrated greater network strength compared with controls at both time points, suggesting a potential compensatory or protective mechanism in these patients. These findings stress the importance of investigating resting-state connectivity within multiple frequency ranges; however, many of our findings are within SF1, which may overlap with frequencies associated with cardiac and respiratory activities.

**Key words:** discrete wavelet; mild traumatic brain injury; postconcussive syndrome; resting state fMRI

#### Introduction

THE CENTERS FOR Disease Control and Prevention (CDC) estimates that each year 1.7 million people sustain a traumatic brain injury (TBI), which results in 275,000 hospitalizations and 52,000 deaths, contributing to approximately one-third (30.5%) of all injury-related deaths in the United States (Faul et al., 2010). TBI is caused by an exterior mechanical force applied to the skull causing damage to the brain tissue and resulting in short- and long-term cognitive impairments, functional disability, or psychosocial maladjustment (Steyerberg et al., 2008). The majority of TBI cases,  $\sim 75\%$ , are diagnosed as mild TBI (mTBI) (CDC, 2003). However,

even among patients diagnosed with a mild injury, many experience physical, cognitive, and psychosocial deficits, resulting in a limited ability to return to work and reduced quality of life. As a consequence of these injuries, the patients and family members are left with a large emotional burden and the nation incurs an immense financial burden estimated to cost annually between \$62 and \$78 billion, which includes both direct and indirect costs (CDC, 2013).

Despite the absence of intracranial injury noted on conventional computed tomography (CT) and magnetic resonance (MR) imaging, somatic, neuropsychological, and cognitive symptoms fail to resolve in the months following injury in a large portion of mTBI patients. For example,

<sup>&</sup>lt;sup>1</sup>Department of Diagnostic Radiology and Nuclear Medicine, University of Maryland School of Medicine, Baltimore, Maryland.

<sup>&</sup>lt;sup>2</sup>Magnetic Resonance Research Center (MRRC), Baltimore, Maryland.

<sup>&</sup>lt;sup>3</sup>University of Maryland School of Medicine, Baltimore, Maryland.

<sup>&</sup>lt;sup>4</sup>Department of Computer Science, Institute for Advanced Computer Studies, University of Maryland College Park, College Park, Maryland.

82% of mTBI patients continue to report the presence of at least one symptom one year postinjury (McMahon et al., 2014). It is possible that the structural damage to neurons, glia, and astrocytes induced by both primary and secondary injuries associated with trauma likely disrupt the communication between large-scale neural networks supporting higher order cognitive processes as well as primary sensory processing. Advanced imaging approaches, including diffusion tensor imaging, functional magnetic resonance imaging (fMRI), and magnetic resonance spectroscopy, show promise in identifying trauma-induced structural, cerebrovascular, and biochemical alterations and will ultimately result in an increased understanding of the neurodegenerative processes related to persistent postconcussive symptoms in mTBI.

Specifically, there has been a great deal of interest in recent years in the use of resting-state fMRI (rs-fMRI) to investigate alterations in neural communication in patient populations. Following mTBI, researchers have noted reduced interhemispheric functional connectivity (Slobounov et al., 2011; Sours et al., 2014) and increased thalamocortical functional connectivity (Sours et al., 2014; Tang et al., 2011; Zhou et al., 2014). However, the majority of the research probing altered resting-state functional connectivity in the mTBI population has focused on alterations to the default mode network (DMN), a set of regions in the brain that are deactivated during task-related activities, while demonstrating increased activity during rest conditions (Greicius et al., 2003; Raichle et al., 2001). Using both data-driven independent component analysis (ICA) and hypothesis-driven seed-based analysis, groups have noted reduced functional connectivity within the DMN ( Johnson et al., 2012; Mayer et al., 2011; Sours et al., 2013; Zhou et al., 2012) as well as increased functional connectivity between the DMN and its anticorrelated task-positive network, also referred to as the executive network (Mayer et al., 2011; Sours et al., 2013).

While traditional connectivity analysis limits analysis to a single frequency range (generally from 0.01 to 0.1 Hz) (Cordes et al., 2001), it has long been known that different frequency ranges of neuronal signals carry unique functional information. Therefore, due to previous research indicating altered resting-state functional connectivity within the DMN in mTBI populations, we were interested in further exploring the effect of mTBI on the neural communication within the DMN contained within multiple frequency components of the resting-state blood oxygen level-dependent (BOLD) signal. We propose to use the emerging technique of discrete wavelet decomposition of rs-fMRI data to investigate network changes in strength and variability of connectivity across multiple frequency ranges that traditional analysis methods may be unable to demonstrate (Bullmore et al., 2004; Maxim et al., 2005; Misiti et al., 1996; Percival and Walden, 2000). We predict that a discrete wavelet decomposition of the rsfMRI BOLD signal can provide insights into specific alterations in neural communication within the DMN across multiple frequency ranges in mTBI patients with and without persistent symptoms compared with control participants.

# Materials and Methods

#### Participants

This study received approval from the Institutional Review Board and was HIPAA compliant. Thirty-two mTBI patients (41.7 – 17.1 years, 21M:11F) were prospectively recruited as part of a larger imaging protocol using a combination of advanced MR imaging and the Automated Neuropsychological Assessment Metrics (ANAM) (Kane et al., 2007). Thirty-one neurologically intact subjects (37.3 – 17.1 years, 17M:14F) served as a control population. All participants were over the age of 18. Patients were screened and excluded for history of neurological and psychiatric illnesses, history of stroke, history of brain tumors or seizures, and contraindications to MR. In addition, patients were excluded for history of previous brain injury. Inclusion criteria consisted of an admission Glasgow Coma Scale of 13–15 and mechanism of injury consistent with trauma and a positive admission head CT or altered mental status and/or loss of consciousness.

All 32 mTBI patients received rs-fMRI \*10 days (average 6 days, range 1–11 days) and 6 months postinjury (average 200 days, range 137–300 days). The 31 control subjects received rs-fMRI at one time point. Based on clinical CT scans, 9 of the 32 mTBI patients had evidence of injury. None of the mTBI patients classified as negative CT demonstrated any trauma-related injury on structural MR.

Based on self-reported symptoms from the Modified Rivermead Postconcussion Symptoms Questionnaire (RPQ) (King et al., 1995) at the 6-month time point, the group of mTBI patients was subdivided into those with and without postconcussive syndrome (PCS + and PCS-, respectively). According to the ICD10 clinical definitions, mTBI patients can only be classified as PCS + if they report three or more of the following symptoms for a period greater than 3 months postinjury: headache, dizziness, sleep abnormalities, trouble concentrating, fatigue, memory problems, or irritability (World Health Organization, 2010). PCS classification from the 6-month time point was used to divide the mTBI patients at the 10-day visit. Based on this classification, 15 mTBI patients were classified as PCS + (50.2 – 13.9 years, 8M/7F) and 17 were classified as PCS- (34.2 – 16.5 years, 13M/4F). There was no significant difference between the two mTBI groups in the number of days postinjury that individuals were scanned during the acute ( *p* = 0.596) or chronic time point ( *p* = 0.983). Participant demographics and clinical characteristics are noted in Table 1. Patients' RPQ scores were later quantified into the number of positive self-reported symptoms of any of the 22 symptomatic categories. The RPQ count number is defined as the sum of the different positive symptoms (any symptomatic category

Table 1. Patient Demographic and Clinical Characteristics

| Controls<br>(SD) | mTBI<br>PCS + (SD)                                              | mTBI<br>PCS<br>(SD)                      |
|------------------|-----------------------------------------------------------------|------------------------------------------|
|                  |                                                                 | 17                                       |
|                  |                                                                 | 34.2 (16.5)                              |
|                  |                                                                 | 14.6 (3.3)                               |
| 17M/14F          | 8M/7F                                                           | 13M/4F                                   |
|                  |                                                                 |                                          |
|                  |                                                                 | 6 (3)                                    |
| NA               | 200 (36)                                                        | 200 (28)                                 |
|                  | 31<br>37.3 (17.1)<br>15.1 (2.3)<br>Days postinjury (days)<br>NA | 15<br>50.2 (13.9)<br>13.5 (2.0)<br>6 (4) |

mTBI, mild traumatic brain injury; NA, not applicable; PCS, postconcussive syndrome; SD, standard deviation.

with a score greater than 0 on a scale from 0 to 4). A summary of the RPQ scores is listed in Table 2.

# Neuropsychological assessment

Along with the self-reported symptoms from the RPQ (King et al., 1995), the computerized cognitive assessment, the ANAM, was administered to participants (Kane et al., 2007). The ANAM consists of seven subtests assessing processing speed, memory, and attention. Weighted throughput (WT-TH) score, a measure that has previously been referred to as the index of cognitive efficiency, was used in our analysis. The WT-TH is a weighted summary of the throughput scores from each of the subtests (Reich et al., 2005; Sours et al., 2014). The weighting is done in a manner that the throughput score from each subtest contributes equally to the overall score. The precise equation used in this analysis is as follows:

WT-TH=
$$(CS\times4.35 + CSD\times5 + MTS\times6.63 + MATH\times8.37 + PRT\times2.18 + SRT + SRT2)/7.$$

A lower throughput score indicates a poorer cognitive performance. A summary of ANAM WT-TH scores is listed in Table 2. Due to the poor clinical condition of patients during the acute time points, 12 mTBI patients (7 PCS + , 5 PCS-) were unable to complete the ANAM. In addition, one healthy control (HC) refused participation in the ANAM.

# MR data acquisition

All imaging was performed on a Siemens Tim Trio 3T MRI scanner using a 12-channel receive-only head coil. A high-resolution T1-weighted-MPRAGE (TE = 3.44 msec, TR = 2250 msec, TI = 900 msec, flip angle = 9-, resolution = 256 · 256 · 96, FOV = 22 cm, sl. Thick. = 1.5 mm) was acquired for anatomic reference. For the rs-fMRI scan, T2\*-weighted images were acquired using a single-shot EPI sequence (TE = 30 msec, TR= 2000 msec, FOV = 220 mm, resolution = 64 · 64) with 36 axial slices (sl. thick. = 4 mm) over 5 min 42 sec that yielded 171 volumes. During all resting-state scans, the participants were instructed to rest peacefully with their eyes closed.

Table 2. ANAM WT-TH Scores and RPQ Count Values for Subjects

|            | Type of<br>assessment | Mean   | SD    | Median |
|------------|-----------------------|--------|-------|--------|
| Controls   | ANAM WT-TH            | 215.67 | 44.44 | 217.18 |
| Acute mTBI | ANAM WT-TH            | 160.77 | 46.21 | 174.36 |
| PCS +      | RPQ Count             | 14.50  | 4.25  | 15.50  |
| Acute mTBI | ANAM WT-TH            | 221.00 | 23.57 | 215.35 |
| PCS        | RPQ Count             | 4.00   | 3.59  | 3.50   |
| Chronic    | ANAM WT-TH            | 198.88 | 38.88 | 208.74 |
| mTBI PCS + | RPQ Count             | 13.13  | 4.82  | 14.00  |
| Chronic    | ANAM WT-TH            | 219.28 | 31.41 | 230.86 |
| mTBI PCS   | RPQ Count             | 1.18   | 1.33  | 1.00   |

ANAM, Automated Neuropsychological Assessment Metrics; RPQ, Modified Rivermead Postconcussion Symptoms Questionnaire; WT-TH, weighted throughput.

# Resting-state data preprocessing and analysis

Preprocessing of the imaging data was performed using AFNI and included slice timing correction and registration of all the 171 volumes to the first volume of the time series. Spatial blurring was then applied to the resting-state data using a 6-mm Gaussian kernel and normalized to percent signal change. The global signal from the mean BOLD time series from the whole-brain mask and the six motion correction parameters were included in the model as regressors to remove the variance related to non-neuronal contributions and motion.

DMN regions of interest (ROIs) were created using a 10-mm spherical ROI centered at the peak correlated voxel of the significant clusters from a seed-based group analysis of a separate population of 28 HC subjects using a posterior cingulate cortex (PCC) seed. The eight ROIs included the PCC, medial prefrontal cortex (MPFC), bilateral lateral parietal (right lateral parietal [RLP] and left lateral parietal [LLP]), bilateral inferior temporal gyri (right inferior temporal gyrus [RITG] and left inferior temporal gyrus [LITG]), and the bilateral parahippocampal gyri (right parahippocampal gyrus [RPHG] and left parahippocampal gyrus [LPHG]). All ROIs are defined in the Montreal Neurological Institute (MNI) space. See Figure 1 for location of ROIs and see Supplementary Table S1 (Supplementary Data are available online at www .liebertpub.com/brain) for MNI coordinates for corresponding ROIs. For each participant, the structural T1-MPRAGE was registered to the fMRI data in native space, resulting in an fMRI-registered T1-MPRAGE image. The standard ROI was transformed to native patient space using an inverse of the transformation matrix used to transform the fMRI-registered T1-MPRAGE into the MNI space. The resulting DMN ROIs in native patient fMRI space were downsampled to the spatial resolution of the fMRI data (3.594 · 3.594 · 4.00 mm) before BOLD time series extraction. All ROIs were visually inspected to ensure proper registration.

#### Wavelet decomposition

The mean BOLD time series for the DMN ROIs in native patient space were extracted and postprocessed using the

FIG. 1. Visualization of the anatomy of the default mode network (DMN) regions of interest (ROIs). The ROIs are shown in standard space overlaid on the MNI template. MPFC, medial prefrontal cortex; PCC, posterior cingulate cortex; LITG, left inferior temporal gyrus; LLP, left lateral parietal; LPHG, left parahippocampal gyrus; RITG, right inferior temporal gyrus; RLP, right lateral parietal; RPHG, right parahippocampal gyrus.

Wavelet Methods for Time Series Analysis (WMTSA) (Percival and Walden, 2000) using MATLAB (2011a; The Math-Works, Inc., Natick, MA). Using the MATLAB modwt.m function, a maximal overlap discrete wavelet transform analysis was performed, decomposing the time series into four scaling factors (SFs) or frequency ranges, which are represented by four columns of wavelet coefficients. The LA(8) wavelet filter was selected for this analysis, which uses the Least Asymmetry Daubechies orthonormal compactly supported wavelet of length L = 8 as the mother wavelet. The four SFs are SF1 corresponding to 0.125–0.250 Hz (8– 15 cycles/min); SF2 corresponding to 0.060–0.125 Hz (3.6–8 cycles/min); SF3 corresponding to 0.030–0.060 Hz (1.8–3.6 cycles/min); and SF4 corresponding to 0.015– 0.030 Hz (0.9–1.8 cycles/min). The wavelet coefficient is a measure of how similar the scaled wavelet is to the time series at that temporal point of analysis. The greater the wavelet coefficient, the more similar the wavelet is to the section of original time series at that time point of analysis. Therefore, similar to the Fourier transform, wavelet decomposition can be used to decompose the time series into multiple frequency domains; however, unlike the Fourier transform, temporal information regarding local features of the time series is maintained (Bullmore et al., 2004; Chang and Glover, 2010).

# Wavelet connectivity mapping

For each ROI, Pearson's correlation of the wavelet coefficients with the other seven DMN ROIs was calculated. For each SF, an 8 · 8 connectivity matrix was obtained for every pairwise correlation for each subject. The individual connectivity matrix values for SF for each participant were then converted to z-scores using the Fisher transformation for future bivariate comparisons. Average connectivity matrices were created for each subject group (HC, PCS + , PCS-) at each visit (acute and chronic). See Figure 2 for the diagram of wavelet connectivity mapping.

# Bivariate connectivity measurements

Strength and diversity were calculated using the z-scores obtained from the connectivity matrices (Lynall et al., 2010). The strength of ROI *i* is defined as the mean value of *i*th column of the connectivity matrix. The diversity of ROI *i* is defined as the variance of the *i*th column of the connectivity matrix (Lynall et al., 2010). The strength is a measure of the average connectivity of an ROI with the rest of the ROIs in the network, while the diversity of a region is a measure of the variability in the strength of the correlation between a single region compared with the other regions in the network. To help evaluate the overall connectivity and overall variation in a subject's resting-state DMN, the eight different strength and diversity values (one for each DMN ROI) were averaged for every SF. Therefore, the reported average strength and average diversity for the DMN represent the mean strength and mean diversity of all 8 DMN ROIs.

# Statistical analyses

All statistical analyses were done using SPSS (IBM SPSS Statistics for Windows, Version 21.0; IBM Corp., Armonk, NY). For each SF, we performed individual analysis of covariance (ANCOVA) with age included as a covariate to compare the changes in strength and diversity across the three groups (HC, PCS + , PCS-) at each mTBI visit (acute and chronic) and compared it with the HC subjects. *Post hoc* tests used Fisher's least significant difference (LSD) test to correct for multiple comparisons. In addition, to investigate the longitudinal changes in connectivity in mTBI patients, we performed repeated measures ANCO-VAs, including age as a covariate and using visit as the within-subject factor (acute vs. chronic) and PCS as the betweensubject factor (PCS + vs. PCS-). Identical analysis was performed on the results from the ANAM.

Another goal of this project was to determine the association between the bivariate imaging measures from the different SFs and behavioral information from the assessments of

FIG. 2. Diagram of analysis methods (DWT, discrete wavelet transform; mTBI, mild traumatic brain injury; mTBI PCS + , mTBI patients with postconcussive syndrome; mTBI PCS-, mTBI patients without postconcussive syndrome).

FIG. 3. Average pairwise resting-state connectivity matrix for the eight DMN ROIs within the scaling factor 1 (SF1: 0.125–0.250). (A) Healthy controls and (B) mTBI patients with postconcussive syndrome (PCS+) and without postconcussive syndrome (PCS-) during the acute and chronic stages of injury. The intensity represents the z-transformed wavelet connectivity, with warmer colors representing greater connectivity between regions.

cognition (ANAM) and symptom severity (RPQ). Functional connectivity measures are known to change with age (Wu et al., 2011). In addition, an initial correlation with age showed that the ANAM was significantly correlated with age; therefore, partial correlations were conducted controlling for age in all the subjects.

#### Results

#### Patient demographics

There were no significant differences among the three groups in education (F=2.016; p=0.142). However, there was a significant difference in age among the three groups (F=4.450; p=0.016).

# Behavior

During the acute visit, a significant difference in performance on the ANAM as measured by the WT-TH among the three groups (F=6.509; p=0.003) was observed. *Post hoc* tests determined that the PCS+ group had lower scores on the ANAM compared with both the control group (p=0.002) and the PCS- group (p=0.002). By the chronic stage, the difference in performance among the three groups was no longer present (F=1.153; p=0.323). Based on results from the RPQ, as expected, the PCS+ group reported more symptoms compared with the PCS- group both at the acute (p<0.001) and chronic stages (p<0.001).

# Comparison of average strength

Visual comparisons of the 8×8 connectivity matrices for each group are shown for SF1 (Fig. 3). These matrices demonstrate an overall reduced connectivity in the PCS+ group compared with both the control and PCS- groups as well as an overall increase in connectivity in both PCS groups between the acute and chronic time points (Fig. 3). While subtle group differences are demonstrated in the 8×8 connectivity matrices for SF2, SF3, and SF4, no group differences in overall strength or diversity of DMN were noted for SF2, SF3, and SF4, suggesting minimal TBI-induced changes in the connectivity within these frequency ranges (Supplementary Figs S1–S3, respectively).

The strength for each study population is shown in Supplementary Table S2. Based on the results of the ANCOVA con-

trolling for age, during the acute stage, a significant difference was observed in strength among the three groups in SF1 (F=4.092; p=0.022) (Fig. 4A). No differences were observed between the strength of the three groups in SF2 (F=2.190; p=0.121), SF3 (F=1.967; p=0.149), or SF4 (F=0.397; p=0.674). Post hoc tests determined that the strength within SF1 was significantly increased in the PCS- group compared with the controls (p=0.014) and the PCS+ group (p=0.002).

At the chronic stage, a significant group difference in strength was observed for SF1 (F=4.210; p=0.020), but not for SF2 (F=0.600; p=0.552), SF3 (F=0.427; p=0.654), or

**FIG. 4.** Group average of DMN strength during the (**A**) acute stage and (**B**) chronic stage. HC, healthy control group (n=31). PCS-, mTBI patients without postconcussive syndrome (n=17). PCS+, mTBI patients with postconcussive syndrome (n=15). SF1: 0.125-0.250 Hz. SF2: 0.060-0.125 Hz. SF3: 0.030-0.060 Hz. SF4: 0.015-0.030 Hz. \*p < 0.05 based on post hoc tests using Fisher's least significant difference (LSD) test to correct for multiple comparisons.

SF4 (F=1.646; p=0.201) (Fig. 4B). Post hoc tests determined that for SF1, the PCS— group had increased strength compared with the control group (p=0.006).

Since the initial results suggested that there was an altered strength in global DMN connectivity within SF1, in an exploratory analysis, we opted to investigate node-specific changes in DMN connectivity through repeating the ANCOVA analysis (controlling for age) on the strength of each of the 8 DMN nodes individually at the acute and the chronic stages. In the acute stage, a significant difference was noted in the strength of connectivity within SF1 for the LLP (F = 4.545; p = 0.015), PCC (F = 5.623; p = 0.006), RLP (F=7.361; p=0.001), and RPHG (F=3.481; p=0.037)(Fig. 5A). Post hoc tests determined that at the acute stage, the PCS- group had increased strength of connectivity compared with the control group as well as compared with the PCS + group for all four of these ROIs (all p < 0.05). In addition, post hoc tests determined that the control group had increased strength of connectivity compared with the PCS + group for the RLP (p = 0.042).

During the chronic stage of injury, there was a significant difference in strength within SF1 in the LITG (F=3.567; p=0.034), LLP (F=3.468; p=0.038), LPHG (F=3.781; p=0.029), MPFC (F=4.859; p=0.011), RITG (F=3.531; p=0.036), RLP (F=3.927; p=0.025), and RPHG (F=3.493; p=0.037) (Fig. 5B). Post hoc tests determined that at the chronic stage, the PCS- group had increased strength compared with the control group for all seven of these ROIs (all p<0.05), suggesting that this is global change in strength of connectivity within SF1. In addition, post hoc tests determined that at the chronic stage, the PCS- group had increased strength compared with the PCS+ for the MPFC (p=0.007) and RITG (p=0.038).

**FIG. 5.** Group average of node-specific changes in DMN strength within SF1  $(0.125-0.250 \, \text{Hz})$  during the (**A**) acute stage and (**B**) chronic stage. HC: healthy control group (n=31). PCS-, mTBI patients without postconcussive syndrome (n=17). PCS+, mTBI patients with postconcussive syndrome (n=15). \*p < 0.05 based on post hoc tests using Fisher's LSD test to correct for multiple comparisons.

# Comparison of average diversity

The diversity for each study population is shown in Supplementary Table S2. Based on the results of the ANCOVA controlling for age, there were no significant differences among the three groups in the diversity for any of the four SFs during the acute stage (SF1: F=0.942, p=0.396; SF2: F=0.073, p=0.930; SF3: F=0.644, p=0.529; SF4: F=0.424, p=0.656) (Fig. 6A). During the chronic stage, there were no significant differences among the three groups in the diversity within any of the four SFs (SF1: F=0.978, p=0.382; SF2: F=1.116, p=0.334; SF3: F=1.281, p=0.285; SF4: F=1.378, p=0.260) (Fig. 6B).

# Longitudinal changes in average strength and average diversity

In addition to differences among the three groups, we were also interested in investigating longitudinal changes in strength and diversity between the two mTBI groups through the use of repeated measures ANCOVA controlling for age at each SF. In regard to the strength of the DMN, we failed to observe a significant difference between the PCS+ and PCS- groups for SF1 (F=0.928, p=0.343), SF2 (F=1.628, p=0.212), SF3 (F=1.309, p=0.262), or SF4 (F=0.058, p=0.812). However, there is evidence of longitudinal changes in strength of connectivity within SF1 (F=5.946, p=0.021) and a nonsignificant trend within SF2 (F=3.101, p=0.089), with both the PCS+ and PCS- groups demonstrating increasing network strength over time suggestive of functional recovery.

In regard to longitudinal changes in diversity within the PCS+ and PCS- groups, no differences in between-group differences or longitudinal differences were noted for any of the four SFs.

**FIG. 6.** Group average of DMN diversity during the **(A)** acute stage and **(B)** chronic stage. HC, healthy control group (n=31). PCS-, mTBI patients without postconcussive syndrome (n=17). PCS+, mTBI patients with postconcussive syndrome (n=15). SF1: 0.125-0.250 Hz. SF2: 0.060-0.125 Hz. SF3: 0.030-0.060 Hz. SF4: 0.015-0.030 Hz.

# Discussion

Wavelet decomposition is well suited for the analysis of resting-state BOLD signals because of its unique ability to decompose the signal into multiple frequency domains (similar to the Fourier analysis), while maintaining temporal information of the local features of the signal (Bullmore et al., 2004; Chang and Glover, 2010). The use of wavelet decomposition to analyze resting-state BOLD data has been successfully implemented to determine frequency-specific alterations in connectivity in multiple diseases, including schizophrenia (Bassett et al., 2012) and Alzheimer's disease (Supekar et al., 2008), in addition to altered neural communication in response to acupuncture (Cheng et al., 2013) or transient emotional stimuli (Eryilmaz et al., 2011). However, to our knowledge, this is the first time that discrete wavelet decomposition has been used in the analysis of restingstate BOLD data from an mTBI population.

This study provides evidence that discrete wavelet decomposition can be effectively used to assess the effect of mTBI on the communication within the DMN across multiple frequency ranges as well as to distinguish network differences in patients with and without persistent symptoms. These results lead to two main conclusions. First, the strength of DMN connectivity is reduced across the frequency range included in SF1 (0.125–0.250 Hz) in patients suffering from persistent postconcussive symptoms compared with those with a more complete recovery. Second, the strength of DMN connectivity is greater in PCS patients compared with the control population for both time points, which may be suggestive of compensatory or protective mechanisms.

# Implications of altered strength of connectivity

Multiple groups have noted reduced resting-state functional connectivity strength within the DMN using traditional seedbased correlation methods considering only the low-frequency fluctuations as a single frequency component (roughly 0.01– 0.1 Hz) ( Johnson et al., 2012; Mayer et al., 2011; Sours et al., 2013; Zhou et al., 2012). However, using wavelet decomposition of rs-fMRI data, our results suggest that while PCS + patients demonstrate reduced strength of wavelet connectivity compared with the PCS group across the frequency range (0.125–0.250), this may in fact be due to an increased strength of connectivity within the PCS group, which has an increased strength of connectivity compared with the control group as well (Fig. 4A). Furthermore, over time, our results suggest a normalization of connectivity within the DMN for both patients with and without persistent symptoms. However, it is intriguing to note that during the chronic stage, in the analysis of the highest frequency range (0.125– 0.250 Hz), the PCS mTBI patients are still exhibiting increased strength of connectivity compared with the control group (Fig. 4B) and that this increase is consistent across the various nodes of the DMN (Fig. 5B).

Since this altered strength of connectivity is present at both time points in the group of patients with good recovery from mTBI, this is suggestive of possible protective characteristics, which help limit the presence of persistent symptoms. On the other hand, this may suggest that this increased neural communication within the DMN during resting conditions is a compensatory mechanism that is able to counteract the traumainduced metabolic alterations to the neurons and other glial support cells within the brain, thereby allowing for a more complete recovery from TBI.

Correlation of wavelet bivariate parameters with cognitive and symptomatic assessments

Being able to correlate the bivariate measures of strength and diversity to clinical data is of utmost interest. Unfortunately, the imaging measures were not significantly correlated with the clinical or behavioral data collected on these participants.

# Limitations

One limitation in this analysis is the significant difference in age between the mTBI groups with those with persistent symptoms being older than those without persistent symptoms. Multiple differences in strength of wavelet connectivity are noted between PCS patients and the control group subjects whose average ages are nearly identical (34 vs. 37 years, respectively), suggesting that the influence of age on wavelet connectivity is limited across the multiple frequency ranges. To further assess the association between age and wavelet connectivity strength, we tested for correlations between age and wavelet connectivity strength across the four frequency ranges within the control population. The results suggest that there is no association between age and strength across the four frequency ranges (Supplementary Fig. S4). While these results suggest that age may not play a factor in the present study, age was still used as a covariate in the statistical analysis to ensure that the results presented are not influenced by difference in age between the groups.

An ideal analysis would include a control group scanned at two visits to assess the test–retest reliability of functional connectivity measures determined from wavelet decomposition. However, there is evidence suggesting that within control participants, resting-state networks are relatively consistent across the timescale we are considering (6 months apart for the mTBI groups) (Franco et al., 2013; Mannfolk et al., 2011). In addition, a group has recently assessed the test–retest reliability of global connectivity measures using a wavelet decomposition method similar to the one employed in this article (Wang et al., 2013). They found fair to excellent test–retest reliability (0.4 < intraclass correlation < 0.9) on global metrics of wavelet connectivity within specific SFs [(Wang et al., 2013) Supplementary Data]. Therefore, we feel confident that the changes noted in the mTBI group across the 6 months from the acute to chronic time points are related to recovery from injury instead of normal variability in resting-state networks.

In addition, it is well accepted in the field that differences in motion between groups have the possibility to influence measures of functional connectivity (Power et al., 2012). Therefore, since mTBI patients are considered a high-risk group for excessive motion, the maximum and mean motion parameters were determined for each group included in this analysis (controls, Acute PCS + , Acute PCS-, Chronic PCS + , and Chronic PCS-). While we found no significant differences in maximum translation or rotation between the groups (all *p*-values > 0.05), we did find significant differences between the five groups in the mean of two of the six motion parameters (x and roll) (Supplementary Fig. S5). To ensure that the main effects reported are not due to differences in motion between the groups, we repeated the statistical analysis, including these two motion parameters (x and roll) as covariates of no interest. The main findings of a significant difference in the strength of connectivity within SF1 between the three groups (control, PCS + , and PCS-) remain after the inclusion of these additional covariates for the acute and chronic time points ( *p*-values < 0.05). The fact that the main effects remain after accounting for the differences in motion between these groups suggests that the results reported in this article are not due to the influence of variable motion parameters between the groups. However, in future studies, the use of additional motion correction methods such as scrubbing (Power et al., 2012) or ICA is warranted to ensure that changes in connectivity noted in the mTBI group within the frequency range of 0.125–0.250 Hz were not due to inherent differences in motion within this group.

An additional limitation in this analysis is that many of the main findings are within the SF1 (0.125–0.25 Hz), which is outside the frequency range generally analyzed using conventional, seed-based functional connectivity analysis. This is due to the possible contribution of the respiratory signal within this frequency range. However, recently, groups have begun to investigate the neuronal contribution of this frequency range. For example Gohel and Biswal (2015) recently demonstrated that resting-state networks (including the DMN) were consistently observed across multiple frequency bands, including slow-2 (0.198–0.50 Hz) and slow-3 (0.073–0.0198 Hz), which overlap with the SF1 frequency range (0.125–0.250 Hz) that we used. In their discussion, the authors suggest that this finding implies that there is a substantial neuronal contribution to this frequency range. Furthermore, others who have investigated resting-state neural communication using frequency-specific functional connectivity measures have reported that resting-state connectivity within a high-frequency interval (0.17-0.25 Hz) was present in multiple limbic and temporal areas (Salvador et al., 2008), as well as that whole-brain connectivity is altered within the scale 1 frequency range (0.17–0.33 Hz) in response to acupuncture (Cheng et al., 2013). However, the frequency range of SF1 may overlap with frequencies associated with respiratory activity (0.10–0.50 Hz); further research that incorporates cardiac (0.60–1.00 Hz) and respiratory (0.10– 0.50 Hz) information is needed to fully characterize the neuronal contribution of TBI-induced alterations noted within the frequency range.

# Conclusions

In this study, we demonstrate for the first time that discrete wavelet decomposition of resting-state BOLD data can effectively be used to assess the effect of mTBI on the communication within the DMN across the frequency range from 0.125 to 0.250 Hz, as well as distinguish global and nodespecific network differences in patients with and without persistent symptoms. We provide evidence using the discrete wavelet decomposition that the strength of the DMN connectivity is altered in both PCS + and PCS patients across frequencies ranging from 0.125 to 0.250 Hz. In addition, we show that DMN connectivity progressively changes during the first 6 months following injury, which is suggestive of either compensatory reorganization (in the case of PCS patients) or disrupted network communication due to potential structural damage (in the case of PCS + patients). These findings stress the importance of investigating resting-state connectivity across multiple frequency ranges as many alterations are noted across frequency ranges that are outside traditional resting-state connectivity analysis ( > 0.1 Hz). Future work using a sliding window analysis, which will take full advantage of the unique ability of the discrete wavelet transform to maintain temporal information, is needed to fully characterize the dynamic properties of multiresolution resting-state connectivity in mTBI populations.

# Acknowledgments

The authors would like to thank Joshua Betz, Jacqueline Janowich, Teodora Stoica, and Joseph Rosenberg for their help with patient recruitment and George Makris for his help with acquiring the data. Support for this work was, in part, provided by the Department of Defense (W81XWH-08-1-0725 and W81XWH-12-1-0098 to R.P.G). C.S. was supported by an NRSA grant from the National Institute of Neurological Disorders and Stroke (1F31NS081984). The authors also acknowledge support provided by The University of Maryland/Mpowering the State through the Center for Health-related Informatics and Bioimaging.

# Author Disclosure Statement

No competing financial interests exist.

# References

Bassett DS, Nelson BG, Mueller BA, Camchong J, Lim KO. 2012. Altered resting state complexity in schizophrenia. Neuroimage 59:2196–2207.

Bullmore E, Fadili J, Maxim V, Sendur L, Whitcher B, Suckling J, Brammer M, Breakspear M. 2004. Wavelets and functional magnetic resonance imaging of the human brain. Neuroimage 23 Suppl 1:S234–S249.

Centers for Disease Control and Prevention (CDC). 2003. Report to congress on mild traumatic brain injury in the United States: steps to prevent a serious public health problem, Atlanta, GA.

Centers for Disease Control and Prevention (CDC). 2013. CDC grand rounds: reducing severe traumatic brain injury in the United States. MMWR Morb Mortal Wkly Rep 62:549–552.

Chang C, Glover GH. 2010. Time-frequency dynamics of resting-state brain connectivity measured with fMRI. Neuroimage 50:81–98.

Cheng H, Yan H, Bai LJ, Wang BG. 2013. Exploration of whole brain networks modulated by acupuncture at analgesia acupoint ST36 using scale-specific wavelet correlation analysis. Chin Med J 126:2459–2464.

Cordes D, Haughton VM, Arfanakis K, Carew JD, Turski PA, Moritz CH, Quigley MA, Meyerand ME. 2001. Frequencies contributing to functional connectivity in the cerebral cortex in ''resting-state'' data. AJNR Am J Neuroradiol 22:1326–1333.

Eryilmaz H, Van De Ville D, Schwartz S, Vuilleumier P. 2011. Impact of transient emotions on functional connectivity during subsequent resting state: a wavelet correlation approach. Neuroimage 54:2481–2491.

Faul M, Xu L, Wald M, Coronado V. 2010. Traumatic brain injury in the United States: emergency department visits, hospitalizations, and deaths. Center of Disease Control. Atlanta, GA.

Franco AR, Mannell MV, Calhoun VD, Mayer AR. 2013. Impact of analysis methods on the reproducibility and reliability of resting-state networks. Brain Connect 3:363–374.

Gohel SR, Biswal BB. 2015. Functional integration between brain regions at rest occurs in multiple-frequency bands. Brain Connect 5:23–34.

- Greicius MD, Krasnow B, Reiss AL, Menon V. 2003. Functional connectivity in the resting brain: a network analysis of the default mode hypothesis. Proc Natl Acad Sci U S A 100:253–258.
- Johnson B, Zhang K, Gay M, Horovitz S, Hallett M, Sebastianelli W, Slobounov S. 2012. Alteration of brain default network in subacute phase of injury in concussed individuals: resting-state fMRI study. Neuroimage 59:511–518.
- Kane RL, Roebuck-Spencer T, Short P, Kabat M, Wilken J. 2007. Identifying and monitoring cognitive deficits in clinical populations using automated neuropsychological assessment metrics (ANAM) tests. Arch Clin Neuropsychol 22 Suppl 1:S115–S126.
- King NS, Crawford S, Wenden FJ, Moss NE, Wade DT. 1995. The rivermead post concussion symptoms questionnaire: a measure of symptoms commonly experienced after head injury and its reliability. J Neurol 242:587–592.
- Lynall ME, Bassett DS, Kerwin R, McKenna PJ, Kitzbichler M, Muller U, Bullmore E. 2010. Functional connectivity and brain networks in schizophrenia. J Neurosci 30:9477– 9487.
- Mannfolk P, Nilsson M, Hansson H, Stahlberg F, Fransson P, Weibull A, Svensson J, Wirestam R, Olsrud J. 2011. Can resting-state functional MRI serve as a complement to taskbased mapping of sensorimotor function? A test-retest reliability study in healthy volunteers. J Magn Reson Imaging 34:511–517.
- Maxim V, Sendur L, Fadili J, Suckling J, Gould R, Howard R, Bullmore E. 2005. Fractional gaussian noise, functional MRI and Alzheimer's disease. Neuroimage 25:141–158.
- Mayer AR, Mannell MV, Ling J, Gasparovic C, Yeo RA. 2011. Functional connectivity in mild traumatic brain injury. Hum Brain Mapp 32:1825–1835.
- McMahon P, Hricik A, Yue JK, Puccio AM, Inoue T, Lingsma HF, Beers SR, Gordon WA, Valadka AB, Manley GT, et al. 2014. Symptomatology and functional outcome in mild traumatic brain injury: results from the prospective TRACK-TBI study. J Neurotrauma 31:26–33.
- Misiti, M., Misiti, Y., Oppenheim, G., Poggi, J. 1996. *Wavelet Toolbox*. The MathWorks, Inc., Natick, MA.
- Percival DB, Walden AT. 2000. *Wavelet Methods for Time Series Analysis*. Cambridge: Cambridge University Press.
- Power JD, Barnes KA, Snyder AZ, Schlaggar BL, Petersen SE. 2012. Spurious but systematic correlations in functional connectivity MRI networks arise from subject motion. Neuroimage 59:2142–2154.
- Raichle ME, MacLeod AM, Snyder AZ, Powers WJ, Gusnard DA, Shulman GL. 2001. A default mode of brain function. Proc Natl Acad Sci U S A 98:676–682.
- Reich S, Short P, Kane R, Weiner W, Shulman L, Anderson K. 2005. Validation of the ANAM test battery in Parkinson's disease. Defense Technical Information Center, Ft. Belvoir.
- Salvador R, Martinez A, Pomarol-Clotet E, Gomar J, Vila F, Sarro S, Capdevila A, Bullmore E. 2008. A simple view of

- the brain through a frequency-specific functional connectivity measure. Neuroimage 39:279–289.
- Slobounov SM, Gay M, Zhang K, Johnson B, Pennell D, Sebastianelli W, Horovitz S, Hallett M. 2011. Alteration of brain functional network at rest and in response to YMCA physical stress test in concussed athletes: RsFMRI study. Neuroimage 55:1716–1727.
- Sours C, Rosenberg J, Kane R, Roys S, Zhuo J, Shanmuganathan K, Gullapalli RP. 2014. Associations between interhemispheric functional connectivity and the automated neuropsychological assessment metrics (ANAM) in civilian mild TBI. Brain Imaging Behav [Epub ahead of print]; PMID: 24557591.
- Sours C, Zhuo J, Janowich J, Aarabi B, Shanmuganathan K, Gullapalli RP. 2013. Default mode network interference in mild traumatic brain injury—a pilot resting state study. Brain Res 1537:201–215.
- Steyerberg EW, Mushkudiani N, Perel P, Butcher I, Lu J, McHugh GS, Murray GD, Marmarou A, Roberts I, Habbema JD, et al. 2008. Predicting outcome after traumatic brain injury: development and international validation of prognostic scores based on admission characteristics. PLoS Med 5:e165; discussion e165.
- Supekar K, Menon V, Rubin D, Musen M, Greicius MD. 2008. Network analysis of intrinsic functional brain connectivity in Alzheimer's disease. PLoS Comput Biol 4:e1000100.
- Tang L, Ge Y, Sodickson DK, Miles L, Zhou Y, Reaume J, Grossman RI. 2011. Thalamic resting-state functional networks: disruption in patients with mild traumatic brain injury. Radiology 260:831–840.
- Wang J, Zuo X, Dai Z, Xia M, Zhao Z, Zhao X, Jia J, Han Y, He Y. 2013. Disrupted functional brain connectome in individuals at risk for Alzheimer's disease. Biol Psychiatry 73:472–481.
- World Health Organization. 2010. International Classification of Disease, 10th review.
- Wu JT, Wu HZ, Yan CG, Chen WX, Zhang HY, He Y, Yang HS. 2011. Aging-related changes in the default mode network and its anti-correlated networks: a resting-state fMRI study. Neurosci Lett 504:62–67.
- Zhou Y, Lui YW, Zuo XN, Milham MP, Reaume J, Grossman RI, Ge Y. 2013. Characterization of thalamo-cortical association using amplitude and connectivity of functional MRI in mild traumatic brain injury. J Magn Reson Imaging 39:1558–1568.
- Zhou Y, Milham MP, Lui YW, Miles L, Reaume J, Sodickson DK, Grossman RI, Ge Y. 2012. Default-mode network disruption in mild traumatic brain injury. Radiology 265:882–892.

Address correspondence to: *Chandler Sours Department of Diagnostic Radiology and Nuclear Medicine University of Maryland School of Medicine 22 South Greene Street Baltimore, MD 21201*

*E-mail:* csour001@umaryland.edu