/*
  Jiyuan Zhao
  zhao89@purdue.edu

  request_unit interface
*/
`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

logic dWEN,dREN,iREN,ihit,dhit,dmemREN,dmemWEN,pcWEN;

modport ru(
    input   ihit,dhit,dWEN,dREN,iREN,
    output dmemREN,dmemWEN,pcWEN
  );


endinterface

`endif //REQUEST_UNIT_IF_VH
