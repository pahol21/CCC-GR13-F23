import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { OrderModule } from "./order/order.module";
import { Order } from "./order/order.entity";

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: "mysql",
      host: '34.78.239.225', // Direct IP address
      port: 3306,
      username: 'admin_user', // Direct username
      password: 'admin_password', // Direct password
      database: 'my-database', // Direct database name
      entities: [Order],
      synchronize: true,
      retryAttempts: 5,
    }),
    OrderModule,
  ],
})
export class AppModule {}