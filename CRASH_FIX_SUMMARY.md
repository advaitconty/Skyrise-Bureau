# iPadOS SIGABRT Crash - Complete Analysis & Fix

## 🔴 PROBLEM STATEMENT
Your iPadOS app crashes with SIGABRT **after running for a while**, specifically when users navigate to the Shop, Fuel, or Attributes screens.

---

## 🎯 ROOT CAUSE IDENTIFIED

**Missing `.modelContainer()` modifier on `.fullScreenCover` presentations**

### Location
`Skyrise Bureau/Skyrise Bureau/Views/MapView/MapView.swift` - Lines 144-152

### The Issue
On macOS, you used separate `Window` declarations, each with their own `.modelContainer(sharedModelContainer)`:
```swift
Window("Jet Set Emporium", id: "shop") {
    AirplaneStoreView()
}
.modelContainer(sharedModelContainer)  // ✅ ModelContainer provided
```

On iPadOS, you switched to `.fullScreenCover` but **forgot to add the modelContainer**:
```swift
.fullScreenCover(isPresented: $openSomeOtherView) {
    if viewToShow == "market" {
        AirplaneStoreView()  // ❌ NO modelContainer!
    } else if viewToShow == "fuel" {
        FuelPriceView()      // ❌ NO modelContainer!
    } else if viewToShow == "attributes" {
        UserUpgradeView()    // ❌ NO modelContainer!
    }
}
```

### Why This Causes SIGABRT

All three views (`AirplaneStoreView`, `FuelPriceView`, `UserUpgradeView`) use SwiftData:

**AirplaneStoreView.swift**:
```swift
@Query var swiftDataUserData: [UserData]
@Environment(\.modelContext) var modelContext
```

**FuelPriceView.swift**:
```swift
@Query var actualUserData: [UserData]
@Environment(\.modelContext) var modelContext
```

**UserUpgradeView.swift**:
```swift
@Query var swiftDataUserData: [UserData]
@Environment(\.modelContext) var modelContext
```

When these views are presented **without a modelContainer**:
1. `@Query` tries to access SwiftData
2. No modelContext exists in the environment
3. SwiftData fails to initialize
4. **App crashes with SIGABRT**

### Why "After A While"?

The crash doesn't happen on app launch because:
- The main `ContentView` has `.modelContainer(sharedModelContainer)` from the app level
- The crash **only happens when the user opens Shop/Fuel/Attributes screens**
- These screens are opened via user action (tapping sidebar buttons)
- Timing is "after a while" because users don't immediately navigate there

---

## ✅ THE FIX

### File Changed
`Skyrise Bureau/Skyrise Bureau/Views/MapView/MapView.swift`

### What Was Changed
Added `.modelContainer(for: UserData.self)` to each view in the fullScreenCover:

```swift
.fullScreenCover(isPresented: $openSomeOtherView) {
    if viewToShow == "market" {
        AirplaneStoreView()
            .modelContainer(for: UserData.self)  // ✅ FIXED
    } else if viewToShow == "fuel" {
        FuelPriceView()
            .modelContainer(for: UserData.self)  // ✅ FIXED
    } else if viewToShow == "attributes" {
        UserUpgradeView()
            .modelContainer(for: UserData.self)  // ✅ FIXED
    }
}
```

---

## 📊 Comparison: macOS vs iPadOS

### macOS (Skyrise-Bureau-macOS)
- Uses multiple `Window` scenes
- Each Window has `.modelContainer(sharedModelContainer)`
- Windows are independent and each has proper SwiftData context
- **Works fine ✅**

### iPadOS (Before Fix)
- Uses single `WindowGroup` with `.fullScreenCover` for navigation
- Main ContentView has modelContainer
- **Presented views DON'T have modelContainer** 
- **Crashes with SIGABRT ❌**

### iPadOS (After Fix)
- Uses single `WindowGroup` with `.fullScreenCover` for navigation
- Main ContentView has modelContainer
- **Each presented view now has `.modelContainer(for: UserData.self)`**
- **Should work without crashes ✅**

---

## 🧪 TESTING CHECKLIST

After applying the fix, test the following:

- [ ] Launch app on iPad - should not crash
- [ ] Navigate to main map view - should work
- [ ] **Tap to open Shop (Jet Set Emporium)** - should open without crash
- [ ] Browse planes in shop - should work without crash
- [ ] Close shop and return to map - should work
- [ ] **Tap to open Fuel screen (KEROX)** - should open without crash
- [ ] Interact with fuel price view - should work without crash
- [ ] Close fuel screen - should work
- [ ] **Tap to open Attributes screen (About Your Airline)** - should open without crash
- [ ] Modify airline attributes - should work without crash
- [ ] Close attributes screen - should work
- [ ] Verify data persists correctly after making changes
- [ ] Test on iPad Air, iPad Pro (different sizes)
- [ ] Test on physical iPad device, not just simulator

---

## 🔍 HOW I FOUND THIS

1. **Investigated macOS vs iPadOS differences** - Found Window → WindowGroup change
2. **Compared App.swift files** - Saw each macOS Window had `.modelContainer()`
3. **Found fullScreenCover in MapView** - Saw it was missing `.modelContainer()`
4. **Verified views need SwiftData** - Confirmed all three use `@Query` and `@Environment(\.modelContext)`
5. **Identified the mismatch** - Presented views need modelContainer but don't have it
6. **Applied the fix** - Added `.modelContainer(for: UserData.self)` to each view

---

## 📝 COMMIT MADE

**Branch**: v1.1.1  
**Commit**: 432e76a  
**Message**: "Fix SIGABRT crash: Add modelContainer to fullScreenCover presentations"

**File Modified**:
- `Skyrise Bureau/Skyrise Bureau/Views/MapView/MapView.swift`

---

## ⚠️ IMPORTANT NOTES

1. **This fix is specific to the iPadOS version** - The macOS version doesn't need this change because each Window already has modelContainer.

2. **Why `.modelContainer(for: UserData.self)` works**: This creates a new model container for the presented view, giving it access to SwiftData.

3. **Alternative approach**: You could also inject the modelContainer via `.environment()` or pass it as a parameter, but `.modelContainer(for: UserData.self)` is the cleanest solution for SwiftUI presentations.

4. **This was NOT a code logic error** - The existing logic works fine on macOS. The issue was architectural: the change from Window-based to fullScreenCover-based navigation required adding modelContainer modifiers that weren't needed before.

---

## 🎉 EXPECTED OUTCOME

After this fix:
- ✅ App should not crash when opening Shop, Fuel, or Attributes screens
- ✅ All SwiftData queries should work correctly in presented views
- ✅ Data should persist and sync properly across all views
- ✅ User experience should match the macOS version (just with fullscreen presentations instead of separate windows)

---

## 📧 NEXT STEPS

1. Pull the changes from the v1.1.1 branch
2. Test thoroughly on iPad simulator
3. Test on physical iPad hardware
4. If all tests pass, merge to main branch
5. Release updated iPadOS version

---

**TLDR**: The SIGABRT crash was caused by missing `.modelContainer()` modifiers on fullScreenCover-presented views. These views need SwiftData access via `@Query` and `@Environment(\.modelContext)`, but without the modelContainer, SwiftData couldn't initialize, causing immediate crashes. The fix adds `.modelContainer(for: UserData.self)` to each presented view.
