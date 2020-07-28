* Project: WB COVID
* Created on: July 2020
* Created by: jdm
* Stata v.16.1

* does
	* reads in first two rounds of Ethiopia data
	* builds panel
	* outputs panel data

* assumes
	* raw Ethiopia data

* TO DO:
	* complete


* **********************************************************************
* 0 - setup
* **********************************************************************

* define 
	global	root	=	"$data/ethiopia/raw"
	global	export	=	"$data/ethiopia/refined"
	global	logout	=	"$data/ethiopia/logs"

* open log
	cap log 		close
	log using		"$logout/eth_build", append

	

* ***********************************************************************
* 1 - build ethiopia panel
* ***********************************************************************

* load round 1 of the data
	use				"$root/wave_01/200614_WB_LSMS_HFPM_HH_Survey-Round1_Clean-Public_Microdata", ///
						clear
	
* generate round variable
	gen				wave = 1
	lab var			wave "Wave number"
	
* append round 2 of the data
	append 			using "$root/wave_02/200620_wb_lsms_hfpm_hh_survey_round2_clean_public_microdata", ///
						force
	
	replace			wave = 2 if wave == .
	order			wave, after(household_id)

* rationalize variables across waves
	gen				phw = phw1 if phw1 != .
	replace			phw = phw2 if phw2 != .
	lab var			phw "sampling weights"
	order			phw, after(phw1)
	drop			phw1 phw2
	
	rename			ii4_resp_id resp_id
	rename			cs4_sector sector
	rename			cs5_eaid ea
	rename			cs6_hhid hh_id
	rename			cs7_hhh_id hhh_id
	rename			cs1_region region
	rename			cs2_zoneid zone_id
	rename			cs3_woredaid county_id
	rename			cs3c_cityid city_id
	rename			cs3c_subcityid subcity_id
	rename			cs3b_kebeleid neighborhood_id
	rename			cs_startdate start_date
	rename			cs_submissiondate submission_date
	rename			cs7a_hhh_gender hhh_gender
	rename			cs7a_hhh_age hhh_age
	rename			cs12_round round
	rename			ii1_attempt attempt
	rename			bi_locchange loc_chg
	rename			bi_same_hhh same_hhh
	rename			kn1_heard know
	rename			kn2_meas_handwash know_01
	rename			kn2_meas_handshake know_02
	rename			kn2_meas_maskglove know_03
	rename			kn2_meas_travel know_04
	rename			kn2_meas_stayhome know_05
	rename			kn2_meas_gatherings know_06
	rename			kn2_meas_distance know_07
	rename			kn2_meas_facetouch know_08
	rename			kn3_gov gov
	rename			kn3_gov_1 gov_01
	rename			kn3_gov_2 gov_02
	rename			kn3_gov_3 gov_03
	rename			kn3_gov_4 gov_04
	rename			kn3_gov_5 gov_05
	rename			kn3_gov_6 gov_06
	rename			kn3_gov_7 gov_07
	rename			kn3_gov_8 gov_08
	rename			kn3_gov_9 gov_09
	rename			kn3_gov_10 gov_10
	rename			kn3_gov_11 gov_11
	rename			kn3_gov_12 gov_12
	rename			bh1_handwash bh_01
	rename			bh2_handshake bh_02
	rename			bh3_gatherings bh_03
	rename			ac1_atb_med ac_med
	rename			ac2_atb_med_why ac_med_why
	rename			ac1_atb_teff ac_teff
	rename			ac2_atb_teff_why ac_teff_why
	rename			ac1_atb_wheat ac_wheat
	rename			ac2_atb_wheat_why ac_wheat_why
	rename			ac1_atb_maize ac_maize
	rename			ac2_atb_maize_why  ac_maize_why
	rename			ac1_atb_oil ac_oil
	rename			ac2_atb_oil_why ac_oil_why
	rename			ac3_sch_child sch_child
	rename			ac4_sch_girls sch_girl
	rename			ac4_sch_boys sch_boy
	rename			ac4_2_edu edu_act
	rename			ac5_edu_type edu
	rename			ac5_edu_type_1 edu_01
	rename			ac5_edu_type_2 edu_02
	rename			ac5_edu_type_3 edu_03
	rename			ac5_edu_type_4 edu_04
	rename			ac5_edu_type_5 edu_05
	rename			ac6_med med
	rename			ac7_med_access med_access
	rename			ac8_med_access_reas med_access_why
	rename			ac9_bank bank 
	rename			em1_work_cur emp
	rename			em6_work_cur_act emp_act
	rename			em6_work_cur_act_other emp_act_other
	rename			em7_work_cur_status emp_stat
	rename			em7_work_cur_status_other emp_stat_other
	rename			em8_work_cur_same emp_same
	rename			em9_work_change_why emp_chg_why
	rename			em2_work_pre emp_pre
	rename			em3_work_no_why emp_pre_why
	rename			em4_work_pre_act emp_pre_act
	rename			em5_work_pre_status emp_pre_stat
	rename			em12_work_cur_able emp_able
	rename			em13_work_cur_notable_paid emp_unable
	rename			em14_work_cur_notable_why emp_unable_why
	rename			em15_bus bus_emp
	rename			em16_bus_sector bus_sect
	rename			em17_bus_inc bus_emp_inc
	rename			em18_bus_inc_low_amt bus_amt
	rename			em19_bus_inc_low_why bus_why
	rename			em19_bus_inc_low_why_1 bus_why_01
	rename			em19_bus_inc_low_why_2 bus_why_02
	rename			em19_bus_inc_low_why_3 bus_why_03
	rename			em19_bus_inc_low_why_4 bus_why_04
	rename			em19_bus_inc_low_why_5 bus_why_05
	rename			em19_bus_inc_low_why_6 bus_why_06
	rename			em19_bus_inc_low_why_7 bus_why_07
	rename			em20_farm farm_emp
	rename			em21_farm_norm farm_norm
	rename			em22_farm_norm_why farm_why
	rename			em22_farm_norm_why_1 farm_why_01
	rename			em22_farm_norm_why_2 farm_why_02
	rename			em22_farm_norm_why_3 farm_why_03
	rename			em22_farm_norm_why_4 farm_why_04
	rename			em22_farm_norm_why_5 farm_why_05
	rename			em22_farm_norm_why_6 farm_why_06
	rename			em22_farm_norm_why_7 farm_why_07
	rename			em23_we wage_emp
	rename			em24_we_layoff wage_off
	rename			em25_we_layoff_covid wage_off_covid
	rename			lc1_farm farm_inc
	rename			lc2_farm_chg farm_chg
	rename			lc1_bus bus_inc
	rename			lc2_bus_chg bus_chg
	rename			lc1_we wage_inc
	rename			lc2_we_chg wage_chg
	rename			lc1_rem_dom rem_dom
	rename			lc2_rem_dom_chg rem_dom_chg
	rename			lc1_rem_for rem_for
	rename			lc2_rem_for_chg rem_for_chg
	rename			lc1_isp isp_inc
	rename			lc2_isp_chg isp_chg
	rename			lc1_pen pen_inc
	rename			lc2_pen_chg pen_chg
	rename			lc1_gov gov_inc
	rename			lc2_gov_chg gov_chg
	rename			lc1_ngo ngo_inc
	rename			lc2_ngo_chg ngo_chg
	rename			lc3_total_chg tot_inc_chg
	rename			lc4_total_chg_cope cope
	rename			lc4_total_chg_cope_1 cope_01
	rename			lc4_total_chg_cope_2 cope_02
	rename			lc4_total_chg_cope_3 cope_03
	rename			lc4_total_chg_cope_4 cope_04
	rename			lc4_total_chg_cope_5 cope_05
	rename			lc4_total_chg_cope_6 cope_06
	rename			lc4_total_chg_cope_7 cope_07
	rename			lc4_total_chg_cope_8 cope_08
	rename			lc4_total_chg_cope_9 cope_09
	rename			lc4_total_chg_cope_10 cope_10
	rename			lc4_total_chg_cope_11 cope_11
	rename			lc4_total_chg_cope_12 cope_12
	rename			lc4_total_chg_cope_13 cope_13
	rename			lc4_total_chg_cope_14 cope_14
	rename			lc4_total_chg_cope_15 cope_15
	rename			lc4_total_chg_cope_0 cope_16
	rename			fi7_outoffood fies_01
	rename			fi8_hungrynoteat fies_02
	rename			fi6_noteatfullday fies_03
	rename			as1_assist_type asst
	rename			as1_assist_type_1 asst_01
	rename			as1_assist_type_2 asst_02
	rename			as1_assist_type_3 asst_03
	rename			as1_assist_type_0 asst_04
	rename			as3_food_value food_val
	rename			as2_food_psnp food_psnp
	rename			as4_food_source food_source
	rename			as3_forwork_value_food work_food_val
	rename			as3_forwork_value_cash work_cash_val
	rename			as2_forwork_psnp work_psnp
	rename			as4_forwork_source work_source 
	rename			as3_cash_value cash_val
	rename			as2_cash_psnp cash_psnp
	rename			as4_cash_source cash_source
	rename			as3_other_value other_val
	rename			as2_other_psnp other_psnp
	rename			as4_other_source other_source
	rename			ii4_resp_same resp_same
	rename			ii4_resp_gender resp_gender
	rename			ii4_resp_age resp_age
	rename			ii4_resp_relhhh resp_hhh
	rename			em15a_bus_prev bus_prev
	rename			em15b_bus_prev_closed bus_prev_close
	rename			em15c_bus_new bus_new
	rename			fi1_enough fies_04
	rename			fi2_healthy fies_05
	rename			fi3_fewkinds fies_06
	rename			fi4_skipmeal fies_07
	rename			fi5_ateless fies_08
	
