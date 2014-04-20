json.array! @plan.semesters do |semester|
  json.set! semester.name do
    json.array! semester.courses do |course|
      json.id course.id
      json.name course.name
      json.units course.units
      json.drag true
    end
  end
end