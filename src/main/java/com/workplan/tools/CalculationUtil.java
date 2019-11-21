package com.workplan.tools;

import java.math.BigDecimal;

/**
 * 弱电项目专用类
 * 
 * @author 01059101 
 * 此类用户涉及到的计算内容 分三个阶段计算：
 *  ①立项：通过 
 *  ②实际开支：财务通过 
 *  ③申请结项：通过
 * 
 */
public class CalculationUtil {
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	/**
	 * ①立项：通过SQL语句
	 * subtotal_cost,project_quotation,project_quotation,simple_tax,simple_tax,simple_tax,project_code
	 * 费用小计=材料+人工(外请)+固定资产分摊+其他项
	 * subtotal_cost = material + allocation_of_fixed_assets + other_items
	 * 成本占比=费用小计/项目报价
	 * cost_share = subtotal_cost / project_quotation
	 * 税价全额 = 项目报价
	 * full_amount_of_tax = project_quotation
	 * 管理成本2% = 税价全额*0.02
	 * management_costs = full_amount_of_tax * 0.02
	 * 税额 6~11%=税价全额/(1+simple_tax)*simple_tax
	 * tax_money = full_amount_of_tax / ( 1 + simple_tax ) * simple_tax
	 * 本金=税价全额/(1+simple_tax)
	 * principal= full_amount_of_tax / ( 1 + simple_tax )
	 * 待收金额=税价全额*0.05
	 * amount_to_be_collected = full_amount_of_tax*0.05
	 */
	public String Sql_HaveWCP() {
		String SQL_HaveWCP=
			"UPDATE weak_current_projects_detail "+
			"SET " +
			"cost_share = ? / ? , "+
			"full_amount_of_tax = ? , "+
			"management_costs = full_amount_of_tax * 0.02 , "+
			"tax_money = full_amount_of_tax / (1 + ? ) * ? , "+
			"principal = full_amount_of_tax / (1 + ? ), "+
			"amount_to_be_collected = full_amount_of_tax * 0.05 "+
			"WHERE "+
			"project_code = ?";
		System.out.println("SQL_HaveWCP="+SQL_HaveWCP);
		return SQL_HaveWCP;
	}
	

		/**
		 * ②实际开支：财务通过
		 * item,item,money,project_code
		 * 人工材料费用小计 = 材料费(含税)+外包人工费、水电(含税)+运杂费 + 工具固定资产分摊+招待 - 抵税金额(增值税专用发票)
		 * subtotal_labor_material_costs = material_cost_including_tax + outsourcing_including_tax + transport_fees + allocation_of_fixed_assets_of_instruments + entertain - tax_credit_amount
		 */
	public String SQL_WCPAE(String item) {
		String SQL_WCPAE=
			"UPDATE weak_current_projects_detail set "+ item +" = "+item+" + ?, " +
			"subtotal_labor_material_costs = material_cost_including_tax + " +
			"outsourcing_including_tax + " +
			"transport_fees + " +
			"allocation_of_fixed_assets_of_instruments + " +
			"entertain - " +
			"tax_credit_amount " +
			"WHERE project_code = ? ";
		System.out.println("SQL_WCPAE="+SQL_WCPAE);
		return SQL_WCPAE;
	}

	/**
	 * ③申请结项：通过
	 * (税额 6~11% - 抵税金额(增值税专用发票))  >0
	 * tax_money - tax_credit_amount > 0
	 * item,item,money,project_code
	 */
	public String SQL_WCPFinalGreaterThanZero() {
		String SQL_WCPFinalGreaterThanZero=""+
			"UPDATE weak_current_projects_detail "+
			"SET tax_reimbursement = ((tax_money - tax_credit_amount) * 1.12 + full_amount_of_tax * 0.0005) + subtotal_labor_material_costs * 0.0005, "+
			"subtotal_management_fees_and_taxes = management_costs + tax_reimbursement, "+
			"real_gross_profit = full_amount_of_tax - subtotal_labor_material_costs - subtotal_management_fees_and_taxes, "+
			"real_gross_profit_per = real_gross_profit / full_amount_of_tax, "+
			"surplus_gross_profit = real_gross_profit - remaining_stock, "+
			"surplus_gross_profit_per = surplus_gross_profit / full_amount_of_tax, "+
			"net_profit = real_gross_profit * 0.75, "+
			"net_profit_per = net_profit / full_amount_of_tax, "+
			"quality_assurance_funds = net_profit * returned_money_point, "+
			"personal = net_profit * 0.25, "+
			"capital_pool = net_profit * 0.25, "+
			"company = net_profit * 0.50, "+
			"personal_warranty = personal * returned_money_point, "+
			"personal_actual_distribution = personal - personal_warranty "+
			"WHERE "+
			"project_code = ?";
		System.out.println("SQL_WCPFinalGreaterThanZero="+SQL_WCPFinalGreaterThanZero);
		return SQL_WCPFinalGreaterThanZero;
	}

