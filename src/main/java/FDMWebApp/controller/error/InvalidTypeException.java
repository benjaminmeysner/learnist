package FDMWebApp.controller.error;

/**
 * Created by Rusty on 30/03/2017.
 */
public class InvalidTypeException extends Exception {

	public InvalidTypeException(int type) {
		super(getMessage(type));
	}

	public InvalidTypeException(int type, Throwable t) {
		super(getMessage(type), t);
	}

	private static String getMessage(int type) {
		return "Cannot resolve type: " + type;
	}
}
