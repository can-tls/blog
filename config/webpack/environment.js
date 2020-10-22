const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
  })
)
environment.config.merge({
    externals: {
      jquery: 'jQuery'
    }
  })
    
module.exports = environment