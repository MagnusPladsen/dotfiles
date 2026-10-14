import { test, expect, mock } from 'claude-code/testing'

const WINDOW_A = '2026-10-14T15:00:00.000Z'
const WINDOW_B = '2026-10-14T20:00:00.000Z'

const measure = (percentUsed: number, resetsAt = WINDOW_A) => ({
  context: { window: 200000 },
  rateLimits: [{ kind: 'five_hour', percentUsed, resetsAt }],
  changed: ['rateLimits' as const],
})

test('warns once per 10% step from 50%, and again in a new window', async ($, on) => {
  mock.store(on)
  on('session.measure', (_$, e) => ({ changed: e.changed }))
  const toasts: string[] = []
  const notes: string[] = []
  on('ui.toast', (_$, e) => {
    toasts.push(e.text)
    return { value: undefined }
  })
  on('ui.notify', (_$, e) => {
    notes.push(e.text)
    return { value: { isSent: true as const, channel: "kitty" } }
  })

  await $.session.measure(measure(45))
  expect(toasts.length).toBe(0)

  await $.session.measure(measure(52))
  expect(toasts.length).toBe(1)
  expect(toasts[0]).toContain('50%')

  await $.session.measure(measure(55))
  expect(toasts.length).toBe(1)

  await $.session.measure(measure(73.5))
  expect(toasts.length).toBe(2)
  expect(toasts[1]).toContain('70%')

  await $.session.measure(measure(91))
  expect(toasts.length).toBe(3)
  expect(notes.length).toBe(1)

  await $.session.measure(measure(51, WINDOW_B))
  expect(toasts.length).toBe(4)
  expect(toasts[3]).toContain('50%')
})

test('ignores the seven-day window', async ($, on) => {
  mock.store(on)
  on('session.measure', (_$, e) => ({ changed: e.changed }))
  const toasts: string[] = []
  on('ui.toast', (_$, e) => {
    toasts.push(e.text)
    return { value: undefined }
  })

  await $.session.measure({
    context: { window: 200000 },
    rateLimits: [{ kind: 'seven_day', percentUsed: 80 }],
    changed: ['rateLimits'],
  })
  expect(toasts.length).toBe(0)
})
