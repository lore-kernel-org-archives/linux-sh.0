From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Dec 2014 16:30:13 +0000
Subject: Re: [PATCH v4 0/6] clk: shmobile: r8a73a4 common clock framework implementation
Message-Id: <13783283.DgS5U4lGcj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418833134-7863-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418833134-7863-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wednesday 17 December 2014 17:18:48 Ulrich Hecht wrote:
> Hi!
> 
> Version 4 of the CCF implementation for r8a73a4.  This version removes some
> unused bits from the CPG driver and adds a few acks.  Suggestions on how to
> proceed with this are highly appreciated.

I think the patch set is ready to be merged. If I'm not mistaken Geert plans 
to take it in his tree and submit the appropriate pull requests.

> Changes since v3:
> - CPG: removed unused divider mask and flags, superflous braces
> - added Acked-bys
> 
> Changes since v2:
> - fixed zb parents
> - fixed CPG clock order in header file
> - multiply divider by 32 for z and z2 clocks
> - added acks by Mike and Laurent
> - fixed various formatting issues
> 
> Changes since v1:
> - use clock-indices instead of renesas,clock-indices
> - dump unused extal2_div2_clk and extal2_div4_clk
> - move mstp2 clocks property below interrupt-names
> 
> 
> Ulrich Hecht (6):
>   clk: shmobile: r8a73a4 common clock framework implementation
>   clk: shmobile: Add r8a73a4 SoC to MSTP bindings
>   ARM: shmobile: r8a73a4: Add CPG register bits header
>   ARM: shmobile: r8a73a4: Common clock framework DT description
>   ARM: shmobile: ape6evm: disable legacy clock initialization
>   ARM: shmobile: r8a73a4: add MSTP clock assignments to DT
> 
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
>  .../bindings/clock/renesas,r8a73a4-cpg-clocks.txt  |  33 +++
>  arch/arm/boot/dts/r8a73a4.dtsi                     | 324 ++++++++++++++++++
>  arch/arm/mach-shmobile/board-ape6evm-reference.c   |   3 +-
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-r8a73a4.c                 | 241 +++++++++++++++
>  include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++++
>  7 files changed, 664 insertions(+), 1 deletion(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,r8a73a4-cpg-clocks.txt
> create mode 100644 drivers/clk/shmobile/clk-r8a73a4.c
>  create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h

-- 
Regards,

Laurent Pinchart

