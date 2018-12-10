module ApplicationHelper
  def mask_mobile_number(mobile)
    return mobile[0,3] + "****" + mobile[-4,4]
  end
end
