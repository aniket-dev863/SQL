## 1. What does `NOT EXISTS` mean?

`EXISTS` asks:

> **"Does the subquery find at least one matching row?"**

`NOT EXISTS` asks:

> **"Does the subquery find ZERO matching rows?"**

In our question:

> Find the highest-paid employee in each department.

For an employee `e`, we're asking:

```sql
SELECT 1
FROM Employee x
WHERE x.dept_id = e.dept_id
  AND x.salary > e.salary
```

In plain English:

> "Is there another employee in my department whose salary is higher than mine?"

### Example

Suppose:

```text
A → 50k → Dept 10
B → 70k → Dept 10
```

For **A**:

```text
Is there someone in Dept 10 earning > 50k?
```

Yes → B earns 70k.

Therefore:

```text
EXISTS = TRUE
NOT EXISTS = FALSE
```

So A is rejected.

For **B**:

```text
Is there someone in Dept 10 earning > 70k?
```

No.

Therefore:

```text
EXISTS = FALSE
NOT EXISTS = TRUE
```

So B is returned.

---

# 2. Why `SELECT 1`?

This is a very common beginner question.

Inside `EXISTS`, **we don't care what the subquery returns**.

We only care:

```text
Did it find a row?
```

So these are effectively equivalent:

```sql
SELECT 1
FROM Employee x
WHERE ...
```

```sql
SELECT *
FROM Employee x
WHERE ...
```

```sql
SELECT x.name
FROM Employee x
WHERE ...
```

Because `EXISTS` doesn't use the returned value.

It only checks:

```text
At least one row?
        ↓
YES → TRUE
NO  → FALSE
```

Therefore:

```sql
SELECT 1
```

is simply a convention that communicates:

> **"I don't care about the data. I only care whether a matching row exists."**

---

## 🧠 Think of `EXISTS` like this

Don't think:

```text
SELECT 1 → give me the number 1
```

Think:

```text
EXISTS(
    SELECT 1
    ...
)
```

as:

```text
"Does ANY row satisfy these conditions?"
```

The `1` is basically irrelevant.

---

# 3. Why is this useful for SQL problems?

You'll see questions like:

> Find customers who have placed an order.

Think:

```sql
EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.id
)
```

Meaning:

> Does this customer have at least one order?

And:

> Find customers who **never** placed an order.

Think:

```sql
NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.id
)
```

Meaning:

> Does this customer have **zero** orders?

---

## 🔥 Connect it to our current problem

```sql
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee x
    WHERE x.dept_id = e.dept_id
      AND x.salary > e.salary
)
```

Read it literally:

> **Keep employee `e` only if there does NOT EXIST another employee `x` in the same department with a higher salary.**

That's why it identifies the highest-paid employee.

### One more subtlety

We don't explicitly write:

```sql
x.id <> e.id
```

because:

```sql
x.salary > e.salary
```

already prevents the current employee from matching themselves.

An employee earning `70000` cannot satisfy:

```text
70000 > 70000
```

So the condition naturally finds someone **better-paid**.

Now you're ready for **Question 17**: combining `NOT EXISTS` with the global-average scalar subquery.
