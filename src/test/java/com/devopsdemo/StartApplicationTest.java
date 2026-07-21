package com.devopsdemo;

import org.junit.jupiter.api.Test;
import org.springframework.ui.Model;
import org.springframework.ui.ConcurrentModel;

import static org.junit.jupiter.api.Assertions.*;

class StartApplicationTest {

    @Test
    void testIndex() {

        StartApplication app = new StartApplication();
        Model model = new ConcurrentModel();

        String viewName = app.index(model);

        assertEquals("index123", viewName);
        assertEquals(
                "Git hub actions Deployed!!!! - Modified_Text",
                model.getAttribute("msg")
        );
    }
}
