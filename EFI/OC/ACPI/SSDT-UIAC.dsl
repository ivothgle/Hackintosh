DefinitionBlock ("", "SSDT", 2, "hack", "_UIAC", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            // XHC (8086_8c31)
            "XHC", Package()
            {
                "port-count", Buffer() { 0x12, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "SS02", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x11, 0x00, 0x00, 0x00 },
                      },
                      "HS08", Package()
                      {
                          "UsbConnector", 255,
                          "port", Buffer() { 0x08, 0x00, 0x00, 0x00 },
                      },
                      "SS03", Package()
                      {
                          "UsbConnector", 3,
                          "port", Buffer() { 0x12, 0x00, 0x00, 0x00 },
                      },
                      "HS02", Package()
                      {
                          "UsbConnector", 0,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "HS06", Package()
                      {
                          "UsbConnector", 0,
                          "port", Buffer() { 0x06, 0x00, 0x00, 0x00 },
                      },
                      "HS03", Package()
                      {
                          "UsbConnector", 0,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "HS07", Package()
                      {
                          "UsbConnector", 255,
                          "port", Buffer() { 0x07, 0x00, 0x00, 0x00 },
                      },
                },
            },
        })
    }
}
