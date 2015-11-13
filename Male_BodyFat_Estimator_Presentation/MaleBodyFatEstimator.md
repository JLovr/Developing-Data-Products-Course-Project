MaleBodyFatEstimator
========================================================
author: John Lovrinic
date: 11/11/2015

Summary
========================================================
- The purpose of this tool is to give the user an estimate of body fat content for men based on minimal easily determined information:
  - Age
  - Weight
  - Height
  - Neck
  - Abdomen
  - Chest
- Employs a linear model of the fat database from the UsingR package.
- While database measurements are in cm, the app converts from inches automatically

Instructions
========================================================
- Take measurements with a tape measure (in inches):
  - Neck
  - Height
  - Chest
  - Abdomen (at the navel)-suck it in guys for accurate measurements
  - Weight (lbs)
  - Age (years)
- Enter numeric values in the corresponding fields
- The %body fat will update automatically as each field is entered.

Plots
========================================================

- The plots show body fat % versus age, weight, height and abdomen measurements in blue.
- The user's index is also plotted in red.
- The plots update as the data is changed.
