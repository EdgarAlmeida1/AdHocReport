import React from 'react';
import { FormGroup, Paper, Button } from '@material-ui/core'
import GitHubIcon from '@material-ui/icons/GitHub';
import TransferList from './components/TransferList'
import Filter from './components/Filter'
import Table from './components/Table'
import './App.css';

export default function App() {
  const [selections, setSelections] = React.useState([]);
  const [table, setTable] = React.useState([]);

  const [filtros, setFiltros] = React.useState([]);
  const [filtrosValues, setFiltrosValues] = React.useState([{}]);
  const [aux, setAux] = React.useState({id: -1, selection: 'a', comparator: 'a', constraint: 'a'})

  React.useEffect( () => {
    if(aux.id !== -1){
      let auxFiltros = filtrosValues;
      auxFiltros[aux.id] = {selection: aux.selection, comparator: aux.comparator, constraint: aux.constraint}
      setFiltrosValues(auxFiltros)
    }
  }, [aux])

  function sendRequest(){
    const jsonBody = {
      selections: selections,
      filtros: filtrosValues
    }
    let data = JSON.stringify(jsonBody);

    fetch('http://localhost:3333/', {
      method: "POST",
      body: data,
      headers: {                             
        "Content-Type": "application/json"    
      }
    })
    .then((response) => {
      return response.json();
    })
    .then((queryJSON) => {
      let data = fixData(queryJSON.return);
      setTable(data);
    })
  }

  return (
    <div className="home-page">
      <div className="header">
        <img src="./images/slogan.svg" alt="slogan-data" />
        <h1>Relatório AdHOC</h1>
      </div>

      <div className="options">
        <div className="containerTransfer">
          <div className="transfer">
            <FormGroup>
              <Paper elevation={5}>
                <TransferList setFunction = {setSelections}/>
              </Paper>
            </FormGroup>
          </div>
          <Button variant="contained" color="primary" onClick={sendRequest}>Gerar Relatório</Button>
        </div>
      </div>

      <div className="filters">
        {filtros}
        <Button variant="contained" color="primary"onClick={() => {
          setFiltros([...filtros, <Filter id={filtros.length} sendValues={setAux}/>])}}>
            Adicionar Filtro</Button>
      </div>

      <div className="table">
        { table.length > 0 &&
          <Table tableData = {table} keys ={selections}/>
        }
      </div>

      <div className="footer">
        <a href='https://github.com/lucasrennok/AdHocBD2' target="_blank" rel="noreferrer"><GitHubIcon style={{ fontSize: 40, color: 'white'}}/></a>
      </div>
    </div>
  );

  function fixData(e){
    let data = e.filter(function(obj){
      for (var key in obj) {
        if (obj[key] === null) return false;
      }
      return true;
    });

    if(data.length > 0 && ('data_partida' in data[0] || 'data_nasc_jogador' in data[0])) {
      data.forEach(function(obj){
        if('data_partida' in obj){
          const year = obj.data_partida.substring(0, 4);
          const month = obj.data_partida.substring(5, 7);
          const day = obj.data_partida.substring(8, 10);
          obj['data_partida'] = day + '/' + month + '/' + year;
        }
        
        if('data_nasc_jogador' in obj){
          const year = obj.data_nasc_jogador.substring(0, 4);
          const month = obj.data_nasc_jogador.substring(5, 7);
          const day = obj.data_nasc_jogador.substring(8, 10);
          obj['data_nasc_jogador'] = day + '/' + month + '/' + year;
        }
      })
    }
    return data;
  }
}