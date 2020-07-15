package org.yale.registry.research.exceptions.handling;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.jetbrains.annotations.NotNull;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;

// API Error Format
// reference: https://www.toptal.com/java/spring-boot-rest-api-error-handling
public class APIError {
    private HttpStatus status; // operation call status
    // convert java 8 datetime classes to JSON
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy hh:mm:ss")
    private LocalDateTime timestamp; // when did the error happen?
    private String message; // user-friendly error description
    private String debugMessage; // more detailed error description for devs
    private List<APISubError> subErrors; // array of sub-errors (multi err for one call)

    private APIError() {
        timestamp = LocalDateTime.now();
    }

    APIError(HttpStatus status) {
        this();
        this.status = status;
    }

    APIError(HttpStatus status, @NotNull Throwable ex) {
        this();
        this.status = status;
        this.message = "Unexpected error";
        this.debugMessage = ex.getLocalizedMessage();
    }

    APIError(HttpStatus status, String message, @NotNull Throwable ex) {
        this();
        this.status = status;
        this.message = message;
        this.debugMessage = ex.getLocalizedMessage();
    }

    public APIError noDebug() {
        RuntimeException obf_ex = new RuntimeException();
        return new APIError(status, message, obf_ex);
    }

    public HttpStatus getStatus() {
        return status;
    }

    public void setStatus(HttpStatus status) {
        this.status = status;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getDebugMessage() {
        return debugMessage;
    }

    public void setDebugMessage(String debugMessage) {
        this.debugMessage = debugMessage;
    }

    public List<APISubError> getSubErrors() {
        return subErrors;
    }

    public void setSubErrors(List<APISubError> subErrors) {
        this.subErrors = subErrors;
    }
}
