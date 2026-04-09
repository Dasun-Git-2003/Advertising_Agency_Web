<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="app-footer">
  <div class="footer-left">
    &copy; 2025 <strong>Advertising Agency</strong>. All rights reserved.
  </div>
  <div class="footer-right">
    <a href="#">Privacy Policy</a>
    <span class="footer-separator">|</span>
    <a href="#">Terms of Service</a>
    <span class="footer-separator">|</span>
    <a href="#">Contact</a>
  </div>
</footer>

<style>
  .app-footer {
    width: 100%;
    background: linear-gradient(90deg, #6610f2, #0d6efd);
    color: #fff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 30px;
    position: fixed;
    bottom: 0;
    font-size: 0.95rem;
    font-weight: 500;
    box-shadow: 0 -2px 10px rgba(0,0,0,0.2);
    z-index: 1000;
    flex-wrap: wrap;
  }
  .app-footer a {
    color: #ffeb3b;
    text-decoration: none;
    margin: 0 5px;
    transition: all 0.3s ease;
  }
  .app-footer a:hover {
    color: #fff;
    text-decoration: underline;
  }
  .footer-separator {
    margin: 0 5px;
    color: rgba(255, 255, 255, 0.6);
  }
  @media (max-width: 768px) {
    .app-footer {
      flex-direction: column;
      text-align: center;
      gap: 8px;
    }
    .footer-right {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
    }
  }
</style>
