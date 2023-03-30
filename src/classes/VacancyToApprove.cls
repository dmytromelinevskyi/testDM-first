public class VacancyToApprove {

    private List<VacancyCandidateWrapper> vacancyCandidateList = new List<VacancyCandidateWrapper>();
    private List<VacancyCandidateAssociation__c> selectedVacancyCandidate = new List<VacancyCandidateAssociation__c>();
    private List<Vacancy__c> vacanciesToUpdate = new List<Vacancy__c>();
    private List<Candidate__c> candidatesToUpdate = new List<Candidate__c>();
    private List<VacancyCandidateAssociation__c> vacanciesCandidatesToDelete = new List<VacancyCandidateAssociation__c>();
    private static String confirmMessageApprove = 'One or more record was updated';
    private static String errorMessageApprove = 'You selected 2 vacancies with one candidate. Please select ONLY one vacancy with one candidate';
    private static String confirmMessageReject = 'All selected candidates was rejected';
    private static String confirmMessageCancelled = 'All selected vacancies was cancelled';
//    private static String CONFIR_MMESSAGE = 'All selected vacancies was cancelled';
    private static Map<Integer, String> vacancyStatusPicklist = new Map<Integer, String>{
            1 => 'New', 2 => 'In-Process', 3 => 'Closed', 4 => 'Cancelled'
    };
    private static Map<Integer, String> candidateStatusPicklist = new Map<Integer, String>{
            1 => 'New', 2 => 'Validated by HR', 3 => 'Hired', 4 => 'Disqualified'
    };

    private List<VacancyCandidateAssociation__c> getVacanciesWithCandidates() {
        return [SELECT Vacancy__c, Candidate__c FROM VacancyCandidateAssociation__c WHERE Vacancy__r.Status__c = :vacancyStatusPicklist.get(2) AND Candidate__r.Status__c = :candidateStatusPicklist.get(2)];
    }

    public void onLoad() {
        for (VacancyCandidateAssociation__c vc : getVacanciesWithCandidates()) {
            vacancyCandidateList.add(new VacancyCandidateWrapper(vc));
        }
    }

    public List<VacancyCandidateWrapper> getVacancyToApprove() {
        return vacancyCandidateList;
    }

    public PageReference getSelected() {
        selectedVacancyCandidate.clear();
        for (VacancyCandidateWrapper vacanciesCandidatesWrapper : vacancyCandidateList) {
            if (vacanciesCandidatesWrapper.selected) {
                selectedVacancyCandidate.add(vacanciesCandidatesWrapper.vacancyCandidate);
            }
        }
        return null;
    }

    public List<VacancyCandidateAssociation__c> getSelectedVacanciesWithCandidates() {
        return selectedVacancyCandidate;
    }

    public void approveCandidates() {
        Integer selectedCandidateSize = selectedVacancyCandidate.size();
        if (selectedCandidateSize > 0) {
            Set<VacancyCandidateAssociation__c> vacanciesWithNoEqualCandidates = new Set<VacancyCandidateAssociation__c>();
            for (Integer i = 0; i < selectedCandidateSize; i++) {
                if (selectedCandidateSize > 1) {
                    for (Integer k = i + 1; k < selectedCandidateSize; k++) {
                        if (selectedVacancyCandidate[i].Candidate__c == selectedVacancyCandidate[k].Candidate__c) {
                            vacanciesWithNoEqualCandidates = null;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessageApprove));
                        } else {
                            if (vacanciesWithNoEqualCandidates != null) {
                                vacanciesWithNoEqualCandidates.add(selectedVacancyCandidate[i]);
                                vacanciesWithNoEqualCandidates.add(selectedVacancyCandidate[k]);
                            }
                        }
                    }
                } else {
                    vacanciesWithNoEqualCandidates.add(selectedVacancyCandidate[i]);
                }
            }
            if (vacanciesWithNoEqualCandidates != null) {
                for (VacancyCandidateAssociation__c vacancyCandidateToApprove : vacanciesWithNoEqualCandidates) {
                    prepareToUpdateCandidate(vacancyCandidateToApprove.Candidate__c, vacancyCandidateToApprove.Id);
                    prepareToUpdateVacancy(vacancyCandidateToApprove.Vacancy__c);
                }
                update vacanciesToUpdate;
                update candidatesToUpdate;
                delete vacanciesCandidatesToDelete;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, confirmMessageApprove));
            }
        }
    }


