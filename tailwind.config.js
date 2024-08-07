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
        'orange': '#e65100',
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
            "accent": "#1a237e",
            "primary": "#E6EBE7",
            "success": "#1565c0",
            "warning": "#FBBF24",
            "info": "#737373",
            "secondary": "#d32f2f",
            "error": "#6d4c41",
          },
        },
      ]
}
}