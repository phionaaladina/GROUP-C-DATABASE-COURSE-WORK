CREATE DATABASE CYBERS_SYSTEM_DB;
USE CYBERS_SYSTEM_DB;
CREATE TABLE Users (
  UserID INT AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) UNIQUE,
  PhoneNumber VARCHAR(20),
  Location POINT,
  UserType ENUM('Citizen', 'EmergencyResponder', 'Volunteer', 'Admin') NOT NULL,
  PRIMARY KEY (UserID)
);

CREATE TABLE EmergencyReports (
  ReportID INT AUTO_INCREMENT,
  UserID INT NOT NULL,
  EmergencyType ENUM('Accident', 'Fire', 'Flood', 'Medical') NOT NULL,
  ReportDetails TEXT,
  Location POINT,
  Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Status ENUM('New', 'InProgress', 'Resolved') NOT NULL DEFAULT 'New',
  PRIMARY KEY (ReportID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE EmergencyResponders (
  ResponderID INT AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  Agency ENUM('Police', 'Medical', 'Fire') NOT NULL,
  ContactInformation VARCHAR(255),
  PRIMARY KEY (ResponderID)
);

CREATE TABLE Volunteers (
  VolunteerID INT AUTO_INCREMENT,
  Name VARCHAR(255) NOT NULL,
  ContactInformation VARCHAR(255),
  Location POINT,
  Availability BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (VolunteerID)
);

CREATE TABLE Responses (
  ResponseID INT AUTO_INCREMENT,
  ReportID INT NOT NULL,
  ResponderID INT NOT NULL,
  ResponseDetails TEXT,
  Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ResponseID),
  FOREIGN KEY (ReportID) REFERENCES EmergencyReports(ReportID),
  FOREIGN KEY (ResponderID) REFERENCES EmergencyResponders(ResponderID)
);

CREATE TABLE Notifications (
  NotificationID INT AUTO_INCREMENT,
  UserID INT NOT NULL,
  ReportID INT NOT NULL,
  NotificationType ENUM('Alert', 'Update') NOT NULL,
  Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (NotificationID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID),
  FOREIGN KEY (ReportID) REFERENCES EmergencyReports(ReportID)
);

CREATE TABLE SystemLogs (
  LogID INT AUTO_INCREMENT,
  Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  EventType ENUM('ReportSubmitted', 'ResponseSent', 'NotificationSent') NOT NULL,
  PRIMARY KEY (LogID)
);



