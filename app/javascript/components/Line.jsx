import React from 'react'
import Cell from './Cell';

function Line({lineIndex, cells, onDiscoverCell}) {
    //console.log(lineIndex);
    console.log(cells);

    function discoverLineCellHandler(cellIndex, isFlag)
    {
        onDiscoverCell(lineIndex, cellIndex, isFlag);
    }

  return (
    <tr style={{backgroundColor: 'Red'}}>
        {cells.map((c, i) => <Cell key={c.id} cellIndex={i} cell={c} onDiscoverLineCell={discoverLineCellHandler}/>)}
    </tr>
  )
}

export default Line;
