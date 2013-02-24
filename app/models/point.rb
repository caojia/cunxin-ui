class Point
  include HTTParty
  base_uri 'http://www.cunxin.org:9500'
  format :json
  headers "Content-Type" => "application/json"

  RECORD_EVENT_ENDPOINT = "/service/rewardService/recordEvent"
  GET_POINTS_ENDPOINT = "/service/rewardService/getPoints"

  def self.get_user_id user_id
    "#{Rails.env}-#{user_id}"
  end

  def self.record_event user_id, project_id, event_type, params = {}
    begin
      post(RECORD_EVENT_ENDPOINT, 
           :body => {
             "userId" => get_user_id(user_id), 
             "projectId" => project_id.to_s, 
             "eventType" => event_type.to_s, 
             "params" => params
            }.to_json).parsed_response
    rescue
      {}
    end
  end

  def self.get_points user_id
    begin
      post(GET_POINTS_ENDPOINT,
           :body => {
            "userId" => get_user_id(user_id)
            }.to_json).parsed_response
    rescue
      {}
    end
  end
end
