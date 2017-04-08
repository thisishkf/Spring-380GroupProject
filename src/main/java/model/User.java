package model;

import java.util.ArrayList;
import java.util.List;

public class User {
    private String name;
    private String password;
    private String status;
    private List<String> role = new ArrayList<>();
    private String[] check;

    public String[] getCheck() {
        return check;
    }

    public void setCheck(String[] check) {
        this.check = check;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<String> getRole() {
        return role;
    }

    public void addRole(String role) {
        this.role.add(role);
    }
    
    public boolean hasRole(String role){
        if( this.role.contains(role))
            return true;
        else 
         return false;
    }
    
    public boolean hasAnyRole(String role,String role2){
        if(this.role.contains(role) || this.role.contains(role2))
            return true;
        else
            return false;
    }
}
