import axios from 'axios';
import React, {useState, useEffect} from 'react'

function LeaderBoard() {
    const [topScorers, setTopScores] = useState([]);
    useEffect(() => {
        axios.get('/leaderboard').then(res => {
            setTopScores(res.data);
        }).catch(err => {});
      });
  return (
    <div>
        <strong>Top 10 Scorers</strong>
        <table style={{width:'300px'}} align="center">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Clicks</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>
                {topScorers.map(t => <tr key={t.id}><td>{t.name}</td><td>{t.clicks}</td><td>{t.time}</td></tr>)}
            </tbody>
        </table>
    </div>
  )
}

export default LeaderBoard;