import React, {useState} from 'react'

function Cell({cellIndex, cell, onDiscoverLineCell}) {

    const unDiscoveredStyle = {minWidth:'50px', height: '50px', paddingTop: '10px', paddingBottom: '10px', textAlign: 'center', backgroundColor: 'Gray', border: '1px', borderStyle:'solid', borderColor:'Black'};
    const discoveredStyle = {minWidth:'50px', height: '50px', paddingTop: '10px', paddingBottom: '10px', textAlign: 'center', backgroundColor: 'LightGray', border: '1px', borderStyle:'solid', borderColor:'Black'};

    let cellText = ""

    if(cell.discovered)
    {
        if(cell.bomb)
        {
            cellText = "💣";
        }
        else{
            cellText = cell.close_bombs;
        }
    }
    else if(cell.flag)
    {
        cellText = "⛳️";
    }

    function discoverHandler()
    {
        if(!cell.flag)
        {
            onDiscoverLineCell(cellIndex, false);
        }
    }

    function flagHandler(e)
    {
        e.preventDefault();
        onDiscoverLineCell(cellIndex, true);
    }
    
    return (
        <td style={cell.discovered ? discoveredStyle : unDiscoveredStyle} onClick={() => discoverHandler()} onContextMenu={(e) => flagHandler(e)}>
            {cellText}
        </td>
    )
}

export default Cell;
