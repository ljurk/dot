rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.pci-0000_0b_00.4" }, --home-pc: builtin audio
    },
    {
      { "device.name", "equals", "alsa_card.pci-0000_09_00.1" },--home-pc: gpu audio
    },
    {
      { "device.name", "equals", "alsa_card.pci-0000_07_00.1" },--t14: gpu audio
    },
    {
      { "device.name", "equals", "alsa_card.usb-Lenovo_ThinkPad_USB-C_Dock_Audio_000000000000-00" },--t14: dock
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules,rule)
