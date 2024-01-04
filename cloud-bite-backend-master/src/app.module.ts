import { Module } from "@nestjs/common";
import { TypeOrmModule, TypeOrmModuleOptions } from "@nestjs/typeorm";
import { OrderModule } from "./order/order.module";
import { Order } from "./order/order.entity";
import { SecretManagerServiceClient } from '@google-cloud/secret-manager';

const client = new SecretManagerServiceClient();

async function getSecret(project: string, key: string) {
  const url = `projects/${project}/secrets/${key}/versions/latest`;
  const [version] = await client.accessSecretVersion({ name: url });
  return version.payload.data.toString();
}

const dbConfig = async () => ({
  type: "mysql",
  host: await getSecret('ccc-gr13-f23', "db-host"),
  port: 3306,
  username: await getSecret('ccc-gr13-f23', "db-user"),
  password: await getSecret('ccc-gr13-f23', "db-password"),
  database: await getSecret('ccc-gr13-f23', "db-name"),
  entities: [Order],
  synchronize: true,
  retryAttempts: 5,
});

@Module({
  imports: [
    TypeOrmModule.forRoot({...dbConfig}),
    OrderModule,
  ],
})
export class AppModule {}

