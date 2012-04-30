/*

    Copyright (c) 2010, 2012 Tender.Pro http://tender.pro.

    This file is part of PGWS - Postgresql WebServices.

    PGWS is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    PGWS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with PGWS.  If not, see <http://www.gnu.org/licenses/>.

*/
-- 50_add.sql - Метод API add
/* ------------------------------------------------------------------------- */
\qecho '-- FD: app:app:50_add.sql / 23 --'

/* ------------------------------------------------------------------------- */
CREATE OR REPLACE FUNCTION add (a INTEGER, b INTEGER DEFAULT 0) RETURNS INTEGER STABLE LANGUAGE 'plpgsql' AS
$_$  -- FD: app:app:50_add.sql / 27 --
  -- a: Слагаемое 1
  -- b: Слагаемое 2
BEGIN
  IF a = -1 THEN
    -- unhandled exception
    RAISE EXCEPTION 'Unhandled catched';
  ELSIF a = -2 THEN
    -- no access (system error)
    RAISE EXCEPTION '%', ws.e_noaccess();
  ELSIF a = -3 THEN
    -- app form error
    RAISE EXCEPTION '%', ws.error_str(ws.const('CORE_ERR_NOINTERNAL')::ws.d_errcode, a::text);
  ELSIF a = -4 THEN
    -- app form field error
    RAISE EXCEPTION '%', ws.perror_str(ws.const('CORE_ERR_NOTFOUND')::ws.d_errcode, 'a', a::text);
  END IF;

  RETURN a + b;
END;
$_$;
SELECT pg_c('f', 'add', 'Сумма 2х целых');

/* ------------------------------------------------------------------------- */
\qecho '-- FD: app:app:50_add.sql / 51 --'