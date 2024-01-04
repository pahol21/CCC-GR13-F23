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
    <div className="container">
      <image className="background-image" src="https://rentspace.dk/wp-content/uploads/Restaurant-Herkomst1-Rentspace-JPEG.jpeg" alt="restourant" /> 
      <h1>Menu</h1>
      <div className="vert-scroll">
      {data.map((food) => (
        <div className="two-x-one-grid">
          <div className="item-header">{food.name} - {food.price}</div>
          <button className="purchase-item-button" onClick={() => handlePlaceOrder(food)}>Add to cart</button>
        </div>
      ))}
      </div>
    </div>
  );
}

export default App;
