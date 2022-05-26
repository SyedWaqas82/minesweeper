import axios from 'axios';
import React, {useState} from 'react'

function NewWinnerForm({clicksCount, timeTaken, onNameAdd}) {
    const [name, setName] = useState("");
    function submitHanlder(e)
    {
        e.preventDefault();
        axios.post('/leaderboard', {name: name, clicks: clicksCount, time: timeTaken/1000}).then(res => {
            setName("");
            onNameAdd();
        }).catch(err => {})
    }
  return (
    <div>
        <form onSubmit={(e) => submitHanlder(e)}>
            <input type='text' placeholder='Enter your name' value={name} required onChange={(e) => setName(e.target.value)}></input>
            <button type='submit'>Save</button>
        </form>
    </div>
  )
}

export default NewWinnerForm;