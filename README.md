# connect

Firebase with Parse Classes

<strong>
To Login your user
</strong>

<p>
let login = FBUser()<br />

login.logInWithUsernameInBackground(email.text!, password: password.text!, completionWithBlock: { (myUser, error) -> () in <br />
            if error == ""{<br />
                    //Success, the uer has been logged in<br />
                }else{<br />
                    //There was an error with the login<br />
                }<br />

</p>

