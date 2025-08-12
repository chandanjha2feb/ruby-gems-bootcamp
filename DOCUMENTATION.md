# Ruby Gyan Documentation

## 1. Project Overview

Ruby Gyan is a comprehensive, open-source online learning platform designed to empower educators and entrepreneurs to create and sell courses online. Inspired by successful platforms like Udemy, Ruby Gyan provides a robust, scalable, and customizable solution for building a "white-label" online school.

The platform allows course creators to build rich, engaging learning experiences with video lessons, text content, and student-teacher interactions. For students, it offers a seamless and intuitive interface for discovering, purchasing, and consuming educational content.

The project is built with Ruby on Rails, a mature and reliable web framework, ensuring a solid foundation for further development and customization.

## 2. Features

Ruby Gyan comes with a rich set of features for both administrators, course creators, and students.

### For Students:
- **Course Discovery:** Browse and search for courses.
- **Easy Enrollment:** Purchase courses via Stripe integration.
- **User-Friendly Dashboard:** View and manage enrolled courses.
- **Interactive Learning:** Watch video lessons, read content, and track progress.
- **Commenting:** Engage in discussions with instructors and other students on each lesson.
- **Social Login:** Sign up or log in using Google, GitHub, or Facebook.
- **Certificates:** Receive a certificate upon course completion.

### For Course Creators:
- **Course Creation Wizard:** A guided, step-by-step process to build and structure courses.
- **Rich Content:** Create lessons with text, images, and video content (via YouTube integration).
- **Pricing and Monetization:** Set prices for courses and receive payments through Stripe.
- **Student Management:** View a list of enrolled students for each course.
- **Creator Analytics:** Access analytics to track course performance.

### For Platform Administrators:
- **Course Approval System:** Review courses submitted by creators and approve/unapprove them for publishing.
- **Comprehensive Analytics:** View platform-wide analytics, including user sign-ups per day, enrollments per day, and course popularity charts.
- **User Management:** Manage all users on the platform.
- **Tag Management:** Create and manage tags for course categorization.
- **Background Job Monitoring:** A Sidekiq dashboard (`/sidekiq`) to monitor background processes like video processing and email delivery.

## 3. Technical Architecture

The Ruby Gyan platform is built on a foundation of proven and widely-used technologies, chosen for their robustness, scalability, and developer productivity.

- **Backend:**
  - **Framework:** Ruby on Rails 6.1
  - **Language:** Ruby 3.1.4
  - **Database:** PostgreSQL
  - **Background Jobs:** Sidekiq with Redis for asynchronous task processing.
  - **Authentication:** Devise for user authentication, including integrations for social login (Google, GitHub, Facebook) via OmniAuth.
  - **Authorization:** Pundit for managing user permissions.

- **Frontend:**
  - **JavaScript:** Webpacker with Yarn for managing JavaScript dependencies.
  - **CSS:** Sass for styling, with Bootstrap as a CSS framework.
  - **Templating:** HAML for clean and concise view templates.

- **Key Integrations & Services:**
  - **Payments:** Stripe for secure and reliable payment processing.
  - **File Storage:** AWS S3 for storing course materials and other assets in a production environment.
  - **Email Delivery:** Amazon SES for sending transactional emails.
  - **Analytics:** Google Analytics for tracking user behavior.
  - **Security:** Google reCAPTCHA to prevent spam and abuse.

## 4. Getting Started

This guide will walk you through setting up the Ruby Gyan platform for local development.

### Prerequisites
- Ruby 3.1.4+
- Rails 6.1.7+
- PostgreSQL
- Yarn
- Redis

### 1. Clone the Repository
```bash
git clone https://github.com/rormvp/corsego
cd corsego
```

### 2. Install Dependencies
```bash
bundle install
yarn install
```

### 3. Configure Credentials
The application requires several external services. You'll need to configure API keys and other secrets.

