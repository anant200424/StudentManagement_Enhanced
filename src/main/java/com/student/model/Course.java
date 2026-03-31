package com.student.model;

public class Course {
    private int    id;
    private String courseName;
    private String duration;
    private double fee;
    private String description;

    public int    getId()                        { return id; }
    public void   setId(int id)                  { this.id = id; }
    public String getCourseName()                { return courseName; }
    public void   setCourseName(String n)        { this.courseName = n; }
    public String getDuration()                  { return duration; }
    public void   setDuration(String d)          { this.duration = d; }
    public double getFee()                       { return fee; }
    public void   setFee(double fee)             { this.fee = fee; }
    public String getDescription()               { return description; }
    public void   setDescription(String desc)    { this.description = desc; }
}
