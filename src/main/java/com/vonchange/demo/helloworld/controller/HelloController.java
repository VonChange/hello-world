package com.vonchange.demo.helloworld.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 */
@RestController
//@Slf4j
public class HelloController {

    @GetMapping("/")
    public String hello(){
        return "hello world";
    }

    @GetMapping("/v1/health")
    public String health(){
        return "up";
    }
}
