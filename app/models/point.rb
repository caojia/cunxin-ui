class Point
  include HTTParty
  base_uri 'http://ec2-54-242-167-22.compute-1.amazonaws.com:9500'
  format :json
  headers "Content-Type" => "application/json"

  RECORD_EVENT_ENDPOINT = "/service/rewardService/recordEvent"
  GET_POINTS_ENDPOINT = "/service/rewardService/getPoints"

  def self.record_event user_id, project_id, event_type, params = {}
    post(RECORD_EVENT_ENDPOINT, 
         :body => {
           "userId" => user_id.to_s, 
           "projectId" => project_id.to_s, 
           "eventType" => event_type.to_s, 
           "params" => params
          }.to_json).parsed_response
  end

  def self.get_points user_id
    post(GET_POINTS_ENDPOINT,
         :body => {
          "userId" => user_id.to_s
          }.to_json).parsed_response
  end
end
