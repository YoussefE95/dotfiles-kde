(async function comfy() {
  if (
    !(
      Spicetify.Player?.data &&
      Spicetify.Platform &&
      Spicetify.PopupModal &&
      Spicetify.React &&
      Spicetify.ReactDOM &&
      Spicetify.AppTitle &&
      document.querySelector(".Root__main-view")
    )
  ) {
    setTimeout(comfy, 300);
    return;
  }

  // Attempt to load color.ini from localStorage and updates it
  let colorSchemes = getConfig("colorSchemes");

  fetch("https://raw.githubusercontent.com/Comfy-Themes/Spicetify/main/Comfy/color.ini")
    .then((response) => response.text())
    .then((iniContent) => {
      const parsedIni = parseIni(iniContent);
      localStorage.setItem("colorSchemes", JSON.stringify(parsedIni).toLowerCase());
      colorSchemes = getConfig("colorSchemes");
      Spicetify.ReactDOM.render(Spicetify.React.createElement(Content), document.createElement("div"));
      console.log("Successfully updated colorSchemes!");
    })
    .catch((error) => {
      console.error("Failed to update colorSchemes:", error);
    });

  // Header Image(s)
  const { Player, Platform } = Spicetify;
  const main = document.querySelector(".Root__main-view");
  const channels = [
    /^\/playlist\//,
    /^\/station\/playlist\//,
    /^\/artist\/(?!artists\b)\w+$/,
    /^\/album\//,
    /^\/collection\/tracks$/,
    /^\/collection\/your-episodes$/,
    /^\/collection\/local-files$/,
    /^\/show\//,
    /^\/episode\//,
    /^\/lyrics-plus$/,
    /^\/user\/(?!users\b)\w+$/,
    /^\/genre\//,
  ];

  // Create image container + preload image
  const frame = document.createElement("div");
  const mainImage = document.createElement("img");
  const secondaryImage = document.createElement("img");

  frame.className = "frame";
  mainImage.className = "mainImage";
  secondaryImage.className = "secondaryImage";

  frame.append(mainImage, secondaryImage);
  main.appendChild(frame);

  // Source Checks + Image Updater
  const sourceCheck = () => getConfig("Custom-Image");
  const source = () => getConfig("Custom-Image-URL")?.replace(/"/g, "");
  function updateImageDisplay() {
    const { pathname } = Platform.History.location;
    frame.style.display = channels.some((channel) => channel.test(pathname)) ? "" : "none";
    mainImage.src = secondaryImage.src = sourceCheck() ? source() : Player.data.track.metadata.image_xlarge_url;
  }

  // Initialize
  updateImageDisplay();

  // Listen for channel switches
  Platform.History.listen(updateImageDisplay);

  // Change the song image on song change
  Player.addEventListener("songchange", updateImageDisplay);

  // FUNCTIONS
  function getConfig(key) {
    try {
      return JSON.parse(Spicetify.LocalStorage.get(key));
    } catch (e) {
      console.error(e);
      return null;
    }
  }

  function isPromise(p) {
    if (typeof p === "object" && typeof p.then === "function") {
      return true;
    }

    return false;
  }

  // courtesy of https://github.com/spicetify/spicetify-marketplace
  function applyTheme(scheme) {
    const existingScheme = document.querySelector("style.comfyScheme");
    if (existingScheme) existingScheme.remove();
    if (!scheme) return;

    const schemeTag = document.createElement("style");
    schemeTag.classList.add("comfyScheme");
    let injectStr = ":root {";
    const themeIniKeys = Object.keys(scheme);
    themeIniKeys.forEach((key) => {
      injectStr += `--spice-${key}: #${scheme[key]};`;
      injectStr += `--spice-rgb-${key}: ${hexToRGB(scheme[key])};`;
    });
    injectStr += "}";
    schemeTag.innerHTML = injectStr;
    document.body.appendChild(schemeTag);
  }

  // courtesy of https://github.com/spicetify/spicetify-marketplace
  function removeTheme() {
    const existingScheme = document.querySelector("style.comfyScheme");
    if (existingScheme) existingScheme.remove();
  }

  // courtesy of https://github.com/spicetify/spicetify-marketplace
  const parseIni = (data) => {
    const regex = {
      section: /^\s*\[\s*([^\]]*)\s*\]\s*$/,
      param: /^\s*([^=]+?)\s*=\s*(.*?)\s*$/,
      comment: /^\s*;.*$/,
    };
    const value = {};
    let section = null;

    const lines = data.split(/[\r\n]+/);

    lines.forEach(function (line) {
      if (regex.comment.test(line)) {
        return;
      } else if (regex.param.test(line)) {
        if (line.includes("xrdb")) {
          delete value[section || ""];
          section = null;
          return;
        }

        const match = line.match(regex.param);

        if (match && match.length === 3) {
          if (section) {
            if (!value[section]) {
              value[section] = {};
            }
            value[section][match[1]] = match[2].split(";")[0].trim();
          }
        }
      } else if (regex.section.test(line)) {
        const match = line.match(regex.section);
        if (match) {
          value[match[1]] = {};
          section = match[1];
        }
      } else if (line.length === 0 && section) {
        section = null;
      }
    });

    return value;
  };

  // courtesy of https://github.com/spicetify/spicetify-marketplace
  const hexToRGB = (hex) => {
    if (hex.length === 3) {
      hex = hex
        .split("")
        .map((char) => char + char)
        .join("");
    } else if (hex.length != 6) {
      throw "Only 3- or 6-digit hex colours are allowed.";
    } else if (hex.match(/[^0-9a-f]/i)) {
      throw "Only hex colours are allowed.";
    }

    const aRgbHex = hex.match(/.{1,2}/g);
    if (!aRgbHex || aRgbHex.length !== 3) {
      throw "Could not parse hex colour.";
    }

    const aRgb = [parseInt(aRgbHex[0], 16), parseInt(aRgbHex[1], 16), parseInt(aRgbHex[2], 16)];

    return aRgb;
  };

  const Tippy = ({ label }) => {
    if (!label) return null;
    return Spicetify.React.createElement(
      Spicetify.ReactComponent.TooltipWrapper,
      {
        label,
        showDelay: 0,
        placement: "left",
        trigger: "mouseenter",
      },
      Spicetify.React.createElement(
        "div",
        { className: "x-settings-tooltip" },
        Spicetify.React.createElement(
          "div",
          {
            className: "x-settings-tooltipIconWrapper",
          },
          Spicetify.React.createElement(
            "svg",
            {
              role: "img",
              height: "16",
              width: "16",
              tabindex: "0",
              className: "Svg-sc-ytk21e-0 Svg-img-16-icon nW1RKQOkzcJcX6aDCZB4",
              viewBox: "0 0 16 16",
            },
            Spicetify.React.createElement("path", {
              d: "M8 1.5a6.5 6.5 0 1 0 0 13 6.5 6.5 0 0 0 0-13zM0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8z",
            }),
            Spicetify.React.createElement("path", {
              d: "M7.25 12.026v-1.5h1.5v1.5h-1.5zm.884-7.096A1.125 1.125 0 0 0 7.06 6.39l-1.431.448a2.625 2.625 0 1 1 5.13-.784c0 .54-.156 1.015-.503 1.488-.3.408-.7.652-.973.818l-.112.068c-.185.116-.26.203-.302.283-.046.087-.097.245-.097.57h-1.5c0-.47.072-.898.274-1.277.206-.385.507-.645.827-.846l.147-.092c.285-.177.413-.257.526-.41.169-.23.213-.397.213-.602 0-.622-.503-1.125-1.125-1.125z",
            })
          )
        )
      )
    );
  };

  const Divider = Spicetify.React.memo(({ name }) => {
    return Spicetify.React.createElement(
      "div",
      { className: "divider-row", id: name },
      Spicetify.React.createElement("div", { className: "space" }),
      name &&
        Spicetify.React.createElement(
          Spicetify.React.Fragment,
          null,
          Spicetify.React.createElement("h2", { className: "title" }, name),
          Spicetify.React.createElement("hr", { className: "divider" })
        )
    );
  });

  const Slider = Spicetify.React.memo(({ name, desc, tippy, defaultVal, condition = true, callback }) => {
    const initialValue = getConfig(name) ?? defaultVal;
    const [state, setState] = Spicetify.React.useState(initialValue);

    Spicetify.React.useEffect(() => {
      if (initialValue !== state) {
        Spicetify.LocalStorage.set(name, state);
        console.log(name, state);
      }
      document.getElementById("main")?.classList.toggle(name, state);
      callback?.(state);
    }, [state]);

    if (condition === false) return null;

    return Spicetify.React.createElement(
      "div",
      { className: "setting-row", id: name },
      Spicetify.React.createElement("label", { className: "col description" }, desc, tippy),
      Spicetify.React.createElement(
        "div",
        { className: "col action" },
        Spicetify.React.createElement(
          "button",
          {
            className: `switch ${state ? "" : "disabled"}`,
            onClick: () => setState(!state),
          },
          Spicetify.React.createElement("svg", {
            height: "16",
            width: "16",
            viewBox: "0 0 16 16",
            fill: "currentColor",
            dangerouslySetInnerHTML: {
              __html: Spicetify.SVGIcons.check,
            },
          })
        )
      )
    );
  });

  const Input = Spicetify.React.memo(
    ({ inputType, name, desc, min, max, step, tippy, defaultVal, condition = true, callback }) => {
      const initialValue = getConfig(name) ?? "";
      const [value, setValue] = Spicetify.React.useState(initialValue);
      const [defaultState, setDefaultState] = Spicetify.React.useState(defaultVal);

      Spicetify.React.useEffect(() => {
        if (isPromise(defaultVal)) defaultVal.then((val) => setDefaultState(val));
      }, [defaultVal]);

      Spicetify.React.useEffect(() => {
        if (initialValue !== value) {
          Spicetify.LocalStorage.set(name, `"${value}"`);
          console.log(name, value);
        }
        callback?.(value, name);
      }, [value]);

      if (condition === false) return null;

      return Spicetify.React.createElement(
        "div",
        { className: "setting-row", id: name },
        Spicetify.React.createElement("label", { className: "col description" }, desc, tippy),
        Spicetify.React.createElement(
          "div",
          { className: "col action" },
          Spicetify.React.createElement("input", {
            type: inputType,
            className: "input",
            value,
            min,
            max,
            step,
            placeholder: defaultState,
            onChange: (e) => setValue(e.target.value),
          })
        )
      );
    }
  );

  const Section = ({ name, children, condition = true }) => {
    if (condition === false) return null;
    return Spicetify.React.createElement(
      Spicetify.React.Fragment,
      null,
      Spicetify.React.createElement(Divider, { name }),
      children.map((child) =>
        Spicetify.React.createElement(child.type, {
          ...child,
          tippy: Spicetify.React.createElement(Tippy, { label: child.tippy }),
        })
      )
    );
  };

  const SubSection = ({ name, condition = true, items, callback, ...props }) => {
    const [state, setState] = Spicetify.React.useState(getConfig(name) ?? true);
    if (condition === false) return null;

    return Spicetify.React.createElement(
      Spicetify.React.Fragment,
      null,
      Spicetify.React.createElement(Slider, {
        name,
        callback: (value) => {
          setState(value);
          callback?.(value);
        },
        ...props,
      }),
      state &&
        Spicetify.React.createElement(
          "ul",
          { className: "sub-section", style: { listStyle: "auto", listStyleType: "disc" } },
          items.map((item) =>
            Spicetify.React.createElement(
              "li",
              { className: "sub-section-item", style: { marginLeft: "1rem" } },
              Spicetify.React.createElement(item.type, {
                ...item,
                tippy: Spicetify.React.createElement(Tippy, { label: item.tippy }),
              })
            )
          )
        )
    );
  };

  const Dropdown = Spicetify.React.memo(({ name, desc, options, defaultVal, condition = true, tippy, callback }) => {
    const initialValue = getConfig(name) ?? defaultVal;
    const [selectedValue, setSelectedValue] = Spicetify.React.useState(initialValue);
    const [buttonEnabled, setButtonEnabled] = Spicetify.React.useState(selectedValue !== defaultVal);

    const fallbackVal = "Select an option";
    if (!defaultVal) defaultVal = fallbackVal;

    Spicetify.React.useEffect(() => {
      if (initialValue !== selectedValue) {
        Spicetify.LocalStorage.set(name, `"${selectedValue}"`);
        console.log(name, selectedValue);
      }
      callback?.(selectedValue);
      setButtonEnabled(selectedValue !== defaultVal);
    }, [selectedValue]);

    if (!condition) return null;

    return Spicetify.React.createElement(
      "div",
      { className: "setting-row", id: name },
      Spicetify.React.createElement("label", { className: "col description" }, desc, tippy),
      Spicetify.React.createElement(
        "div",
        { className: "col action", style: { display: "flex", flexDirection: "row !important" } },
        buttonEnabled &&
          Spicetify.React.createElement(
            "button",
            {
              className: `switch`,
              style: { marginInlineEnd: "12px" },
              onClick: () => {
                setSelectedValue(defaultVal);
                callback?.(defaultVal);
              },
            },
            Spicetify.React.createElement("svg", {
              height: "16",
              width: "16",
              viewBox: "0 0 16 16",
              fill: "currentColor",
              dangerouslySetInnerHTML: {
                __html: Spicetify.SVGIcons.x,
              },
            })
          ),
        Spicetify.React.createElement(
          "select",
          {
            value: selectedValue,
            onChange: (event) => {
              const newValue = event.target.value;
              setSelectedValue(newValue);
              callback?.(newValue);
            },
          },
          defaultVal === fallbackVal && Spicetify.React.createElement("option", { value: "" }, fallbackVal),
          options.map((option) => Spicetify.React.createElement("option", { key: option, value: option }, option))
        )
      )
    );
  });

  const Content = () => {
    let cachedFeature = null;
    const additionalFeatureSchemes = ["nord", "mono"];

    return Spicetify.React.createElement(
      "div",
      { className: "comfy-settings" },
      Spicetify.React.createElement(Section, { name: "Colorscheme" }, [
        {
          type: Dropdown,
          name: "Color-Scheme",
          desc: `Color Scheme`,
          options: colorSchemes ? Object.keys(colorSchemes) : [],
          defaultVal: Spicetify.Config?.color_scheme.toLowerCase(),
          condition: !document.querySelector("body > style.marketplaceCSS.marketplaceScheme"),
          tippy: Spicetify.React.createElement("div", null, "For faster loadtimes use cli to change color schemes."),
          callback: (value) => {
            if (value !== Spicetify.Config?.color_scheme.toLowerCase() && colorSchemes) {
              applyTheme(colorSchemes[value]);
            } else {
              removeTheme();
            }
          },
        },
        {
          type: Dropdown,
          name: `Scheme-Features`,
          desc: `Additional Features`,
          options: additionalFeatureSchemes,
          callback: (value) => {
            if (cachedFeature) {
              document.getElementById("main")?.classList.remove(`Comfy-${cachedFeature}-Snippet`);
            }
            if (value !== "Select an option" && value !== "") {
              cachedFeature = value;
              document.getElementById("main")?.classList.add(`Comfy-${value}-Snippet`);
            }
          },
        },
      ]),
      Spicetify.React.createElement(Section, { name: "Interface" }, [
        {
          type: Input,
          inputType: "text",
          name: "App-Title",
          desc: "Application Title",
          defaultVal: Spicetify.AppTitle.get(),
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            "Leave blank to reset to default",
            Spicetify.React.createElement("br", null),
            "Note: default value can be lost"
          ),
          callback: async (value) => {
            await Spicetify.Platform.UserAPI._product_state.delOverridesValues({ keys: ["name"] });
            if (value) await Spicetify.Platform.UserAPI._product_state.putOverridesValues({ pairs: { name: value } });
          },
        },
        {
          type: Input,
          inputType: "number",
          name: "Button-Radius",
          desc: "Button Radius",
          defaultVal: "8",
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement("h4", null, "Change how circular buttons are:"),
            Spicetify.React.createElement("li", null, "Comfy default: 8px"),
            Spicetify.React.createElement("li", null, "Spotify default: 50px")
          ),
          callback: (value) => document.documentElement.style.setProperty("--button-radius", (value || "8") + "px"),
        },
        {
          type: SubSection,
          name: "Custom-Font",
          desc: "Custom Font",
          defaultVal: false,
          callback: (value) => {
            if (!value) {
              document.documentElement.style.setProperty("--font-family", "");
            }
          },
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement(
              "div",
              {
                style: {
                  // tippy doesnt like loading images
                  height: "300px",
                },
              },
              Spicetify.React.createElement("img", {
                src: "https://media.discordapp.net/attachments/811648374687399988/1139576978924642425/image.png?width=1069&height=520",
                alt: "preview",
                style: {
                  width: "100%",
                },
              }),
              Spicetify.React.createElement(
                "h4",
                { style: { fontWeight: "normal" } },
                "If you have the font installed on your PC, then just enter the fonts name."
              ),
              Spicetify.React.createElement(
                "h4",
                { style: { fontWeight: "normal" } },
                "Otherwise, you can use a Google Font by entering the URL of the font."
              )
            )
          ),
          items: [
            {
              type: Input,
              inputType: "text",
              name: "Font",
              desc: "Font",
              defaultVal: "",
              callback: (value) => {
                let fontFamily = value;
                if (value.includes(".")) {
                  fontFamily = decodeURIComponent(value.match(/family=([^&:]+)/)?.[1]?.replace(/\+/g, " "));
                  if (!document.getElementById("custom-font")) {
                    const link = document.createElement("link");
                    link.rel = "stylesheet";
                    link.href = value;
                    link.id = "custom-font";
                    document.head.appendChild(link);
                  } else {
                    document.getElementById("custom-font").href = value;
                  }
                }
                document.documentElement.style.setProperty("--font-family", fontFamily);
              },
            },
          ],
        },
        {
          type: Slider,
          name: "Flatten-Colors-Snippet",
          desc: "Flatten Theme Colors",
          defaultVal: false,
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement("h4", null, "Sets main color to the same color as sidebar")
          ),
        },
        {
          type: Slider,
          name: "Home-Header-Snippet",
          desc: "Colorful Home Header",
          defaultVal: true,
        },
        {
          type: Slider,
          name: "Topbar-Inside-Titlebar-Snippet",
          desc: "Move Topbar Inside Titlebar",
          defaultVal: false,
        },
        {
          type: Slider,
          name: "Horizontal-pageLinks-Snippet",
          desc: "Horizontal Page Links",
          defaultVal: false,
        },
        {
          type: Slider,
          name: "visible-column-bar-Snippet",
          desc: "Visible Column Bar",
          defaultVal: false,
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement("h4", null, "Unhides the column bar above tracklist")
          ),
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement(
              "div",
              {
                style: {
                  // tippy doesnt like loading images
                  height: "120px",
                },
              },
              Spicetify.React.createElement("img", {
                src: "https://github.com/Comfy-Themes/Spicetify/blob/main/images/settings/column-bar.png?raw=true",
                alt: "preview",
                style: {
                  width: "100%",
                },
              }),
              Spicetify.React.createElement("h4", null, "Unhides the column bar above tracklist")
            )
          ),
        },
      ]),
      Spicetify.React.createElement(Section, { name: "Playbar" }, [
        {
          type: Slider,
          name: "Remove-Device-Picker-Notification-Snippet",
          desc: "Remove Device Picker Notification",
          defaultVal: false,
        },
        {
          type: Slider,
          name: "Remove-Progress-Bar-Gradient-Snippet",
          desc: "Remove Progress Bar Gradient",
          defaultVal: false,
        },
        {
          type: Slider,
          name: "Remove-Timers-Snippet",
          desc: "Remove Playback Timers",
          defaultVal: false,
        },
        {
          type: Slider,
          name: "Remove-Lyrics-Button-Snippet",
          desc: "Remove Lyrics Button",
          defaultVal: false,
        },
      ]),
      Spicetify.React.createElement(Section, { name: "Cover Art" }, [
        {
          type: SubSection,
          name: "Custom-Cover-Art-Dimensions",
          desc: "Custom Dimensions",
          defaultVal: false,
          callback: (value) => {
            if (!value) {
              document.documentElement.style.setProperty("--cover-art-width", "");
              document.documentElement.style.setProperty("--cover-art-height", "");
              document.documentElement.style.setProperty("--cover-art-radius", "");
              document.documentElement.style.setProperty("--cover-art-margin", "");
            }
          },
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement("h4", null, "Change the size of the cover art:"),
            Spicetify.React.createElement("li", null, "Comfy default: (84px, 84px, 8px, 20px)"),
            Spicetify.React.createElement("li", null, "Spotify default: (56px, 56px, 4px, 0px)"),
            Spicetify.React.createElement("li", null, "Oblong: (115px, 84px, 15px, 20px)")
          ),
          items: [
            {
              type: Input,
              inputType: "number",
              name: "Cover-Art-Width",
              desc: "Width",
              defaultVal: "84px",
              callback: (value) =>
                document.documentElement.style.setProperty("--cover-art-width", (value || "84") + "px"),
            },
            {
              type: Input,
              inputType: "number",
              name: "Cover-Art-Height",
              desc: "Height",
              defaultVal: "84px",
              callback: (value) =>
                document.documentElement.style.setProperty("--cover-art-height", (value || "84") + "px"),
            },
            {
              type: Input,
              inputType: "number",
              name: "Cover-Art-Radius",
              desc: "Border Radius",
              defaultVal: "8px",
              callback: (value) =>
                document.documentElement.style.setProperty("--cover-art-radius", (value || "8") + "px"),
            },
            {
              type: Input,
              inputType: "number",
              name: "Cover-Art-Bottom",
              desc: "Bottom Margin",
              defaultVal: "20px",
              tippy: Spicetify.React.createElement(
                Spicetify.React.Fragment,
                null,
                Spicetify.React.createElement(
                  "h4",
                  null,
                  "Change the distance between the cover art and the bottom of the playbar:"
                ),
                Spicetify.React.createElement("li", null, "Comfy default: 20px"),
                Spicetify.React.createElement("li", null, "Spotify default: 0px")
              ),
              callback: (value) =>
                document.documentElement.style.setProperty("--cover-art-bottom", (value || "20") + "px"),
            },
          ],
        },
        {
          type: Slider,
          name: "Revert-Right-Art-Snippet",
          desc: "Disable Right Side Cover Art",
          defaultVal: false,
        },
      ]),
      Spicetify.React.createElement(Section, { name: "Banner Image" }, [
        {
          type: Input,
          inputType: "number",
          name: "Image-Blur",
          desc: "Image Blur",
          defaultVal: "4",
          min: "0",
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement("h4", null, "Amount of banner blur in pixels:"),
            Spicetify.React.createElement("li", null, "Comfy default: 4px")
          ),
          callback: (value) => document.documentElement.style.setProperty("--image-blur", (value || "4") + "px"),
        },
        {
          type: SubSection,
          name: "Apple-Music-Gradient-Snippet",
          desc: "Apple Music Gradient",
          defaultVal: false,
          tippy: Spicetify.React.createElement(
            Spicetify.React.Fragment,
            null,
            Spicetify.React.createElement(
              "div",
              {
                style: {
                  // tippy doesnt like loading images
                  height: "315px",
                },
              },
              Spicetify.React.createElement("img", {
                src: "https://github.com/Comfy-Themes/Spicetify/blob/main/images/settings/am-blur.gif?raw=true",
                alt: "preview",
                style: {
                  width: "100%",
                },
              }),
              Spicetify.React.createElement("h4", null, "Blur (10x Value):"),
              Spicetify.React.createElement("li", null, "Recommended: 4px")
            )
          ),
          items: [
            {
              type: Input,
              inputType: "number",
              name: "Gradient-Speed",
              desc: "Speed - Advanced",
              defaultVal: "50",
              min: "0",
              tippy: Spicetify.React.createElement(
                Spicetify.React.Fragment,
                null,
                Spicetify.React.createElement("h4", null, "Seconds per full rotation (360°):"),
                Spicetify.React.createElement("li", null, "Comfy default: 50")
              ),
              callback: (value) =>
                document.documentElement.style.setProperty("--gradient-speed", (value || "50") + "s"),
            },
            {
              type: Input,
              inputType: "number",
              name: "Gradient-Size",
              desc: "Size - Advanced",
              defaultVal: "150",
              min: "0",
              tippy: Spicetify.React.createElement(
                Spicetify.React.Fragment,
                null,
                Spicetify.React.createElement("h4", null, "Width of circles in relation to viewport (in %):"),
                Spicetify.React.createElement("li", null, "Comfy default: 150")
              ),
              callback: (value) =>
                document.documentElement.style.setProperty("--gradient-width", (value || "150") + "%"),
            },
          ],
        },
        {
          type: SubSection,
          name: "Custom-Image",
          desc: "Custom Image",
          defaultVal: false,
          callback: updateImageDisplay,
          items: [
            {
              type: Input,
              inputType: "text",
              name: "Custom-Image-URL",
              desc: "URL",
              defaultVal: "Paste URL here!",
              tippy: Spicetify.React.createElement(
                Spicetify.React.Fragment,
                null,
                Spicetify.React.createElement("h4", null, "Local Images:"),
                Spicetify.React.createElement("li", null, "Place desired image in 'spotify/Apps/xpui/images'."),
                Spicetify.React.createElement("li", null, "Enter 'images/image.png' into text box.")
              ),
              callback: updateImageDisplay,
            },
          ],
        },
      ])
    );
  };

  const DiscordButton = () => {
    return Spicetify.React.createElement(
      Spicetify.ReactComponent.TooltipWrapper,
      {
        label: "Join our Discord!",
        showDelay: 200,
      },
      Spicetify.React.createElement(
        "button",
        {
          className:
            "main-buddyFeed-closeButton Button-sm-16-buttonTertiary-iconOnly-isUsingKeyboard-useBrowserDefaultFocusStyle Button-sm-16-buttonTertiary-iconOnly-useBrowserDefaultFocusStyle",
          onClick: () => window.open("https://discord.gg/rtBQX5D3bD"),
        },
        Spicetify.React.createElement("svg", {
          width: "16",
          height: "16",
          viewBox: "0 -28.5 256 256",
          fill: "currentColor",
          dangerouslySetInnerHTML: {
            __html: `<g xmlns="http://www.w3.org/2000/svg"><path d="M216.856339,16.5966031 C200.285002,8.84328665 182.566144,3.2084988 164.041564,0 C161.766523,4.11318106 159.108624,9.64549908 157.276099,14.0464379 C137.583995,11.0849896 118.072967,11.0849896 98.7430163,14.0464379 C96.9108417,9.64549908 94.1925838,4.11318106 91.8971895,0 C73.3526068,3.2084988 55.6133949,8.86399117 39.0420583,16.6376612 C5.61752293,67.146514 -3.4433191,116.400813 1.08711069,164.955721 C23.2560196,181.510915 44.7403634,191.567697 65.8621325,198.148576 C71.0772151,190.971126 75.7283628,183.341335 79.7352139,175.300261 C72.104019,172.400575 64.7949724,168.822202 57.8887866,164.667963 C59.7209612,163.310589 61.5131304,161.891452 63.2445898,160.431257 C105.36741,180.133187 151.134928,180.133187 192.754523,160.431257 C194.506336,161.891452 196.298154,163.310589 198.110326,164.667963 C191.183787,168.842556 183.854737,172.420929 176.223542,175.320965 C180.230393,183.341335 184.861538,190.991831 190.096624,198.16893 C211.238746,191.588051 232.743023,181.531619 254.911949,164.955721 C260.227747,108.668201 245.831087,59.8662432 216.856339,16.5966031 Z M85.4738752,135.09489 C72.8290281,135.09489 62.4592217,123.290155 62.4592217,108.914901 C62.4592217,94.5396472 72.607595,82.7145587 85.4738752,82.7145587 C98.3405064,82.7145587 108.709962,94.5189427 108.488529,108.914901 C108.508531,123.290155 98.3405064,135.09489 85.4738752,135.09489 Z M170.525237,135.09489 C157.88039,135.09489 147.510584,123.290155 147.510584,108.914901 C147.510584,94.5396472 157.658606,82.7145587 170.525237,82.7145587 C183.391518,82.7145587 193.761324,94.5189427 193.539891,108.914901 C193.539891,123.290155 183.391518,135.09489 170.525237,135.09489 Z" fill="currentColor" fill-rule="nonzero"></path></g>`,
          },
        })
      )
    );
  };

  // SETTINGS MENU
  const svg = `<svg viewBox="0 0 262.394 262.394" style="scale: 0.5; fill: currentcolor"><path d="M245.63,103.39h-9.91c-2.486-9.371-6.197-18.242-10.955-26.432l7.015-7.015c6.546-6.546,6.546-17.159,0-23.705 l-15.621-15.621c-6.546-6.546-17.159-6.546-23.705,0l-7.015,7.015c-8.19-4.758-17.061-8.468-26.432-10.955v-9.914 C159.007,7.505,151.502,0,142.244,0h-22.091c-9.258,0-16.763,7.505-16.763,16.763v9.914c-9.37,2.486-18.242,6.197-26.431,10.954 l-7.016-7.015c-6.546-6.546-17.159-6.546-23.705,0.001L30.618,46.238c-6.546,6.546-6.546,17.159,0,23.705l7.014,7.014 c-4.758,8.19-8.469,17.062-10.955,26.433h-9.914c-9.257,0-16.762,7.505-16.762,16.763v22.09c0,9.258,7.505,16.763,16.762,16.763 h9.914c2.487,9.371,6.198,18.243,10.956,26.433l-7.015,7.015c-6.546,6.546-6.546,17.159,0,23.705l15.621,15.621 c6.546,6.546,17.159,6.546,23.705,0l7.016-7.016c8.189,4.758,17.061,8.469,26.431,10.955v9.913c0,9.258,7.505,16.763,16.763,16.763 h22.091c9.258,0,16.763-7.505,16.763-16.763v-9.913c9.371-2.487,18.242-6.198,26.432-10.956l7.016,7.017 c6.546,6.546,17.159,6.546,23.705,0l15.621-15.621c3.145-3.144,4.91-7.407,4.91-11.853s-1.766-8.709-4.91-11.853l-7.016-7.016 c4.758-8.189,8.468-17.062,10.955-26.432h9.91c9.258,0,16.763-7.505,16.763-16.763v-22.09 C262.393,110.895,254.888,103.39,245.63,103.39z M131.198,191.194c-33.083,0-59.998-26.915-59.998-59.997 c0-33.083,26.915-59.998,59.998-59.998s59.998,26.915,59.998,59.998C191.196,164.279,164.281,191.194,131.198,191.194z"/><path d="M131.198,101.199c-16.541,0-29.998,13.457-29.998,29.998c0,16.54,13.457,29.997,29.998,29.997s29.998-13.457,29.998-29.997 C161.196,114.656,147.739,101.199,131.198,101.199z"/></svg>`;
  new Spicetify.Topbar.Button(
    "Comfy Settings",
    svg,
    () => {
      Spicetify.PopupModal.display({
        title: "Comfy Settings",
        content: Spicetify.React.createElement(Content),
        isLarge: true,
      });

      const header = document.querySelector(".main-trackCreditsModal-header");
      const container = document.createElement("div");
      const extraText = document.createElement("a");
      extraText.textContent = "Need support? Click here!";
      extraText.href = "https://discord.gg/rtBQX5D3bD";
      extraText.style.color = "lightgreen";

      container.appendChild(document.querySelector("h1.main-type-alto"));
      container.appendChild(extraText);
      header.prepend(container);
    },
    false,
    true
  );

  // Workaround for hotloading assets
  Spicetify.ReactDOM.render(Spicetify.React.createElement(Content), document.createElement("div"));
})();
