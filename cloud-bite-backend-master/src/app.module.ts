import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { OrderModule } from "./order/order.module";
import { Order } from "./order/order.entity";

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: "mysql",
      host: '34.78.239.225', 
      port: 3306,
      username: 'admin_user', 
      password: 'admin_password', 
      database: 'my_database', 
      entities: [Order],
      synchronize: true,
      retryAttempts: 5,
    }),
    OrderModule,
  ],
})
export class AppModule {}