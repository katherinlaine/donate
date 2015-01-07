Geocoder.configure(
  :timeout      => 35,           # geocoding service timeout (secs)
  :lookup       => :google,     # name of geocoding service (symbol)
  :use_https    => true,       # use HTTPS for lookup requests? (if supported)
  :api_key      => ENV["GOOGLE_GEOCODER_KEY"],         # API key
  :ip_lookup    => :telize
)
