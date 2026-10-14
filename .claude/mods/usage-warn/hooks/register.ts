import type { Register } from 'claude-code'

const FIRST_STEP = 50
const LOUD_STEP = 90
const KEY = 'five_hour'

type Warned = { window: string; step: number }

const isWarned = (value: unknown): value is Warned =>
  typeof value === 'object' &&
  value !== null &&
  typeof (value as Warned).window === 'string' &&
  typeof (value as Warned).step === 'number'

const resetTime = (resetsAt: string | undefined) => {
  if (!resetsAt) return ''
  const at = new Date(resetsAt)
  if (Number.isNaN(at.getTime())) return ''
  const hh = String(at.getHours()).padStart(2, '0')
  const mm = String(at.getMinutes()).padStart(2, '0')
  return ` · resets ${hh}:${mm}`
}

export const register: Register = on => {
  on('session.measure', async ($, e, next) => {
    const limit = e.rateLimits.find(r => r.kind === KEY)
    const step = limit ? Math.floor(limit.percentUsed / 10) * 10 : 0

    if (limit && step >= FIRST_STEP) {
      // $.store is shared across sessions, so parallel sessions warn once between them.
      const window = limit.resetsAt ?? 'unknown'
      const last = await $.store.get(KEY)
      const warnedStep = isWarned(last) && last.window === window ? last.step : 0

      if (step > warnedStep) {
        await $.store.set(KEY, { window, step } satisfies Warned)
        const text = `5h usage at ${step}%${resetTime(limit.resetsAt)}`
        $.ui.toast(text, { timeoutMs: 8000 })
        if (step >= LOUD_STEP) {
          await $.ui.notify(text, { title: 'Claude usage' }).catch(() => undefined)
        }
      }
    }

    return next(e)
  })
}
