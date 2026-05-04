# Mehrdad Alemzadeh

**Email:** Zade.Mehrdad@gmail.com  
**Location:** Toronto, Ontario | Canadian Citizen  
**Links:** [LinkedIn](https://www.linkedin.com/in/zade) | [GitHub](https://github.com/mehrdad-zade) | [Website](https://mehrdad-zade.github.io/)

---

## Summary

Senior Application Solution Architect and high-performing Full Stack Software Engineer with a proven record of leading and delivering impactful solutions for mission-critical initiatives across multiple teams and departments. Skilled in cloud services and end-to-end SDLC ownership, with expertise in leveraging AI-assisted development to accelerate software delivery. Experienced in setting technical direction, mentoring engineers, and driving cross-functional collaboration at scale. Expert problem-solving skills and consistent ability to deliver cost-effective, high-quality outcomes.

Currently serving as a multi-faceted lead at Aletha Corp., navigating complex client engagements as a Solution Architect and Tech Lead. Complementing corporate expertise with an entrepreneurial background as a founder of multiple live software solutions, demonstrating a unique blend of technical rigor and product vision.

---

## Skills & Core Competencies

| Category | Details |
|:--|:--|
| **Strategy & Stakeholders** | Executive-level roadmap planning · Multi-million-dollar migration strategy · Cross-functional stakeholder alignment · Cost reduction & optimization · Vendor engagement & architecture governance |
| **Leadership & Delivery** | Onsite/offshore team management (20+ engineers) · Hiring & technical interviewing · Developer mentoring & onboarding · Delivery planning & capacity management · SDLC ownership · ITIL release management |
| **Solution Architecture** | Distributed systems design · High availability & disaster recovery · Microservices & API design · Event-driven architecture · Enterprise integration (REST / SOAP / MQ) · Fraud detection & FinTech systems |
| **AI & Data Engineering** | RAG / LLM integration · Prompt engineering · Agentic workflows · ML pipelines · Databricks · Azure OpenAI · Form Recognizer |
| **Languages & Frameworks** | Go (Chi), Spring Boot, .NET, FastAPI / Django / Flask (Python), Express.js, Next.js, React, Angular, Swift / SwiftUI / SwiftData, iOS, Android, JavaScript, TypeScript, Chrome Extensions, Tailwind CSS, Bootstrap, HTML, CSS |
| **LLMs & Agentic AI** | Anthropic Claude, OpenAI ChatGPT, Grok, Meta Llama, DeepSeek, GitHub Copilot, Ollama, Eliza, Azure AI Foundry, AWS Bedrock |
| **Cloud & Infrastructure** | Azure, AWS, GCP · Azure OpenShift · Kafka · Docker · Kubernetes · Azure Bicep · Ansible |
| **DevOps & CI/CD** | GitHub Actions, Azure DevOps Pipelines, Jenkins, Makefile |
| **Security** | OAuth 2.0, JWT, API Keys, SSL Certificates, Sessions, Cookies, Apigee, API Proxies, RBAC, Azure Entra ID |
| **Databases** | PostgreSQL, MS SQL / SQL MI, Oracle, MySQL, MongoDB, Firebase |
| **Observability** | Splunk, Dynatrace, Azure Monitor, Application Insights, Elasticsearch / ELK |
| **Blockchain** | Ethereum, Truffle Framework, Solidity (Smart Contracts), Ganache |

---

## Honors

- **Top 3 Enterprise AI Solutions — CIBC Dragon's Den Innovation Challenge** *(December 2025)*
- **Top 20 Developers at BNS** — BlueOptima *(June 2023)*
- **Ranked #1 in T-Factor at TCS** *(2018–2021)*
- **4-Year Academic Scholarship** — McMaster University

---

## Education

**PhD, Computer Science** — McMaster University *([Completed Thesis 2016](https://macsphere.mcmaster.ca/handle/11375/19286))*  
**M.Sc., Information Systems**  
**B.Sc., Software Engineering**

---

<div style="page-break-before: always;"></div>

## Work Experience

### [Maester.Work](https://maester.work) | *Founder & Full-Stack Engineer*
**Apr 2026 – Present**

Designed, built, and deployed a production-grade **AI-powered hiring intelligence platform** as a solo full-stack project — covering product design, architecture, backend, frontend, infrastructure, and billing in a single continuous build.

**Platform Overview**

A dual-sided SaaS marketplace: hiring managers upload resumes and job descriptions for instant AI-scored fit analysis; job seekers build profiles and let the AI autonomously discover, score, and track matched opportunities across company career pages.

**Key Capabilities**
- **AI Resume Analysis** — Claude evaluates candidate fit against job descriptions with a 0–100 match score, hire recommendation, and structured breakdown; enriched with live LinkedIn, GitHub, and personal website content fetched at analysis time
- **Autonomous Job Discovery** — multi-step agentic pipeline: Claude generates target companies by ATS platform, scrapes Greenhouse and Lever JSON APIs concurrently, then batch-assesses all postings against the candidate profile in a single LLM pass
- **Subscription & Billing** — Stripe Checkout integration with three payment tiers (pay-per-analysis, bulk pack, 24-hour unlimited); atomic Firestore quota transactions prevent double-spend under concurrent load
- **PII-Safe Data Model** — emails and names stored exclusively as SHA-256 hashes in Firestore; raw PII never persists to the database
- **Admin Intelligence Dashboard** — real-time aggregated analytics across all users, analysis history, and application pipeline with role-based access control

**Architecture Highlights**
- Stateless Go (Chi) REST API on Cloud Run; zero cold-start overhead at scale-to-zero pricing
- Firebase Auth JWT verification middleware; all Firestore writes restricted to the backend service account — client writes blocked at the security rules layer
- Fully containerized local development stack with Firebase Auth + Firestore emulators via Docker Compose; production mirrors the same topology on GCP
- One-command deployment pipeline: automated GCP provisioning, IAM, Secret Manager, Docker build/push, and Cloud Run deploy via custom shell scripts

*Technologies: Go · Chi · Next.js 15 · TypeScript · Tailwind CSS · Anthropic Claude API (Sonnet 4.6, Haiku 4.5) · Firebase Auth · Cloud Firestore · Google Cloud Run · Artifact Registry · Secret Manager · Stripe Checkout · Docker · GCP IAM · Firebase Emulator Suite*

#### Independent Developer

**[Gist Reader](https://apps.apple.com/ca/app/gist-reader/id6761196988) — iOS App Store** *(Mar 2026 – Present)*

Designed, built, and shipped a production native iOS app as a solo independent project — covering product design, architecture, AI integration, monetization, and App Store submission end-to-end.

**What It Does**

A book and movie companion app that delivers AI-powered multi-section summaries, real-time multi-source search, text-to-speech playback, and a personal library — built on a polished liquid glass SwiftUI design.

**Key Technical Highlights**
- **AI Summary Pipeline** — Streams summaries from OpenAI GPT-4o and Anthropic Claude via SSE; a three-tier cache (in-memory → SwiftData → Firestore cloud cache) ensures any summary generated by one user is served instantly to all future users at zero API cost
- **Cloud Cache** — Firestore-backed shared cache keyed by SHA-256 of title + author; Firebase App Check (App Attest in Release) blocks unauthorized access at the database layer
- **Monetization** — Rewarded video ad model via Google AdMob with intelligent back-to-back preloading for seamless 3-ad sequences before AI generation
- **Security** — All API keys stored exclusively in the iOS Keychain; no plaintext secrets in source, plist, or UserDefaults
- **Multi-Source Search** — Concurrent async fan-out across Google Books, Open Library, and OMDb with real-time streaming results and deduplication
- **MVVM Architecture** — Single `@MainActor` AppViewModel injected at scene root; SwiftData persistence for library entries and cached summaries

*Technologies: Swift · SwiftUI · SwiftData · MVVM · Firebase Auth · Cloud Firestore · Firebase App Check · Google AdMob · OpenAI API · Anthropic Claude API · SSE Streaming · iOS Keychain*

---

### CIBC — Commercial Banking & Payments | *Solution Architect (via Aletha)*
**June 2025 – Present**

**Project 1 — Safer Payment Canada Migration (IBM to CIBC Azure)**
- Drove design, POCs, application launch, and cost reduction strategies for a multi-million-dollar infrastructure migration.
- Planned and executed a migration roadmap targeting millions of dollars in annual cost savings.
- Engineered network configuration across multiple VNets with NSG rules for secure segmentation.
- Configured F5 load balancers for local high availability and global disaster recovery.
- Implemented APIM, RBAC, MSI, and SSL configurations for authentication, authorization, and security.
- Millions of dollars savings for the client with the new infra archetecture and support cost

**Project 2 — FAE Pinot US Payment Fraud Solution**
- Lead architect building infrastructure to support fraud detection across multiple payment touchpoints.
- Architected highly available distributed systems across Azure and hybrid infrastructures using Kafka and Azure OpenShift.
- Embedded observability through Splunk, Dynatrace, and Azure Monitor for proactive anomaly detection.
- Delivered cost-effective, scalable solutions balancing regional failover with optimized service sizing.
- Full tech lead for end-to-end delivery.
- Saved a million dollar with a scalable solution for the client to host several future data sources
- Azure-based solution with internal and external integrations via SOAP and REST APIs, VNet peering, VPN Tunnel, SSL, and SPNs.
- Integrations with SMTP, ServiceNow, CyberArk, Splunk, FeedHub, and Azure Monitor.

**Project 3 — CMO Mobile Migration & Modernization**
- Lead solution architect migrating a legacy mobile and web application from CGI infrastructure to CIBC Azure, including new features and functionality.
- Supporting 3,000+ users at go-live.

*Technologies: Azure OpenShift, Spring Boot, React, APIM, PostgreSQL, Kafka, Oracle, RSA, VPN Tunnel, Akamai, F5, Azure Blob, AKV, HashiCorp Vault, Dynatrace, Splunk, GitHub Actions, CyberArk, Google Firebase (FCM), VMs, SQL MI*

---

### CIBC — Enterprise Wires Modernization | *Senior Consultant (via Aletha)*
**January 2024 – June 2025**

- Owned end-to-end ODS solution architecture, DevOps, design, capacity planning, and delivery.
- Delivered **10x performance improvement** on the AMH parser application through hands-on development and architectural redesign.
- Boosted SQL MI database performance on Azure by **25%** by introducing a write-DB to segregate read/write indexes.
- Achieved **8x throughput improvement** on Swift MT-to-MX completeness validation.
- Optimized and generalized ADF pipelines for file transfers across upstream and downstream systems.
- Modernized analytics strategy through Databricks and Generative AI integrations.
- Resolved security deviations and led Tier 1 (high resiliency / high availability) migration planning and design roadmap.

*Technologies: Azure, Spring Boot, Azure Function Apps, Azure Data Factory, SQL MI, Application Insights, Azure Monitor*

---

### ONEX | *Tech Lead & Architect (via Aletha)*
**July 2023 – December 2024**

- Architected and delivered HRIS go-live; integrated Hibob with 10+ services including Shareworks, Carrot, Optum, iA, OCA, ActivPayroll, Active Directory, and Business Central.
- Extended an open-source Microsoft project into a production multi-index RAG solution — integrating Azure OpenAI, Microsoft Search, and Form Recognizer — **saving ~$300K/year** in legal document review costs.
- Designed secure RBAC and Azure Entra ID access models for the AI-powered RAG/chatbot system, ensuring authorized-only data access.
- Engineered an invoice/expense integration service between Coupa and Business Central using Azure Function Apps.

*Technologies: Azure, Azure Function Apps, .NET, Spring Boot, Flask, Azure OpenAI, Microsoft Search, Form Recognizer, React*

---

### AutoSavvy | *Application Architect (via Aletha)*
**October 2023 – 2024**

- Optimized workflows and designed scalability strategies to improve platform throughput.
- Designed and normalized database schemas with rigorous validation procedures.

*Technologies: SQL SaaS, Azure Data Factory*

---

### Scotiabank — Wealth Management | *Tech Lead (via Aletha)*
**March 2022 – July 2023**

- Led as principal architect and technical lead, owning project delivery and aligning solutions with business goals through close stakeholder collaboration.
- Designed and delivered five key applications: Fixed Income API, Remediation Application, Real-Time XML Service, ADPR App, and Mediator API.
- Co-authored a 5-year modernization roadmap for the Wealth department, defining phased delivery strategies, platform integrations, and a GCP migration path.

*Technologies: Gradle/Spring Boot, Maven/Spring Batch, React, MS SQL SaaS, Oracle, REST & SOAP APIs, JAXB/WSDL/XSD/XML, Azure, WAM OAuth2, Apigee, Splunk, Dynatrace*

---

### Aletha — Side Projects | *Sr. Application Architect*
**February 2022 – Present**

- AI-based project effort estimator with chatbot generating high-level architecture, deliverables, and PERT-based effort breakdowns.
- Interview agent full-stack solution for first-round candidate screening.
- Custom full-stack Azure cost dashboard by resource group and service breakdown.
- SuiteCRM deployment to Azure.
- Timesheet app integrated with Azure Entra ID (Flask, React, MSSQL) — *Jan 2022*
- Chrome extension integrated with OpenAI for page summarization — *Jan 2023*
- Education app integrated with OpenAI; Dockerized FastAPI and PostgreSQL — *Feb 2024*
- Conducting interview sessions for hiring and mentoring team on AI trends.

---

### CIBC — Personal Banking Product & Technology | *Tech Lead (via TCS)*
**April 2014 – February 2022**

- Directed onsite/offshore teams of 20+ developers, BAs, and QA engineers across programs spanning mortgage securitization, mortgage sale optimization, Azure migration, archive automation, DevOps modernization, log management, ITIL release management, production support, and CMHC/insurer reporting APIs.

*Technologies: Java, Spring Boot, Express/Node.js, Python, C#, VB, MS SQL, Git, GitHub, ClearCase, Maven, Jenkins, Ansible, UFT, Elasticsearch, ELK, Splunk, Dynatrace, Jira/Confluence, Docker, Kubernetes, Azure, Power Automate, Tableau, Crystal Reports*

---

### St. Joseph's Hospital | *Software Engineer & Researcher*
**September 2014 – June 2016**

- Partnered with the head of St. Joseph's Imaging Center to automate radiological lung image analysis for disease pattern classification.
- Built a MATLAB-based classifier achieving **92%+ accuracy** across 10 irregular radiological patterns using neural networks and machine learning.
- Developed a Python feature extraction tool to identify regions of interest (ROIs), working directly with radiologists to validate clinical relevance.

---

<div style="page-break-before: always;"></div>

## Certificates

**Cloud & DevOps:** Microsoft Azure AZ-900 · Cloud Architecture · DevOps Foundations · Six Sigma Foundations · Salesforce Integration (SOAP API) · Google Cloud Platform Fundamentals

**AI & Machine Learning:** Azure Machine Learning for Data Scientists · GitHub Copilot for Project Management · Generative AI for Leaders · Change Management for Generative AI · Neural Networks and Deep Learning *(deeplearning.ai)* · Improving Deep Neural Networks *(deeplearning.ai)* · Convolutional Neural Networks *(deeplearning.ai)* · Sequence Models *(deeplearning.ai)* · Machine Learning — Andrew Ng (Stanford) · Machine Learning A–Z: Python & R · Data Science and ML Bootcamp

**Programming & Full-Stack:** Foundational C# with Microsoft · OOP in Java (University of Helsinki) · Python and Django Full Stack Web Developer · The Web Developer Bootcamp · React — The Complete Guide (Hooks, Router, Redux) · MERN Stack Front to Back · Full Stack: Angular and Java Spring Boot · E-Commerce App with .NET Core and Angular · Blockchain & Cryptocurrency Full Stack

**Mobile:** iOS 12 & Swift Bootcamp · Android Oreo Developer

**Big Data & Analytics:** The Ultimate Hands-On Hadoop · Tableau and Crystal Reports *(also referenced in Experience)*

---

## Open Source Contributions

**AI-Powered Solutions:** x-university (AI auto-generated courses for different age groups) · Agentic-AI (frontend developer integrated with Microsoft Teams) · PortfolioGPT (stock market analysis with LSTM models) · Multi-index ChatGPT solution with privacy management · Book Summarizer Chrome extension · Twitter & Reddit sentiment analysis tools · Azure video-to-text processing pipeline

**Full-Stack Development:** Interview Agent · Project Effort Estimator · Telegram-based news aggregator · CRM ideathon · Azure custom cost and security dashboard

**Enterprise Applications:** Flight Reservation System with check-in · Clinical Data Reporting Platform · eCommerce application · Document management system · Location tracking web application

**Mobile Applications:** Stock price tracker with AI suggestions · Weather forecasting app · Bitcoin price monitor · Bluetooth device finder · Custom Chrome browser with ad-blocker *(Android & iOS)*

**Automation & DevOps Tools:** macOS app arranger across virtual desktops/monitors/display positions · Windows custom hotkeys to mimic macOS keyboard shortcuts · Automated Yahoo Finance advertisement bot · Video download automation · macOS feature enablement shortcuts · Stock price web scraper · News summarization system

**Blockchain Solutions:** Full-stack cryptocurrency application · Smart contract development (Solidity) · Blockchain integration with modern web frameworks · Decentralized application (DApp) development · Personal bill/tax tracker

**Production Systems:** CIBC Commercial Banking modernization · Scotiabank Wealth Management platforms · Enterprise wire processing systems · Multi-million dollar migration projects · High-availability financial applications
