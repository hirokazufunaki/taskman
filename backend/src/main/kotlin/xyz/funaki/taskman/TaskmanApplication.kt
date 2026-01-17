package xyz.funaki.taskman

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class TaskmanApplication

fun main(args: Array<String>) {
	runApplication<TaskmanApplication>(*args)
}
