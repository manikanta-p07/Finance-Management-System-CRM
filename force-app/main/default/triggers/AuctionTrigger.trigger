trigger AuctionTrigger on Auction__c (before update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        AuctionHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }
}