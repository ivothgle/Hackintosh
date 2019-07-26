// This is a hotpatch for HASEE (K650D-i5 D2) backlight control 
// Fn + F8(down) / F9(up)
DefinitionBlock ("", "SSDT", 2, "hack", "fnkey", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (OEM2, FieldUnitObj)
    
    
    External (_SB_.PCI0.LPCB.EC__._Q0A, MethodObj)
    External (_SB_.PCI0.LPCB.EC__._Q0B, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        Name (OEM8, 0)
        Store (OEM2, OEM8)

        Method (_Q12, 0, NotSerialized)
        {
            If (OEM2 < OEM8 || ( OEM2 == 0 && OEM8 == 0))
            {
                //Notify (PS2K, 0x0405) // Down
                Notify (PS2K, 0x20) // Reserved
                Notify (PS2K, 0x0205)
                Notify (PS2K, 0x0285)
            }
            ElseIf (OEM2 > OEM8 || ( OEM2 == 7 && OEM8 == 7))
            {
                //Notify (PS2K, 0x0406) // Up
                Notify (PS2K, 0x10) // Reserved
                Notify (PS2K, 0x0206)
                Notify (PS2K, 0x0286)
            }
            \_SB_.PCI0.LPCB.EC__._Q0A()
            \_SB_.PCI0.LPCB.EC__._Q0B()

            Store (OEM2, OEM8)
        }
    }
}