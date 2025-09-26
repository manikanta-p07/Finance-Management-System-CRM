trigger ContributionTrigger on Contribution__c (before insert, before update, after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        ContributionHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        ContributionHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        ContributionHandler.afterInsert(Trigger.new);
    }
}