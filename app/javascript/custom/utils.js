const BEERS = {};

const BREWERIES = {};

const handleResponse = (beers) => {
  BEERS.list = beers;
  BEERS.show();
};

const handleBreweryResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (beer) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const beername = tr.appendChild(document.createElement("td"));
  beername.innerHTML = beer.name;
  const style = tr.appendChild(document.createElement("td"));
  style.innerHTML = beer.style.name;
  const brewery = tr.appendChild(document.createElement("td"));
  brewery.innerHTML = beer.brewery.name;

  return tr;
};

const createBreweryTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const breweryfounded = tr.appendChild(document.createElement("td"));
  breweryfounded.innerHTML = brewery.year;
  const beercount = tr.appendChild(document.createElement("td"));
  beercount.innerHTML = brewery.beers.length;
  const breweryclosed = tr.appendChild(document.createElement("td"));
  breweryclosed.innerHTML = !brewery.active;
  return tr;
};

BEERS.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("beertable");

  BEERS.list.forEach((beer) => {
    const tr = createTableRow(beer);
    table.appendChild(tr);
  });
};

BREWERIES.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createBreweryTableRow(brewery);
    table.appendChild(tr);
  });
};

BEERS.sortByName = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BEERS.sortByStyle = () => {
  BEERS.list.sort((a, b) => {
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
  });
};

BEERS.sortByBrewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name
      .toUpperCase()
      .localeCompare(b.brewery.name.toUpperCase());
  });
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return (a.year-b.year);
  });
};

BREWERIES.sortByBeerCount = () => {
  BREWERIES.list.sort((a, b) => {
    return (a.beers.length-b.beers.length);
  });
};

const beers = () => {
  if (document.querySelectorAll("#beertable").length < 1) return;
  
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByName();
    BEERS.show();
  });

  document.getElementById("style").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByStyle();
    BEERS.show();
  });

  document.getElementById("brewery").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByBrewery();
    BEERS.show();
  });

  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse);

};

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;
  
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("founded").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById("beerCount").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByBeerCount();
    BREWERIES.show();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleBreweryResponse);

};

export { beers, breweries };