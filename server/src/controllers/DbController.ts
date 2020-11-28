import {Request, Response} from 'express';
import db from "../database/connections";

export default class DbController{
    async dbSearch(request: Request, response: Response){
        const body = request.body;
        body.filtros = body.filtros.filter(function(obj:any){
            for (var key in obj) {
                if (obj[key] === null || obj[key] === '') return false;
            }
            return true;
        });

        let query = await db.select(body.selections).from('league')
        .fullOuterJoin('team', 'league.id_liga', 'team.liga_time')
        .fullOuterJoin('player', 'team.id_time', 'player.id_time_jogador')
        .fullOuterJoin('game', 'team.id_time', 'game.time_casa')
        .where(function () {
            body.filtros.forEach( (item: any) => {
                //@ts-ignore
                if(Object.keys(item).length !== 0) this.where(item.selection, item.comparator, item.constraint)
            })
        }).distinct();

        return response.status(201).json({return: query});
    }
}