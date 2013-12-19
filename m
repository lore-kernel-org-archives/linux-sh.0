From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Dec 2013 11:34:33 +0000
Subject: Re: [PATCH v5 00/17] Lager and Koelsch multiplatform support
Message-Id: <20131219113431.GA15603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387034741-3852-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387034741-3852-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Sat, Dec 14, 2013 at 04:25:24PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> This is the fourth version of the patch set that moves the lager-reference and
> koelsch-reference boards to multiplatform kernel. It starts by syncing the
> non-reference DTSes with the reference DTSes (01/17 and 02/17), setting the
> external clock frequency in DT (03/17 and 04/17), adding CCF support to the
> -reference boards (05/17 to 09/17), and cleaning up unneeded leftovers (10/17
> to 17/17).

I have queued patches 1 - 14 of v4 of this series (sorry for missing v5,
but I believe the code is the same) for v3.14.

I made a slight modification to patch 11 ("ARM: shmobile: Remove
non-multiplatform Koelsch reference support") which was to drop the
arch/arm/boot/dts/Makefile portion of the change.

This is because the DT portion koelsch-reference doesn't actually exist in
the boards branch, which seems to be the most relevant place to make this
change. Could you please submit that portion of the patch separately
with a repost of patch 15. I'm quite happy if you squash it all into
one patch.

I have not queued up patches 16 and 17 as I believe they create
what Olof would call a circular branch dependency:


       +------> dt ------+
soc ---+                 +----> soc
       +----> boards ----+

As they just remove stuff I suggest holding them over until v3.15.





> 
> The net result are multiplatform-only lager-reference and koelsch-reference
> boards with a DTSes shared by the reference and non-reference boards.
> 
> The code is available in my git tree at
> 
>         git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/rcar-gen2-boards
> 
> It has been tested on both the Lager and Koelsch boards.
> 
> Changes since v4:
> 
> - Rebased on top of renesas-devel-v3.13-rc3-20131214v2
> - Added patch 17/17

> 
> Changes compared to v3:
> 
> - Rebase on top of the fourth version of the R-Car Gen2 CCF patches
> - Initialize clocks in rcar_gen2_timer_init()
> 
> Changes compared to v2:
> 
> - Rebase on top of the third version of the R-Car Gen2 CCF patches
> - Add Koelsch board multiplatform support
> 
> Changes compared to v1:
> 
> - Rebase on top of the second version of the r8a7790 CCF patches
> 
> Laurent Pinchart (17):
>   ARM: shmobile: Sync Lager DTS with Lager reference DTS
>   ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS
>   ARM: shmobile: lager: Specify external clock frequency in DT
>   ARM: shmobile: koelsch: Specify external clock frequency in DT
>   ARM: shmobile: rcar-gen2: Initialize CCF before clock sources
>   ARM: shmobile: lager-reference: Enable multiplaform kernel support
>   ARM: shmobile: koelsch-reference: Remove duplicate CCF initialization
>   ARM: shmobile: lager-reference: Instantiate clkdevs for SCIF and CMT
>   ARM: shmobile: koelsch-reference: Instantiate clkdevs for SCIF and CMT
>   ARM: shmobile: Remove non-multiplatform Lager reference support
>   ARM: shmobile: Remove non-multiplatform Koelsch reference support
>   ARM: shmobile: Let Lager multiplatform boot with Lager DTB
>   ARM: shmobile: Let Koelsch multiplatform boot with Koelsch DTB
>   ARM: shmobile: Remove Lager reference DTS
>   ARM: shmobile: Remove Koelsch reference DTS
>   ARM: shmobile: r8a7790: Remove legacy clock aliases for DT devices
>   ARM: shmobile: r8a7791: Remove legacy clock aliases for DT devices
> 
>  arch/arm/boot/dts/Makefile                       |   5 +-
>  arch/arm/boot/dts/r8a7790-lager-reference.dts    |  89 ------------------
>  arch/arm/boot/dts/r8a7790-lager.dts              |  57 +++++++++++
>  arch/arm/boot/dts/r8a7791-koelsch-reference.dts  | 115 -----------------------
>  arch/arm/boot/dts/r8a7791-koelsch.dts            |  87 +++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                   |  30 ++----
>  arch/arm/mach-shmobile/Makefile                  |   3 +-
>  arch/arm/mach-shmobile/Makefile.boot             |   2 -
>  arch/arm/mach-shmobile/board-koelsch-reference.c |  30 +++++-
>  arch/arm/mach-shmobile/board-lager-reference.c   |  32 +++++++
>  arch/arm/mach-shmobile/clock-r8a7790.c           |  11 ---
>  arch/arm/mach-shmobile/clock-r8a7791.c           |   1 -
>  arch/arm/mach-shmobile/setup-rcar-gen2.c         |   8 +-
>  13 files changed, 222 insertions(+), 248 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts
>  delete mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
