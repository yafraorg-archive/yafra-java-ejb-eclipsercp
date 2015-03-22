package org.yafra.server.rest;

import java.util.List;

import javax.ws.rs.core.Response;

import org.yafra.server.jee.xmlobjects.WSPerson;

public interface PersonRSI {
    List<WSPerson> getPersons();

    WSPerson getPerson( String id);
    
    Response updateCustomer(WSPerson customer);

	Response addCustomer(WSPerson customer);

	Response deleteCustomer( String id);
}
