// This is a hotpatch for HASEE (K650D-i5 D2) to disabling discrete graphics in dual-GPU laptops.
// In config ACPI, _REG renamed XREG
// Find:     <115f5245 4702>
// Replace:  <11585245 4702>
// In config ACPI, _WAK renamed XWAK
// Find:     <5f57414b 09>
// Replace:  <5857414b 09>
// In config ACPI, SGOF renamed XGOF
// Find:     <53474f46 08>
// Replace:  <58474f46 08>
// In config ACPI, _INI renamed XINI
// Find:     <5f494e49 0070005c 2f>
// Replace:  <58494e49 0070005c 2f>
DefinitionBlock("", "SSDT", 2, "hack", "D-GPU", 0)
{
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.XINI, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP.CCHK, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP.SPP0, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.XREG, MethodObj)
    External (_SB_.PCI0.LPCB.EC__.ECOK, IntObj)
    External (_SB_.PCI0.LPCB.EC__.GPUT, FieldUnitObj)
    External (XWAK, MethodObj) 

    External (P80H, FieldUnitObj)
    External (EECP, FieldUnitObj)
 
     
    Scope(_SB.PCI0.PEG0.PEGP)
    {
        External (LCTL, FieldUnitObj)
        External (SVID, FieldUnitObj)
        External (SDID, FieldUnitObj)
        External (LNKD, FieldUnitObj)
        External (LNKS, FieldUnitObj)
        External (EMLW, FieldUnitObj)
        External (GP50, FieldUnitObj)
        External (GP54, FieldUnitObj)
        External (GP74, FieldUnitObj)
        
        External (ONOF, IntObj)
        External (ELCT, IntObj)
        External (HVID, IntObj)
        External (HDID, IntObj)
        External (DMLW, IntObj)
        
        Method (_INI)
        {
            XINI() // call original _INI, now renamed XINI
            _OFF()
        }
        
        Method (SGOF, 0)
        {
            Store (0x8E, P80H)
            If (LEqual (CCHK (Zero), Zero))
            {
                Return (Zero)
            }

            Store (Zero, ONOF)
            Store (LCTL, ELCT)
            Store (SVID, HVID)
            Store (SDID, HDID)
            Store (EMLW, DMLW)
            SPP0 ()
            Store (One, LNKD)
            While (LNotEqual (LNKS, Zero))
            {
                Sleep (One)
            }

            Sleep (0x64)
            Store (Zero, GP50)
            Stall (0x64)
            Store (One, GP54)
            Store (One, GP74)
            Sleep (0x012C)
            Store (0x8F, P80H)
            Return (Zero)
        }
    }

    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (RME3, EmbeddedControl, 0x00, 0xFF)
        Method (_REG, 2)
        {
            XREG(Arg0, Arg1) // call original _REG, now renamed XREG
            If (3 == Arg0 && 1 == Arg1)
            {
                If (ECOK)
                {
                    Store (Zero, GPUT)
                }
            }
        }
    }
    
    Scope (\)
    {
        Method (_WAK, 1)
        {
            If (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF))
            {
                \_SB.PCI0.PEG0.PEGP._OFF()
            }
            Return (XWAK(Arg0)) // call original _WAK, now renamed XWAK
        }
    }
}