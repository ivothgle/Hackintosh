// This is a hotpatch for HASEE (K650D-i5 D2) backlight control 
// Fn + F8(down) / F9(up)
// In config ACPI, _Q12 renamed XQ12
// Find:     <5f513132 00700a>
// Replace:  <58513132 00700a>
DefinitionBlock ("", "SSDT", 2, "hack", "fnkey", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (OEM2, FieldUnitObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        Name (OEM8, 0)
        Store (OEM2, OEM8)

        Method (_Q12, 0, NotSerialized)
        {
            If (OEM2 < OEM8 || ( OEM2 == 0 && OEM8 == 0))
            {
                Notify (PS2K, 0x0405) // Down
            }
            ElseIf (OEM2 > OEM8 || ( OEM2 == 7 && OEM8 == 7))
            {
                Notify (PS2K, 0x0406) // Up
            }

            Store (OEM2, OEM8)
        }
    }
}