# Security Quick Reference Guide

## 🔐 For Developers

### Accessing Secrets Safely

#### ✅ DO: Load from .env
```dart
// In main.dart or initialization code
await dotenv.load(fileName: ".env");
final apiKey = dotenv.env['API_KEY_NAME'];
```

#### ❌ DON'T: Hardcode secrets
```dart
// WRONG - Never do this!
const String apiKey = "pk_test_51RytrZ45hm6BjdBDwq18oaQ0oLS8Htp...";
```

---

### Token Storage

#### ✅ DO: Use StorageService for tokens
```dart
// Save token securely
await StorageService.saveToken(token, userId);

// Retrieve from cache (fast)
final token = StorageService.token;

// Retrieve from secure storage (fresh)
final freshToken = await StorageService.getTokenAsync();
```

#### ❌ DON'T: Store tokens in SharedPreferences directly
```dart
// WRONG - This is unencrypted!
await SharedPreferences.getInstance()
    .then((p) => p.setString('token', token));
```

---

### Environment Files

#### .env (Local Development)
Create in project root - **NEVER COMMIT TO GIT**

```
ANDROID_GOOGLE_MAP_API=your_key_here
STRIPE_PUBLISHABLE_KEY=your_key_here
```

#### .gitignore
✅ Ensure these patterns are present:
```
.env
.env.local
.env.*.local
```

---

## 🚀 For DevOps/Deployment

### Setting Environment Variables

#### Docker
```dockerfile
ENV STRIPE_PUBLISHABLE_KEY=your_production_key
ENV ANDROID_GOOGLE_MAP_API=your_production_key
```

#### CI/CD (GitHub Actions)
```yaml
env:
  STRIPE_PUBLISHABLE_KEY: ${{ secrets.STRIPE_PUBLISHABLE_KEY }}
  ANDROID_GOOGLE_MAP_API: ${{ secrets.ANDROID_GOOGLE_MAP_API }}
```

#### Local Development
```bash
# Create .env file
echo "STRIPE_PUBLISHABLE_KEY=pk_test_..." > .env
echo "ANDROID_GOOGLE_MAP_API=AIzaSy..." >> .env

# Run app
flutter run
```

---

## 🔍 Security Checklist

### Before Committing Code
- [ ] No hardcoded API keys in code
- [ ] No secrets in strings
- [ ] No credentials in comments
- [ ] All secrets in .env file
- [ ] .env added to .gitignore

### Before Deployment
- [ ] .env file configured for environment
- [ ] All secrets set in deployment platform
- [ ] API keys rotated (if exposed)
- [ ] Token expiration configured
- [ ] Secure storage enabled

### During Development
- [ ] Use `.env.local` for personal secrets
- [ ] Keep .env.example with dummy values in git
- [ ] Never share .env files
- [ ] Review git history for exposed keys

---

## 📋 Available Environment Variables

| Variable | Purpose | Required |
|----------|---------|----------|
| `STRIPE_PUBLISHABLE_KEY` | Payment processing | Yes (Production) |
| `ANDROID_GOOGLE_MAP_API` | Maps functionality | Yes (Production) |

---

## 🆘 If You Accidentally Exposed a Secret

1. **Stop** - Don't panic, rotation is quick
2. **Rotate** - Immediately rotate the exposed key
3. **Scan** - Use GitGuardian to check git history
4. **Remediate** - Remove from commits if found
5. **Update** - Deploy new keys to all environments

### Quick Rotation Steps
```bash
# 1. Generate new key in service dashboard
# 2. Update .env file locally
# 3. Test locally with new key
# 4. Commit .env update
# 5. Deploy to staging first
# 6. Deploy to production
# 7. Invalidate old key
```

---

## 🛡️ Secure Coding Practices

### Logging
```dart
// ✅ DO: Log non-sensitive info
AppLoggerHelper.info('User logged in: ${user.id}');

// ❌ DON'T: Log sensitive data
AppLoggerHelper.info('Token: $token');
AppLoggerHelper.info('API Key: $apiKey');
```

### Network Requests
```dart
// ✅ DO: Use Bearer token from cache
final token = StorageService.token;
headers['Authorization'] = 'Bearer $token';

// ❌ DON'T: Hardcode or log tokens
headers['Authorization'] = 'Bearer pk_test_123...';
```

### Error Handling
```dart
// ✅ DO: Handle missing credentials gracefully
final token = StorageService.token;
if (token == null) {
  SnackBarConstant.error("Please login again");
  navigateToLogin();
  return;
}

// ❌ DON'T: Force unwrap without checks
final token = StorageService.token!; // Could crash if null
```

---

## 🔐 Platform-Specific Security

### iOS (Keychain)
- Tokens stored in Keychain automatically encrypted
- Accessible only to your app
- Survives app uninstall? No (secure)

### Android (Keystore)
- Tokens stored in Keystore automatically encrypted
- Hardware-backed encryption when available
- Protected by device security

---

## 📚 Additional Resources

- [Flutter Security Testing](https://flutter.dev/docs/testing/security-testing)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-top-10/)
- [12 Factor App](https://12factor.net/)
- [Secure Coding Guidelines](https://cheatsheetseries.owasp.org/)

---

## ❓ Common Questions

**Q: Can I commit .env to git?**
A: No! It contains secrets. Use .env.example instead.

**Q: Is SharedPreferences secure?**
A: No, it's unencrypted. Use flutter_secure_storage.

**Q: How do I test with real API keys?**
A: Add to .env locally, never commit it.

**Q: What if I forget to add .env?**
A: App will show error log, no crashes.

**Q: Can I use different keys per environment?**
A: Yes, use .env.dev, .env.staging, .env.prod patterns.

---

**Last Updated:** February 2, 2026
**Status:** Production Ready