1.  **Remove the existing encrypted credentials file:**
    ```bash
    rm config/credentials.yml.enc
    ```
2.  **Edit the credentials in a secure editor:**
    ```bash
    EDITOR=vim rails credentials:edit
    ```
3.  **Add your credentials.** You will need to sign up for these services and get your own keys. Below is a template to follow.

    ```yaml
    awss3:
      access_key_id: YOUR_S3_ACCESS_KEY
      secret_access_key: YOUR_S3_SECRET_KEY
    google_analytics: YOUR_GOOGLE_ANALYTICS_CODE
    recaptcha:
      site_key: YOUR_RECAPTCHA_SITE_KEY
      secret_key: YOUR_RECAPTCHA_SECRET_KEY
    google_oauth2:
      client_id: YOUR_GOOGLE_OAUTH_CLIENT_ID
      client_secret: YOUR_GOOGLE_OAUTH_CLIENT_SECRET
    github:
      client_id: YOUR_GITHUB_OAUTH_CLIENT_ID
      client_secret: YOUR_GITHUB_OAUTH_CLIENT_SECRET
    stripe:
      publishable_key: YOUR_STRIPE_PUBLISHABLE_KEY
      secret_key: YOUR_STRIPE_SECRET_KEY
    facebook:
      client_id: YOUR_FACEBOOK_OAUTH_CLIENT_ID
      client_secret: YOUR_FACEBOOK_OAUTH_CLIENT_SECRET
    smtp:
      address: YOUR_SMTP_ADDRESS
      user_name: YOUR_SMTP_USERNAME
      password: YOUR_SMTP_PASSWORD
    ```

### 4. Set Up the Database
```bash
rails db:create
rails db:migrate
rails db:seed # Optional: to populate with sample data
```

### 5. Start the Server
```bash
rails s
```
The application should now be running at `http://localhost:3000`.

## 5. Making the Product Business Ready

Taking a software project from a functional state to a "business ready" product involves more than just code. It requires a focus on reliability, scalability, security, and user experience. Here are key areas to address to make Ruby Gyan a commercial-grade product.

### 1. Production Deployment & Scalability
- **Hosting:** While Heroku is a good starting point, consider more robust solutions like AWS (EC2, Elastic Beanstalk), Google Cloud, or DigitalOcean for better control and scalability.
- **Database Management:** Use a managed database service (e.g., Amazon RDS for PostgreSQL) to handle backups, scaling, and maintenance.
- **Content Delivery Network (CDN):** Use a CDN like AWS CloudFront or Cloudflare to serve assets (CSS, JS, images) quickly to users worldwide. This is crucial for a good user experience, especially on a media-heavy site.
- **Background Workers:** Monitor your Sidekiq instance and scale the number of workers based on the job queue length to ensure timely processing of tasks like email sending and video transcoding.

### 2. Security & Compliance
- **Regular Audits:** Regularly audit the application for security vulnerabilities. Use tools like Brakeman for static analysis of Ruby on Rails code.
- **Dependency Updates:** Keep all dependencies (gems and npm packages) up-to-date to patch security holes. Use services like GitHub's Dependabot.
- **Data Privacy:** As you are handling user data, ensure you are compliant with regulations like GDPR and CCPA. This includes having a clear privacy policy and handling user data responsibly.
- **Environment Variables:** Never hard-code sensitive information. Use the Rails credentials system or a dedicated secrets management service (like AWS Secrets Manager or HashiCorp Vault) to manage API keys and other secrets for production environments.

### 3. Monetization & Financials
- **Stripe Webhooks:** Implement and thoroughly test Stripe webhooks to handle events like failed payments, subscription updates, and chargebacks automatically. The current implementation may not cover all edge cases.
- **Multiple Payment Options:** Consider expanding beyond simple one-time purchases. Think about subscriptions, course bundles, or different pricing tiers.
- **Affiliate/Referral System:** A common growth strategy is to allow users to earn a commission by referring new students.
- **Tax Compliance:** Integrate a service like Stripe Tax or Quaderno to handle sales tax and VAT calculations automatically.

