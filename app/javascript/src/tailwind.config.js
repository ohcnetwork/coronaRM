const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
    theme: {
        extend: {
            fontFamily: {
                sans: ["CircularStd", ...defaultTheme.fontFamily.sans]
            }
        },
    },
    variants: {},
    plugins: [
        require('@tailwindcss/custom-forms'),
    ],
}
