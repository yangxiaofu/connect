# connect

Firebase with Parse Classes


<h1>FB User</h1>
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


<h3>Update Business Card</h3>
Initialize the card<br />
let card = DDBusinessCard();<br />

card.name = "Dave Dong"<br />

card.updateCard()
