# Good and Bad Tests

Use **AAA (Arrange, Act, Assert)** to structure every test:

```typescript
test("description of behavior", async () => {
  // Arrange — set up state and dependencies
  const cart = createCart();
  cart.add(product);

  // Act — invoke the behavior
  const result = await checkout(cart, paymentMethod);

  // Assert — verify the outcome
  expect(result.status).toBe("confirmed");
});
```

## Good Tests

**Behavior-focused**: Test through public interfaces, not internal implementation details.

```typescript
// GOOD: State assertion — verifies observable outcome
test("user can checkout with valid cart", async () => {
  // Arrange
  const cart = createCart();
  cart.add(product);

  // Act
  const result = await checkout(cart, paymentMethod);

  // Assert
  expect(result.status).toBe("confirmed");
});
```

```typescript
// GOOD: Interaction assertion — verifies boundary was called correctly
// (valid when testing a unit against a mocked dependency)
test("checkout charges the cart total", async () => {
  // Arrange
  const mockPayment = { charge: jest.fn().mockResolvedValue({ success: true }) };
  const checkout = new CheckoutService(mockPayment);

  // Act
  await checkout.process(cart);

  // Assert
  expect(mockPayment.charge).toHaveBeenCalledWith(cart.total);
});
```

```typescript
// GOOD: Verifies through interface — survives switching from SQL to any other store
// (contrast with the bad version in Bad Tests below)
test("createUser makes user retrievable", async () => {
  // Arrange
  const name = "Alice";

  // Act
  const user = await createUser({ name });

  // Assert
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe(name);
});
```

Characteristics:

- Tests behavior users/callers care about
- Describes WHAT, not HOW
- One logical assertion per test

## Bad Tests

**Implementation-detail tests**: Coupled to internal structure.

```typescript
// BAD: Asserts on internal method name — breaks if you rename process() to charge()
//      even though checkout behavior is unchanged
test("checkout calls paymentService.process", async () => {
  const spy = jest.spyOn(paymentService, 'process');
  await checkout(cart, payment);
  expect(spy).toHaveBeenCalled();
});
```

```typescript
// BAD: Bypasses interface to verify — couples test to storage implementation
// (see the good version in Good Tests above)
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});
```

Red flags:

- Testing private methods
- Test name describes HOW not WHAT
- Verifying through external means instead of interface
