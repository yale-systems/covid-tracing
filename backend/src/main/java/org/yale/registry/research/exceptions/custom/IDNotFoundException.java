package org.yale.registry.research.exceptions.custom;

import org.springframework.data.rest.webmvc.ResourceNotFoundException;

/**
 * Extends ResourceNotFoundException to include resource ID and type
 */
public class IDNotFoundException extends ResourceNotFoundException {
    private static final long serialVersionUID = 1L;
    public final Long id;
    public final String typeName;

    public IDNotFoundException(Long id, String typeName) {
        this.id = id;
        this.typeName = typeName;
    }

    public IDNotFoundException(String message, Long id, String typeName) {
        super(message);
        this.id = id;
        this.typeName = typeName;
    }

    public IDNotFoundException(String message, Throwable cause, Long id, String typeName) {
        super(message, cause);
        this.id = id;
        this.typeName = typeName;
    }
}
