# How to Articulate Animation

Rules for describing motion that produces implementable specs, not vibes.

## Core Principle

Motion is feedback, not decoration. Every animation answers one question: "what just happened?" If you can't name what it communicates, cut it.

## The Three Decisions

Every animation spec reduces to three choices:

1. **What moves** — one element, a group, a transition between views
2. **How it moves** — the transform (translate/scale/rotate/fade) + easing
3. **Why it moves** — entrance, feedback, orientation, attention

If "why" has no clear answer, the animation shouldn't exist.

## Easing Rules of Thumb

| Direction | Easing | Reason |
|-----------|--------|--------|
| Entering screen | Ease-out | Decelerates into place, feels like arrival |
| Leaving screen | Ease-in | Accelerates away, feels like departure |
| Moving on screen | Ease-in-out | Smooth repositioning |
| Responding to user | Spring or ease-out | Feels alive, acknowledges input |
| Looping/mechanical | Linear | Only for spinners, marquees, progress |

Never mirror enter for exit — enter decelerates in, exit accelerates out. Reversing entry for exit feels like content arriving backwards.

## Duration Anchors

- **Hover/micro-interaction**: ~150ms (platform-native feel)
- **Enter/exit**: 200-350ms
- **Complex orchestration**: 400-600ms total
- **> 400ms without visible progress**: feels broken

## Stagger

40-80ms intervals between items create a sense of arrival. All at once feels like a flash. Cap total stagger duration — if list has 20 items, don't let the last one wait 1.6s.

## Choreography

Multiple elements animating simultaneously without coordination = visual noise. Fix with:
- **Stagger**: items cascade in sequence
- **Grouping**: related elements move as one
- **Sequencing**: A finishes → B starts

The viewer's eye needs one clear path at any moment.

## Direction = Spatial Memory

Navigation animations must reflect spatial relationships:
- Forward → slides right/up
- Backward → slides left/down
- Deeper → scales up from origin
- Shallower → scales down to origin

Violating this disorients the user. They lose track of where they are.

## Performance Constraint

Only animate `transform` and `opacity` — they composite on GPU without triggering layout. Animating `width`, `height`, `padding`, `top`, `left` forces layout recalculation every frame. The difference between 60fps and jank.

## Motion as Feedback Patterns

| Action | Motion feedback |
|--------|----------------|
| Button press | Scale down slightly (press), scale back (release) |
| Invalid input | Shake — 3-4 cycle horizontal oscillation |
| Success | Checkmark draw-in, or subtle scale+fade |
| Loading | Skeleton shimmer (not spinner for content areas) |
| Drag | Element follows with momentum on release |

## Reduced Motion

Not optional. `prefers-reduced-motion: reduce` means:
- Remove translation/scale motion
- Keep opacity fades (shorter duration)
- Keep color transitions
- Ignoring this can trigger vestibular symptoms

## Articulation Checklist

When describing an animation, answer these in order:

1. What element?
2. What triggers it?
3. What transform (translate/scale/rotate/fade/reveal)?
4. What direction and distance?
5. What easing and why?
6. How long?
7. Multiple items? Stagger?
8. Interruptible?
9. Reduced motion fallback?

If you can fill this list, any developer can implement it without a video reference.

---

Sources: [animations.dev/vocabulary](https://animations.dev/vocabulary), [index.how/to/articulate](https://index.how/to/articulate) — Emil Kowalski
