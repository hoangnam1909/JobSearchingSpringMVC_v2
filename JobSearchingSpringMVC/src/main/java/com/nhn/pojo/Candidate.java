package com.nhn.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Entity
public class Candidate {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Basic
    @Column(name = "years_experience")
    private int yearsExperience;

    @Basic
    @Column(name = "strengths")
    private String strengths;

    @Basic
    @Column(name = "weaknesses")
    private String weaknesses;

    @Basic
    @Column(name = "majoring")
    private String majoring;

    @Basic
    @Column(name = "majoring_detail")
    private String majoringDetail;

    @Basic
    @Column(name = "language_certificate")
    private String languageCertificate;

    @Basic
    @Column(name = "informatics_certificate")
    private String informaticsCertificate;

    @Basic
    @Column(name = "cv")
    private String cv;

    @Transient
    @JsonIgnore
    private MultipartFile file;

    @Transient
    @JsonIgnore
    private int userId;

//    @OneToMany(mappedBy = "candidate")
//    private Collection<User> users;


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getYearsExperience() {
        return yearsExperience;
    }

    public void setYearsExperience(int yearsExperience) {
        this.yearsExperience = yearsExperience;
    }

    public String getStrengths() {
        return strengths;
    }

    public void setStrengths(String strengths) {
        this.strengths = strengths;
    }

    public String getWeaknesses() {
        return weaknesses;
    }

    public void setWeaknesses(String weaknesses) {
        this.weaknesses = weaknesses;
    }

    public String getMajoring() {
        return majoring;
    }

    public void setMajoring(String majoring) {
        this.majoring = majoring;
    }

    public String getMajoringDetail() {
        return majoringDetail;
    }

    public void setMajoringDetail(String majoringDetail) {
        this.majoringDetail = majoringDetail;
    }

    public String getLanguageCertificate() {
        return languageCertificate;
    }

    public void setLanguageCertificate(String languageCertificate) {
        this.languageCertificate = languageCertificate;
    }

    public String getInformaticsCertificate() {
        return informaticsCertificate;
    }

    public void setInformaticsCertificate(String informaticsCertificate) {
        this.informaticsCertificate = informaticsCertificate;
    }

    public String getCv() {
        return cv;
    }

    public void setCv(String cv) {
        this.cv = cv;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Candidate candidate = (Candidate) o;
        return id == candidate.id && yearsExperience == candidate.yearsExperience && Objects.equals(strengths, candidate.strengths) && Objects.equals(weaknesses, candidate.weaknesses) && Objects.equals(majoring, candidate.majoring) && Objects.equals(majoringDetail, candidate.majoringDetail) && Objects.equals(languageCertificate, candidate.languageCertificate) && Objects.equals(informaticsCertificate, candidate.informaticsCertificate) && Objects.equals(cv, candidate.cv);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, yearsExperience, strengths, weaknesses, majoring, majoringDetail, languageCertificate, informaticsCertificate, cv);
    }

    //    public Collection<User> getUsers() {
//        return users;
//    }
//
//    public void setUsers(Collection<User> usersById) {
//        this.users = usersById;
//    }
}
