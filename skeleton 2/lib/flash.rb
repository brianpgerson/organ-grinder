class Flash
  def initialize(req)
    @to_store = {}
    @flash_now = {}
    data_from_last_time = req.cookies['_flash_cookie'].nil? ? {} : JSON.parse(req.cookies['_flash_cookie'])

    unless data_from_last_time.empty?
      data_from_last_time.each do |key, val|
        @flash_now[key] = val
      end
    end
  end

  def now
    @flash_now
  end

  def [](key)
    @flash_now[key] || @to_store[key]
  end

  def []=(key, val)
    @flash_now[key] = val
    @to_store[key] = val
  end

  def store_flash(res)
    res.set_cookie('_flash_cookie', {path: '/', value: @to_store.to_json})
  end



end
