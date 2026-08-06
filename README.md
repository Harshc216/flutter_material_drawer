# flutter_material_drawer

[![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D1.17.0-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-orange.svg)](#)

**flutter_material_drawer** is a premium, highly customizable, and interactive dynamic navigation drawer package for Flutter. It features seven distinct aesthetic styles (including a fully custom Twitter-style profile navigation layout), dual drawer positioning (left and right simultaneously), an interactive real-time collapsible menu list with "See All / See Less" expander logic, and dynamic dark mode toggles.

---

## 📷 Preview

<p align="center">
  <img src="assets/material_drawer_preview.gif" alt="Material Drawer Preview" width="320"/>
</p>

*A premium interactive drawer component featuring rounded animations, live dark/light mode toggling, collapsible menus, and responsive side configurations.*

---

## ✨ Features

- **🎨 7 Dynamic Drawer Styles**
  - **Classic**: Standard clean Material design layout.
  - **Rounded**: Beautiful curved edges sliding smoothly from the left.
  - **Gradient**: Dynamic, elegant background gradients.
  - **Glassmorphism**: Backdrop blur filter for clean glass aesthetics.
  - **Minimal**: Modern minimalist design with flat color fills.
  - **Dark**: Deep black palette optimized for dark themes.
  - **Twitter**: High-fidelity Twitter profile replication with handles, follower counts, avatar-tapped profile links, and bottom utility corner buttons.
- **🔄 Dual Drawer Positioning**
  - Allows simultaneous integration of two drawer structures—e.g., standard customizer on the left (`drawer` property) and Twitter profile drawer on the right (`endDrawer` property).
- **🌓 Dynamic Dark Mode Corner Toggle**
  - Features a built-in brightness toggle switcher in the bottom utility corner (Twitter style) that integrates seamlessly with your application's `ThemeMode` notifier.
- **📂 Collapsible Menu Items ("See All" / "See Less")**
  - Truncates long menu lists to show only a subset of key items followed by a collapsible down-arrow. Tapping "See All" smoothly slides the list open, and clicking "See Less" collapses it back.
- **📐 Responsive Half-Width Drawers**
  - Custom width configuration capability supporting responsive design. Toggling "Half-Width Drawer" automatically shrinks drawer width to half the device screen width (capped nicely at `180px` on desktop) for compact navigations.
- **🛠️ High-Fidelity Styling properties**
  - Deep customization options via `MaterialDrawerTheme` to set background color, capsule indicator color, unselected item typography, borders, dividers, and custom elevations.

---

## 📦 Installation

To use this library in your Flutter project, add it to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Local or Pub package reference
  flutter_material_drawer:
    path: ../
```

Or reference it directly from a Git repository:

```yaml
dependencies:
  flutter_material_drawer:
    git:
      url: https://github.com/your_username/flutter_material_drawer.git
      ref: main
```

---

## 🚀 Usage

Import the package in your Dart code:

```dart
import 'package:flutter_material_drawer/flutter_material_drawer.dart';
```

### 1. Simple Customizable Drawer (Left Side)
Implement a simple left drawer with responsive capsule themes.

```dart
final _drawerController = MaterialDrawerController();

Scaffold(
  drawer: MaterialDrawer(
    controller: _drawerController,
    name: 'Jane Doe',
    email: 'jane.doe@example.com',
    type: DrawerType.rounded,
    items: [
      const DrawerMenuItem(
        title: 'Dashboard',
        icon: Icons.dashboard_rounded,
        badge: 'New',
      ),
      const DrawerMenuItem(
        title: 'Settings',
        icon: Icons.settings_rounded,
      ),
    ],
  ),
  body: const Center(child: Text('Main Page Content')),
)
```

### 2. Double Drawers Setup (Left Customizable, Right Twitter Style)
Expose both left and right drawers simultaneously with coordinated action buttons in the `AppBar`.

```dart
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Scaffold(
  key: _scaffoldKey,
  appBar: AppBar(
    leading: IconButton(
      icon: const Icon(Icons.menu_rounded),
      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.flutter_dash_rounded),
        onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
      ),
    ],
  ),
  drawer: MaterialDrawer(
    controller: _drawerController,
    items: menuItems,
    name: 'Jane Doe',
    email: 'jane.doe@example.com',
    type: DrawerType.rounded,
  ),
  endDrawer: MaterialDrawer(
    controller: _drawerController,
    items: menuItems,
    name: 'Jane Doe',
    email: 'jane.doe@example.com',
    handle: '@jane_doe_ux',
    followingCount: 184,
    followersCount: '4.8K',
    type: DrawerType.twitter,
  ),
)
```

### 3. Collapsible Drawer Items ("See All")
Set `maxItems` to restrict initial items count. A "See All" list item will be appended to expand/collapse the menu list.

```dart
MaterialDrawer(
  controller: _drawerController,
  items: manyMenuItems,
  name: 'Jane Doe',
  email: 'jane.doe@example.com',
  maxItems: 3, // Shows first 2 items + "See All" button
)
```

### 4. Half-Width & Theme Mode Syncing
Configure drawers to take custom responsive widths and listen to theme brightness changes.

```dart
MaterialDrawer(
  controller: _drawerController,
  items: menuItems,
  name: 'Jane Doe',
  email: 'jane.doe@example.com',
  width: MediaQuery.of(context).size.width * 0.5, // Opens half screen width
  onThemeToggle: () {
    // Trigger your application's light/dark theme toggle notifier
  },
)
```

---

## 🛠️ API Reference

### `MaterialDrawer` properties:

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `MaterialDrawerController` | *Required* | Controller to track and notify index selections. |
| `items` | `List<DrawerMenuItem>` | *Required* | List of menu items to render in the drawer body. |
| `name` | `String` | *Required* | Full user profile name shown in the header. |
| `email` | `String` | *Required* | User email address shown in the header. |
| `image` | `ImageProvider?` | `null` | Optional profile avatar image. |
| `theme` | `MaterialDrawerTheme` | `MaterialDrawerTheme()` | The styling palette configuration parameters. |
| `type` | `DrawerType` | `DrawerType.classic` | The visual layout drawer style. |
| `handle` | `String?` | `null` | Bio handle (e.g. `@username`) (Twitter style). |
| `followingCount` | `int?` | `null` | Total accounts user is following (Twitter style). |
| `followersCount` | `String?` | `null` | Display string of followers count (Twitter style). |
| `onProfileTap` | `VoidCallback?` | `null` | Triggered when user taps the profile details or avatar. |
| `onThemeToggle` | `VoidCallback?` | `null` | Triggered when tapping the theme toggle button (Twitter style). |
| `width` | `double?` | `null` | Custom horizontal drawer width constraints. |
| `maxItems` | `int?` | `null` | Maximum count of menu items visible before collapsing. |

### `MaterialDrawerTheme` properties:

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `backgroundColor` | `Color` | `Colors.white` | Background paint color of the drawer container. |
| `selectedColor` | `Color` | `Colors.blue` | Capsule background color of the active item. |
| `unselectedColor` | `Color` | `Colors.black87` | Typography color of unselected text label. |
| `iconColor` | `Color` | `Colors.black87` | Color of unselected icons. |
| `selectedIconColor` | `Color` | `Colors.white` | Color of the selected icon. |
| `headerColor` | `Color` | `Colors.blue` | Background paint color of the classic header. |
| `dividerColor` | `Color` | `Color(0xFFE0E0E0)` | Colors of items and border dividers. |
| `elevation` | `double` | `8` | Shadow elevation height. |
| `borderRadius` | `double` | `20` | Corner curves radius for the rounded drawer. |
| `itemRadius` | `double` | `12` | Corner curve radius of the selection capsule. |

### `DrawerMenuItem` properties:

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `String` | *Required* | Label text of the menu item. |
| `icon` | `IconData` | *Required* | Icon representation. |
| `badge` | `String?` | `null` | Optional text badge overlay (e.g. "New"). |
| `enabled` | `bool` | `true` | Interactive toggle indicator. |
| `onTap` | `VoidCallback?` | `null` | Execution callback upon item selection. |

---

## 📄 License

```lic
MIT License

Copyright (c) 2026 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
