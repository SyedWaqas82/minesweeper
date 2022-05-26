import axios from 'axios';
import React, {useState, useEffect} from 'react'
import Line from './Line';
import WinCofirmation from './WinCofirmation';

export default function Minesweeper() {
  const [gameBoard, setGameBoard] = useState({});
  const [pendingBombs, setpendingBombs] = useState(0);
  const [time, setTime] = useState(0);
  const [isGameWon, setIsGameWon] = useState(false);
  const [clicksCount, setClicksCount] = useState(0);
  const [isPlaying, setIsPlaying] = useState(false);

  function newGameHandler(difficulty)
  {
    let gameParam = {width: 3, height: 3, bombs_count: 1 };

    if(difficulty == "Expert")
    {
      gameParam = {width: 30, height: 16, bombs_count: 99 };
    }
    else if(difficulty == "Intermediate")
    {
      gameParam = {width: 16, height: 16, bombs_count: 40 };
    }
    
    axios.post("/board", gameParam).then(res => {
      resetGame();
      handleGame(res.data);
    }).catch(error => {});
  }

  function resetGame()
  {
    setIsGameWon(false);
    setClicksCount(0);
    setIsPlaying(false);
    setTime(0);
    setGameBoard({});
  }

  function discoverCellHandler(lineIndex, cellIndex, isFlag)
  {
    if(!isFlag)
    {
      setClicksCount(clicksCount + 1);
      axios.patch(`/play?id=${gameBoard.id}`, {line : lineIndex, column: cellIndex}).then(res => {
        handleGame(res.data);
      }).catch(err => {})
    }
    else
    {
      axios.patch(`/flag?id=${gameBoard.id}`, {line : lineIndex, column: cellIndex}).then(res => {
        handleGame(res.data);
      }).catch(err => {})
    }
  }

  useEffect(()=>{
    if(gameBoard.lines)
    {
      const falgedCells = gameBoard.lines?.flatMap(l => l.cells).filter(c => c.flag == true).length;
      setpendingBombs(gameBoard.bombs_count - falgedCells);
    }

  },[gameBoard]);

  function handleGame(data)
  {
    //console.log(data);
    setGameBoard(data);
    setIsPlaying(data.playing);

    if(!data.playing)
    {
      alert("game over");
    }

    const allCells = data.lines?.flatMap(l => l.cells);

    if(allCells.filter(c => c.flag == false && c.discovered == false).length == 0)
    {
      setIsPlaying(false);
      setIsGameWon(true);
    }
  }

  useEffect(() => {
    let interval;
    if (isPlaying) {
      interval = setInterval(() => {
        setTime((prevTime) => prevTime + 1000);
      }, 1000);
    } else if (!isPlaying) {
      clearInterval(interval);
    }
    return () => clearInterval(interval);
  }, [isPlaying]);

  if(isGameWon)
  {
    return (<div className='container text-center'><WinCofirmation clicksCount={clicksCount} timeTaken={time} onResetGame={resetGame}/></div>)
  }

  return (
    <div className='container text-center'>
      <div>
        <div className="row">
          <div className="col">
            <h4>{time/1000}</h4>
          </div>
          <div className="col">
            <button onClick={() => newGameHandler("Standard")}>New Standard Game</button>
            <button onClick={() => newGameHandler("Intermediate")}>New Intermediate Game</button>
            <button onClick={() => newGameHandler("Expert")}>New Expert Game</button>
          </div>
          <div className="col">
            <h4>{pendingBombs}</h4>
          </div>
        </div>
      </div>

      <br/>
      <div className='text-center'>
        <table align="center">
          <tbody>
            {Array.isArray(gameBoard.lines)
            ? gameBoard.lines.map((l,i) => (
                <Line key={l.id} lineIndex={i} cells={l.cells} onDiscoverCell={discoverCellHandler}/>
              ))
            : null}
          </tbody>
        </table>
      </div>
    </div>
  )
}