* drop unnecessary variables
	drop			kn3_gov_0 kn3_gov__98 kn3_gov__99 kn3_gov__96 kn3_gov_other ///
						ac2_atb_med_why_other ac2_atb_teff_why_other ///
						ac2_atb_wheat_why_other ac2_atb_maize_why_other ///
						ac2_atb_oil_why_other ac5_edu_type__98 ac5_edu_type__99 ///
						ac5_edu_type__96 ac5_edu_type_other ac8_med_access_reas_other ///
						em9_work_change_why_other em5_work_pre_status_other ///
						em3_work_no_why_other em4_work_pre_act_other ///
						em16_bus_sector_other em14_work_cur_notable_why_other ///
						em19_bus_inc_low_why__98 em19_bus_inc_low_why__99 ///
						em19_bus_inc_low_why__96 em19_bus_inc_low_why_other ///
						em22_farm_norm_why__98 em22_farm_norm_why__99 ///
						em22_farm_norm_why__96 em22_farm_norm_why_other ///
						lc1_other lc1_other_source lc2_other_chg ///
						as1_assist_type__98 as1_assist_type__99 ///
						as1_assist_type__96 as1_assist_type_other ///
						as4_food_source_other as4_forwork_source_other ///
						as4_cash_source_other as4_other_source_other ///
						ir1_endearly ir1_whyendearly ir1_whyendearly_other ///
						ir_lang ir_understand ir_confident key ///
						em15b_bus_prev_closed_other lc4_total_chg_cope__98 ///
						lc4_total_chg_cope__99 lc4_total_chg_cope__96 ///
						lc4_total_chg_cope_other

* reorder variables
	order			fies_04 fies_05 fies_06 fies_07 fies_08, after(fies_03)
	order 			resp_same resp_gender resp_age resp_hhh, after(hhh_age)
	order			bus_prev bus_prev_close bus_new, after(bus_why_07)
	

* **********************************************************************
* 2 - end matter, clean up to save
* **********************************************************************

compress
describe
summarize 

* save file
		customsave , idvar(household_id) filename("eth_panel.dta") ///
			path("$export") dofile(eth_build) user($user)

* close the log
	log	close

/* END */