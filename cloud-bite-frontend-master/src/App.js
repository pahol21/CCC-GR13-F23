import "./App.css";
import { useQuery, useMutation } from "react-query";
import axios from "axios";


function App() {
  const fetchMenu = async () => {
    return await axios.get(`${process.env.REACT_APP_API_URL}/menu`).then((response) => response.data);
  };

  const { data, error, isLoading } = useQuery(`${process.env.REACT_APP_API_URL}/menu`, fetchMenu);

  const orderMutation = useMutation((order) =>
    axios.post(`${process.env.REACT_APP_API_URL}/order`, order)
  );

  if (isLoading) {
    return <div>Server is not up...</div>;
  }

  if (error) {
    return <div>Error...</div>;
  }

  const handlePlaceOrder = (item) => {
    orderMutation.mutate(item);
  };

  return (
    <>
      <h1>Menu</h1>
      {data.map((food) => (
        <li>
          {food.name} - {food.price}
          <button onClick={() => handlePlaceOrder(food)}>Add to cart</button>
        </li>
      ))}
    </>
  );
}

export default App;
