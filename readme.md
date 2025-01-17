<h1 align="center">Nevermore</h1>
<div align="center">
  <a href="http://quenty.github.io/api/">
    <img src="https://img.shields.io/badge/docs-website-green.svg" alt="Documentation" />
  </a>
  <a href="https://discord.gg/mhtGUS8">
    <img src="https://img.shields.io/badge/discord-nevermore-blue.svg" alt="Discord" />
  </a>
  <a href="https://github.com/Quenty/NevermoreEngine/actions">
    <img src="https://github.com/Quenty/NevermoreEngine/actions/workflows/build.yml/badge.svg" alt="Build and release status" />
  </a>
</div>

<div align="center">
	ModuleScript loader with reusable and easy unified server-client modules for faster game development on Roblox
</div>

<div>&nbsp;</div>

<div align="center">
  ⚠**WARNING**: This branch of Nevermore is under development and is gaining CI/CD and other quality-of-life upgrades. Usage may be unstable at this point, and versions may not be fully semantically versioned. ⚠
</div>

<div>&nbsp;</div>

## About
Nevermore is a ModuleScript loader for Roblox, and loads modules by name. Nevermore is designed to make code more portable. Nevermore comes with a variety of utility libraries. These libraries are used on both the client and server and are useful for a variety of things. These libraries are separated into packages that can be consumed individually using npm.

Nevermore follows both functional and OOP programming paradigms. However, many modules return classes, and may require more advance Lua knowledge to use.

## Install using npm
Nevermore is designed to use [npm](https://www.npmjs.com/) to manage packages. You can install a package like this.

```
npm install @quenty/maid
```

Each package is designed to be synced into Roblox using [rojo](https://rojo.space/).

## Install using bootstrapper
To install Nevermore, paste the following code into your command bar in Roblox Studio!

```lua
local h = game:GetService("HttpService") local e = h.HttpEnabled h.HttpEnabled = true loadstring(h:GetAsync("https://raw.githubusercontent.com/Quenty/NevermoreEngine/version2/Install.lua"))(e)
```

## Documentation
See [quenty.github.io/api/](http://quenty.github.io/api/) for API documentation.

## Usage
See [quenty.github.io/api/](http://quenty.github.io/api/topics/02_usage.md.html) for examples and usage documentation.

## Community

* [Discord](https://discord.gg/mhtGUS8)
