# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a SwiftUI iOS application called "Prescription Box" that converts free text into structured medical data using the OpenAI API. The app has two main functions:
1. Converting prescription text into structured `Prescription` objects
2. Converting lab report text into structured `LabReport` objects

## Architecture

The app follows a standard SwiftUI architecture with:
- **Main App**: `PrescriptionBoxApp.swift` - Entry point
- **Content View**: `ContentView.swift` - Tab-based navigation with 4 tabs (Home, Prescriptions, Lab Reports, Settings)
- **Models**: Located in `Models/` folder
  - `Prescription.swift` - Model for prescription data with fields like patientName, medicationName, dosage, etc.
  - `LabReport.swift` - Model for lab reports with TestResult array and ReportStatus enum
- **Views**: Located in `Views/` folder
  - `HomeView.swift` - Welcome screen
  - `PrescriptionsView.swift` - Text input for prescription conversion (placeholder implementation)
  - `LabReportsView.swift` - Text input for lab report conversion (placeholder implementation)
  - `SettingsView.swift` - API key configuration and app settings

## Development Commands

This is an Xcode project. Build and run using:
- Open `PrescriptionBox.xcodeproj` in Xcode
- Build: `⌘+B`
- Run: `⌘+R`

## Key Dependencies

The project uses the MacPaw/OpenAI library for structured outputs. Refer to https://github.com/MacPaw/OpenAI?tab=readme-ov-file#structured-outputs for implementation guidance.

## Current Implementation Status

The app has basic UI structure but needs implementation for:
1. Username setting and display in Settings/Home views
2. API key persistence and management
3. OpenAI API integration for text-to-structured-data conversion
4. UI for text input and results display in Prescriptions and Lab Reports views

## Data Models

Both models are `Codable` and designed to match the JSON structure expected from OpenAI structured outputs:
- `Prescription`: Contains patient info, medication details, dates, and notes
- `LabReport`: Contains test results array with parameters, values, units, reference ranges, and normal/abnormal flags
- `TestResult`: Individual test parameter with value, unit, reference range, and normal status
- `ReportStatus`: Enum with pending/completed/reviewed states