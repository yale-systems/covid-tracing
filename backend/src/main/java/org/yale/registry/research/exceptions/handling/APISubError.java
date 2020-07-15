package org.yale.registry.research.exceptions.handling;

import java.util.Objects;

// for representing multiple errors caused by one call
// reference: https://www.toptal.com/java/spring-boot-rest-api-error-handling
abstract class APISubError {
}

class APIValidationError extends APISubError {
    private String object;
    private String field;
    private Object rejectedValue;
    private String message;

    public APIValidationError(String object, String field, Object rejectedValue, String message) {
        this.object = object;
        this.field = field;
        this.rejectedValue = rejectedValue;
        this.message = message;
    }

    APIValidationError(String object, String message) {
        this.object = object;
        this.message = message;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        APIValidationError that = (APIValidationError) o;
        return Objects.equals(object, that.object) &&
                Objects.equals(field, that.field) &&
                Objects.equals(rejectedValue, that.rejectedValue) &&
                Objects.equals(message, that.message);
    }

    @Override
    public int hashCode() {
        return Objects.hash(object, field, rejectedValue, message);
    }
}