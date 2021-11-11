package web.app.example;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class controller {
    @RequestMapping("/welcome")
    public String loginMessage(){
        return "welcome";
    }
}