From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 18:11:18 +0000
Subject: [PATCH 0/5 v2 RFC] R-Car Gen2 PCIe host driver
Message-Id: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Phil Edworthy <phil.edworthy@renesas.com>

This is version 2 of a PCIe Host driver for the R-Car Gen2 devices,
i.e. R-Car H2 (r8a7790) and R-Car M2 (r8a7791). All changes are in patch 1,
the other patches are the same.

Still RFC as there is some work required for DT support.

All feedback welcome!
Phil

root@koelsch:~# lspci -vv
00:00.0 PCI bridge: Renesas Technology Corp. Device 001f (prog-if 00 [Norma=
l decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64n=
s, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- Tr=
ansPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s, Latency L=
0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLAct=
ive+ BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-=
 CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LT=
R-, OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR25=
6-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
                        Status: NegoPending- InProgress-
        Capabilities: [1b0 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Kernel driver in use: pcieport

01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connect=
ion (rev 01)
        Subsystem: Intel Corporation Ethernet Server Adapter I350-T2
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 148
        Region 0: Memory at 30000000 (32-bit, non-prefetchable) [size=3D1M]
        Region 3: Memory at 30200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] MSI-X: Enable- Count=10 Masked-
                Vector table: BAR=3D3 offset=00000000
                PBA: BAR=3D3 offset=00002000
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512=
ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsup=
ported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tr=
ansPend-
                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latenc=
y L0 <4us, L1 <32us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLAct=
ive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+,=
 OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-23-18-c0
        Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 1
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
                IOVSta: Migration-
                Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function De=
pendency Link: 00
                VF offset: 384, stride: 4, Device ID: 1520
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 0000000000000000 (64-bit, prefetchable)
                Region 3: Memory at 0000000000000000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0
        Capabilities: [1a0 v1] Transaction Processing Hints
                Device specific mode supported
                Steering table in TPH capability structure
        Capabilities: [1c0 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [1d0 v1] Access Control Services
                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Kernel driver in use: igb
        Kernel modules: igb

01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connect=
ion (rev 01)
        Subsystem: Intel Corporation Ethernet Server Adapter I350-T2
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 148
        Region 0: Memory at 30100000 (32-bit, non-prefetchable) [size=3D1M]
        Region 3: Memory at 30204000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] MSI-X: Enable- Count=10 Masked-
                Vector table: BAR=3D3 offset=00000000
                PBA: BAR=3D3 offset=00002000
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512=
ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsup=
ported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ Tr=
ansPend-
                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Latenc=
y L0 <4us, L1 <32us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ DLAct=
ive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+,=
 OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Capabilities: [140 v1] Device Serial Number a0-36-9f-ff-ff-23-18-c0
        Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
                IOVSta: Migration-
                Initial VFs: 8, Total VFs: 8, Number of VFs: 0, Function De=
pendency Link: 01
                VF offset: 384, stride: 4, Device ID: 1520
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 0000000000000000 (64-bit, prefetchable)
                Region 3: Memory at 0000000000000000 (64-bit, prefetchable)
                VF Migration: offset: 00000000, BIR: 0
        Capabilities: [1a0 v1] Transaction Processing Hints
                Device specific mode supported
                Steering table in TPH capability structure
        Capabilities: [1d0 v1] Access Control Services
                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamF=
wd- EgressCtrl- DirectTrans-
        Kernel driver in use: igb
        Kernel modules: igb

Phil Edworthy (5):
  PCI: host: Add Renesas R-Car PCIe driver
  ARM: shmobile: r8a7791: Add PCIe clock
  ARM: shmobile: Add PCIe resources to r8a7791 device
  ARM: shmobile: Add PCIe to r8a7791 device Kconfig
  ARM: koelsch: Add PCIe to defconfig

 arch/arm/configs/koelsch_defconfig     |    3 +
 arch/arm/mach-shmobile/Kconfig         |    2 +
 arch/arm/mach-shmobile/clock-r8a7791.c |    3 +
 arch/arm/mach-shmobile/setup-r8a7791.c |   13 +
 drivers/pci/host/Kconfig               |    6 +
 drivers/pci/host/Makefile              |    1 +
 drivers/pci/host/pcie-rcar.c           |  588 ++++++++++++++++++++++++++++=
++++
 drivers/pci/host/pcie-rcar.h           |   82 +++++
 10 files changed, 716 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pcie-rcar.c
 create mode 100644 drivers/pci/host/pcie-rcar.h

--=20
1.7.9.5

