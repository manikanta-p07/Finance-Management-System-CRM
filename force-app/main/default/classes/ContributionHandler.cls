public class ContributionHandler {
    public static void beforeInsert(List<Contribution__c> newCons) {
        for(Contribution__c con : newCons){
            if(con.Amount__c == null || con.Amount__c <= 0){
                con.addError('Amount must be greater than 0');
            }
        }
    }

    public static void beforeUpdate(List<Contribution__c> newCons, Map<Id, Contribution__c> oldMap) {
        for(Contribution__c con : newCons){
            Contribution__c oldRec = oldMap.get(con.Id);
            if(oldRec != null && oldRec.Status__c == 'Paid' && con.Status__c != 'Paid'){
                con.addError('Cannot change status once marked as Paid');
            }
        }
    }

    public static void afterInsert(List<Contribution__c> newCons) {
        List<Task> tasks = new List<Task>();
        for(Contribution__c con : newCons){
            Task t = new Task(
                Subject = 'Follow up with member',
                WhatId = con.Id,
                ActivityDate = Date.today().addDays(2)
            );
            tasks.add(t);
        }
        if(!tasks.isEmpty()){
            insert tasks;
        }
    }
}