### 4. Administration & Maintenance
- **Monitoring & Alerting:** Set up a monitoring service (e.g., New Relic, Datadog, Skylight) to track application performance, error rates, and server health. Configure alerts to be notified of issues proactively.
- **Logging:** Use a centralized logging service (e.g., LogDNA, Papertrail) to aggregate logs from all parts of your infrastructure. This makes debugging production issues much easier.
- **Customer Support:** Plan for a customer support workflow. This could start with a simple email address but might grow to require a ticketing system like Zendesk or Freshdesk.
- **Customization & Branding:** To sell this as a "white-label" solution, build out features that allow administrators to easily customize the branding (logo, colors, domain name) of their school without needing to touch the code.

## 6. AI/ML Integration Use Cases

Integrating Artificial Intelligence (AI) and Machine Learning (ML) can significantly enhance the value of an e-learning platform like Ruby Gyan. These technologies can create more personalized, engaging, and effective learning experiences. Here are several high-impact use cases.

### 1. Personalized Course Recommendation Engine
- **What it is:** An engine that analyzes a student's behavior—such as courses viewed, enrolled in, completed, and search history—to suggest other courses they might be interested in.
- **Benefit:** Increases student engagement and course sales by surfacing relevant content, similar to how Netflix or Amazon recommend content.
- **Implementation:**
    - **Simple:** Start with collaborative filtering based on user-item interactions (e.g., "users who took course A also took course B"). Ruby gems like `disco` or `recommendify` can be a starting point.
    - **Advanced:** Build a more sophisticated model using user profile data, course metadata (tags, descriptions), and interaction data. This could involve using Python libraries like Scikit-learn or TensorFlow and exposing the model via an API that the Rails app can query.

### 2. AI-Powered Q&A Assistant / Tutor
- **What it is:** An AI chatbot integrated into each course or lesson that can answer student questions about the content in real-time.
- **Benefit:** Provides instant support to students, reducing instructor workload and helping students overcome learning blocks faster.
- **Implementation:**
    - Use a Large Language Model (LLM) like OpenAI's GPT-4 or Google's Gemini.
    - **Fine-tuning/RAG:** To ensure the assistant answers based on the course content, use a Retrieval-Augmented Generation (RAG) approach. This involves feeding the model the text content of the current lesson or course as context when a student asks a question. This prevents the AI from giving answers that are too generic or out of scope.
    - The frontend would have a chat interface that sends student questions to a Rails backend endpoint, which in turn queries the LLM API with the appropriate context.

### 3. Automated Content Generation
- **What it is:** Using AI to automatically generate supplementary learning materials from existing lesson content.
- **Benefit:** Saves instructors significant time and effort in creating course materials.
- **Implementation:**
    - **Quizzes:** Use an LLM API to generate multiple-choice questions, true/false statements, or short-answer questions based on the text of a lesson.
    - **Summaries & Key Takeaways:** Automatically generate a concise summary or a bulleted list of key points for each lesson.
    - **Transcripts:** For video lessons, use a speech-to-text service (like AWS Transcribe or OpenAI's Whisper) to create accurate transcripts, improving accessibility and searchability.

### 4. Predictive Analytics for Student Success
- **What it is:** An ML model that identifies students who are at risk of dropping out or failing a course.
- **Benefit:** Allows instructors to intervene proactively by reaching out to struggling students with targeted support, improving course completion rates.
- **Implementation:**
    - **Feature Engineering:** Gather data points (features) for each student, such as login frequency, time spent on lessons, quiz scores, and forum participation.
    - **Model Training:** Use this data to train a classification model (e.g., logistic regression or a gradient boosting model) to predict the likelihood of a student not completing the course.
    - **Dashboard:** Display the risk score for each student on the instructor's dashboard, with alerts for high-risk students.
