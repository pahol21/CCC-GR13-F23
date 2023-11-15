import "./App.css";
import { useQuery, useMutation } from "react-query";
import axios from "axios";

const getToken = () => {
  // Retrieve your token here (e.g., from local storage or global state)
  return "eyJhbGciOiJSUzI1NiIsImtpZCI6IjViMzcwNjk2MGUzZTYwMDI0YTI2NTVlNzhjZmE2M2Y4N2M5N2QzMDkiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzMjU1NTk0MDU1OS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjMyNTU1OTQwNTU5LmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE3MDEwODE0Mjg5MjQxNzIyNTYxIiwiZW1haWwiOiJsYXVnZWp1bmttYWlsQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiaDh0aC15SlB6Y1RhTHNONWRSMlZWQSIsImlhdCI6MTcwMDA0MzAzNCwiZXhwIjoxNzAwMDQ2NjM0fQ.f8T5EoepPVHEkxHkBloVab8r7UMaHZxVWJzYWBoS_GopEN91uPbFYOzAEsjaLXlS5xckqqOZc3tj_fX9C6tECI2gS_xXI17fWW2PMUJaWqwRYdQ4VV9THRRxIbWQ8glRF5prCSIi93vxoP0Wr-tjTtMaYny0chQQ7hngqWUo375b-YTHw-Cvc5Nc5sPcKbhpq9sWwxVd1KH4SSRF63Gu-WKHAu1_zuJ6DkEOirb9GxWhsK4myTKZbcyNYqw56CQ2Asz09kCkOZORbZmqh2tzPV-7h_GrpROAmSfznq5FvBCiK9wUHudkGzr5BShngGZXZdniVQpmnBjFp3JjEKefcQ"; 
};

function App() {
  const fetchMenu = async () => {
    return await axios.get("/menu", {
      headers: {
        Authorization: `Bearer ${getToken()}`
      }
    }).then((response) => response.data);
  };

  console.log(getToken());
  const { data, error, isLoading } = useQuery("menu", fetchMenu);

  const orderMutation = useMutation((order) =>
    axios.post("/order", order, {
      headers: {
        Authorization: `Bearer ${getToken()}`
      }
    })
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
