/**
 * Class TriggerFactory
 *
 * Used to instantiate and execute Trigger Handlers associated with sObjects.
 */
public with sharing class TriggerFactory{
   /**
     * Public static method to create and execute a trigger handler
     *
     * Arguments:   Schema.sObjectType soType - Object type to process (SObject.sObjectType)
     *
     * Throws a TriggerException if no handler has been coded.
     */
   public static void createHandler(Schema.sObjectType soType){
       // Get a handler appropriate to the object being processed
       ITrigger handler = getHandler(soType);
       
       // Make sure we have a handler registered, new handlers must be registered in the getHandler method.
       if (handler == null){
           throw new TriggerException('No Trigger Handler registered for Object Type: ' + soType);
       }
       
       // Execute the handler to fulfil the trigger
        execute(handler);
        
            
   }// end of createHandler method
   
   /**
     * private static method to control the execution of the handler
     *
     * Arguments:   ITrigger handler - A Trigger Handler to execute
     */ 
    private static void execute(ITrigger handler){
        // Before Trigger
        if (Trigger.isBefore){
            handler.bulkBefore();
            if(System.Trigger.isInsert){
                handler.beforeInsert(trigger.new);
            }
            if(System.Trigger.isUpdate){
                handler.beforeUpdate(System.Trigger.oldMap,System.Trigger.newMap);
            }
            if(System.Trigger.isDelete){
                handler.beforeDelete(System.Trigger.new);
            }
        }//end of if isBefore
        else{
            handler.bulkAfter();
            if(System.Trigger.isInsert){
                handler.afterInsert(trigger.new);
            }
            if(System.Trigger.isUpdate){
                handler.afterUpdate(System.Trigger.oldMap,System.Trigger.newMap);
            }
            if(System.Trigger.isDelete){
                handler.afterDelete(System.Trigger.new);
            }
            
        }//end of else isbefore
    }//End of execute method 
   
   /**
     * private static method to get the appropriate handler for the object type.
     * Modify this method to add any additional handlers.
     *
     * Arguments:   Schema.sObjectType soType - Object type tolocate (SObject.sObjectType)
     *
     * Returns:     ITrigger - A trigger handler if one exists or null.
     */
   private static ITrigger getHandler(Schema.sObjectType soType){
       if(soType == Lead.sObjectType){
           return new LeadHandler();
       }
       return null;
   }//end of getHandler method 
    
}