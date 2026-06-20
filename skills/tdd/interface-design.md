# Interface Design for Testability

Good interfaces make testing natural:

1. **Accept dependencies, don't create them**

   ```typescript
   // Testable
   function processOrder(order, paymentGateway) {}

   // Hard to test
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

2. **Return results, don't produce side effects**

   ```typescript
   // Testable
   function calculateDiscount(cart): Discount {}

   // Hard to test
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

3. **Small surface area**
   - Fewer methods = fewer tests needed
   - Fewer params = simpler test setup

4. **One function per external operation, not a generic dispatcher**

   ```typescript
   // GOOD: each function independently mockable, one shape per call
   const api = {
     getUser: (id) => fetch(`/users/${id}`),
     createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
   };

   // BAD: mocking requires conditional logic inside the mock
   const api = {
     fetch: (endpoint, options) => fetch(endpoint, options),
   };
   ```
