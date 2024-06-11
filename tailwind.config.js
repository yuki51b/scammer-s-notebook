const defaultTheme = require('tailwindcss/defaultTheme')
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'orange': '#FF6E05',
      },
      textUnderlineOffset: {
        12: '12px',
      },
    },
  },
  plugins: [require("daisyui")],
    daisyui: {
      themes: [
        {
          mytheme: {
            "accent": "#120852",
            "primary": "#E6EBE7",
            "button-orange": "#FF7D05",
          },
        },
      ]
}
}