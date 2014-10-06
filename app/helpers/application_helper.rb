module ApplicationHelper
	def avatar_url(current_user)
		if current_user.avatar.present?
			current_user.avatar
		else
			gravatar_id = Digest::MD5.hexdigest(current_user.email.downcase)
			"http://gravatar.com/avatar/#{gravatar_id}.png?s=50&d=mm"
		end
	end
end
