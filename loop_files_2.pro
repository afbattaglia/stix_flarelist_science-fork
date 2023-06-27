pro loop_files_2

data = READ_CSV('full_flarelist_with_paths.csv')


for i = 1 ,n_elements(data.field01) do begin   ;loop through all rows in data structure
    
    path_sci_file = data.FIELD16[i]
    peak_time = data.FIELD05[i]
    start_time = atime(anytim(peak_time) - 5)
    end_time = atime(anytim(peak_time) + 5)
    time_range = [start_time, end_time]
    aux_fits_file = data.FIELD15[i]
    req_id = data.FIELD14[i] 
    flare_id = data.FIELD01[i]


    get_flare_location, path_sci_file, time_range, aux_fits_file, req_id, flare_id, i, flare_loc=flare_loc, vis_fwdfit_pso_map, bp_nat_map=bp_nat_map, $
       max_bp_coord=max_cp_coord, fitsigmasout_pso=fitsigmasout_pso

	CATCH, Error_status    
	IF Error_status NE 0 THEN BEGIN
      PRINT, 'Error index: ', Error_status
      PRINT, 'Error message: ', !ERROR_STATE.MSG
      ; Handle the error by extending A:
      ;A=FLTARR(12)
      CATCH
   ENDIF

  endfor

end

