package com.student.model;

import java.sql.Timestamp;

public class Payment {
    private int       id;
    private int       studentId;
    private String    studentName;
    private String    feeType;
    private double    amount;
    private String    razorpayPaymentId;
    private String    razorpayOrderId;
    private String    status;
    private Timestamp paidAt;

    public int       getId()                         { return id; }
    public void      setId(int id)                   { this.id = id; }
    public int       getStudentId()                  { return studentId; }
    public void      setStudentId(int s)             { this.studentId = s; }
    public String    getStudentName()                { return studentName; }
    public void      setStudentName(String n)        { this.studentName = n; }
    public String    getFeeType()                    { return feeType; }
    public void      setFeeType(String f)            { this.feeType = f; }
    public double    getAmount()                     { return amount; }
    public void      setAmount(double a)             { this.amount = a; }
    public String    getRazorpayPaymentId()          { return razorpayPaymentId; }
    public void      setRazorpayPaymentId(String r)  { this.razorpayPaymentId = r; }
    public String    getRazorpayOrderId()            { return razorpayOrderId; }
    public void      setRazorpayOrderId(String r)    { this.razorpayOrderId = r; }
    public String    getStatus()                     { return status; }
    public void      setStatus(String s)             { this.status = s; }
    public Timestamp getPaidAt()                     { return paidAt; }
    public void      setPaidAt(Timestamp t)          { this.paidAt = t; }
}
