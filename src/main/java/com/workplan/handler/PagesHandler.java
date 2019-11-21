package com.workplan.handler;

import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiresUser
public class PagesHandler {
	@RequestMapping("/login")
	private String list() {
		System.out.println("login界面");
		return "login";
	}

	@RequestMapping("/main")
	private String main() {
		System.out.println("main界面");
		return "main";
	}

	@RequestMapping("/index")
	private String index() {
		System.out.println("index界面");
		return "index";
	}
	@RequestMapping("/home/console")
	private String home_console() {
		System.out.println("/home/console界面");
		return "/home/console";
	}

	@RequestMapping("/system/userinfo")
	private String system_userinfo() {
		System.out.println("/system/userinfo界面");
		return "/system/userinfo";
	}
	@RequestMapping("/system/role")
	private String system_role() {
		System.out.println("/system/role界面");
		return "/system/role";
	}
	@RequestMapping("/system/rolepermission")
	private String system_rolepermission() {
		System.out.println("/system/rolepermission界面");
		return "/system/rolepermission";
	}
	@RequestMapping("/system/authorities")
	private String system_authorities() {
		System.out.println("/system/authorities界面");
		return "/system/authorities";
	}
	@RequestMapping("/tpl/add_edit_user")
	private String tpl_add_edit_user() {
		System.out.println("/tpl/add_edit_user界面");
		return "/tpl/add_edit_user";
	}
	@RequestMapping("/tpl/add_edit_role")
	private String tpl_add_edit_role() {
		System.out.println("/tpl/add_edit_role界面");
		return "/tpl/add_edit_role";
	}
	@RequestMapping("/tpl/add_edit_permission")
	private String tpl_add_edit_permission() {
		System.out.println("/tpl/add_edit_permission界面");
		return "/tpl/add_edit_permission";
	}
	@RequestMapping("/tpl/edit_user_role")
	private String tpl_edit_user_role() {
		System.out.println("/tpl/edit_user_role界面");
		return "/tpl/edit_user_role";
	}
	@RequestMapping("/system/permission")
	private String system_permission() {
		System.out.println("/system/permission界面");
		return "/system/permission";
	}
	@RequestMapping("/tpl/theme")
	private String tpl_theme() {
		System.out.println("/tpl/theme界面");
		return "/tpl/theme";
	}


	@RequestMapping("/tpl/password")
	private String tpl_password() {
		System.out.println("/tpl/password界面");
		return "/tpl/password";
	}

	@RequestMapping("/tpl/message")
	private String tpl_message() {
		System.out.println("/tpl/message界面");
		return "/tpl/message";
	}

	@RequestMapping("/system/user_form")
	private String system_user_form() {
		System.out.println("/system/user_form界面");
		return "/system/user_form";
	}

	@RequestMapping("/system/login_record")
	private String system_login_record() {
		System.out.println("/system/login_record界面");
		return "/system/login_record";
	}
	
	
	
	
	//**********************框架外界面***********************************//
	

	@RequestMapping("/function_page/panorama")
	private String function_page_panorama() {
		System.out.println("/function_page/panorama界面");
		return "/function_page/panorama";
	}
	@RequestMapping("/function_page/workitemfirst")
	private String function_workitemfirst() {
		System.out.println("/function_page/workitemfirst界面");
		return "/function_page/workitemfirst";
	}

	@RequestMapping("/function_page/templets")
	private String function_templets() {
		System.out.println("/function_page/templets界面");
		return "/function_page/templets";
	}
	
