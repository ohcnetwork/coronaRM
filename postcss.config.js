const purgecss = require('@fullhuman/postcss-purgecss')({
    // Specify the paths to all of the template files in your project
    content: [
        './app/views/**/*.html.erb'
    ],

    // Include any special characters you're using in this regular expression
    defaultExtractor: content => content.match(/[\w-/.:]+(?<!:)/g) || []
})

module.exports = {
    plugins: [
        require('postcss-import'),
        require('postcss-flexbugs-fixes'),
        require('tailwindcss')('./app/javascript/src/tailwind.config.js'),
        require('autoprefixer'),
        require('postcss-preset-env')({
            autoprefixer: {
                flexbox: 'no-2009'
            },
            stage: 3
        }),
        ...process.env.NODE_ENV === 'production'
            ? [purgecss]
            : []
    ]
}
