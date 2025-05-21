package com.prime;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/primecheck")
public class PrimeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String numberParam = request.getParameter("number");

            if (numberParam == null || numberParam.trim().isEmpty()) {
                throw new NumberFormatException("Input is empty");
            }

            int number = Integer.parseInt(numberParam);
            boolean isPrime = true;

            if (number <= 1) {
                isPrime = false;
            } else {
                for (int i = 2; i <= Math.sqrt(number); i++) {
                    if (number % i == 0) {
                        isPrime = false;
                        break;
                    }
                }
            }

            out.println("<html><head><title>Prime Result</title></head><body>");
            out.println("<div style='margin: 20px;'>");
            out.println("<h2>Number Entered: " + number + "</h2>");

            if (isPrime) {
                out.println("<h3 style='color: green;'>" + number + " is a Prime Number.</h3>");
            } else {
                out.println("<h3 style='color: red;'>" + number + " is NOT a Prime Number.</h3>");
            }

            out.println("<a href='index.html'>Check Another Number</a>");
            out.println("</div></body></html>");

        } catch (NumberFormatException e) {
            out.println("<html><head><title>Error</title></head><body>");
            out.println("<div style='margin: 20px; color: red;'>");
            out.println("<h2>Invalid Input</h2>");
            out.println("<p>Please enter a valid number.</p>");
            out.println("<a href='index.html'>Try Again</a>");
            out.println("</div></body></html>");
        } finally {
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.html");
    }
}