	@RequestMapping("/tpl/add_panorama")
	private String tpl_add_panorama() {
		System.out.println("/tpl/add_panorama界面");
		return "/tpl/add_panorama";
	}
	@RequestMapping("/tpl/addstep")
	private String tpl_addstep() {
		System.out.println("/tpl/addstep界面");
		return "/tpl/addstep";
	}
	@RequestMapping("/tpl/edit_panorama")
	private String tpl_edit_panorama() {
		System.out.println("/tpl/edit_panorama界面");
		return "/tpl/edit_panorama";
	}
	@RequestMapping("/tpl/pannrama_detail")
	private String tpl_pannrama_detail() {
		System.out.println("/tpl/pannrama_detail界面");
		return "/tpl/pannrama_detail";
	}
	@RequestMapping("/tpl/progress")
	private String tpl_progress() {
		System.out.println("/tpl/progress界面");
		return "/tpl/progress";
	}
	@RequestMapping("/function_page/wcp/weak_current_projects_summary")
	private String weak_current_projects_summary() {
		System.out.println("/function_page/wcp/weak_current_projects_summary界面");
		return "/function_page/wcp/weak_current_projects_summary";
	}
	@RequestMapping("/function_page/wcp/weak_current_project")
	private String weak_current_project() {
		System.out.println("/function_page/wcp/weak_current_project界面");
		return "/function_page/wcp/weak_current_project";
	}
	@RequestMapping("/tpl/wcp/add_edit_weak_current_project")
	private String tpl_add_edit_weak_current_project() {
		System.out.println("/tpl/wcp/add_edit_weak_current_project界面");
		return "/tpl/wcp/add_edit_weak_current_project";
	}
	@RequestMapping("/tpl/wcp/update_wcp_progress")
	private String tpl_update_wcp_progress() {
		System.out.println("/tpl/wcp/update_wcp_progress界面");
		return "/tpl/wcp/update_wcp_progress";
	}
	@RequestMapping("/function_page/wcp/weak_current_project_actual_expenditure")
	private String function_page_weak_current_project_actual_expenditure() {
		System.out.println("/function_page/wcp/weak_current_project_actual_expenditure界面");
		return "/function_page/wcp/weak_current_project_actual_expenditure";
	}
	@RequestMapping("/tpl/wcp/add_wcp_actual_expenditure")
	private String tpl_add_wcp_actual_expenditure() {
		System.out.println("/tpl/wcp/add_wcp_actual_expenditure界面");
		return "/tpl/wcp/add_wcp_actual_expenditure";
	}
	@RequestMapping("/tpl/wcp/edit_wcp_actual_expenditure")
	private String tpl_edit_wcp_actual_expenditure() {
		System.out.println("/tpl/wcp/edit_wcp_actual_expenditure界面");
		return "/tpl/wcp/edit_wcp_actual_expenditure";
	}
	@RequestMapping("/tpl/wcp/add_wcp_bonus_shares")
	private String tpl_add_wcp_bonus_shares() {
		System.out.println("/tpl/wcp/add_wcp_bonus_shares界面");
		return "/tpl/wcp/add_wcp_bonus_shares";
	}
	@RequestMapping("/tpl/wcp/pending_audit_wcp_bonus_shares")
	private String tpl_pending_audit_wcp_bonus_shares() {
		System.out.println("/tpl/wcp/pending_audit_wcp_bonus_shares界面");
		return "/tpl/wcp/pending_audit_wcp_bonus_shares";
	}
	@RequestMapping("/tpl/wcp/show_wcp_bonus_shares")
	private String tpl_show_wcp_bonus_shares() {
		System.out.println("/tpl/wcp/show_wcp_bonus_shares界面");
		return "/tpl/wcp/show_wcp_bonus_shares";
	}
	@RequestMapping("/tpl/wcp/pending_audit_wcp_summary")
	private String tpl_pending_audit_wcp_summary() {
		System.out.println("/tpl/wcp/pending_audit_wcp_summary界面");
		return "/tpl/wcp/pending_audit_wcp_summary";
	}
	@RequestMapping("/tpl/wcp/show_wcp_summary")
	private String tpl_show_wcp_summary() {
		System.out.println("/tpl/wcp/show_wcp_summary界面");
		return "/tpl/wcp/show_wcp_summary";
	}

