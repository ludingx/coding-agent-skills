# When to Mock

Two schools of TDD take different positions on mocking. Know which you're applying and why.

## Chicago School (Classicist) — default

Use real collaborators you own. Mock only at **system boundaries**:

- External APIs (payment, email, SMS, etc.)
- Databases (prefer a real test DB; mock when that's impractical)
- Time / randomness (`Date.now()`, `Math.random()`)
- Filesystem (sometimes)

Don't mock:
- Your own classes/modules
- Internal collaborators
- Anything you control and can instantiate cheaply

**Why:** tests verify outcomes through real code paths. Renaming or restructuring internals doesn't break tests. Gives genuine confidence that components work together.

**Watch out for:** harder to pinpoint which class caused a failure; slow if real collaborators are expensive to construct.

```typescript
// Chicago: real DiscountService, mock only the external payment boundary
it("applies discount and charges correct amount", async () => {
  const mockPaymentClient = { charge: jest.fn().mockResolvedValue({ success: true }) };

  const checkout = new CheckoutService(new DiscountService(), mockPaymentClient);
  await checkout.process(order);

  expect(mockPaymentClient.charge).toHaveBeenCalledWith(90);
});
```

## London School (Mockist)

Mock all collaborators, even ones you own. Test each unit in strict isolation.

Use when:
- The unit under test has complex logic that warrants tight isolation
- You're doing design-first TDD to feel out interfaces before building collaborators
- A collaborator is expensive or painful to construct in tests
- You need to pinpoint failure at the unit level in a large system

**Why:** forces explicit, injectable interfaces; fast; failures point directly to the broken unit.

**Watch out for:** tests verify _interactions_ (was `charge` called?), not _outcomes_ (did the charge succeed?). Mocks can pass while the real integration is broken. Refactoring internal structure breaks tests even when behavior is unchanged.

```typescript
// London: mock all collaborators, verify interactions
it("applies discount and charges correct amount", async () => {
  const mockDiscountService = { calculate: jest.fn().mockReturnValue(10) };
  const mockPaymentClient = { charge: jest.fn().mockResolvedValue({ success: true }) };

  const checkout = new CheckoutService(mockDiscountService, mockPaymentClient);
  await checkout.process(order);

  expect(mockDiscountService.calculate).toHaveBeenCalledWith(order);
  expect(mockPaymentClient.charge).toHaveBeenCalledWith(90);
});
```

## Choosing a School

| Scenario | Prefer |
|---|---|
| Workflow wiring multiple owned components | Chicago — test the outcome, real collaborators |
| Complex isolated algorithm (parser, calculator, rules engine) | London — isolate and unit test it |
| Design-first TDD, feeling out interfaces | London — mocking forces interface clarity |
| External HTTP / DB / clock / filesystem | Both agree — mock the boundary |
| Stable, well-understood internal interfaces | Chicago — just use the real thing |

## Prefer Fakes Over Mocks at Boundaries

When mocking a boundary you'll use across many tests, a hand-written fake is usually better than a spy/stub:

```typescript
// Fake: real behavior, shared across tests, no conditional mock logic
class InMemoryEmailService implements EmailService {
  sent: Email[] = [];
  send(email: Email) { this.sent.push(email); }
}

// Mock: fragile, duplicated setup per test
const mockEmail = { send: jest.fn() };
```

Fakes are reusable, readable, and can encode real constraints (e.g. duplicate detection).

## Designing for Mockability

At system boundaries, design interfaces that are easy to swap:

**Use dependency injection** — pass dependencies in rather than constructing them internally:

```typescript
// Easy to swap
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// Hard to swap
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**Prefer SDK-style interfaces over generic fetchers** — one function per operation, not one function with conditional logic:

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
