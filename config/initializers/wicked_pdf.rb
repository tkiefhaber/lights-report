if Rails.env.staging? || Rails.env.production?
  WickedPdf.config = {:exe_path => "/bin/wkhtmltopdf"}
else
  WickedPdf.config = { :exe_path => '/usr/local/bin/wkhtmltopdf'}
end
