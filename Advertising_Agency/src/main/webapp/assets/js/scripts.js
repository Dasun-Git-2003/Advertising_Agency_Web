document.addEventListener("DOMContentLoaded", function() {
    const sidebar = document.querySelector(".sidebar");
    const body = document.body;

    // Toggle sidebar
    document.querySelector("#sidebarToggle").addEventListener("click", () => {
        sidebar.classList.toggle("collapsed");
        document.querySelector(".main").style.marginLeft = sidebar.classList.contains("collapsed") ? "70px" : "250px";
        document.querySelector(".footer").style.left = sidebar.classList.contains("collapsed") ? "70px" : "250px";
    });

    // Toggle dark mode
    document.querySelector("#themeToggle").addEventListener("click", () => {
        body.classList.toggle("dark");
    });

    // Highlight active link
    const page = window.location.pathname.split("/").pop();
    document.querySelectorAll(".sidebar a").forEach(link => {
        if (link.getAttribute("href") === page) {
            link.classList.add("active");
        }
    });

    // Example Chart.js
    const ctx = document.getElementById("chart1");
    if (ctx) {
        new Chart(ctx, {
            type: "line",
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May"],
                datasets: [{
                    label: "Campaign Reach",
                    data: [1200, 1900, 3000, 2500, 3200],
                    borderColor: "#3949ab",
                    backgroundColor: "rgba(57,73,171,0.2)",
                    fill: true,
                    tension: 0.3
                }]
            }
        });
    }
});
