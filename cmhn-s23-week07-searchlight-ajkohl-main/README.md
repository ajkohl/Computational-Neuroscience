# cmhn-s23-week07-searchlight
Learn to conduct searchlight analysis on fMRI data in the face-scene dataset.

Read through and perform the analyses described in the notebook. Complete all of the **Exercises** described in the text. **Self-study** indicates an optional tangent that can help you to flesh out your knowledge of the content covered in this course.

For this notebook, make sure to also submit the contents of the `07-searchlight` directory, containing any python or slurm scripts you create (including `searchlight.py`, `searchlight_rank.py`, and `submit_searchlight.sh`). Double check on Github in a browser that you have submitted these files!

When you are satisfied, commit your changes to this repo. It will automatically be submitted tomorrow at midnight.

*Instructor's corner*  
Score: 4.5/5        
Comments: NC: Calculating the rank does not run a classification analysis, thus should not return any sort of classification accuracy -- the result returned from calculating rank is exactly what you visualized above in exercise 11. Your accuracy as you printed it appears identical classification (but to run faster) because calc_rank doesn't run a classifier, but you printed `my_sl_result` which is the result from your SVM, rather than `all_sl_result` which is what you saved from calc_rank.   
