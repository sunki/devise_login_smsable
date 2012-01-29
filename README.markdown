**IMPORTANT:** This is very alpha-release. Stable release (0.1) is coming.

DeviseLoginSmsable
==================

Ability to additional authentication by SMS code or IP for Devise gem.

Install notes
-------------

**Migration:**

<code>rails generate devise_login_smsable &lt;<YOUR_DEVISE_MODEL>&gt;</code>

**Config initializer:**

<code>rails generate devise_login_smsable:config</code>

Look into *config/initializers/devise_login_smsable.rb* and change the *phone_column_name* if needed, then run migrations:

<code>rake db:migrate</code>

**Routes:**
Add this line to *config/routes.rb* inside routes block:

<code>login_smsable</code>

**Model:**

Add new module to devise declaration in your model (named as *:login_smsable*), so your model should look like:

<code>devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable, :login_smsable</code>

Building your own gates
-----------------------

Look into this two files to build same gates using other services:

*lib/devise_login_smsable/abstract_gate.rb*

*lib/devise_login_smsable/smsru.rb*

More info and instructions will come.

Known bugs and issues
---------------------

* Rails::Engine not loads config/routes.rb

TODO
----

* Add possibility to resend sms_code (now user should log-out and log-in again to receive new sms_code when current one is expired)

&copy; Chvertkin Maxim. Protected by MIT-LICENSE.