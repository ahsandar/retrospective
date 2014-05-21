require 'logger'

class LogService
  attr_accessor :logger, :service

  def initialize(service = 'digital_hub', log_file = nil)
    @logger ||= Logger.new(log_file)
    @service = service
  end


  def msg(msgs)
    msgs  = msgs.join("\n") if msgs.is_a?Array
    logger.info "###### #{service}_service ###### #{msgs}"
  end

  def timestamp
    msgs = ["\n"]
    msgs <<'#'*100
    msgs << "#{Time.now.strftime('%d-%m-%y %H:%M:%S')}"
    msgs <<'#'*100
    msg msgs
  end

  def self.log_directory
    FileUtils.mkdir_p(File.join(Dir.getwd, 'app','log'))
  end

  def info(msgs)
    msg msgs
  end

  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end


end