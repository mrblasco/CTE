CTPATH="data-raw/clinicaltrials/NCT0*"

# Clinical trials information 
extract_ct_info () {
	FILENAME=$1
    echo "id, title, status, date, description, enrollment, enrollment_type" > $FILENAME 
	for d in $CTPATH
	do
        echo "directory $d ..."
        jq -r " .FullStudy.Study.ProtocolSection | 
        select(.DesignModule.StudyType == \"Interventional\") | {
        id: .IdentificationModule.NCTId
        , title: .IdentificationModule.OfficialTitle
        , status: .StatusModule.OverallStatus
        , date: .StatusModule.StudyFirstSubmitDate
        , description: .DescriptionModule.DetailedDescription
        , enrollment: .DesignModule.EnrollmentInfo.EnrollmentCount
        , enrollment_type: .DesignModule.EnrollmentInfo.EnrollmentType
        } | [
        .id, .title, .status, .date, .description, .enrollment, .enrollment_type 
        ] | @csv " $d/*.json \
        >> $FILENAME 
	done
	head $FILENAME
	wc -l $FILENAME
	du -h $FILENAME
}


# Extract conditions (~2-3 minutes)
extract_conditions() {
	FILENAME=$1
	echo 'id, condition' > $FILENAME 
    for d in $CTPATH 
    do
		echo "directory $d ..."
	    jq ".FullStudy.Study.ProtocolSection | {
		id: .IdentificationModule.NCTId, 
		condition: .ConditionsModule.ConditionList.Condition[]
		}" $d/*.json | jq -r '[.id, .condition] | @csv' \
		>> $FILENAME 
	done
	head $FILENAME
	wc -l $FILENAME
	du -h $FILENAME
}

# Extract interventions (~2-3 minutes)

extract_interventions() {
    FILENAME=$1
    echo 'id, type, name, description' > $FILENAME
    for d in $CTPATH 
    do
        echo "directory $d ..."
        jq ".FullStudy.Study.ProtocolSection | {
        id: .IdentificationModule.NCTId, 
        intervention: .ArmsInterventionsModule.InterventionList.Intervention[] 
        | [.InterventionType, .InterventionName, .InterventionDescription]
        }" $d/*.json \
        | jq -r "[.id, .intervention[]] | @csv" \
        >> $FILENAME
    done
    head $FILENAME
    wc -l $FILENAME
    du -h $FILENAME
}


#extract_ct_info data-raw/ct-info.csv 
#extract_conditions data-raw/ct-conditions.csv
#extract_interventions data-raw/ct-interventions.csv

