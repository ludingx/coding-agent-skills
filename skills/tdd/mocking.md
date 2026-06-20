# When to Mock

**Rule of thumb**: Mock when the real collaborator is a liability. Use the real thing otherwise.

A collaborator is a liability when it is:
- Slow or expensive to construct
- Has side effects (sends email, writes to DB, calls external API)
- Non-deterministic (time, randomness)
- Already well-tested elsewhere and you don't want to re-exercise it

Always mock at system boundaries (external HTTP, DB, clock, filesystem) — no exceptions.

## Decision Table

| Scenario | Approach |
|---|---|
| External API / HTTP / DB / clock | Mock — always |
| Internal service with side effects | Mock — it's a liability |
| Internal service that's pure / cheap to construct | Use the real thing |
| Complex isolated algorithm | Use the real thing, test it directly |
| Feeling out a new interface before building it | Mock to drive the design |

## Prefer Fakes Over Mocks at Boundaries

When a boundary is used across many tests, a hand-written fake beats a spy/stub:

```typescript
// Fake: real behavior, reusable, no conditional mock logic per test
class InMemoryEmailService implements EmailService {
  sent: Email[] = [];
  send(email: Email) { this.sent.push(email); }
}

// Mock: fragile, setup duplicated per test
const mockEmail = { send: jest.fn() };
```

Fakes are reusable, readable, and can encode real constraints (e.g. duplicate detection).

## Designing for Mockability

See [interface-design.md](interface-design.md) for how to design interfaces that are easy to swap.
