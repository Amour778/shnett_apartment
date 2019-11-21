package com.workplan.tools;


/**
 * 这个类作为弱电项目审核状态的纪录，代码无实际参与
 * @author Administrator
 *
 */
public class ApprovalStatusOfWeakCurrent {

	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(approvalStatus("1010"));
	}
	public static String approvalStatus(String statue_number) {
		System.out.println("进入的审核状态代码为："+statue_number);
		String infoString;
		switch (Integer.parseInt(statue_number)) {
		case 1010:
			infoString = "立项-大区负责人待审核";
			break;
		case 1011:
			infoString = "立项-大区负责人已通过";
			break;
		case 1012:
			infoString = "立项-大区负责人已驳回";
			break;
		case 1020:
			infoString = "立项-管理员待审核";
			break;
		case 1021:
			infoString = "立项-已立项";
			break;
		case 1022:
			infoString = "立项-管理员已驳回";
			break;
		case 1030:
			infoString = "立项-已撤项";
			break;

		case 2010:
			infoString = "实际开支-大区负责人待审核";
			break;
		case 2011:
			infoString = "实际开支-大区负责人通过";
			break;
		case 2012:
			infoString = "实际开支-大区负责人驳回";
			break;
		case 2020:
			infoString = "实际开支-管理员待审核";
			break;
		case 2021:
			infoString = "实际开支-管理员已通过";
			break;
		case 2022:
			infoString = "实际开支-管理员已驳回";
			break;
		case 2030:
			infoString = "实际开支-财务待审核";
			break;
		case 2031:
			infoString = "实际开支-财务已通过";
			break;
		case 2032:
			infoString = "实际开支-财务已驳回";
			break;
		case 2040:
			infoString = "实际开支-BOSS待审核";
			break;
		case 2041:
			infoString = "实际开支-BOSS已通过";
			break;
		case 2042:
			infoString = "实际开支-BOSS已驳回";
			break;

		case 3010:
			infoString = "申请结项-大区负责人待审核";
			break;
		case 3011:
			infoString = "申请结项-大区负责人已通过";
			break;
		case 3012:
			infoString = "申请结项-大区负责人已驳回";
			break;
		case 3020:
			infoString = "申请结项-财务待审核";
			break;
		case 3021:
			infoString = "申请结项-财务已通过";
			break;
		case 3022:
			infoString = "申请结项-财务已驳回";
			break;
		case 3030:
			infoString = "申请结项-管理员待审核";
			break;
		case 3031:
			infoString = "申请结项-管理员已通过";
			break;
		case 3032:
			infoString = "申请结项-管理员已驳回";
			break;

		case 4010:
			infoString = "个人奖金-大区负责人待审核";
			break;
		case 4011:
			infoString = "个人奖金-大区负责人已通过";
			break;
		case 4012:
			infoString = "个人奖金-大区负责人已驳回";
			break;
		case 4020:
			infoString = "个人奖金-管理员待审核";
			break;
		case 4021:
			infoString = "个人奖金-管理员已通过";
			break;
		case 4022:
			infoString = "个人奖金-管理员已驳回";
			break;
		case 4030:
			infoString = "个人奖金-BOSS待审核";
			break;
		case 4031:
			infoString = "个人奖金-BOSS已通过";
			break;
		case 4032:
			infoString = "个人奖金-BOSS已驳回";
			break;
		case 4040:
			infoString = "个人奖金-人资待审核";
			break;
		case 4041:
			infoString = "个人奖金-人资已通过";
			break;
		case 4042:
			infoString = "个人奖金-人资已驳回";
			break;
			
		case 9999:
			infoString = "工程已结项";
			break;
			
		default:
			infoString = "NULL";
			break;
		}
		return infoString;
	}

}
