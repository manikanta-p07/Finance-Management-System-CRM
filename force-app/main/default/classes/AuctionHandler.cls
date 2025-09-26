public class AuctionHandler {
    public static void beforeUpdate(List<Auction__c> newList, Map<Id, Auction__c> oldMap) {
        for(Auction__c auc : newList){
            Auction__c oldRec = oldMap.get(auc.Id);
            if(auc.Status__c == 'Closed' && String.isBlank(auc.Winner__c)){
                auc.addError('Winner must be selected before closing an auction');
            }
        }
    }
}