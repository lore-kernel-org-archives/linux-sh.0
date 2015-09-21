From: Rob Herring <robh@kernel.org>
Date: Mon, 21 Sep 2015 14:25:43 +0000
Subject: Re: [PATCH v2 00/11] clocksource: sh_cmt: DT binding rework V2
Message-Id: <56001367.5040403@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
In-Reply-To: <20150917095325.5369.73893.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, tglx@linutronix.de

On 09/17/2015 04:53 AM, Magnus Damm wrote:
> clocksource: sh_cmt: DT binding rework V2
> 
> [PATCH v2 01/11] devicetree: bindings: Remove sh7372 CMT binding
> [PATCH v2 02/11] clocksource: sh_cmt: Use 0x3f mask for SH_CMT_48BIT case
> [PATCH v2 03/11] devicetree: bindings: R-Car Gen2 CMT0 and CMT1 bindings
> [PATCH v2 04/11] clocksource: sh_cmt: Support separate R-Car Gen2 CMT0/1
> [PATCH v2 05/11] devicetree: bindings: r8a73a4 and R-Car Gen2 CMT bindings
> [PATCH v2 06/11] ARM: shmobile: Update CMT compat string users in DTS
> [PATCH v2 07/11] devicetree: bindings: Deprecate property, update example
> [PATCH v2 08/11] ARM: shmobile: Remove CMT renesas,channels-mask from DTS
> [PATCH v2 09/11] devicetree: bindings: Remove unused 32-bit CMT bindings
> [PATCH v2 10/11] clocksource: sh_cmt: Remove unused 32-bit CMT bindings
> [PATCH v2 11/11] devicetree: bindings: Remove deprecated properties
> 
> This series reworks the CMT DT bindings to try to deal with the following:
> - R-Car Gen2 CMT0 and CMT1 hardware instances are not identical
> - The property renesas,channels-mask is not enough to describe the difference
> - DT should describe the hardware, not the software implementation
> - Not all documented DT bindings are actually used
> 
> Without these patches the binding "renesas,cmt-48-gen2" is used for both
> CMT0 and CMT1 on R-Car Gen2 SoCs. CMT0 and CMT1 are currently seen by the
> Linux device driver as compatible hardware, and the device-specific property
> "renesas,channels-mask" is used to point out some of the hardware configuration
> differences. Since the driver is not feature complete only some differences are
> described and when diving into the data sheet we can see that:
> 
> 1) CMT0 is not 48-bit at all, instead it only supports 32-bit counters.
> 2) Some channels of CMT1 are 48-bit, some 32-bit.
> 3) A couple of CMT1 channels have even more features.
> 
> It turns out that none of the above differences are described in our current
> DT files. And since we use the same compat string for CMT0 and CMT1 the driver
> itself cannot enable features specific only to CMT1 without first updating
> the DTS. So this series is ground work for future feature patches.
> 
> It seems that we have two choices if we want to support CMT1 features:
> A) Keep existing DT bindings, add more properties for CMT1
> B) Rework the compatible strings and keep configuration in the driver
> 
> Judging by above it seems that DT update is inevitable. In my mind it is
> rather painful to update the DT so I'd like to minimize the number of
> updates and let the majority of the changes only happen in the driver.
> And since we should really describe hardware in DT but driver features tend
> to be implemented incrementally then B) seems like a good fit to me.

Agreed.

For 1, 3. 5, 7, 9, 11:

Acked-by: Rob Herring <robh@kernel.org>

> 
> I wouldn't mind going with A) but to be honest I must say that the existing
> compat string "renesas,cmt-48-gen2" is just too confusing with "48"
> (when CMT0 is 32bit-only) and also "gen2" (used without product line R-Car).
> 
> Because of that I've gone with B) and reworked the bindings to separate
> CMT0 from CMT1 and keep channel configuration in the device driver.
> 
> While at it I've deprecated "renesas,channels-mask" and the old DT compat
> strings. Per-SoC compat strings have also been reworked, but are not left
> around documented as deprecated since they were never used by the driver.
> 
> Comments are very welcome! If all are in favor then it would be good to
> merge patch 1-5 first and patch 6-8 later once 1-5 are in. Old DTBs are
> left working but treated as low-feature CMT0. New DTBs including patch 6
> will not work on old kernels.
> 
> V2 patch series fixes patch 1-2 and adds patches 9, 10, 11.
> Patch 9 and 10 cleans up r8a7740 and sh73a0 bindings.
> Patch 11 removes deprecated properties as proposed by Laurent.
> 
> Many thanks to Geert and Laurent for feedback!
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> (For patch 1-8)
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (For patch 1-8)
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> (For patch 1-7)
> ---
> 
>  Written against renesas-drivers-2015-09-15-v4.3-rc1
> 
>  Documentation/devicetree/bindings/timer/renesas,cmt.txt |   85 ++++++---------
>  arch/arm/boot/dts/r8a73a4.dtsi                          |    5 
>  arch/arm/boot/dts/r8a7740.dtsi                          |    3 
>  arch/arm/boot/dts/r8a7790.dtsi                          |   10 -
>  arch/arm/boot/dts/r8a7791.dtsi                          |   10 -
>  arch/arm/boot/dts/r8a7793.dtsi                          |   10 -
>  arch/arm/boot/dts/r8a7794.dtsi                          |   10 -
>  arch/arm/boot/dts/sh73a0.dtsi                           |    3 
>  drivers/clocksource/sh_cmt.c                            |   54 ++++++---
>  9 files changed, 85 insertions(+), 105 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

