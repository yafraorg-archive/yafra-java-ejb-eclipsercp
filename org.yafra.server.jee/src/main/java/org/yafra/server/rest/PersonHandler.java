package org.yafra.server.rest;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.apache.cayenne.BaseContext;
import org.apache.cayenne.CayenneRuntimeException;
import org.apache.cayenne.ObjectContext;
import org.yafra.directclient.YafraDirectSession;
import org.yafra.modelhandler.MHPerson;
import org.yafra.orm.Person;
import org.yafra.server.jee.xmlobjects.WSPerson;
import org.yafra.utils.Logging;

@Path("/yafra/")
@Produces("application/json")
public class PersonHandler implements PersonRSI {

	private ObjectContext dbcontext;
	private Logging log;
	private YafraDirectSession sess;

	private void login()
	{
		// start 1 session (could be n in parallel)
		try
			{
			dbcontext = BaseContext.getThreadObjectContext();
			//dbcontext = DataContext.createDataContext();
			log = new Logging();
			log.setDebugFlag(true);
			log.logInfo("org.yafra.tests.serverdirectclient - logging init done - getting session now");
			sess = new YafraDirectSession();
			sess.setLogging(log);
			sess.setContext(dbcontext);
			sess.logMessage(" - client starts now with session id " + sess.getSessionId());
			}
		catch (CayenneRuntimeException e)
			{
			sess.getLogging().logError("cayenne runtime exception during startup", e);
			}
		catch (Throwable t)
			{
			sess.getLogging().logError("generic catch all exception during startup", t);
			}
	}

    @GET
    @Path("/persons/")
	public List<WSPerson> getPersons() {
    	login();
    	// start 1 session (could be n in parallel)
		log.setDebugFlag(true);
		log.logInfo("org.yafra.jee.rest - logging init done - getting session now");
		List<WSPerson> tol = new ArrayList<WSPerson>();
		MHPerson mhp = new MHPerson(dbcontext, log);
		List<Person> pl = mhp.getPersons();
		Iterator<Person> it = pl.iterator();
		while (it.hasNext())
			{
			Person i = (Person) it.next();
			WSPerson to = new WSPerson();
			to.setAddress(i.getAddress());
			to.setName(i.getName());
			to.setFirstname(i.getFirstname());
			to.setId(i.getId());
			to.setType(i.getType());
			to.setCountry(i.getCountry());
			to.setGoogleId(i.getGoogleId());
			tol.add(to);
			}
		return tol;
	}

    @GET
    @Path("/persons/{id}/")
	public WSPerson getPerson(@PathParam("id") String id) {
		// TODO Auto-generated method stub
    	System.out.println("started get person with id: " + id);
    	login();
    	// start 1 session (could be n in parallel)
		log.setDebugFlag(true);
		log.logInfo("org.yafra.tests.serverdirectclient - logging init done - getting session now");
		MHPerson mhp = new MHPerson(dbcontext, log);
		Person from = null;
		WSPerson to = new WSPerson();
		try
			{
			from = mhp.selectPerson(Integer.parseInt(id));
			}
		 catch(NumberFormatException nfe)
		 	{
			from = mhp.selectPerson(id);
		 	}
		catch (IndexOutOfBoundsException e)
			{
			sess.getLogging().logError("entry not found", e);
			to.setName("NOT FOUND ERROR");
			return to;
			}
		to.setAddress(from.getAddress());
		to.setName(from.getName());
		to.setFirstname(from.getFirstname());
		to.setId(from.getId());
		to.setType(from.getType());
		to.setCountry(from.getCountry());
		to.setGoogleId(from.getGoogleId());

		return to;
	}

    @PUT
    @Path("/persons/")
	public Response updateCustomer(WSPerson customer) {
		// TODO Auto-generated method stub
		return null;
	}

    @POST
	@Path("/persons/")
	public Response addCustomer(WSPerson customer) {
		// TODO Auto-generated method stub
		return null;
	}

    @DELETE
    @Path("/persons/{id}/")
	public Response deleteCustomer(@PathParam("id") String id) {
		// TODO Auto-generated method stub
		return null;
	}

}