	@RequestMapping("/function_page/wechat_edianzu_information_gathering")
	private String function_page_wechat_edianzu_information_gathering() {
		System.out.println("/function_page/wechat_edianzu_information_gathering界面");
		return "/function_page/wechat_edianzu_information_gathering";
	}
	@RequestMapping("/tpl/show_wechat_edianzu_img")
	private String tpl_show_wechat_edianzu_img() {
		System.out.println("/tpl/show_wechat_edianzu_img界面");
		return "/tpl/show_wechat_edianzu_img";
	}
	@RequestMapping("/tpl/wcp/show_wcp_simple")
	private String tpl_show_wcp_simple() {
		System.out.println("/tpl/wcp/show_wcp_simple界面");
		return "/tpl/wcp/show_wcp_simple";
	}
	@RequestMapping("/tpl/wcp/show_wcp_files")
	private String tpl_show_wcp_files() {
		System.out.println("/tpl/wcp/show_wcp_files界面");
		return "/tpl/wcp/show_wcp_files";
	}
	@RequestMapping("/tpl/wcp/pending_wcp_actual_expenditure")
	private String tpl_pending_wcp_actual_expenditure() {
		System.out.println("/tpl/wcp/pending_wcp_actual_expenditure界面");
		return "/tpl/wcp/pending_wcp_actual_expenditure";
	}
	@RequestMapping("/tpl/wcp/show_wcp_actual_expenditure")
	private String tpl_show_wcp_actual_expenditure() {
		System.out.println("/tpl/wcp/show_wcp_actual_expenditure界面");
		return "/tpl/wcp/show_wcp_actual_expenditure";
	}

	@RequestMapping("/tpl/demo")
	private String tpl_demo() {
		System.out.println("/tpl/demo界面");
		return "/tpl/demo";
	}

	/***********智慧公寓************/
	@RequestMapping("/function_page/apartment/network")
	private String apartment_network() {
		System.out.println("/function_page/apartment/network");
		return "/function_page/apartment/network";
	}

	@RequestMapping("/function_page/apartment/apartment")
	private String apartment_apartment() {
		System.out.println("/function_page/apartment/apartment");
		return "/function_page/apartment/apartment";
	}

	@RequestMapping("/function_page/apartment/apartment_roo")
	private String apartment_apartment_roo() {
		System.out.println("/function_page/apartment/apartment_roo");
		return "/function_page/apartment/apartment_roo";
	}

	@RequestMapping("/function_page/apartment/apartment_bed")
	private String apartment_apartment_bed() {
		System.out.println("/function_page/apartment/apartment_bed");
		return "/function_page/apartment/apartment_bed";
	}

	@RequestMapping("/function_page/apartment/apply")
	private String apartment_apply() {
		System.out.println("/function_page/apartment/apply");
		return "/function_page/apartment/apply";
	}

	@RequestMapping("/tpl/apartment/applyCheckInInfo")
	private String tpl_apartment_applyCheckInInfo() {
		System.out.println("/tpl/apartment/applyCheckInInfo");
		return "/tpl/apartment/applyCheckInInfo";
	}

	@RequestMapping("/tpl/apartment/applyCheckOutInfo")
	private String tpl_apartment_applyCheckOutInfo() {
		System.out.println("/tpl/apartment/applyCheckOutInfo");
		return "/tpl/apartment/applyCheckOutInfo";
	}
	@RequestMapping("/tpl/apartment/apartmentInfo")
	private String tpl_apartment_apartmentInfo() {
		System.out.println("/tpl/apartment/apartmentInfo");
		return "/tpl/apartment/apartmentInfo";
	}

	@RequestMapping("/tpl/apartment/checkIn")
	private String tpl_apartment_checkIn() {
		System.out.println("/tpl/apartment/checkIn");
		return "/tpl/apartment/checkIn";
	}

	@RequestMapping("/function_page/apartment/data_analysis")
	private String apartment_data_analysis() {
		System.out.println("/function_page/apartment/data_analysis");
		return "/function_page/apartment/data_analysis";
	}


	@RequestMapping("/function_page/apartment/score")
	private String apartment_data_score() {
		System.out.println("/function_page/apartment/score");
		return "/function_page/apartment/score";
	}


	@RequestMapping("/function_page/apartment/notice")
	private String apartment_data_notice() {
		System.out.println("/function_page/apartment/notice");
		return "/function_page/apartment/notice";
	}

	@RequestMapping("/function_page/apartment/signIn")
	private String apartment_data_signIn() {
		System.out.println("/function_page/apartment/signIn");
		return "/function_page/apartment/signIn";
	}

	@RequestMapping("/function_page/apartment/mapSelect")
	private String apartment_data_mapSelect() {
		System.out.println("/function_page/apartment/mapSelect");
		return "/function_page/apartment/mapSelect";
	}


}
