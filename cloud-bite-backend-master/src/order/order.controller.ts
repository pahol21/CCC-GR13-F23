import { Body, Controller, Get, Post } from "@nestjs/common";
import { OrderService } from "./order.service";
import { Order } from "./order.entity";

@Controller()
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Get("menu")
  getMenu(): Order[] {
    return this.orderService.findAll();
  }

  @Post("order")
  createOrder(@Body() orderData: Order): Order {
    console.log("Order received:", orderData);
    return this.orderService.addOrder(orderData);
  }
}
