const bootScreen = document.getElementById("boot-screen");
const enterButton = document.getElementById("enter-button");
const siteShell = document.getElementById("site-shell");
const menuToggle = document.querySelector(".menu-toggle");
const navLinks = document.querySelector(".nav-links");
const cursorGlow = document.querySelector(".cursor-glow");

enterButton.addEventListener("click", () => {
  bootScreen.classList.add("exit");
  siteShell.classList.remove("hidden");
  document.body.classList.remove("locked");

  setTimeout(() => {
    bootScreen.style.display = "none";
  }, 750);
});

menuToggle.addEventListener("click", () => {
  const open = navLinks.classList.toggle("open");
  menuToggle.setAttribute("aria-expanded", open);
});

document.querySelectorAll(".nav-links a").forEach((link) => {
  link.addEventListener("click", () => {
    navLinks.classList.remove("open");
    menuToggle.setAttribute("aria-expanded", "false");
  });
});

document.addEventListener("mousemove", (event) => {
  cursorGlow.style.left = `${event.clientX}px`;
  cursorGlow.style.top = `${event.clientY}px`;
});

const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
      }
    });
  },
  { threshold: 0.12 }
);

document.querySelectorAll(".reveal").forEach((element) => {
  observer.observe(element);
});
