import SwiftUI

// MARK: - Login & Authentication Flow Template
// Complete authentication flow with login, signup, and forgot password

struct LoginFlowTemplate: View {
    @State private var currentView: AuthView = .login
    
    enum AuthView {
        case login, signup, forgotPassword, onboarding
    }
    
    var body: some View {
        Group {
            switch currentView {
            case .login:
                LoginView(currentView: $currentView)
            case .signup:
                SignUpView(currentView: $currentView)
            case .forgotPassword:
                ForgotPasswordView(currentView: $currentView)
            case .onboarding:
                OnboardingView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentView)
    }
}

// MARK: - Login View
struct LoginView: View {
    @Binding var currentView: LoginFlowTemplate.AuthView
    @State private var email = ""
    @State private var password = ""
    @State private var isSecured = true
    @State private var rememberMe = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Spacer(minLength: 50)
                    
                    // Logo and Welcome
                    VStack(spacing: 20) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        VStack(spacing: 8) {
                            Text("Welcome Back")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Sign in to your account")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Login Form
                    VStack(spacing: 20) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Enter your email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            HStack {
                                if isSecured {
                                    SecureField("Enter your password", text: $password)
                                } else {
                                    TextField("Enter your password", text: $password)
                                }
                                
                                Button(action: { isSecured.toggle() }) {
                                    Image(systemName: isSecured ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                        
                        // Remember Me & Forgot Password
                        HStack {
                            Button(action: { rememberMe.toggle() }) {
                                HStack(spacing: 8) {
                                    Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                        .foregroundColor(rememberMe ? .blue : .secondary)
                                    
                                    Text("Remember me")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            Spacer()
                            
                            Button("Forgot Password?") {
                                currentView = .forgotPassword
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        
                        // Login Button
                        Button(action: handleLogin) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                        .foregroundColor(.white)
                                }
                                
                                Text("Sign In")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFormValid ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(!isFormValid || isLoading)
                        
                        // Social Login
                        VStack(spacing: 15) {
                            HStack {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.secondary)
                                
                                Text("or continue with")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack(spacing: 15) {
                                SocialLoginButton(icon: "apple.logo", action: {})
                                SocialLoginButton(icon: "google.logo", action: {})
                                SocialLoginButton(icon: "facebook.logo", action: {})
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Sign Up Link
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.secondary)
                        
                        Button("Sign Up") {
                            currentView = .signup
                        }
                        .foregroundColor(.blue)
                        .fontWeight(.medium)
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }
    
    private func handleLogin() {
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            currentView = .onboarding
        }
    }
}

// MARK: - Sign Up View
struct SignUpView: View {
    @Binding var currentView: LoginFlowTemplate.AuthView
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var acceptTerms = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Text("Create Account")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Join us and get started today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 30)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        HStack(spacing: 15) {
                            AuthTextField(title: "First Name", text: $firstName)
                            AuthTextField(title: "Last Name", text: $lastName)
                        }
                        
                        AuthTextField(title: "Email", text: $email, keyboardType: .emailAddress)
                        AuthTextField(title: "Password", text: $password, isSecure: true)
                        AuthTextField(title: "Confirm Password", text: $confirmPassword, isSecure: true)
                        
                        // Terms and Conditions
                        Button(action: { acceptTerms.toggle() }) {
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: acceptTerms ? "checkmark.square.fill" : "square")
                                    .foregroundColor(acceptTerms ? .blue : .secondary)
                                
                                Text("I agree to the Terms of Service and Privacy Policy")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                        
                        // Sign Up Button
                        Button(action: handleSignUp) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                        .foregroundColor(.white)
                                }
                                
                                Text("Create Account")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFormValid ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(!isFormValid || isLoading)
                    }
                    
                    Spacer()
                    
                    // Sign In Link
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.secondary)
                        
                        Button("Sign In") {
                            currentView = .login
                        }
                        .foregroundColor(.blue)
                        .fontWeight(.medium)
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && 
        !password.isEmpty && password == confirmPassword && 
        email.contains("@") && acceptTerms
    }
    
    private func handleSignUp() {
        isLoading = true
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            currentView = .onboarding
        }
    }
}

// MARK: - Forgot Password View
struct ForgotPasswordView: View {
    @Binding var currentView: LoginFlowTemplate.AuthView
    @State private var email = ""
    @State private var isLoading = false
    @State private var emailSent = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                // Icon and Title
                VStack(spacing: 20) {
                    Image(systemName: "envelope.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    VStack(spacing: 8) {
                        Text("Forgot Password?")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Enter your email address and we'll send you a link to reset your password")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                
                if !emailSent {
                    // Email Input
                    VStack(spacing: 20) {
                        AuthTextField(title: "Email", text: $email, keyboardType: .emailAddress)
                        
                        Button(action: handleResetPassword) {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                        .foregroundColor(.white)
                                }
                                
                                Text("Send Reset Link")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(email.contains("@") ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(!email.contains("@") || isLoading)
                    }
                } else {
                    // Success Message
                    VStack(spacing: 20) {
                        Text("Email Sent!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        
                        Text("Check your email for a password reset link")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("Resend Email") {
                            handleResetPassword()
                        }
                        .foregroundColor(.blue)
                    }
                }
                
                Spacer()
                
                // Back to Login
                Button("Back to Sign In") {
                    currentView = .login
                }
                .foregroundColor(.blue)
                .fontWeight(.medium)
            }
            .padding(.horizontal, 30)
        }
    }
    
    private func handleResetPassword() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            emailSent = true
        }
    }
}

// MARK: - Onboarding View
struct OnboardingView: View {
    var body: some View {
        VStack {
            Text("Welcome to the App!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("You're now logged in successfully")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .padding()
        }
    }
}

// MARK: - Supporting Views
struct AuthTextField: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            if isSecure {
                SecureField("Enter \(title.lowercased())", text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            } else {
                TextField("Enter \(title.lowercased())", text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
        }
    }
}

struct SocialLoginButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 50, height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .foregroundColor(.primary)
    }
}

#Preview {
    LoginFlowTemplate()
}
