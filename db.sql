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
    'o_disconnected',
    'x_cheated',
    'o_cheated'
);

CREATE TABLE game (
    game_id smallserial PRIMARY KEY,
    rows smallint NOT NULL,
    cols smallint NOT NULL,
    win smallint NOT NULL,
    creator_mark mark,
    moves move[],
    status game_status
);

