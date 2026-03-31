package com.student.model;

public class Student {
    private int    id;
    private String name;
    private String email;
    private String password;
    private String course;
    private String address;
    private String phone;
    private String fatherName;
    private String motherName;
    private String regId;

    public int    getId()                    { return id; }
    public void   setId(int id)              { this.id = id; }
    public String getName()                  { return name; }
    public void   setName(String name)       { this.name = name; }
    public String getEmail()                 { return email; }
    public void   setEmail(String email)     { this.email = email; }
    public String getPassword()              { return password; }
    public void   setPassword(String p)      { this.password = p; }
    public String getCourse()                { return course; }
    public void   setCourse(String c)        { this.course = c; }
    public String getAddress()               { return address; }
    public void   setAddress(String a)       { this.address = a; }
    public String getPhone()                 { return phone; }
    public void   setPhone(String p)         { this.phone = p; }
    public String getFatherName()            { return fatherName; }
    public void   setFatherName(String fn)   { this.fatherName = fn; }
    public String getMotherName()            { return motherName; }
    public void   setMotherName(String mn)   { this.motherName = mn; }
    public String getRegId()                 { return regId; }
    public void   setRegId(String r)         { this.regId = r; }
}
