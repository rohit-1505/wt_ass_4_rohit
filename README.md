# Electricity Bill Calculator (JSP)

A responsive, 2-page JSP web app that calculates an electricity bill using
slab-wise tariff rates.

## Files
```
ElectricityBillCalculator/
├── index.jsp          → Input form (consumer name + units), responsive UI
├── calculate.jsp       → Slab-wise calculation + bill summary
└── WEB-INF/
    └── web.xml         → Deployment descriptor
```

## Tariff Slabs Used
| Slab | Units          | Rate/unit |
|------|----------------|-----------|
| 1    | First 50       | Rs. 3.50  |
| 2    | Next 100 (51–150)  | Rs. 4.00  |
| 3    | Next 100 (151–250) | Rs. 5.20  |
| 4    | Above 250      | Rs. 6.50  |

(A flat Rs. 30 meter rent and 5% electricity duty are added to the energy
charge to form the final payable amount — remove that block in
`calculate.jsp` if you only want the pure slab total.)

---

## How to Run (Apache Tomcat) — Easiest Method

### Step 1: Install Java (JDK)
- Download and install **JDK 11 or above** from https://adoptium.net
- Verify: open Command Prompt / Terminal and run
  ```
  java -version
  ```

### Step 2: Install Apache Tomcat
- Download **Tomcat 9 or 10** from https://tomcat.apache.org/download-90.cgi
- Extract the ZIP to a simple path, e.g. `C:\tomcat9` (Windows) or
  `/opt/tomcat9` (Linux/Mac).

### Step 3: Copy the project into Tomcat's webapps folder
Copy the whole `ElectricityBillCalculator` folder into Tomcat's `webapps`
directory:
```
<tomcat-folder>/webapps/ElectricityBillCalculator/
```
So the final path looks like:
```
tomcat9/webapps/ElectricityBillCalculator/index.jsp
tomcat9/webapps/ElectricityBillCalculator/calculate.jsp
tomcat9/webapps/ElectricityBillCalculator/WEB-INF/web.xml
```
(No compilation needed — JSP files are compiled automatically by Tomcat the
first time they're requested.)

### Step 4: Start Tomcat
- **Windows:** double-click `tomcat9\bin\startup.bat`
- **Linux/Mac:**
  ```
  cd tomcat9/bin
  ./startup.sh
  ```
Wait until the console shows `Server startup in [xxxx] ms`.

### Step 5: Open the app in your browser
Go to:
```
http://localhost:8080/ElectricityBillCalculator/index.jsp
```
Enter a name and the number of units, click **Calculate Bill**, and the
bill summary page will show the slab-wise breakup and total amount.

### Step 6: Stop Tomcat (when done)
- **Windows:** run `tomcat9\bin\shutdown.bat`
- **Linux/Mac:** run `./shutdown.sh` from `tomcat9/bin`

---

## Alternative: Run Instantly with Eclipse / NetBeans / IntelliJ
1. Create a new **Dynamic Web Project** (Eclipse) or **Java Web Application**
   (NetBeans/IntelliJ).
2. Copy `index.jsp` and `calculate.jsp` into the `WebContent` /
   `web` / `webapp` source folder.
3. Add a Tomcat server in the IDE (Servers view → New → Apache Tomcat).
4. Right-click the project → **Run on Server**.
5. The IDE will open the app automatically in a browser, or visit
   `http://localhost:8080/<project-name>/index.jsp`.

---

## Notes
- The form uses `POST` and passes `name` and `units` to `calculate.jsp`.
- Basic input validation is included: non-numeric or negative unit values
  redirect back to the form with an error message.
- The design is fully responsive (works on mobile, tablet, and desktop) via
  CSS flexbox and a `max-width` card layout — no external CSS framework or
  internet connection is required at runtime.
