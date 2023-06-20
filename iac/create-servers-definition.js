const fs = require('fs');

const makeServerDefinition = (reference, alias) => ({
  alias,
  reference,
});

const serversAlwaysAvailable = {
  production: makeServerDefinition('main', 'production'),
  qa: makeServerDefinition('qa', 'qa'),
};

const featureReferences = (process.argv[2]) ? process.argv[2].split(',') : [];

const serversForFeatures = {};

featureReferences.forEach((featureReference) => {
  serversForFeatures[featureReference] = makeServerDefinition(featureReference, featureReference);
});

const servers = {...serversAlwaysAvailable, ...serversForFeatures};

fs.writeFileSync('servers.json', JSON.stringify(servers));
