enum TokenType { MSQ, P2UP, MSQP, MATIC, MSQX, MSQXP }

const List<String> tokenTypes = [
  "MSQ",
  "P2UP",
  "MSQP",
  "MATIC",
  "MSQX",
  "MSQXP"
];
Map tokenTypeMapping = {
  "MSQ": TokenType.MSQ,
  "P2UP": TokenType.P2UP,
  "MSQP": TokenType.MSQP,
  "MATIC": TokenType.MATIC,
  "MSQX": TokenType.MSQX,
  "MSQXP": TokenType.MSQXP
};
