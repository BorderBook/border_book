# Software Design Document

## Project: Border Queue Management Application

### 1. **Introduction**

This project aims to reduce waiting times at border crossings by allowing users to book a time slot in advance. The system will notify users an hour before their scheduled time. It will be built using Flutter for the mobile app, Amazon EC2 Lambda for the server, and MongoDB as the cloud database. The solution consists of three main interfaces: booking, QR code verification, and a border manager interface.

---

### 2. **System Overview**

The system consists of a mobile application and a server-side component. Users will interact through the app to book a time slot at a border, while the border staff uses the border manager interface to manage queue capacity.

#### Components:

1. **Mobile Application (Flutter)**
   - Cross-platform (Android & iOS) app that allows users to:
     - Book a time slot.
     - Receive a QR code.
     - Scan and check QR codes.
   - Built using Flutter for high performance and cross-platform compatibility.

2. **Backend (Amazon EC2 Lambda)**
   - Handles requests related to booking, QR code generation, and user data management.
   - Ensures serverless scalability with Amazon EC2 Lambda.

3. **Database (MongoDB Cloud)**
   - Stores user booking information, QR codes, and security codes.
   - Provides a scalable NoSQL solution with high availability and performance.

---

### 3. **User Stories**

1. **As a user, I want to book a time slot to cross the border**, so I don’t have to wait in a long queue.
2. **As a user, I want to receive a unique QR code with my booking information**, so I can verify my appointment at the border.
3. **As a border official, I want to check the authenticity of QR codes**, so I can verify if a user has a valid booking.
4. **As a border manager, I want to control the number of people crossing the border**, so I can manage border flow effectively.

---

### 4. **Functional Requirements**

#### 4.1. **Mobile Application (Flutter)**

- **User Booking Interface**
  - Collect the following data from the user:
    - First Name
    - Last Name
    - Birthdate
  - Present available time slots (fetched from the server) to the user.
  - Allow the user to select a time slot.
  - On submission, generate a unique order number and a QR code containing:
    - User's name
    - Birthdate
    - Time slot
    - Random security code (MongoDB ID)
  - Notify the user one hour before their time slot via a push notification.

- **QR Code Verification Interface**
  - Allow users or border officials to scan QR codes.
  - Decode the user’s information and check the validity of the QR code by matching the security code (MongoDB ID) stored in the database.
  - Display user information on successful verification.

- **Push Notifications**
  - Implement push notifications using Firebase Cloud Messaging (FCM) to alert users one hour before their booking time.

#### 4.2. **Border Manager Interface**

- Allow border managers to:
  - Specify how many people they are ready to process at the border (maximum 15).
  - Mark users as processed by scanning their QR code or entering their order number.
  - Update queue capacity and availability of time slots in real-time.

#### 4.3. **Backend (Amazon EC2 Lambda)**

- **Booking API**:
  - Generate a list of available time slots.
  - Store booking data (user info, selected time, security code) in MongoDB.
  - Return a unique order number and the QR code data.

- **QR Code API**:
  - Validate the QR code by checking the MongoDB for the corresponding security code.
  - If valid, return user information for display.

- **Push Notification API**:
  - Trigger push notifications one hour before the scheduled time.

#### 4.4. **Database (MongoDB Cloud)**

- Store user data, including:
  - First Name, Last Name, Birthdate
  - Selected time slot
  - Order number
  - QR code data (security code)
  
- Ensure data integrity and uniqueness, especially for security codes (MongoDB Object ID) used in QR code generation.

---

### 5. **Non-Functional Requirements**

- **Performance**: 
  - The app should have a fast response time for all user interactions (less than 2 seconds).
  - Serverless architecture should allow the system to scale automatically based on traffic.

- **Security**:
  - The unique security code in each QR code should prevent forgery.
  - Sensitive data like user information and security codes should be encrypted.
  
- **Scalability**: 
  - The use of Amazon Lambda and MongoDB should allow the system to scale based on demand, handling high volumes of users during peak times.
  
- **Cross-Platform Compatibility**:
  - The Flutter app should work seamlessly on both Android and iOS devices.
  
- **Reliability**:
  - The system must handle edge cases like lost QR codes, incorrect time slots, or failed scans, with appropriate fallback messages and error handling.
  
- **User Experience**:
  - The UI should be simple and intuitive, allowing users to book a time slot in less than 2 minutes.
  
- **Accessibility**:
  - Ensure the app is accessible to all users, including those with disabilities.

---

### 6. **Technical Architecture**

#### 6.1. **System Flow**

1. **Booking a Time Slot**:
   - The user submits their information and selects a time slot.
   - The server (Amazon Lambda) generates a unique order number and a QR code with user information.
   - The booking details are saved in MongoDB, including a unique security code (MongoDB ID).
   - The user receives a QR code and a notification one hour before their time slot.

2. **QR Code Verification**:
   - The app or a border official scans the QR code.
   - The system checks the QR code’s validity by comparing the security code with the database.
   - If valid, user information is displayed.

3. **Border Manager Interface**:
   - The manager sets the number of users they can process.
   - The system shows the users with upcoming slots, allowing the manager to mark them as processed.

#### 6.2. **Technology Stack**

| Component       | Technology        |
|-----------------|-------------------|
| Mobile App      | Flutter            |
| Backend         | Amazon EC2 Lambda  |
| Database        | MongoDB Cloud      |
| QR Code         | QR Code Generator  |
| Push Notifications | Firebase Cloud Messaging (FCM) |
  
---

### 7. **User Interface Design**

#### 7.1. **Booking Interface**
- Simple form for user information entry (First Name, Last Name, Birthdate).
- Dropdown list for available time slots.
- Confirmation screen with QR code and booking details.

#### 7.2. **QR Code Verification**
- Camera interface for scanning QR codes.
- Display user information upon successful scan or error message for invalid QR codes.

#### 7.3. **Border Manager Interface**
- Dashboard displaying the number of people they can accept.
- List of users with time slots, with an option to mark them as processed.

---

### 8. **Security Considerations**

- **QR Code Tampering**: Use MongoDB Object ID as a security code to ensure that QR codes cannot be easily faked.
- **Data Encryption**: User information and booking details should be encrypted both at rest and in transit.
- **Access Control**: Border manager interface should be protected with proper authentication and role-based access control to ensure that only authorized personnel can access it.

---

### 9. **Testing & Quality Assurance**

- **Unit Testing**: Test each component of the app (e.g., booking, QR code generation, and scanning).
- **Integration Testing**: Test the end-to-end flow, ensuring the app interacts correctly with the backend and database.
- **User Acceptance Testing (UAT)**: Ensure the app meets user expectations for functionality and ease of use.
- **Security Testing**: Verify that QR codes cannot be tampered with and that sensitive user data is secure.

---

### 10. **Project Timeline**

| Milestone                | Estimated Completion Date |
|--------------------------|---------------------------|
| Requirements Gathering    | Week 1                    |
| Mobile App Development    | Week 2-5                  |
| Backend Development       | Week 2-4                  |
| Database Setup            | Week 2                    |
| Integration & Testing     | Week 6                    |
| User Acceptance Testing   | Week 7                    |
| Deployment                | Week 8                    |

---

### 11. **Conclusion**

This document outlines the design for a mobile application aimed at improving border queue management. By using a combination of Flutter, Amazon EC2 Lambda, and MongoDB, the system will be scalable, secure, and user-friendly. The three main interfaces (user booking, QR code scanning, and border manager interface) are designed to streamline the process of managing border crossings. 

---
