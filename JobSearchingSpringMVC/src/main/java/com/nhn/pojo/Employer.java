package com.nhn.pojo;

import javax.persistence.*;
import java.util.Collection;

@Entity
public class Employer {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;

    @Basic
    @Column(name = "name")
    private String name;

    @Basic
    @Column(name = "description")
    private String description;

    @Basic
    @Column(name = "location")
    private String location;

    @Basic
    @Column(name = "contact")
    private String contact;

    @Basic
    @Column(name = "website")
    private String website;

    @Basic
    @Column(name = "majoring")
    private String majoring;

//    @OneToMany(mappedBy = "employer", fetch = FetchType.LAZY)
//    private Collection<User> users;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getMajoring() {
        return majoring;
    }

    public void setMajoring(String majoring) {
        this.majoring = majoring;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Employer employer = (Employer) o;

        if (id != employer.id) return false;
        if (name != null ? !name.equals(employer.name) : employer.name != null) return false;
        if (description != null ? !description.equals(employer.description) : employer.description != null)
            return false;
        if (location != null ? !location.equals(employer.location) : employer.location != null) return false;
        if (contact != null ? !contact.equals(employer.contact) : employer.contact != null) return false;
        if (website != null ? !website.equals(employer.website) : employer.website != null) return false;
        if (majoring != null ? !majoring.equals(employer.majoring) : employer.majoring != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (location != null ? location.hashCode() : 0);
        result = 31 * result + (contact != null ? contact.hashCode() : 0);
        result = 31 * result + (website != null ? website.hashCode() : 0);
        result = 31 * result + (majoring != null ? majoring.hashCode() : 0);
        return result;
    }

//    public Collection<User> getUsers() {
//        return users;
//    }
//
//    public void setUsers(Collection<User> usersById) {
//        this.users = usersById;
//    }
}
