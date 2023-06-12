CREATE TYPE mark AS ENUM (
    'cross',
    'nought'
);

CREATE TYPE move AS (
	  row smallint,
	  col smallint
);

CREATE TYPE game_status as ENUM (
    'x_won',
    'o_won',
    'tie',
    'x_disconnected',
    'x_illegal_move',
    'x_left',
    'o_disconnected',
    'o_illegal_move',
    'o_left'
);

CREATE TYPE game_entity AS (
    end_move_index smallint,
    status game_statusg
);

CREATE TABLE game_session (
    game_id smallserial PRIMARY KEY,
    rows smallint NOT NULL,
    cols smallint NOT NULL,
    win smallint NOT NULL,
    creator_mark mark,
    moves move[],
    entities game_entity[]
);

