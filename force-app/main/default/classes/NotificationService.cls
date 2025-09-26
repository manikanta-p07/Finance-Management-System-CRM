public class NotificationService {
    @future
    public static void sendReminder(Id memberId, String message){
        // In real integration: perform callout to SMS/Email provider
        System.debug('Reminder for Member: ' + memberId + ' -> ' + message);
    }
}