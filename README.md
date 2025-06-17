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

### Part 2: Deploying the Form to KoBoToolbox

Once your form has been customized and built, you can upload it to [KoBoToolbox](https://kobotoolbox.org) for hosting and data storage.

1. **Sign in** to your account at [https://kobotoolbox.org](https://kobotoolbox.org). Create an account if you don’t already have one.
2. **Create a new project**, then choose **Upload an XLSForm** when prompted.
3. **Upload the finalized `form.xlsx`** file from the `build/` folder.
4. **Upload media files** associated with the form:
   * Navigate to your form's **Settings → Media** tab
   * Upload all `.svg` and other media files found in the `build/media/` directory
5. **Click “Deploy” or “Redeploy”** to activate the form for use in CyberTracker or other compatible clients.

Once deployed, the form can be accessed and downloaded from the CyberTracker app on your mobile device.

---

## Field Use Workflow

This section outlines how to use the system during a typical aerial survey. It assumes the CyberTracker app has already been installed and connected to your backend (see [Installation and Setup](#installation-and-setup)).

### Launching the Form
1. Open the **CyberTracker** app on your device
2. Tap the form to launch it
3. Tap the "New survey" button in the lower right corner

You will be prompted to enter **session metadata**, such as:
* Aircraft registration
* Pilot name
* Names of observers

This information will be attached to all observations recorded during the session.

When complete, tap the "Start survey" button in the lower right corner

### Recording Observations
Once the session begins, the app will display the **observation interface**, which includes:
* A set of **large, icon-based buttons** grouped by category (e.g., Wildlife, Birds, Human Activity)
* Touch-friendly layouts optimized for fast selection
* GPS-based location capture at the moment of tap

### Editing
After the first observation, a large red button will appear in the lower right corner. This button will allow correction of the prior observation.

### Completing the survey
When the survey is complete, tap the "Stop survey" button in the top right corner of the screen.

---

## FAQ / Troubleshooting

This section addresses common questions and issues you may encounter when customizing the form, collecting data, or uploading results.

---

### The form isn’t showing up in CyberTracker. What should I do?

* Make sure you have:
  * Deployed the form on your backend (e.g. KoBoToolbox)
  * Signed in to CyberTracker with the same backend account
* Check for a stable internet connection during the initial sync
* Try refreshing the form list in CyberTracker using the **Sync** tab

---

### I changed the `choices` sheet and now the form won’t build.

* Check that:
  * You didn’t rename or delete any columns or sheets
  * The `list_name`, `name`, and `label` fields are all filled in
  * You only modified allowed lists: `employee`, `observation_category`, `observation_type`
* Refer to [XlsForm.org](https://xlsform.org) for help fixing validation errors

---

### My icon images don’t show up in CyberTracker.

* Confirm that:
  * SVG files are uploaded to your backend under **Settings → Media**
  * The `media::image` column in the `choices` sheet is filled in correctly and matches the file names exactly
* Re-run `python make.py` to rebuild the form before redeploying

---

### I can't upload data from CyberTracker.
* Ensure you have an internet connection
* Go to the **Settings** page and select the "Upload queue" option
* If errors persist:
  * Restart CyberTracker and try again

---

### Can I use this system with ODK or Survey123 instead of KoBoToolbox?

Yes. While KoBoToolbox is used as an example in this documentation, the form can be uploaded to any platform that supports XlsForm. Just ensure that:
* The backend supports media attachments (e.g. SVG files)
* You deploy the form with all referenced media
* You connect CyberTracker to the appropriate backend using its login option

---

### Can I use this on a phone?
Technically yes, but the screen needs to be large enough to make the icons usable.

---

## License & Acknowledgments

### License

This project is released under the **MIT License**.

You are free to:
* Use this form and associated tools for any purpose
* Modify the form to suit your project needs
* Distribute your customized versions, with or without attribution

> *Please check the license terms of CyberTracker and any backend platform (e.g., KoBoToolbox, ODK, Survey123) separately, as those are governed by their respective projects.*

---

### Acknowledgments

This project builds on the outstanding work of several open-source and community-driven platforms:

* [**CyberTracker**](https://www.cybertracker.org) – Mobile data collection system optimized for visual and rapid entry in field conditions
* [**XlsForm.org**](https://xlsform.org) – The open standard for building survey forms in Excel
* [**KoBoToolbox**](https://kobotoolbox.org) – Free and open-source platform for field data collection
* [**ODK**](https://getodk.org) – A powerful open-source data collection ecosystem
* [**Survey123**](http://survey123.arcgis.com/) – ArcGIS-native survey platform for spatial data collection

Special thanks to the field teams and conservation partners who helped refine and test this system in real-world aerial survey conditions.

---

Great! Here's a final **Section 10: Contributing**, written in Markdown:

---

## Contributing

We welcome contributions from users who want to improve this system or adapt it to new use cases.

### Ways to Contribute

* **Add support for new observation categories or layouts**
* **Improve form validation or automation** (e.g., extending the `make.py` script)
* **Translate the form or labels** for use in other regions or languages
* **Share your deployment guides or use cases**

### Guidelines

1. Fork this repository
2. Make your changes on a new branch
3. Submit a pull request with a clear description of the changes
4. If modifying the XlsForm, ensure the form builds cleanly using:

   ```bash
   python make.py
   ```

Please keep contributions focused on the core scope of the project: **rapid, icon-based data collection in aerial surveys using CyberTracker and XlsForm**.
