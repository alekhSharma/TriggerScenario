/**
 * Class LeadHandler
 *
 * Trigger Handler for the Lead SObject. This class implements the ITrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */
 public with sharing class LeadHandler implements ITrigger{
 
     Map<String, Lead> leadMap = new Map<String, Lead>();
     
     //Constructor
     public LeadHandler(){
     
     }
     
     /**
     * bulkBefore
     *
     * This method is called prior to execution of a BEFORE trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */
     public void bulkBefore(){
         if(System.Trigger.isInsert){
             for(sObject so :System.Trigger.new){
                 // Logic to check if new created leads have same email ids.
                 Lead lead = (Lead)so;
                 if(lead.email != null){
                     if(leadMap.containsKey(lead.email)){
                         lead.email.addError('Another new lead has the same email address.');
                     }else{
                         leadMap.put(lead.email,lead);
                     }
                 }
             }
         }//end of isInsert
         if(System.Trigger.isUpdate){
             for(SObject so: System.Trigger.new){
                 Lead newLead = (Lead)so;
                 Lead oldLead = (Lead)System.Trigger.oldMap.get(newLead.id);
                 if(newLead.email != oldLead.Email){
                     leadMap.put(newLead.email,newLead);
                 }
             }//end of for
         }
     }
     
     public void bulkAfter(){
     
     }
     
     public void beforeInsert(List<Sobject> soLst){
         LeadDuplicateHelper.checkDuplicateLead(leadMap);
         
     }
     
     public void beforeUpdate(Map<Id,SObject> oldSoMap, Map<Id,SObject> newSoMap){
         LeadDuplicateHelper.checkDuplicateLead(leadMap);
     }
     
     /**
     * beforeDelete
     *
     * This method is called iteratively for each record to be deleted during a BEFORE
     * trigger.
     */
     public void beforeDelete(List<Sobject> soLst){
     
     }
     
     public void afterInsert(List<Sobject> soLst){
     
     }
     
     public void afterUpdate(Map<Id,SObject> oldSoMap, Map<Id,SObject> newSoMap){
     
     }
     
     public void afterDelete(List<Sobject> soLst){
     
     }
     
     /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
     public void andFinally(){
     
     }
 
 }//End of LeadHandlerClass