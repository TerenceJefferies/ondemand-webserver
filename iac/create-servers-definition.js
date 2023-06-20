const fs = require('fs');

if (!process.argv[2]) {
  console.error('You must provide at least one feature reference');
  process.exit(1);
}

const makeServerDefinition = (reference, alias) => ({
  alias,
  reference,
});

const serversAlwaysAvailable = [
  makeServerDefinition('main', 'production'),
  makeServerDefinition('qa', 'qa'),
];

const featureReferences = process.argv[2].split(',');

const serversForFeatures = featureReferences.map((reference) => makeServerDefinition(reference, reference));

const servers = [...serversAlwaysAvailable, ...serversForFeatures];

fs.writeFileSync('servers.json', JSON.stringify(servers));
