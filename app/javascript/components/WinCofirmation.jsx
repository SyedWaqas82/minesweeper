import axios from 'axios';
import React, {useState} from 'react'
import LeaderBoard from './LeaderBoard';
import NewWinnerForm from './NewWinnerForm';

function WinCofirmation({clicksCount, timeTaken, onResetGame}) {

  const [isNameAdded, setIsNameAdded] = useState(false)

  function nameAdded()
  {
      setIsNameAdded(true);
  }

  return (
    <div>
      <h3>Congratualtion you won in {clicksCount} clicks cosuming {timeTaken/1000} seconds</h3>
      {!isNameAdded && <NewWinnerForm clicksCount={clicksCount} timeTaken={timeTaken} onNameAdd={nameAdded}/>}
      <LeaderBoard/>
      {isNameAdded && <button onClick={() => onResetGame()}>Start Over</button>}
    </div>
  )
}

export default  WinCofirmation;