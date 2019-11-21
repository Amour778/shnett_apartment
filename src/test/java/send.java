import com.workplan.handler.aparment.SendWxTemplateMessageHandler;

public class send {
    public static void main(String[] args) {
        SendWxTemplateMessageHandler sendWxTemplateMessageHandler=new SendWxTemplateMessageHandler();
        String returnMessage =sendWxTemplateMessageHandler.sendApplyCheckSubscribeMessage("陈贤杰","入住","通过","oavp45KDUn3DJHb9YsbiqXdIjoRU");
        System.out.println(returnMessage);
        returnMessage =sendWxTemplateMessageHandler.sendNewApplySubscribeMessage("01059101","入住","2019年10月22日","2019年10月22日","oavp45KDUn3DJHb9YsbiqXdIjoRU");
        System.out.println(returnMessage);
    }

}
