Focus: Security best practices and PII protection.

Security Guardrails:

Sanitization: All external inputs (API, CLI, or User UI) must be sanitized.

Auth Enforcement: Verify that any new endpoint or sensitive function includes an authorization check.

Logging Policy:

PII Masking: Never log Personally Identifiable Information (PII) such as emails, tokens, or passwords. Use masked strings (e.g., user_***@email.com) if logging is necessary for debugging.

Log Levels: Use INFO for flow tracking, WARN for recoverable issues, and ERROR for failures. Avoid DEBUG logs in production-ready code.