const { SecretManagerServiceClient } = require('@google-cloud/secret-manager');

const client = new SecretManagerServiceClient();

async function getSecret(project, key) {
  const secretPath = `projects/${project}/secrets/${key}/versions/latest`;
  const [version] = await client.accessSecretVersion({ name: secretPath });
  return version.payload.data.toString('utf8');
}

async function setEnvironmentVariables() {
  process.env["DB_HOST"] = await getSecret('ccc-gr13-f23', "db-host");
  process.env["DB_USER"] = await getSecret('ccc-gr13-f23', "db-username");
  process.env["DB_PASSWORD"] = await getSecret('ccc-gr13-f23', "db-password");
  process.env["DB_NAME"] = await getSecret('ccc-gr13-f23', "db-database");

  console.log('Environment variables set:');
  console.log(`DB_HOST: ${process.env.DB_HOST}`);
  console.log(`DB_USER: ${process.env.DB_USER}`);
  console.log(`DB_PASSWORD: ${process.env.DB_PASSWORD}`);
  console.log(`DB_NAME: ${process.env.DB_NAME}`);
}

setEnvironmentVariables();
