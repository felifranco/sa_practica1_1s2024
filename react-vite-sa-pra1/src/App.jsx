import reactLogo from "./assets/react.svg";
import viteLogo from "/vite.svg";
import "./App.css";

function App() {
  const timeElapsed = Date.now();
  const today = new Date(timeElapsed);
  const options = {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
    hour: "numeric",
    minute: "numeric",
    hour12: "false",
  };

  return (
    <>
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Práctica 1 de Software Avanzado</h1>
      <h2>(Vite + React)</h2>
      <div className="card">
        <h2>200915532</h2>
        <h2>Feliciano Ernesto Franco Lux</h2>
        <h2>{today.toLocaleDateString("es-GT", options)}</h2>
      </div>
    </>
  );
}

export default App;
