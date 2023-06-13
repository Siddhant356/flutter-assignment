class AppConfiguration {
  static const baseURL = String.fromEnvironment('baseUrl', defaultValue: 'https://api.kevee.com');
  static const stripeSecret = String.fromEnvironment('stripeSecret', defaultValue: 'sk_test_51NG4EUSDadCoPzy5KhYnXTWWT326ozvkWnJb9wMQsYjEkYOdFCodPtWWizZy9oWRO4Kv1xhPHpH9P3DffOT3rayA00iXdgVPVb');
  static const stripePublishableKey = String.fromEnvironment('stripePublishableKey', defaultValue: 'pk_test_51NG4EUSDadCoPzy52KDAD9OUCMitYVRjAhjrYCZ5VhUa1X6zx8zyQtcLQYMHHArN9I68uKgS2zokIH8kN7KFWaTw00ZpX0BX50');
  static const googleMapKey = String.fromEnvironment('googleMapKey', defaultValue: 'AIzaSyAspPd5sXSPrJiBbCqzZ9ntP639ZrzPwGQ');
  static const application = "kevee";
}
