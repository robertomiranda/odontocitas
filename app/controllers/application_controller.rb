class ApplicationController < ActionController::Base
  protect_from_forgery


 private

def current_user

	if session[:user_id] 
		if session[:tipo] == "paciente"
			if Paciente.exists?(session[:user_id])
				@current_user ||= Paciente.find(session[:user_id])
			else
				session[:user_id] = nil
    			redirect_to root_url
    			cookies.delete :login
			end
 		else

 			if session[:tipo] == "odontologo"
	 			if Odontologo.exists?(session[:user_id])
					@current_user ||= Odontologo.find(session[:user_id])
				else 
					session[:user_id] = nil
	    			redirect_to root_url
	    			cookies.delete :login
				end
 			else
 				if Clinica.exists?(session[:user_id])
					@current_user ||= Clinica.find(session[:user_id])
				else 
					session[:user_id] = nil
	    			redirect_to root_url
	    			cookies.delete :login
				end
 			end


 		end	
 	end
end

helper_method :current_user

end
