# Tasktracker

Design Details:

 User Details:
 * A user must be registered first in order to be able to sign in to the App. It is assumed that only an Admin can 
   register every new user into the system and assign a manager to the new user being registered.
 * So it is assumed that any user who clicks on register button to register is treated as an admin.
 * Every user can be a manager if he has users assigned to him as underlings by the admin.  
 * For the first user there will be no manager as he is the first person to register in the system.
 * Users are not entitled to delete other users hence they cannot see the list of registered users except when assigning tasks.
 * When a user logs out he will be redirected to the login page.

 Manager Details:
 * A manager is entitled to assign tasks to his underlings. Only a manager can assign tasks. No user can assign tasks
   to himself.
 * If a user is not a manager he cannot create new tasks. When he tries to create a task "You cannot create tasks as you are 
   not a Manager yet!!" message is displayed.   
 * A manager can create a new task by entering a title, description, and will be able to select a user from a drop down 
   to whom the task is to be assigned. The list in the drop down consists a list of names of only his underlings. He will not
   be able to assign tasks to any other user whom he doesn't manage.
 * A manager can see a task report of his underlings where a list fo tasks assigned to his underlings is displayed.

 Profile Page:
 * A user sees the details of his manager and list of underlings in his profile page. There are links to create a task, View 
   tasks assigned to him or see a task report if he is a Manager.
 * A user can see tasks assigned to him by clicking on the "Your Tasks" link. He can edit or delete the tasks assigned to him
   by clicking on the edit and delete buttons.
 
 Tasks and Actions:
 * Users can edit the tasks assigned to them where they can enter time blocks for the hours they spent on their tasks.
 * They can enter the hours spent by either clicking on the start time button at the start of the task and click on stop 
   time button after they are done working. Or they can manually enter the start and end time in the edit page and save it. 
 * The user will see list of timeblocks on the edit page that he worked on and can edit or delete individual blocks if he feels
   it necessary. When a user clicks on edit button on a time block, new input fields for time will be displayed at the bottom of the timeblocks list where he can make the necesarry changes and click on save to update the timeblock.
 * A user has to keep the page open if he chooses to enter time by clicking on start time and stop buttons. Once he clicks on 
   Start Time button the page should be open and should not be reloaded until he clicks on the Stop Time button to keep live tracking of the time. A user can do this by keeping the tasktracker app open in the browser while he continues his work.
 * A user cannot assign the tasks that are assigned to him to his underlings.


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
