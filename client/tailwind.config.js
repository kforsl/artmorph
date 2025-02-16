/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ['./src/**/*.{html,js,ts,jsx,tsx,elm}'],
    theme: {
        extend: {
            colors: {
                primary: '#EC5001',
                secondary: '#363F34',
                textLight: '#FFFFFF',
                textDark: '#000000',
                bgLight: '#F4F0E6',
                bgDark: '#283127',
            },
            spacing: {
                maxWidth: "1180px"
            },
            fontFamily: {
                logo: "Megrim",
                title: "Aboreto",
                bread: "Inter"
            },
            fontSize: {
                sizeBg: "304px"
            },
        },
    },
    plugins: [],
};
