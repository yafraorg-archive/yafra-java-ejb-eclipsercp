package org.yafra.orm.auto;

import java.util.Date;

import org.apache.cayenne.CayenneDataObject;
import org.yafra.orm.YafraUser;

/**
 * Class _YafraAudit was generated by Cayenne.
 * It is probably a good idea to avoid changing this class manually,
 * since it may be overwritten next time code is regenerated.
 * If you need to make any customizations, please use subclass.
 */
public abstract class _YafraAudit extends CayenneDataObject {

    public static final String AUDITOBJECT_PROPERTY = "auditobject";
    public static final String AUDITTEXT_PROPERTY = "audittext";
    public static final String TIMESTAMP_PROPERTY = "timestamp";
    public static final String TO_USER_PROPERTY = "toUser";

    public static final String PK_AUDIT_PK_COLUMN = "pkAudit";

    public void setAuditobject(String auditobject) {
        writeProperty(AUDITOBJECT_PROPERTY, auditobject);
    }
    public String getAuditobject() {
        return (String)readProperty(AUDITOBJECT_PROPERTY);
    }

    public void setAudittext(String audittext) {
        writeProperty(AUDITTEXT_PROPERTY, audittext);
    }
    public String getAudittext() {
        return (String)readProperty(AUDITTEXT_PROPERTY);
    }

    public void setTimestamp(Date timestamp) {
        writeProperty(TIMESTAMP_PROPERTY, timestamp);
    }
    public Date getTimestamp() {
        return (Date)readProperty(TIMESTAMP_PROPERTY);
    }

    public void setToUser(YafraUser toUser) {
        setToOneTarget(TO_USER_PROPERTY, toUser, true);
    }

    public YafraUser getToUser() {
        return (YafraUser)readProperty(TO_USER_PROPERTY);
    }


}
