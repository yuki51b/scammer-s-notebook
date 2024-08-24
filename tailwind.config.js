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
      animation: {
        "fade-out": "fade-out 1s ease 0.5s  both",
        "tracking-in-expand-fwd-top": "tracking-in-expand-fwd-top 0.8s cubic-bezier(0.215, 0.610, 0.355, 1.000)   both",
        "text-focus-in": "text-focus-in 1s cubic-bezier(0.550, 0.085, 0.680, 0.530)   both",
        "bounce-top": "bounce-top 0.9s ease   both",
        "slide-in-right": "slide-in-right 0.5s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both",
        "wobble-hor-top": "wobble-hor-top 0.8s ease   both",
        "shake-vertical": "shake-vertical 8s cubic-bezier(0.455, 0.030, 0.515, 0.955)  infinite both",
        heartbeat: "heartbeat 3s ease  infinite both"
      },
      keyframes: {
          "fade-out": {
              "0%": {
                  opacity: "1"
              },
              to: {
                  opacity: "0"
              }
          },
          "tracking-in-expand-fwd-top": {
            "0%": {
                "letter-spacing": "-.5em",
                transform: "translateZ(-700px) translateY(-500px)",
                opacity: "0"
            },
            "40%": {
                opacity: ".6"
            },
            to: {
                transform: "translateZ(0) translateY(0)",
                opacity: "1"
            }
        },
          "text-focus-in": {
            "0%": {
                filter: "blur(12px)",
                opacity: "0"
            },
            to: {
                filter: "blur(0)",
                opacity: "1"
            }
        },
          "bounce-top": {
            "0%": {
                transform: "translateY(-45px)",
                "animation-timing-function": "ease-in",
                opacity: "1"
            },
            "24%": {
                opacity: "1"
            },
            "40%": {
                transform: "translateY(-24px)",
                "animation-timing-function": "ease-in"
            },
            "65%": {
                transform: "translateY(-12px)",
                "animation-timing-function": "ease-in"
            },
            "82%": {
                transform: "translateY(-6px)",
                "animation-timing-function": "ease-in"
            },
            "93%": {
                transform: "translateY(-4px)",
                "animation-timing-function": "ease-in"
            },
            "25%,55%,75%,87%": {
                transform: "translateY(0)",
                "animation-timing-function": "ease-out"
            },
            to: {
                transform: "translateY(0)",
                "animation-timing-function": "ease-out",
                opacity: "1"
            }
        },
          "slide-in-right": {
            "0%": {
                transform: "translateX(1000px)",
                opacity: "0"
            },
            to: {
                transform: "translateX(0)",
                opacity: "1"
            }
        },
          "wobble-hor-top": {
            "0%,to": {
                transform: "translateX(0%)",
                "transform-origin": "50% 50%"
            },
            "15%": {
                transform: "translateX(-30px) rotate(6deg)"
            },
            "30%": {
                transform: "translateX(15px) rotate(-6deg)"
            },
            "45%": {
                transform: "translateX(-15px) rotate(3.6deg)"
            },
            "60%": {
                transform: "translateX(9px) rotate(-2.4deg)"
            },
            "75%": {
                transform: "translateX(-6px) rotate(1.2deg)"
            }
        },
          "shake-vertical": {
            "0%,to": {
                transform: "translateY(0)"
            },
            "10%,30%,50%,70%": {
                transform: "translateY(-6px)"
            },
            "20%,40%,60%": {
                transform: "translateY(6px)"
            },
            "80%": {
                transform: "translateY(6.4px)"
            },
            "90%": {
                transform: "translateY(-6.4px)"
            }
        },
          heartbeat: {
            "0%": {
                transform: "scale(1)",
                "transform-origin": "center center",
                "animation-timing-function": "ease-out"
            },
            "10%": {
                transform: "scale(.91)",
                "animation-timing-function": "ease-in"
            },
            "17%": {
                transform: "scale(.98)",
                "animation-timing-function": "ease-out"
            },
            "33%": {
                transform: "scale(.87)",
                "animation-timing-function": "ease-in"
            },
            "45%": {
                transform: "scale(1)",
                "animation-timing-function": "ease-out"
            }
        }
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'orange': '#e65100',
      },
      lineHeight: {
        '2': '0.625rem', // 10px相当の行間をカスタムクラスとして追加
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