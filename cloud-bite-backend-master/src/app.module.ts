import { Module, DynamicModule } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { OrderModule } from "./order/order.module";
import { Order } from "./order/order.entity";

@Module({})
export class AppModule {
  static forRoot(dbConfig: any): DynamicModule {
    return {
      module: AppModule,
      imports: [
        TypeOrmModule.forRoot({
          type: "mysql",
          host: dbConfig.host, 
          port: 3306,
          username: dbConfig.username, 
          password: dbConfig.password, 
          database: dbConfig.database, 
          entities: [Order],
          synchronize: true,
          retryAttempts: 5,
        }),
        OrderModule,
      ],
    };
  }
}
