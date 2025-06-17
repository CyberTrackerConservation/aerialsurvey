# CyberTracker Aerial Survey custom form

## Introduction

This is a data collection system designed for **aerial wildlife surveys**, where observers must quickly record what they see, how many, and where. The system is built around the **CyberTracker mobile application**, which provides an optimized and configurable interface for rapid data entry in challenging field conditions — such as inside a moving aircraft.

At its core, the system uses the [XlsForm](https://xlsform.org) standard, making it compatible with widely used data collection backends like [KoBoToolbox](https://kobotoolbox.org), [ODK](https://getodk.org), and [Survey123](http://survey123.arcgis.com/). Data collected via CyberTracker is stored in a standard XlsForm-compatible format, enabling easy integration with existing reporting workflows and dashboards.

To enable the speed and flexibility required for aerial data collection, the XlsForm is extended with [CyberTracker-specific visual and interaction features](https://cybertrackerwiki.org/xlsform/). These include customized layouts, button-based entry, and touch-optimized interfaces that go beyond the standard capabilities of most form-based tools.

> **Note:** While the data model is compatible with other platforms, **CyberTracker is required** on the mobile device to collect data using this system. It interprets the XlsForm with the embedded CyberTracker extensions, providing the necessary UI for field use.

This repository contains everything needed to use the system:

* The XlsForm survey, preconfigured for aerial data capture
* Instructions for customizing specific parts of the form (e.g., observation types)
* Setup guidance for installing the form on CyberTracker and integrating with a backend

---

## Features
This system is purpose-built for fast, accurate aerial data collection. It combines performance-focused design with support for standardized workflows, all while operating fully offline. Key features include:

### 1. Metadata Specification
Before starting data collection, the user is prompted to enter **metadata** that is automatically attached to every observation. This includes:
* Aircraft registration
* Pilot and observer names
* Protocol

This ensures each dataset is tagged with essential context for quality control and reporting.
<div style="text-align: center;">
  <img src="https://github.com/CyberTrackerConservation/aerialsurvey/blob/main/screenshots/metadata.png" alt="Metadata entry" style="width: 50%;">
</div>

### 2. Rapid Icon-Based Entry
The observation interface uses large, icon-driven buttons to represent standard observation protocols. This allows observers to:
* Quickly identify and tap the correct category or type
* Minimize errors through visual recognition
* Log observations with minimal attention diverted from the field
* The icon layout can be customized for the specific device. This includes the number of icon columns as well as the icon sizes.

<div style="text-align: center;">
  <img src="https://github.com/CyberTrackerConservation/aerialsurvey/blob/main/screenshots/collect1.png" alt="Icon based design" style="width: 50%;">
</div>

### 3. Instant GPS Capture
Each observation is automatically stamped with the **current GPS location** the moment the user selects the type that was observed. This ensures positional accuracy even at high speeds.

### 4. Continuous Track Recording

The GPS track is logged throughout the survey. This provides a full spatial trace of the flight path, which can be used for:
* Contextualizing observations
* Post-flight review
* Spatial analysis and verification

The track log is attached to the "Stop" record as a ZIP file. The ZIP contains a [GeoJSON](https://en.wikipedia.org/wiki/GeoJSON) file.

<div style="text-align: center;">
  <img src="https://github.com/CyberTrackerConservation/aerialsurvey/blob/main/screenshots/collect3.png" alt="Metadata entry" style="width: 50%;">
</div>

### 5. Edit Past Observations
Mistakes happen—this system allows observers to review and edit the previously logged entry before the session is finalized, helping ensure data integrity without disrupting the workflow.

<div style="text-align: center;">
  <img src="https://github.com/CyberTrackerConservation/aerialsurvey/blob/main/screenshots/collect2.png" alt="Edit button" style="width: 50%;">
</div>

### 6. Offline Maps
CyberTracker supports offline maps in a variety of formats. This support is described more fully in the [CyberTracker documentation](https://cybertrackerwiki.org/xlsform/reference-manual/maps)

### 7. Upload to Chosen Backend
At the end of the survey, data can be uploaded to a backend: [KoBoToolbox](https://kobotoolbox.org), [ODK](https://getodk.org), [Survey123](http://survey123.arcgis.com/).

This supports seamless reporting, export, and analysis workflows across a wide range of platforms.

<div style="text-align: center;">
  <img src="https://github.com/CyberTrackerConservation/aerialsurvey/blob/main/screenshots/complete.png" alt="Edit button" style="width: 50%;">
</div>

---

## Hardware Requirements

To ensure smooth operation in demanding field conditions, this system is designed to run on modern tablets that offer a balance of performance, screen size, and portability. While the CyberTracker app supports both Android and iOS devices, the following hardware guidelines are recommended for optimal use during aerial surveys.

### Recommended Specifications

* **Device Type:** Tablet (Android or iOS)
* **Minimum Display Resolution:** 1920×1200
  Higher resolutions improve visibility and ease of use with icon-based input.
* **Screen Size:** At least 8"
  Large enough to allow quick, accurate selection while remaining portable in aircraft cockpits.
* **GPS:** Built-in GPS is strongly recommended
  Ensures accurate geotagging of observations and continuous track recording.
* **Battery Life:** 6+ hours
  Sufficient for a full day of data collection without charging.
* **Storage:** At least 16 GB of free space
  Offline maps, form files, and track logs can take up significant storage during extended use.

### Additional Recommendations

* **Sunlight Readability:** Devices with high screen brightness or anti-reflective coatings are better suited for use in bright daylight conditions.
* **Durability:** A rugged or shock-resistant case is advisable for airborne environments.
* **Operating System:**

  * Android 9.0 (Pie) or later
  * iOS 13 or later

> *Note: Phones are technically supported but not recommended due to smaller screen size, which may reduce usability in fast-paced field scenarios.*

---

Understood. We'll revert **Section 4: Installation and Setup** to its original purpose — just covering installation of CyberTracker and connecting to an already-configured backend. The customization and backend setup steps will move to a new section, likely titled **Customizing and Deploying the Form** or similar.

Here is the **revised Section 4: Installation and Setup**, focused only on installing CyberTracker and connecting to a backend:

---

## Installation and Setup

If the form has already been created and deployed to a backend (e.g., KoBoToolbox, ODK, or Survey123), getting started with data collection is simple. Just install CyberTracker on your mobile device and connect to your backend account.

### Step 1: Install CyberTracker

Download and install the **CyberTracker mobile app**:

* [CyberTracker on Google Play (Android)](https://play.google.com/store/apps/details?id=org.cybertracker.mobile)
* [CyberTracker on the App Store (iOS)](https://apps.apple.com/us/app/cybertracker-mobile/id1582068361)

Once installed, launch the app.

### Step 2: Connect to Your Backend

CyberTracker supports connecting to major XlsForm-compatible platforms. The example below shows how to connect to [KoBoToolbox](https://kobotoolbox.org):

1. Open CyberTracker and select the large "+" button in the lower right corner of the screen. Tap **KoBoToolbox**.
2. Enter your login credentials.
3. After logging in, CyberTracker will display a list of available forms.
4. Select the form and tap to download it to your device.

It may take a while to download, depending on how many icons are used and the speed of your internet connection.

### Step 3: Begin Data Collection

Once downloaded:

* Tap the form to launch it
* Enter the required metadata (e.g. aircraft, pilot, observers)
* Begin logging observations in real time

All data is stored locally on the device and can be uploaded when internet access is available.

---

## Customizing and Deploying the Form

This section describes how to make limited customizations to the form (such as updating the list of employees or observation categories), regenerate the finalized form package, and deploy it to a backend like [KoBoToolbox](https://kobotoolbox.org).

> ⚠️ **Important:** Most of the form should not be modified. Only the contents of the following lists are expected to change:
> * `employee`
> * `observation_category`
> * `observation_type`

---

### Part 1: Customizing the Form

1. **Clone the repository** to your desktop computer:

   ```bash
   git clone https://github.com/CyberTrackerConservation/aerialsurvey.git
   cd aerialsurvey
   ```

2. **Open `form.xlsx`** (located in the root of the repository) using a spreadsheet which supports Excel format.

3. **Edit the `choices` sheet**, updating only the rows associated with the following list names:

   * `employee`: Add or remove team members as needed.

   * `observation_category`: Define the top-level groupings used in the interface.

   * `observation_type`: Add or adjust the specific items to be recorded under each category.

   > Refer to the [XlsForm documentation](https://xlsform.org) if you're unsure about how the format works.

   *Example:*
   Below is a sample Excel-style snippet showing how to modify the `observation_category` list:
   | list\_name            | name            | label          |
   | --------------------- | --------------- | -------------- |
   | observation\_category | wildlife        | Wildlife       |
   | observation\_category | birds           | Birds          |
   | observation\_category | human\_activity | Human activity |

4. **Build the finalized form** using the provided Python script:

   ```bash
   pip install openpyxl pyxform
   python make.py
   ```

5. A `build` folder will be created containing:

   * The finalized `form.xlsx`
   * All media files referenced in the form (e.g., SVG icons)

---
