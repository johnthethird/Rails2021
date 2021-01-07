// import "core-js/stable";
// import "regenerator-runtime/runtime";

//require("@rails/activestorage").start();
import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

require("trix/dist/trix-core");
require("@rails/actiontext");

const images = require.context("../images", true);
const imagePath = (name) => images(name, true);

// let y = { a: 1, b: 2 };
// let z = y.foo?.bar;

// const xx = { ...y, c: 3 };
// const { a } = y;

// Array.from(new Set([1, 2, 3, 2, 1])); // => [1, 2, 3]
// [1, [2, 3], [4, [5]]].flat(2); // => [1, 2, 3, 4, 5]
// Promise.resolve(32).then((x) => console.log(x)); // => 32

require("stylesheets/application.scss");
