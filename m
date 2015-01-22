From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Jan 2015 00:01:06 +0000
Subject: Re: [PATCH 00/11] r8a7778 CCF and multiplatform
Message-Id: <3495680.rgt4LlyhO6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patches.

On Wednesday 21 January 2015 17:20:51 Ulrich Hecht wrote:
> Hi!
> 
> Here's the CCF/MP support for r8a7778 and Bock-W.  It consists of the CCF
> driver, a couple of extra DT devices, and multiplatform enablement.  To keep
> disruption to a minimum it leaves the existing legacy platforms in place
> for now.

Have we reached feature parity with the legacy C platforms ? If so, when do 
you think they should be removed ? If not, what is missing ?

> Morimoto-san, it'd be nice if you could give me some feedback on the sound
> device descriptions because a) I have no clue what I'm doing there, and b) I
> only have remote access to the Bock-W board and thus no way to test if this
> works...
> 
> Thanks for your help.
> 
> CU
> Uli
> 
> Ulrich Hecht (11):
>   ARM: shmobile: r8a7778: synchronize dts with reference platform
>   ARM: shmobile: r8a7778: add CPG register bits header
>   ARM: shmobile: r8a7778: Common clock framework DT description
>   ARM: shmobile: r8a7778: common clock framework CPG driver
>   ARM: shmobile: r8a7778: add MSTP clock assignments to DT
>   ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
>   ARM: shmobile: bockw: add pins and clock to ethernet controller in DT
>   ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
>   ARM: shmobile: r8a7778: add sound to DT
>   ARM: shmobile: bockw: add sound to DT
>   ARM: shmobile: r8a7778: enable multiplatform target

I've reviewed the whole series except for patch 09 and 10. For patches 01, 02, 
03, 06 and 08,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I don't have additional comments in addition to the point that Sergei already 
raised for patch 11.

>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
>  .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  24 ++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/r8a7778-bockw.dts                | 177 ++++++++++++++
>  arch/arm/boot/dts/r8a7778.dtsi                     | 263 ++++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                     |   4 +
>  arch/arm/mach-shmobile/board-bockw-reference.c     |   2 +
>  arch/arm/mach-shmobile/setup-r8a7778.c             |  19 ++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-r8a7778.c                 | 146 ++++++++++++
>  include/dt-bindings/clock/r8a7778-clock.h          |  72 ++++++
>  include/linux/clk/shmobile.h                       |   1 +
>  12 files changed, 711 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
>  create mode 100644 drivers/clk/shmobile/clk-r8a7778.c
>  create mode 100644 include/dt-bindings/clock/r8a7778-clock.h

-- 
Regards,

Laurent Pinchart

