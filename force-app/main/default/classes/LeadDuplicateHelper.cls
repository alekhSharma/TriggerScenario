/*
 *Utlity methods to check for lead duplicacy on email field
 *
 */
public class LeadDuplicateHelper{

    public static void checkDuplicateLead(Map<String,Lead> leadMap){
        for(Lead lead : [SELECT email FROM Lead
                          WHERE email in :leadMap.KeySet()]){
             if(leadMap.containsKey(lead.email)){
                 Lead newLead = leadMap.get(lead.email);
                 newLead.email.addError('A lead with this email address already exits');
             }
         }
    }

}