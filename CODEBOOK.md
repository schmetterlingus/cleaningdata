# data_all (steps 1-4)
Type: data.table
Observations: 10299
Variables: 89
* subject - subject number given in the experiment; class: integer (values: 1-30)
* activity - desciption of the activity; class: character (values:laying/sitting/standing/walking/walkingdownstairs/walkingupstairs)
* tbodyaccmeanx
* tbodyaccmeanyt
* bodyaccmeanz
...
* anglezgravitymean
* dataset (values: test/train)

# tidy_data (step 5)
Type: data.table
Observations: 180
Columns: 56
* subject - subject number given in the experiment; class: integer (values: 1-30)
* activity - desciption of the activity; class: character (values:laying/sitting/standing/walking/walkingdownstairs/walkingupstairs)
* tbodyaccmeanx
* tbodyaccmeany
...
* anglezgravitymean
* dataset (values: test/train)
