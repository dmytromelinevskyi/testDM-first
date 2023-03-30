/**
 * Created by dmeli on 25.07.19.
 */

trigger DeleteVacancyFromCandidate on Vacancy__c (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        List<Candidate__c> candidateList = new List<Candidate__c>();
        List<Candidate__c> candidateListToUpdate = new List<Candidate__c>();
        for (Vacancy__c v : Trigger.new) {
            candidateList = [SELECT Id,Vacancies__c, (SELECT Id,LastModifiedDate FROM Vacancies__r) FROM Candidate__c WHERE Id = :Trigger.oldMap.get(v.Id).Candidate__c];
            if (v.Candidate__c != Trigger.oldMap.get(v.Id).Candidate__c) {
                if (candidateList.size() > 0) {
                    for (Candidate__c curCandidate : candidateList) {
                        Integer sizeOfRelatedVacancy = curCandidate.Vacancies__r == null ? 0 : curCandidate.Vacancies__r.size();
                        if (sizeOfRelatedVacancy == 1) {
                            curCandidate.Vacancies__c = null;
                            update curCandidate;
                        } else if (sizeOfRelatedVacancy > 1) {
                            Id vacancyId = curCandidate.Vacancies__c;
                            Id vacancyIdToUpdate = curCandidate.Vacancies__c;
                            for (Vacancy__c relatedVacancies : curCandidate.Vacancies__r) {
                                if (vacancyId == v.Id) {
                                    if (vacancyId != relatedVacancies.Id) {
                                        vacancyIdToUpdate = relatedVacancies.Id;
                                    }
                                }
                            }
                            curCandidate.Vacancies__c = vacancyIdToUpdate;
                            candidateListToUpdate.add(curCandidate);
                            update candidateListToUpdate;
                        }
                    }
                }
            }
        }
    }
}