//    public void prepareToUpdateCandidateToReject(Id candidateId, Id vacancyCandidateId) {
//        prepareToUpdateCandidate(Id candidateId, Id vacancyCandidateId, candidateStatusPicklist.get(3));
//    }
//
//    public void prepareToUpdateCandidateToAccept(Id candidateId, Id vacancyCandidateId) {
//        prepareToUpdateCandidate(Id candidateId, Id vacancyCandidateId, candidateStatusPicklist.get(4));
//    }
//
//    public void prepareToUpdateCandidate(Id candidateId, Id vacancyCandidateId, String status) {
//        Candidate__c approvedCandidate = [SELECT Id,Name,Status__c FROM Candidate__c WHERE Id = :candidateId];
//        approvedCandidate.Status__c = status;
//        candidatesToUpdate.add(approvedCandidate);
//        VacancyCandidateAssociation__c vacancyCandidateToDelete = [SELECT Candidate__c, Vacancy__c, Id, Name FROM VacancyCandidateAssociation__c WHERE Candidate__c = :approvedCandidate.Id AND Id != :vacancyCandidateId];
//        vacanciesCandidatesToDelete.add(vacancyCandidateToDelete);
//    }

    public void prepareToUpdateCandidate(Id candidateId, Id vacancyCandidateId) {
        Candidate__c approvedCandidate = [SELECT Id,Name,Status__c FROM Candidate__c WHERE Id = :candidateId];
        approvedCandidate.Status__c = candidateStatusPicklist.get(3);
        candidatesToUpdate.add(approvedCandidate);
        VacancyCandidateAssociation__c vacancyCandidateToDelete = [SELECT Candidate__c, Vacancy__c, Id, Name FROM VacancyCandidateAssociation__c WHERE Candidate__c = :approvedCandidate.Id AND Id != :vacancyCandidateId];
        vacanciesCandidatesToDelete.add(vacancyCandidateToDelete);
    }

    public void prepareToUpdateVacancy(Id vacancyId) {
        Vacancy__c approvedVacancy = [SELECT Id,Name,Status__c FROM Vacancy__c WHERE Id = :vacancyId];
        approvedVacancy.Status__c = vacancyStatusPicklist.get(3);
        vacanciesToUpdate.add(approvedVacancy);
    }

    public void rejectCandidates() {
        Integer selectedCandidateSize = selectedVacancyCandidate.size();
        if (selectedCandidateSize > 0) {
            for (VacancyCandidateAssociation__c rejectedVacancyCandidates : selectedVacancyCandidate) {
                prepareToRejectCandidate(rejectedVacancyCandidates.Candidate__c, rejectedVacancyCandidates);
                prepareToRejectVacancies(rejectedVacancyCandidates.Vacancy__c);
            }
            update candidatesToUpdate;
            update vacanciesToUpdate;
            delete vacanciesCandidatesToDelete;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, confirmMessageReject));
        }
    }

    public void prepareToRejectCandidate(Id candidateId, VacancyCandidateAssociation__c vacancyCandidate) {
        Candidate__c rejectedCandidate = [SELECT Id, Name, Status__c FROM Candidate__c WHERE Id = :candidateId];
        rejectedCandidate.Status__c = candidateStatusPicklist.get(4);
        candidatesToUpdate.add(rejectedCandidate);
        vacanciesCandidatesToDelete.add(vacancyCandidate);
    }

    public void prepareToRejectVacancies(Id vacancyId) {
        Vacancy__c updatedVacancy = [SELECT Id, Name, Status__c FROM Vacancy__c WHERE Id = :vacancyId];
        updatedVacancy.Status__c = vacancyStatusPicklist.get(2);
        vacanciesToUpdate.add(updatedVacancy);
    }

    public void cancelVacancies() {
        Integer selectedCandidateSize = selectedVacancyCandidate.size();
        if (selectedCandidateSize > 0) {
            for (VacancyCandidateAssociation__c cancelledVacancyCandidates : selectedVacancyCandidate) {
                prepareToCancelVacancy(cancelledVacancyCandidates.Vacancy__c, cancelledVacancyCandidates);
            }
            update vacanciesToUpdate;
            delete vacanciesCandidatesToDelete;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, confirmMessageCancelled));
        }
    }

    public void prepareToCancelVacancy(Id vacancyId, VacancyCandidateAssociation__c vacancyCandidate) {
        Vacancy__c cancelledVacancy = [SELECT Id, Name, Status__c FROM Vacancy__c WHERE Id = :vacancyId];
        cancelledVacancy.Status__c = vacancyStatusPicklist.get(4);
        vacanciesToUpdate.add(cancelledVacancy);
        vacanciesCandidatesToDelete.add(vacancyCandidate);
    }

    public class VacancyCandidateWrapper {
        public VacancyCandidateAssociation__c vacancyCandidate { get; set; }
        public Boolean selected { get; set; }
        public VacancyCandidateWrapper(VacancyCandidateAssociation__c vc) {
            vacancyCandidate = vc;
            selected = false;
        }
    }
}