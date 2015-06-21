From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 08:09:03 +0000
Subject: [PATCH 00/08] clocksource: sh_cmt: DT binding rework
Message-Id: <20150621080903.10187.20998.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

clocksource: sh_cmt: DT binding rework

[PATCH 01/08] devicetree: bindings: Remove sh7372 CMT binding
[PATCH 02/08] clocksource: sh_cmt: Use 0x3f mask for SH_CMT_48BIT case
[PATCH 03/08] devicetree: bindings: R-Car Gen2 CMT0 and CMT1 bindings
[PATCH 04/08] clocksource: sh_cmt: Support separate R-Car Gen2 CMT0/1
[PATCH 05/08] devicetree: bindings: r8a73a4 and R-Car Gen2 CMT bindings
[PATCH 06/08] ARM: shmobile: Update CMT compat string users in DTS
[PATCH 07/08] devicetree: bindings: Deprecate property, update example
[PATCH 08/08] ARM: shmobile: Remove CMT renesas,channels-mask from DTS

This series reworks the CMT DT bindings to try to deal with the following:
- R-Car Gen2 CMT0 and CMT1 hardware instances are not identical
- The property renesas,channels-mask is not enough to describe the difference
- DT should describe the hardware, not the software implementation
- Not all documented DT bindings are actually used

Without these patches the binding "renesas,cmt-48-gen2" is used for both
CMT0 and CMT1 on R-Car Gen2 SoCs. CMT0 and CMT1 are currently seen by the
Linux device driver as compatible hardware, and the device-specific property
"renesas,channels-mask" is used to point out some of the hardware configuration
differences. Since the driver is not feature complete only some differences are
described and when diving into the data sheet we can see that:

1) CMT0 is not 48-bit at all, instead it only supports 32-bit counters.
2) Some channels of CMT1 are 48-bit, some 32-bit.
3) A couple of CMT1 channels have even more features.

It turns out that none of the above differences are described in our current
DT files. And since we use the same compat string for CMT0 and CMT1 the driver
itself cannot enable features specific only to CMT1 without first updating
the DTS. So this series is ground work for future feature patches.

It seems that we have two choices if we want to support CMT1 features:
A) Keep existing DT bindings, add more properties for CMT1
B) Rework the compatible strings and keep configuration in the driver

Judging by above it seems that DT update is inevitable. In my mind it is
rather painful to update the DT so I'd like to minimize the number of
updates and let the majority of the changes only happen in the driver.
And since we should really describe hardware in DT but driver features tend
to be implemented incrementally then B) seems like a good fit to me.

I wouldn't mind going with A) but to be honest I must say that the existing
compat string "renesas,cmt-48-gen2" is just too confusing with "48"
(when CMT0 is 32bit-only) and also "gen2" (used without product line R-Car).

Because of that I've gone with B) and reworked the bindings to separate
CMT0 from CMT1 and keep channel configuration in the device driver.

While at it I've deprecated "renesas,channels-mask" and the old DT compat
strings. Per-SoC compat strings have also been reworked, but are not left
around documented as deprecated since they were never used by the driver.

Comments are very welcome! If all are in favor then it would be good to
merge patch 1-5 first and patch 6-8 later once 1-5 are in. Old DTBs are
left working but treated as low-feature CMT0. New DTBs including patch 6-8
will not work on old kernels.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

Written against renesas-devel-20150619-v4.1-rc8

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   55 +++++++++------
 arch/arm/boot/dts/r8a73a4.dtsi                          |    5 -
 arch/arm/boot/dts/r8a7740.dtsi                          |    3 
 arch/arm/boot/dts/r8a7790.dtsi                          |   10 --
 arch/arm/boot/dts/r8a7791.dtsi                          |   10 --
 arch/arm/boot/dts/r8a7793.dtsi                          |   10 --
 arch/arm/boot/dts/r8a7794.dtsi                          |   10 --
 arch/arm/boot/dts/sh73a0.dtsi                           |    3 
 drivers/clocksource/sh_cmt.c                            |   54 ++++++++++----
 9 files changed, 83 insertions(+), 77 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
