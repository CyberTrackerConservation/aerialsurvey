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
