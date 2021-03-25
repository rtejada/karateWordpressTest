Feature: (users - utility) Get thread name

  @ignore
  Scenario: (users - utility) Get thread name
    * def JavaThread = Java.type('java.lang.Thread')
    * def current_thread = JavaThread.currentThread().getId()
    * string current_thread_name = (JavaThread.currentThread().getName() == 'main') ? 'worker-1' : JavaThread.currentThread().getName()
    * def users_name = 'QA_users_' + current_thread_name