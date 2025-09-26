@isTest
public class ContributionHandlerTest {
    @isTest
    static void testContributionInsert() {
        // Create a Member
        Member__c mem = new Member__c(First_Name__c='Test', Last_Name__c='User', KYC_ID__c='KYC001', Status__c='Active');
        insert mem;

        Contribution__c con = new Contribution__c(
    	Member__c = mem.Id,  // your existing lookup
    	Amount__c = 500,
    	Due_Date__c = Date.today().addDays(3),
    	Status__c = 'Pending',
    	Membe_Contribution__c = mem.Id // <-- add required field
		);
		insert con;


        // Verify contribution inserted
        Contribution__c inserted = [SELECT Id, Amount__c, Status__c FROM Contribution__c WHERE Id = :con.Id];
        System.assertEquals(500, inserted.Amount__c);
        System.assertEquals('Pending', inserted.Status__c);
    }

    @isTest
    static void testAuctionUpdate_NoWinnerThrows() {
        Auction__c auc = new Auction__c(Auction_Date__c=Date.today().addDays(1), Status__c='Open');
        insert auc;

        // Try to close without a winner - trigger should addError and DML should fail
        auc.Status__c = 'Closed';
        Test.startTest();
        Boolean threw = false;
        try {
            update auc;
        } catch (DmlException e) {
            threw = true;
            System.assert(e.getMessage().contains('Winner must be selected'));
        }
        Test.stopTest();
        System.assert(threw, 'Expected DMLException when closing auction without winner');
    }
    @isTest
    static void testAuctionUpdate_WithWinner() {
        Member__c mem = new Member__c(
            First_Name__c = 'Auction',
            Last_Name__c = 'Winner',
            KYC_ID__c = 'KYC002',
            Status__c = 'Active'
        );
        insert mem;
    
        Auction__c auc = new Auction__c(
            Auction_Date__c = Date.today().addDays(1),
            Status__c = 'Open'
        );
        insert auc;
    
        // Assign Winner before closing
        auc.Status__c = 'Closed';
        auc.Winner__c = mem.Id;
        update auc; // ✅ should pass trigger
    }
    @isTest
    static void testContributionValidation() {
        Member__c mem = new Member__c(
            First_Name__c='Low', Last_Name__c='Amount', KYC_ID__c='KYC003', Status__c='Active'
        );
        insert mem;
    
        // Insert with invalid amount
        Contribution__c badCon = new Contribution__c(
            Member__c = mem.Id,
            Amount__c = 0,
            Due_Date__c = Date.today().addDays(2),
            Status__c = 'Pending',
            Membe_Contribution__c = mem.Id
        );
        Test.startTest();
        try {
            insert badCon;
            System.assert(false, 'Expected validation error for Amount <= 0');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Amount must be greater than 0'));
        }
        Test.stopTest();
    }

        @isTest
        static void testContributionUpdateStatus() {
            Member__c mem = new Member__c(
                First_Name__c='Paid', Last_Name__c='Test', KYC_ID__c='KYC004', Status__c='Active'
            );
            insert mem;
        
            Contribution__c con = new Contribution__c(
                Member__c = mem.Id,
                Amount__c = 200,
                Due_Date__c = Date.today(),
                Status__c = 'Paid',
                Membe_Contribution__c = mem.Id
            );
            insert con;
        
            con.Status__c = 'Pending'; // should fail
            Test.startTest();
            try {
                update con;
                System.assert(false, 'Expected validation error when changing from Paid');
            } catch (DmlException e) {
                System.assert(e.getMessage().contains('Cannot change status once marked as Paid'));
            }
            Test.stopTest();
        }
    @isTest
    static void testFutureNotification() {
        Member__c mem = new Member__c(
            First_Name__c='Notify', Last_Name__c='Test', KYC_ID__c='KYC005', Status__c='Active'
        );
        insert mem;
    
        Test.startTest();
        NotificationService.sendReminder(mem.Id, 'Test Reminder');
        Test.stopTest(); // forces @future method to run
    }


    

}