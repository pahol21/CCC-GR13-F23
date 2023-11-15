import { Injectable } from "@nestjs/common";
import { Order } from "./order.entity";

@Injectable()
export class OrderService {
  private readonly orders: Order[] = [
    { id: 1, name: "Salad", price: 5 },
    { id: 2, name: "Soup", price: 4 },
    { id: 3, name: "Burger", price: 10 },
    // Add more static orders as needed
  ];

  findAll(): Order[] {
    return this.orders;
  }

  addOrder(order: Order): Order {
    // Add logic to add to the orders array if needed
    console.log("Order added:", order);
    return order;
  }
}
