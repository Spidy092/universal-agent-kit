---
name: frontend-ui
description: Frontend UI work covering responsive design, accessibility, loading/error/empty states, components, layout, and animation integration.
---

# Frontend UI Skill

## When to Use

Use when building UI components, fixing layout, making pages responsive, improving UX, adding animation, integrating assets/SVG/layers, or improving accessibility.

## Goal Tracking

Before starting, define:
- **UI Goal**: What specific UI improvement are we making?
- **User Experience**: How will this improve the user's experience?
- **Done Criteria**: How will we know the UI work is complete?

## Inputs to Gather

- target component/page
- framework
- design system
- asset paths
- breakpoints
- states required
- browser/mobile verification path

## Workflow

### Phase 1: Analysis (5 min)
- [ ] Inspect existing UI patterns
- [ ] Understand current component structure
- [ ] Identify design system constraints
- [ ] Plan responsive breakpoints

### Phase 2: Implementation (15-30 min)
- [ ] Reuse existing components first
- [ ] Implement desktop layout
- [ ] Implement mobile layout
- [ ] Add loading state
- [ ] Add empty state
- [ ] Add error state
- [ ] Add disabled state
- [ ] Add accessible labels
- [ ] Add keyboard behavior

### Phase 3: Polish (10 min)
- [ ] Add animation (useful, not heavy)
- [ ] Verify with viewport sizes
- [ ] Test accessibility
- [ ] Mention design assumptions

### Phase 4: Verification (5 min)
- [ ] Test on multiple screen sizes
- [ ] Test keyboard navigation
- [ ] Test with screen reader
- [ ] Verify no layout shifts

## UI Checklist

### Layout
- [ ] Desktop layout works
- [ ] Tablet layout works
- [ ] Mobile layout works
- [ ] No horizontal scroll
- [ ] Proper spacing/margins

### States
- [ ] Loading state shown
- [ ] Empty state shown
- [ ] Error state shown
- [ ] Disabled state shown
- [ ] Success state shown

### Accessibility
- [ ] Proper heading hierarchy
- [ ] Alt text for images
- [ ] ARIA labels where needed
- [ ] Keyboard navigation works
- [ ] Focus management correct
- [ ] Color contrast sufficient

### Performance
- [ ] Images optimized
- [ ] Lazy loading implemented
- [ ] No unnecessary re-renders
- [ ] Animations performant

### Responsive
- [ ] Mobile-first approach
- [ ] Breakpoints defined
- [ ] Touch targets appropriate
- [ ] Text readable on all sizes

## Common Patterns

### Component Structure
```jsx
function Component({ props }) {
  // State
  // Effects
  // Handlers
  // Render
  return (
    <div>
      {/* Loading state */}
      {/* Error state */}
      {/* Empty state */}
      {/* Content */}
    </div>
  )
}
```

### Responsive Breakpoints
- Mobile: < 640px
- Tablet: 640px - 1024px
- Desktop: > 1024px

### Animation Guidelines
- Use for feedback, not decoration
- Keep under 300ms
- Use easing functions
- Respect prefers-reduced-motion

## Output Format

## UI goal
## Components changed
## States covered
## Accessibility checks
## Responsive checks
## Remaining UX risks
