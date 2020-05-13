package org.yale.registry.research.configurations;

import com.bedatadriven.jackson.datatype.jts.parsers.PointParser;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class TracingConfiguration {
    private static final int DECIMAL_TO_ROUND_TO = 10000000;

    @Bean
    GeometryFactory geometryFactory(){
       PrecisionModel precisionModel = new PrecisionModel();
       return new GeometryFactory(precisionModel, 4326);
    }
    @Bean
    public PointParser pointParser(@Autowired GeometryFactory geometryFactory)
    {
        return new PointParser(geometryFactory);
    }
}
