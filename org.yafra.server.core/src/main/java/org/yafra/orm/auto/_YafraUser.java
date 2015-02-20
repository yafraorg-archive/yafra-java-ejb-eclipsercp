package org.yafra.orm.auto;

import java.util.List;

import org.apache.cayenne.CayenneDataObject;
import org.yafra.orm.YafraAudit;
import org.yafra.orm.YafraBusinessRole;
import org.yafra.orm.YafraUserDevice;

/**
 * Class _YafraUser was generated by Cayenne.
 * It is probably a good idea to avoid changing this class manually,
 * since it may be overwritten next time code is regenerated.
 * If you need to make any customizations, please use subclass.
 */
public abstract class _YafraUser extends CayenneDataObject {

    public static final String EMAIL_PROPERTY = "email";
    public static final String NAME_PROPERTY = "name";
    public static final String PHONE_PROPERTY = "phone";
    public static final String PICTURELINK_PROPERTY = "picturelink";
    public static final String USERID_PROPERTY = "userid";
    public static final String YROLES_PROPERTY = "YRoles";
    public static final String AUDIT_ARRAY_PROPERTY = "auditArray";
    public static final String DEVICE_ARRAY_PROPERTY = "deviceArray";

    public static final String PK_YAFRA_USER_PK_COLUMN = "pkYafraUser";

    public void setEmail(String email) {
        writeProperty(EMAIL_PROPERTY, email);
    }
    public String getEmail() {
        return (String)readProperty(EMAIL_PROPERTY);
    }

    public void setName(String name) {
        writeProperty(NAME_PROPERTY, name);
    }
    public String getName() {
        return (String)readProperty(NAME_PROPERTY);
    }

    public void setPhone(String phone) {
        writeProperty(PHONE_PROPERTY, phone);
    }
    public String getPhone() {
        return (String)readProperty(PHONE_PROPERTY);
    }

    public void setPicturelink(String picturelink) {
        writeProperty(PICTURELINK_PROPERTY, picturelink);
    }
    public String getPicturelink() {
        return (String)readProperty(PICTURELINK_PROPERTY);
    }

    public void setUserid(String userid) {
        writeProperty(USERID_PROPERTY, userid);
    }
    public String getUserid() {
        return (String)readProperty(USERID_PROPERTY);
    }

    public void addToYRoles(YafraBusinessRole obj) {
        addToManyTarget(YROLES_PROPERTY, obj, true);
    }
    public void removeFromYRoles(YafraBusinessRole obj) {
        removeToManyTarget(YROLES_PROPERTY, obj, true);
    }
    @SuppressWarnings("unchecked")
    public List<YafraBusinessRole> getYRoles() {
        return (List<YafraBusinessRole>)readProperty(YROLES_PROPERTY);
    }


    public void addToAuditArray(YafraAudit obj) {
        addToManyTarget(AUDIT_ARRAY_PROPERTY, obj, true);
    }
    public void removeFromAuditArray(YafraAudit obj) {
        removeToManyTarget(AUDIT_ARRAY_PROPERTY, obj, true);
    }
    @SuppressWarnings("unchecked")
    public List<YafraAudit> getAuditArray() {
        return (List<YafraAudit>)readProperty(AUDIT_ARRAY_PROPERTY);
    }


    public void addToDeviceArray(YafraUserDevice obj) {
        addToManyTarget(DEVICE_ARRAY_PROPERTY, obj, true);
    }
    public void removeFromDeviceArray(YafraUserDevice obj) {
        removeToManyTarget(DEVICE_ARRAY_PROPERTY, obj, true);
    }
    @SuppressWarnings("unchecked")
    public List<YafraUserDevice> getDeviceArray() {
        return (List<YafraUserDevice>)readProperty(DEVICE_ARRAY_PROPERTY);
    }


}
