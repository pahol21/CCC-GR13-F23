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
  const dbConfig = {
    host: await getSecret('ccc-gr13-f23', "db-host"),
    username: await getSecret('ccc-gr13-f23', "db-username"),
    password: await getSecret('ccc-gr13-f23', "db-password"),
    database: await getSecret('ccc-gr13-f23', "db-database"),
  };

  const app = await NestFactory.create(AppModule.forRoot(dbConfig));
  app.enableCors({ origin: "*" });
  await app.listen(3000);
}

bootstrap();
