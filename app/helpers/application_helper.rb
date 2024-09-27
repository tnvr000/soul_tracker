module ApplicationHelper
  def submit_method(resource)
    resource.persisted? ? :patch : :post
  end
end
