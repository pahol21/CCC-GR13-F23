import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";
import { SecretManagerServiceClient } from '@google-cloud/secret-manager';

const client = new SecretManagerServiceClient();

async function getSecret(project: string, key: string) {
  const url = `projects/${project}/secrets/${key}/versions/latest`;
  const [version] = await client.accessSecretVersion({ name: url });
  return version.payload.data.toString();
}

async function bootstrap() {
  process.env["DB_HOST"] = await getSecret('ccc-gr13-f23', "db-host");
  process.env["DB_USER"] = await getSecret('ccc-gr13-f23', "db-user");
  process.env["DB_PASSWORD"] = await getSecret('ccc-gr13-f23', "db-password");
  process.env["DB_NAME"] = await getSecret('ccc-gr13-f23', "db-name");

  const app = await NestFactory.create(AppModule);
  app.enableCors({ origin: "*" });
  await app.listen(3000);
}
bootstrap();
