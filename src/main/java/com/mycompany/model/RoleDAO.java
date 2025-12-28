package com.mycompany.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAO {

    public List<Role> getAllRoles() throws SQLException, ClassNotFoundException {
        List<Role> list = new ArrayList<>();
        Connection conn = DBConnect.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM role");
        while (rs.next()) {
            Role r = new Role();
            r.setRoleID(rs.getInt("roleID"));
            r.setRoleName(rs.getString("roleName"));
            r.setRoleDescription(rs.getString("roleDescription"));
            list.add(r);
        }
        DBConnect.closeConnection(conn);
        return list;
    }

    public Role getRoleByID(int roleID) throws SQLException, ClassNotFoundException {
        Role r = null;
        Connection conn = DBConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM role WHERE roleID=?");
        ps.setInt(1, roleID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            r = new Role();
            r.setRoleID(rs.getInt("roleID"));
            r.setRoleName(rs.getString("roleName"));
            r.setRoleDescription(rs.getString("roleDescription"));
        }
        DBConnect.closeConnection(conn);
        return r;
    }
}