	/**
	 * ③申请结项：通过
	 * (税额 6~11% - 抵税金额(增值税专用发票))  <=0
	 * item,item,money,project_code
	 */
	public String SQL_WCPFinalLessThanOrEqualToZero() {
	String SQL_WCPFinalGreaterThanZero=""+
		"UPDATE weak_current_projects_detail "+
		"SET tax_reimbursement = full_amount_of_tax * 0.0005 + subtotal_labor_material_costs * 0.0005, "+
		"subtotal_management_fees_and_taxes = management_costs + tax_reimbursement, "+
		"real_gross_profit = full_amount_of_tax - tax_reimbursement - subtotal_management_fees_and_taxes, "+
		"real_gross_profit_per = real_gross_profit / full_amount_of_tax, "+
		"surplus_gross_profit = real_gross_profit - remaining_stock, "+
		"surplus_gross_profit_per = surplus_gross_profit / full_amount_of_tax, "+
		"net_profit = real_gross_profit * 0.75, "+
		"net_profit_per = net_profit / full_amount_of_tax, "+
		"quality_assurance_funds = net_profit * returned_money_point, "+
		"personal = net_profit * 0.25, "+
		"capital_pool = net_profit * 0.25, "+
		"company = net_profit * 0.50, "+
		"personal_warranty = personal * returned_money_point, "+
		"personal_actual_distribution = personal - personal_warranty "+
		"WHERE "+
		"project_code = ?";
	System.out.println("SQL_WCPFinalGreaterThanZero="+SQL_WCPFinalGreaterThanZero);
	return SQL_WCPFinalGreaterThanZero;
	}
	
			
		

	
	/*
	 * 
【成本估算】
费用小计=材料+人工(外请)+固定资产分摊+其他项
subtotal_cost = material + allocation_of_fixed_assets + other_items

【成本占比%】
成本占比=费用小计/项目报价
cost_share = subtotal_cost / project_quotation

【实际开支】
人工材料费用小计 = 材料费(含税)+外包人工费、水电(含税)+运杂费 + 工具固定资产分摊+招待 - 	 抵税金额(增值税专用发票)
subtotal_labor_material_costs = material_cost_including_tax + outsourcing_including_tax + transport_fees + allocation_of_fixed_assets_of_instruments + entertain - tax_credit_amount

【税务管理 】
税价全额 = 项目报价
full_amount_of_tax = project_quotation

管理成本2% = 税价全额*0.02
management_costs = full_amount_of_tax * 0.02

税额 6~11%=税价全额/(1+simple_tax)*simple_tax
tax_money = full_amount_of_tax / ( 1 + simple_tax ) * simple_tax

本金=税价全额/(1+simple_tax)
principal= full_amount_of_tax / ( 1 + simple_tax )

(财务填)补税
如果 (税额 6~11% - 抵税金额(增值税专用发票))  >0
	补税=(税额 6~11% - 抵税金额(增值税专用发票)) *0.12 + 税价全额*0.0005
	tax_reimbursement = ( tax_money - tax_credit_amount ) *0.12 + full_amount_of_tax * 0.0005
否则
	补税=人工材料费用小计*0.0005
	tax_reimbursement = subtotal_labor_material_costs * 0.0005

管理费及税务小计=管理成本2% +(财务填)补税
subtotal_management_fees_and_taxes = management_costs + tax_reimbursement


实际毛利=税价全额-人工材料费用小计-管理费及税务小计
real_gross_profit = full_amount_of_tax - tax_reimbursement - subtotal_management_fees_and_taxes

实际毛利%=实际毛利/税价全额
real_gross_profit_per = real_gross_profit / full_amount_of_tax


余料毛利=实际毛利-余材库存
surplus_gross_profit = real_gross_profit_per - remaining_stock

余料毛利%=余料毛利/税价全额
surplus_gross_profit_per = surplus_gross_profit / full_amount_of_tax

净利润=实际毛利*0.75
net_profit = real_gross_profit * 0.75

净利%=净利润/税价全额
net_profit_per = net_profit / full_amount_of_tax

待收金额=税价全额*0.05
amount_to_be_collected = full_amount_of_tax * 0.05

个人25%=净利润*0.25
personal = net_profit * 0.25

资金池25%=净利润*0.25
capital_pool = net_profit * 0.25

公司50%=净利润*0.50
company = net_profit * 0.50

个人质保金=个人25%*质保金(未收)
personal_warranty = personal * quality_assurance_funds

个人实际发放=个人25%-个人质保金
personal_actual_distribution = personal - personal_warranty

	 */
	
	

	private static BigDecimal BigDecimalDivision(Object a, Object b) {
	    BigDecimal result = new BigDecimal(String.valueOf(a)).divide(new BigDecimal(String.valueOf(b)), 2, BigDecimal.ROUND_HALF_UP);
	    return result;
	}
	//MYSQL 除法 ：SELECT TRUNCATE(1/0.3,2)
	//MYSQL 乘法 ：SELECT TRUNCATE(1.23*0.35,2)
}
