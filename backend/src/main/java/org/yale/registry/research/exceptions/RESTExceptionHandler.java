package org.yale.registry.research.exceptions;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

//@Order(Ordered.HIGHEST_PRECEDENCE) // need to verify this should be done
@ControllerAdvice
public class RESTExceptionHandler extends ResponseEntityExceptionHandler {

    // Custom Response Entity
    private ResponseEntity<Object> buildResponseEntity(APIError apiError) {
        return new ResponseEntity<>(apiError, apiError.getStatus());
    }

    // Custom Exception Handlers

    // Resource Not Found Exception
    @ExceptionHandler(ResourceNotFoundException.class)
    protected ResponseEntity<Object> handleResourceNotFoundException(
            ResourceNotFoundException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        String error = "Resource not found";
        return buildResponseEntity(new APIError(HttpStatus.NOT_FOUND, error, ex));
    }

}
