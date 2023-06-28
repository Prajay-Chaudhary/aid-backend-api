class ArchiveRequestJob < ApplicationJob
  queue_as :default

  def perform(request_id)
    request = Request.find_by(id: request_id, request_status: 'unfulfilled')
    return unless request

    if request.updated_at < 24.hours.ago
      request.update(request_status: 'archived')
    end
  end
end