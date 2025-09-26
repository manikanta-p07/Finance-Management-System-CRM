global class OverdueBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [SELECT Id, Status__c, Due_Date__c FROM Contribution__c WHERE Status__c = 'Pending' AND Due_Date__c < :Date.today()]
        );
    }
    global void execute(Database.BatchableContext bc, List<Contribution__c> scope) {
        for(Contribution__c con : scope){
            con.Status__c = 'Overdue';
        }
        if(!scope.isEmpty()){
            update scope;
        }
    }
    global void finish(Database.BatchableContext bc) {
        System.debug('OverdueBatch finished');
    }
}