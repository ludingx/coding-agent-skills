# Tests

Use **AAA (Arrange, Act, Assert)** to structure every test.

## Pattern 1 — Unit: pure result

Assert on the return value or state change. No mocks needed.

```ts
// GOOD: asserts observable outcome
test('confirms order when payment succeeds', () => {
  // Arrange
  const card = validCard()

  // Act
  const result = processPayment({ amount: 100, card })

  // Assert
  expect(result.status).toBe('confirmed')
})

// BAD: asserts on internal method name — breaks if renamed even if behavior unchanged
test('checkout calls paymentService.process', async () => {
  // Arrange
  const spy = jest.spyOn(paymentService, 'process')

  // Act
  await checkout(cart, payment)

  // Assert
  expect(spy).toHaveBeenCalled()
})
```

## Pattern 2 — Unit: side effect boundary

Test a handler or service that triggers external calls (email, SNS, DB). Mock the boundaries — asserting the call *is* the behavior since there's no other observable outcome.

```ts
// GOOD: verifies the right boundary was called with the right contract
test('sends confirmation email after checkout', async () => {
  // Arrange
  const emailService = { send: jest.fn() }
  const handler = checkoutHandler({ emailService })

  // Act
  await handler({ orderId: '123', email: 'alice@example.com' })

  // Assert
  expect(emailService.send).toHaveBeenCalledWith({
    to: 'alice@example.com',
    template: 'order-confirmation',
    orderId: '123'
  })
})

// BAD: asserts on an internal method instead of the boundary call itself.
//      If you inline buildEmailPayload() or rename it, this test breaks
//      even though the email sent to the user is exactly the same.
test('checkout builds email payload', async () => {
  // Arrange
  const spy = jest.spyOn(emailBuilder, 'buildEmailPayload')

  // Act
  await checkoutHandler({ orderId: '123', email: 'alice@example.com' })

  // Assert
  expect(spy).toHaveBeenCalled()
})
```

## Pattern 3 — Integration: real outcome

No mocks. Assert on actual state through the public interface. Requires real infra (DB container, HTTP server).

```ts
// GOOD: verifies through interface — survives switching storage implementation
test('createUser makes user retrievable', async () => {
  // Arrange
  const name = 'Alice'

  // Act
  const user = await createUser({ name })

  // Assert
  const retrieved = await getUser(user.id)
  expect(retrieved.name).toBe(name)
})

// BAD: bypasses interface to verify — couples test to storage implementation
test('createUser saves to database', async () => {
  // Arrange
  const name = 'Alice'

  // Act
  await createUser({ name })

  // Assert
  const row = await db.query('SELECT * FROM users WHERE name = ?', [name])
  expect(row).toBeDefined()
})
```
