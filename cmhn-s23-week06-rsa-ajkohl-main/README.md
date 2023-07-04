# cmhn-s23-week06-rsa
Representational similarity analysis in the Ninetysix dataset.

Read through and perform the analyses described in the notebook. Complete all of the **Exercises** described in the text. **Self-study** indicates an optional tangent that can help you to flesh out your knowledge of the content covered in this course.

When you are satisfied, commit your changes to this repo. It will automatically be submitted tomorrow at midnight.

*Instructor's corner*  
Score: 4/5        
Comments:  
Exercise 2: Your corr_matrix is 70 by 70 (not 96x96 like the pearson corrmat) -- indicating it's a voxels by voxels similarity matrix. This means you have to specify axis=1 to get a stimulus by stimulus similarity matrix.    
Exercise 6: A RDM value of 0 means the two items are perfectly correlated whereas a value of 1 means they're unrelated (same thing as a correlation=0).   
Exercise 9: Your lFFA and lPPA plots are identical because you use the same RSM in each plot.   
Exercise 10: Great approach! The correct answer is actually the first unknown stimulus, whereas the 4th is a nonhuman face.   
