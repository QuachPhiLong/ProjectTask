// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum Strings {
  /// Add
  internal static var add: String { return Strings.tr("Localizable", "add", fallback: "Add") }
  /// Add new task
  internal static var addNewTask: String { return Strings.tr("Localizable", "addNewTask", fallback: "Add new task") }
  /// Add task
  internal static var addTask: String { return Strings.tr("Localizable", "addTask", fallback: "Add task") }
  /// Add to calendar
  internal static var addToCalendar: String { return Strings.tr("Localizable", "addToCalendar", fallback: "Add to calendar") }
  /// Cancel
  internal static var cancel: String { return Strings.tr("Localizable", "cancel", fallback: "Cancel") }
  /// Datetime
  internal static var datetime: String { return Strings.tr("Localizable", "datetime", fallback: "Datetime") }
  /// Delete
  internal static var delete: String { return Strings.tr("Localizable", "delete", fallback: "Delete") }
  /// Description
  internal static var description: String { return Strings.tr("Localizable", "description", fallback: "Description") }
  /// Detail
  internal static var detail: String { return Strings.tr("Localizable", "detail", fallback: "Detail") }
  /// Edit task
  internal static var editTask: String { return Strings.tr("Localizable", "editTask", fallback: "Edit task") }
  /// Localizable.strings
  ///   DreamerlyTest
  /// 
  ///   Created by Long Quách on 09/09/2024.
  internal static var home: String { return Strings.tr("Localizable", "home", fallback: "Home") }
  /// Save
  internal static var save: String { return Strings.tr("Localizable", "save", fallback: "Save") }
  /// Streamerly
  internal static var streamerly: String { return Strings.tr("Localizable", "streamerly", fallback: "Streamerly") }
  /// Tag
  internal static var tagTypeWork: String { return Strings.tr("Localizable", "tagTypeWork", fallback: "Tag") }
  /// Personal
  internal static var taskTypePersonal: String { return Strings.tr("Localizable", "taskTypePersonal", fallback: "Personal") }
  /// Work
  internal static var taskTypeWork: String { return Strings.tr("Localizable", "taskTypeWork", fallback: "Work") }
  /// All
  internal static var taskTypeWorkAll: String { return Strings.tr("Localizable", "taskTypeWorkAll", fallback: "All") }
  /// Title
  internal static var title: String { return Strings.tr("Localizable", "title", fallback: "Title") }
  /// Today
  internal static var today: String { return Strings.tr("Localizable", "today", fallback: "Today") }
  /// To do list
  internal static var toDoList: String { return Strings.tr("Localizable", "toDoList", fallback: "To do list") }
  /// Well done
  internal static var toDoListEmpty: String { return Strings.tr("Localizable", "toDoListEmpty", fallback: "Well done") }
  /// Tip: Tap here to add new task
  internal static var tooltipAddNewTask: String { return Strings.tr("Localizable", "tooltipAddNewTask", fallback: "Tip: Tap here to add new task") }
  /// Tip: Change language here
  internal static var tooltipChangeLanguage: String { return Strings.tr("Localizable", "tooltipChangeLanguage", fallback: "Tip: Change language here") }
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = Localize_Swift_bridge(forKey:table:fallbackValue:)(key, table, value)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
