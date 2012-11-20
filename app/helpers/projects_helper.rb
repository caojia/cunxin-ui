module ProjectsHelper
  def get_time_left(project)
    # TODO use real finish time
    timeDiff = (Time.parse("2012-12-30") - Time.now).to_i
    if timeDiff > 0
      a = [timeDiff / (24*3600), timeDiff / 3600 % 24, timeDiff / 60 % 60, timeDiff % 60 ]
    else
      a = [0, 0, 0, 0]
    end
    t("projects.info.time_left") % a
  end
end
