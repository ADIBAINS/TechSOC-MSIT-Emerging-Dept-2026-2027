# Cybersecurity: Basic Web Recon

## Objective

The objective of this project is to understand the basics of web reconnaissance by examining an authorized test website. The goal is to identify security-related observations, understand why they matter, and suggest possible improvement.

## Scope and Authorized Target

The scope of this project was limited to the assigned TryHackMe target machine at IP address 10.49.129.38 . All reconnaissance activities were conducted within the authorized lab environment.

## Tools used

-**Linux Terminal:** Used to run Nmap scans against the authorized target and work with the scan output.

-**Firefox:** Used to access the target website and inspect the robots.txt file and staff portal path.

-**Firefox Developer Tool:** Used to inspect HTTP response headers, request status, cookies for the selected request, and request timing.

-**Text Editor:** Used to veiw and copy the saved output for documentation.

## Reconnaissance Commands

The following commands used during reconnaissance of the authorized target. They were used to scan for open results, and check the directory content.

```
nmap -A 10.49.129.38
nmap -oN nmap_scan.txt 10.49.129.38
```

## Finding

### 1. Server Information in HTTP Response Headers

The inspected HTTP response included a `Server` header identifying the web server software.

**Observed value:** nginx/1.18.0 (Ubuntu)

**Why it matters:** Server information can help someone identify the technology in use and research relevant weaknesses. The header alone does not prove that the server is vulnerable.

**Recommendation:** Keep the server software updated and consider limiting unnecessary version details in response headers.

### 2. Content Security Policy Header

A `Content-Security-Policy` header was not observed in the HTTP response that I inspected.

**Why it matters:** A suitable Content Security Policy (CSP) can restrict which sources a browser is allowed to load content from and can help reduce the impact of certain injection attacks.

**Recommendation:** Review whether a suitable CSP should be configured and test it to ensure it does not break legitimate website functionality.

### 3. robots.txt and Staff Portal Path

The website's `robots.txt` file included a rule mentioning `/staff-portal`. When I visited that path in the lab, the page displayed the message: "You found the robots.txt endpoint."

**Evidence:** `robots_txt.png` and `staff_portal_page.png`.

**Why it matters:** The `robots.txt` file is publicly accessible and can reveal paths that a website operator has listed for web crawlers. It does not provide access control or protect a page.

**Recommendation:** Protect any sensitive pages with appropriate authentication and authorization. Do not rely on `robots.txt` to keep pages private.

## Limitations

This project was limited to basic reconnaissance of the assigned lab target. The observations recorded here are based on the commands run and the website responses inspected. They do not, by themselves, confirm that the target has an exploitable vulnerability.

## Conclusion

This project provided practical experience with basic web reconnaissance, Nmap scanning, and browser developer tools. It demonstrated how open services, HTTP response headers, and publicly accessible website paths can provide useful information during an initial security review. The observations also highlighted the importance of keeping services updated, reviewing security headers, and enforcing proper access controls.

## Evidence

- `nmap_scan.txt` — saved Nmap scan output.
- `nmap_scan_initial.png` — initial Nmap scan screenshot.
- `nmap_scan_results.png` — saved scan output screenshot.
- `response_headers_1.png` and `response_headers_2.png` — HTTP response header screenshots.
- `robots_txt.png` — `robots.txt` contents.
- `staff_portal_page.png` — staff portal page screenshot.

