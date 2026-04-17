import 'package:flutter/material.dart';
import 'package:zona_x_16_4/features/auth/data/auth_service.dart';
import 'package:zona_x_16_4/core/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authService = AuthService();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _vehicleType = 'Car';
  bool isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _passwordStrengthText = '';
  Color _passwordStrengthColor = Colors.grey;

  void _updatePasswordStrength() {
    final strength = authService.getPasswordStrength(_passwordController.text);
    setState(() {
      switch (strength) {
        case 0:
          _passwordStrengthText = '';
          _passwordStrengthColor = Colors.grey;
        case 1:
          _passwordStrengthText = 'Weak';
          _passwordStrengthColor = Colors.red;
        case 2:
          _passwordStrengthText = 'Medium';
          _passwordStrengthColor = Colors.orange;
        case 3:
          _passwordStrengthText = 'Strong';
          _passwordStrengthColor = Colors.green;
        default:
          _passwordStrengthText = '';
          _passwordStrengthColor = Colors.grey;
      }
    });
  }

  void signUp() async {
    final name = _nameController.text;
    final phone = authService.formatPhoneNumber(_phoneController.text);
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorDialog("Validation Error", "Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog("Password Mismatch", "Passwords don't match");
      return;
    }

    setState(() => isLoading = true);

    final result = await authService.signUp(
        email, password, name, phone, _vehicleType);

    setState(() => isLoading = false);

    if (!mounted) return;

    if (result == null) {
      _showSuccessDialog(
        "Account Created",
        "Check your email to confirm your account",
        onConfirm: () => Navigator.pop(context),
      );
    } else {
      _showErrorDialog("Sign Up Failed", result);
    }
  }

  void _showErrorDialog(String title, String message) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.surface,
        title: Text(
          title,
          style: TextStyle(color: appColors.textPrimary),
        ),
        content: Text(
          message,
          style: TextStyle(color: appColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: appColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String title, String message,
      {VoidCallback? onConfirm}) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.surface,
        title: Text(
          title,
          style: TextStyle(color: appColors.textPrimary),
        ),
        content: Text(
          message,
          style: TextStyle(color: appColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm?.call();
            },
            child: Text(
              "OK",
              style: TextStyle(color: appColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        backgroundColor: appColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Account",
          style: TextStyle(color: appColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Join ZonaX",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: appColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Create your account to get started",
              style: TextStyle(
                fontSize: 14,
                color: appColors.textSecondary,
              ),
            ),
            const SizedBox(height: 30),

            // Name Field
            _buildFieldLabel('Full Name'),
            const SizedBox(height: 8),
            _buildStyledTextField(
              controller: _nameController,
              hintText: 'Enter your full name',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),

            // Email Field
            _buildFieldLabel('Email'),
            const SizedBox(height: 8),
            _buildStyledTextField(
              controller: _emailController,
              hintText: 'example@email.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Phone Field
            _buildFieldLabel('Phone Number'),
            const SizedBox(height: 8),
            _buildStyledTextField(
              controller: _phoneController,
              hintText: '+20 XXX XXX XXXX',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              onChanged: (value) => setState(() {}),
            ),
            if (_phoneController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Format: +201001234567',
                  style: TextStyle(
                    fontSize: 12,
                    color: authService
                                .formatPhoneNumber(_phoneController.text)
                                .length ==
                            13
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Password Field
            _buildFieldLabel('Password'),
            const SizedBox(height: 8),
            _buildStyledPasswordField(
              controller: _passwordController,
              hintText: 'At least 6 characters',
              showPassword: _showPassword,
              onVisibilityToggle: () =>
                  setState(() => _showPassword = !_showPassword),
              onChanged: (value) => _updatePasswordStrength(),
            ),
            if (_passwordStrengthText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Text(
                      'Strength: ',
                      style: TextStyle(fontSize: 12, color: appColors.textHint),
                    ),
                    Text(
                      _passwordStrengthText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _passwordStrengthColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: authService.getPasswordStrength(
                                _passwordController.text) /
                            3,
                        backgroundColor: appColors.inputBorder,
                        valueColor:
                            AlwaysStoppedAnimation(_passwordStrengthColor),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // Confirm Password Field
            _buildFieldLabel('Confirm Password'),
            const SizedBox(height: 8),
            _buildStyledPasswordField(
              controller: _confirmPasswordController,
              hintText: 'Re-enter your password',
              showPassword: _showConfirmPassword,
              onVisibilityToggle: () =>
                  setState(() => _showConfirmPassword = !_showConfirmPassword),
            ),
            const SizedBox(height: 16),

            // Vehicle Type Dropdown
            _buildFieldLabel('Vehicle Type'),
            const SizedBox(height: 8),
            _buildDropdown(),
            const SizedBox(height: 30),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Sign In Link
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: appColors.textSecondary),
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: appColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Text(
      label,
      style: TextStyle(
        color: appColors.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(color: appColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: appColors.textHint, fontSize: 14),
        prefixIcon: Icon(prefixIcon,
            color: appColors.inputIcon, size: 20),
        filled: true,
        fillColor: appColors.inputBackground,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: appColors.inputBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: appColors.inputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: appColors.accent, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildStyledPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool showPassword,
    required VoidCallback onVisibilityToggle,
    Function(String)? onChanged,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return TextFormField(
      controller: controller,
      obscureText: !showPassword,
      onChanged: onChanged,
      style: TextStyle(color: appColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: appColors.textHint, fontSize: 14),
        prefixIcon: Icon(Icons.lock_outline_rounded,
            color: appColors.inputIcon, size: 20),
        suffixIcon: GestureDetector(
          onTap: onVisibilityToggle,
          child: Icon(
            showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: appColors.inputIcon,
            size: 20,
          ),
        ),
        filled: true,
        fillColor: appColors.inputBackground,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: appColors.inputBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: appColors.inputBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: appColors.accent, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: appColors.inputBorder),
        borderRadius: BorderRadius.circular(12),
        color: appColors.inputBackground,
      ),
      child: DropdownButton<String>(
        value: _vehicleType,
        isExpanded: true,
        underline: const SizedBox(),
        style: TextStyle(color: appColors.textPrimary),
        dropdownColor: appColors.surface,
        items: ['Car', 'Truck', 'Motorcycle', 'Bus', 'Van']
            .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _vehicleType = value);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
