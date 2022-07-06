package com.nhn.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@Configuration
public class TilesConfig {
    @Bean
    public UrlBasedViewResolver viewResolver() {
        UrlBasedViewResolver r = new UrlBasedViewResolver();
        r.setViewClass(TilesView.class);
        r.setOrder(-2);

        return r;
    }

    @Bean
    public TilesConfigurer tilesConfiguer() {
        TilesConfigurer c = new TilesConfigurer();
        c.setDefinitions("/WEB-INF/tiles.xml");
        c.setCheckRefresh(true);

        return c;
    }
}
