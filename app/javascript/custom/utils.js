const handleResponse = (beers) => {
  const beerList = beers.map((beer) => `<li>${beer.name}</li>`);

  document.getElementById("beers").innerHTML = `<ul> ${beerList.join("")} </ul>`;
};

const beers = () => {
  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse);
};

export { beers };