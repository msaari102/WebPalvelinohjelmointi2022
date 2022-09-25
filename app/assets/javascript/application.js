//= require jquery3
//= require popper
//= require bootstrap-sprockets
import "@hotwired/turbo-rails";
import "controllers";
import { beers, breweries } from "custom/utils";

beers();
breweries();