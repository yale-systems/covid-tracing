package org.yale.registry.research.exceptions;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

// Reference: https://docs.spring.io/spring/docs/5.2.7.RELEASE/spring-framework-reference/web.html#mvc-ann-rest-exceptions

//@Order(Ordered.HIGHEST_PRECEDENCE) // need to verify this should be done
@ControllerAdvice // @RestControllerAdvice not needed--we are handling responses manually
public class RESTExceptionHandler extends ResponseEntityExceptionHandler {

    // Custom Response Entity
    private ResponseEntity<Object> buildResponseEntity(APIError apiError) {
        return new ResponseEntity<>(apiError, apiError.getStatus());
    }

    // Custom Exception Handlers
    // beware of runtime exceptions vs http client error exceptions
    // https://stackoverflow.com/a/55308054/4513452

    // Generic (all otherwise unhandled) Exception Handler
    @ExceptionHandler(Exception.class)
    protected ResponseEntity<?> handleGenericException(
            Exception ex, WebRequest request) {
        String error = "Unknown error occurred";
        return buildResponseEntity(new APIError(HttpStatus.BAD_REQUEST, error, ex));
    }

    // Resource Not Found Exception
    @ExceptionHandler(ResourceNotFoundException.class)
    protected ResponseEntity<?> handleResourceNotFoundException(
            ResourceNotFoundException ex, WebRequest request) {
        String error = "Resource not found";
        System.out.println(error);
        return buildResponseEntity(new APIError(HttpStatus.NOT_FOUND, error, ex));
    }

}
