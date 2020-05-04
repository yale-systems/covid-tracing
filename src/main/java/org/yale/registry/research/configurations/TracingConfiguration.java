package org.yale.registry.research.configurations;

import com.bedatadriven.jackson.datatype.jts.parsers.PointParser;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TracingConfiguration {
    @Bean
    public PointParser pointParser()
    {
        PrecisionModel precisionModel = new PrecisionModel(100000);
        GeometryFactory geometryFactory = new GeometryFactory(precisionModel, 4326);
        return new PointParser(geometryFactory);
    }
}
