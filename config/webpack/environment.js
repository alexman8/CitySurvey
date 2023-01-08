const { environment } = require('@rails/webpacker')

// Need to following to load jQuery properly; otherwise will get the error "jQuery is not defined"
const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

module.exports = environment
