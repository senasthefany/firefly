## Run multiple files on Firefly

The script is used to perform multiple calculations in a row on Firefly.

First, give permission for execution: chmod +x run_firefly.sh <br/>
Then you can run this script: ./run_firefly.sh

The script requires some steps for the first use:

1. Put the Firefly binary on the same folder containing the script;
2. Run the script for the first time and let it creates an initial empty folder for your inputs;
3. Move your inputs into the "inputs" folder;
4. Run the script and see the magic happening;
5. Check your outputs on "results" folder.

From now on,  you must repeat from step 3.

### Some errors:
 - Inputs must be without .in or .inp, not even space in name; 
 - If you are using an outdated version of Firefly, please insert the new one at line 70;
 - Sometimes there are different types of outputs from calculations that could cause a bug. In this case, just remove them manually.
