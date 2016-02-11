# connect

Firebase with Parse Classes

<strong>
To Login your user
</strong>

<p>
let login = FBUser()
            login.logInWithUsernameInBackground(email.text!, password: password.text!, completionWithBlock: { (myUser, error) -> () in
                if error == ""{
                    //Success, the uer has been logged in
                }else{
                    //There was an error with the login
                }

</p>

