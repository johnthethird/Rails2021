module.exports = function (api) {
  var validEnv = ["development", "test", "production"];
  var currentEnv = api.env();
  var isDevelopmentEnv = api.env("development");
  var isProductionEnv = api.env("production");
  var isTestEnv = api.env("test");

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      "Please specify a valid `NODE_ENV` or " +
        '`BABEL_ENV` environment variables. Valid values are "development", ' +
        '"test", and "production". Instead, received: ' +
        JSON.stringify(currentEnv) +
        "."
    );
  }
  // return {};

  return {
    presets: [
      isTestEnv && [
        "@babel/preset-env",
        {
          targets: {
            node: "current",
          },
        },
      ],
      (isProductionEnv || isDevelopmentEnv) && [
        "@babel/preset-env",
        {
          forceAllTransforms: false,
          useBuiltIns: "usage",
          corejs: 3,
          modules: "auto",
          shippedProposals: true,
          targets: {
            browsers: "> 1%, not IE 11, not dead",
          },
          exclude: [
            "transform-typeof-symbol",
            "transform-async-to-generator",
            "transform-regenerator",
          ],
        },
      ],
    ].filter(Boolean),
    plugins: ["babel-plugin-macros"].filter(Boolean),
  };
};
