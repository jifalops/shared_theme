/**
 * The JS namespace used in this package.
 */
var SharedThemeDart = {
  dpPerInch: 160.0,
  spPerInch: 96.0,
  cssVarDp: '--px-per-dp',
  cssVarSp: '--px-per-sp',

  /**
   * Sets a CSS variable on the root element (html) for the number of device
   * pixels per logical pixel.
   */
  setPxPerDp: function() {
    this.setRootCssVar(this.cssVarDp,
      (window.devicePixelRatio * 96.0) / this.dpPerInch);
  },

  /**
   * Sets a CSS variable on the root element (html) for the number of device
   * pixels per logical text pixel.
   */
  setPxPerSp: function() {
    this.setRootCssVar(this.cssVarSp,
      (window.devicePixelRatio * 96.0) / this.spPerInch);
  },

  /**
   * Set a CSS variable on the root element (html).
   * @param {*} name The CSS variable name. The '--' prefix will be added if necessary.
   * @param {*} value The value of the CSS variable.
   */
  setRootCssVar: function(name, value) {
    if (!name.startsWith('--')) name = `--${name}`;
    document.documentElement.style.setProperty(name, value);
  }
};

// Setup the default scales.
SharedThemeDart.setPxPerDp();
SharedThemeDart.setPxPerSp();