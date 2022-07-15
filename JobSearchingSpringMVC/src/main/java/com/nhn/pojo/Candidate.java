package com.nhn.pojo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.Collection;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "candidate")
public class Candidate {

    @Column(name = "years_experience")
    private int yearsExperience;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "candidate")
    @JsonIgnore
    private Collection<ApplyJob> applyJobCollection;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @Lob
    @Column(name = "strengths")
    private String strengths;

    @Lob
    @Column(name = "weaknesses")
    private String weaknesses;

    @Column(name = "majoring", length = 100)
    private String majoring;

    @Lob
    @Column(name = "language_certificate")
    private String languageCertificate;

    @Lob
    @Column(name = "informatics_certificate")
    private String informaticsCertificate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User user;

    @JsonIgnore
    @Transient
    private int userId;

    @Transient
    @JsonIgnore
    private MultipartFile file;

    @Lob
    @Column(name = "majoring_detail")
    private String majoringDetail;

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    @Column(name = "cv", length = 300)
    private String cv;

    public String getMajoringDetail() {
        return majoringDetail;
    }

    public void setMajoringDetail(String majoringDetail) {
        this.majoringDetail = majoringDetail;
    }

    public String getCv() {
        return cv;
    }

    public void setCv(String cv) {
        this.cv = cv;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Candidate() {
    }

    public void setYearsExperience(Integer yearsExperience) {
        this.yearsExperience = yearsExperience;
    }

    @XmlTransient
    public Collection<ApplyJob> getApplyJobCollection() {
        return applyJobCollection;
    }

    public void setApplyJobCollection(Collection<ApplyJob> applyJobCollection) {
        this.applyJobCollection = applyJobCollection;
    }

}