class AssetManifest

  def self.manifest
    if File.exists?('build/rev-manifest.json') && Rails.env == 'production'
      @manifest ||= JSON.parse(File.read('build/rev-manifest.json'))
    end
  end

  def self.stylesheet_path(url)
    if AssetManifest.manifest
      url += '.css' unless url.end_with?('.css')
      url = AssetManifest.manifest[url] || url
    end
    "/assets/" + url
  end

  def self.javascript_path(url)
    if AssetManifest.manifest
      url += '.js' unless url.end_with?('.js')
      url = AssetManifest.manifest[url] || url
    end
    "/assets/" + url
  end

  def self.asset_path(url)
    if AssetManifest.manifest
      url = AssetManifest.manifest[url] || url
    end
    "/assets/" + url
  end

end
