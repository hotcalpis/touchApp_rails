module WaitForAjax
  # ajaxが完了するまで待つ
  def wait_for_ajax(wait_time)
    Timeout.timeout(wait_time) do
      loop until finished_all_ajax_requests?
    end
    yield if block_given?
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end