/**
 * Created by dmeli on 31.07.19.
 */

public class ListOfCandidates {

    private final Vacancy__c currentVacancy;
    private List<CandidateWrapper> candidateList = new List<CandidateWrapper>();
    private List<Candidate__c> selectedCandidates = new List<Candidate__c>();
    private List<VacancyCandidateAssociation__c> vacancyCandidateAssociations = new List<VacancyCandidateAssociation__c>();
    private String confirmMessage = 'One or more candidate was updated';
    private String errorMessage = 'Select candidate';
    private Map<Integer, String> vacancyStatusPicklist = new Map<Integer, String>{
            1 => 'New', 2 => 'In-Process', 3 => 'Closed', 4 => 'Cancelled'
    };
    private Map<Integer, String> candidateStatusPicklist = new Map<Integer, String>{
            1 => 'New', 2 => 'Validated by HR', 3 => 'Hired', 4 => 'Disqualified'
    };

    public ListOfCandidates(ApexPages.StandardController stdController) {
        System.debug('123123123');
        this.currentVacancy = (Vacancy__c) stdController.getRecord();
    }

    private List<Candidate__c> getCandidates() {
        return [SELECT FirstName__c, Status__c, Name, (SELECT Vacancy__c, Candidate__c FROM VacancyCandidateAssociations__r WHERE Vacancy__c = :currentVacancy.Id) FROM Candidate__c WHERE Status__c = :candidateStatusPicklist.get(2)];
    }

    public void onLoad() {
        Vacancy__c vacancyToCheck = [SELECT Id,Name, Status__c FROM Vacancy__c WHERE Id = :currentVacancy.Id];

        if (vacancyToCheck.Status__c == vacancyStatusPicklist.get(2)) {
            for (Candidate__c c : getCandidates()) {
                if (c.VacancyCandidateAssociations__r.size() < 1) {
                    candidateList.add(new CandidateWrapper(c));
                }
            }
        }
    }

    public List<CandidateWrapper> getCandidatesToAdd() {
        return candidateList;
    }

    public PageReference getSelected() {
        selectedCandidates.clear();
        for (CandidateWrapper candidatesWrapper : candidateList) {
            if (candidatesWrapper.selected) {
                selectedCandidates.add(candidatesWrapper.candidate);
            }
        }
        return null;
    }

    public List<Candidate__c> getSelectedCandidates() {
        return selectedCandidates;
    }

    public void addCandidates() {
        if (selectedCandidates.size() > 0) {
            for (Candidate__c currentCandidate : selectedCandidates) {
                prepareToAddCandidate(currentCandidate.Id);
            }
            insert vacancyCandidateAssociations;
            currentVacancy.Status__c = vacancyStatusPicklist.get(2);
            update currentVacancy;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, confirmMessage));
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
        }
    }

    public void prepareToAddCandidate(Id CandidateId) {
        VacancyCandidateAssociation__c vacancyCandidate = new VacancyCandidateAssociation__c();
        vacancyCandidate.Vacancy__c = currentVacancy.Id;
        vacancyCandidate.Candidate__c = CandidateId;
        vacancyCandidateAssociations.add(vacancyCandidate);
    }

    public class CandidateWrapper {
        public Candidate__c candidate { get; set; }
        public Boolean selected { get; set; }
        public CandidateWrapper(Candidate__c c) {
            candidate = c;
            selected = false;
        }
    }
}