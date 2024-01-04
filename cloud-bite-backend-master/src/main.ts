import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { SecretManagerServiceClient } from '@google-cloud/secret-manager';

async function getSecret(project, key) {
  const client = new SecretManagerServiceClient();
  const secretPath = `projects/${project}/secrets/${key}/versions/latest`;
  const [version] = await client.accessSecretVersion({ name: secretPath });
  return version.payload.data.toString();
}

async function bootstrap() {
  const dbHost = await getSecret('ccc-gr13-f23', "db-host");
  const dbUser = await getSecret('ccc-gr13-f23', "db-username");
  const dbPassword = await getSecret('ccc-gr13-f23', "db-password");
  const dbName = await getSecret('ccc-gr13-f23', "db-database");

  process.env.DB_HOST = dbHost;
  process.env.DB_USER = dbUser;
  process.env.DB_PASSWORD = dbPassword;
  process.env.DB_NAME = dbName;

  console.log('Environment variables set:');
  console.log(`DB_HOST: ${process.env.DB_HOST}`);
  console.log(`DB_USER: ${process.env.DB_USER}`);
  console.log(`DB_PASSWORD: ${process.env.DB_PASSWORD}`);
  console.log(`DB_NAME: ${process.env.DB_NAME}`);

  const app = await NestFactory.create(AppModule);
  app.enableCors({ origin: "*" });
  await app.listen(3000);
}
bootstrap();