/**
 * Created by dmeli on 19.07.19.
 */

public with sharing class VacancyCandidate {
    List<Candidate__c> candidates = new List<Candidate__c>();

    public List<Vacancy__c> getVacanciesWithCandidate() {
        List<Vacancy__c> results = [SELECT Id,Candidate__c,Title__c FROM Vacancy__c WHERE Candidate__c != NULL];
        return results;
    }

    public void updateCandidate() {
        for (Vacancy__c currentVacancy : getVacanciesWithCandidate()) {
            candidates.add([SELECT Id,Vacancies__c,FirstName__c FROM Candidate__c WHERE Id = :currentVacancy.Candidate__c]);

            System.debug('candidates@@@@@@@@@ ----- ' + candidates);

//            for (Candidate__c currentCandidate : candidates) {
//                currentCandidate.Vacancies__c = currentVacancy.Id;
//                System.debug('CANDIDATE ----- ' + currentCandidate);
//                update currentCandidate;
//            }
        }
    }
}