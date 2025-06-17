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
