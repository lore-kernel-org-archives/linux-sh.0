From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:31:04 +0000
Subject: Re: [PATCH 0/27] ARM: shmobile: resend patch set
Message-Id: <877gvcyizv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4aqzhd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4aqzhd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Paul
Cc Magnus, Simon

> These are resend/rebase version of my patch set (which are not applied yet)
> It includes below patch set
> 	[PATCH 0/11] ARM: mach-shmobile: armadillo: add FSI/HDMI/Camera support
> 	[PATCH 0/2]  ARM: mach-shmobile: kzm9g: add FSI support
> 	[PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
> 	[PATCH][RFC] ARM: mach-shmobile: sh73a0: bugfix: SY-DMAC number
> 	[PATCH 0/9]  ARM: mach-shmobile: r8a7740: add DMAEngine support
> 	[PATCH 0/2]  ARM: mach-shmobile: kzm9g: add FSI DMAEngine support
> 
> The diff are...
> 	- all-in-one patch set
> 	- I added what/why on log area as much as possible
> 	- Subject : mach-shmobile -> shmobile 
> 	- Subject : "add xxx support" -> "enable xxxx" on platform patch
>         - based on latest linus/master branch
>
> Some of these patches have "WARNING: line over 80 characters" from checkpatch.pl
> on setup/clock/pfc files.
> But these are bacause traditional(?) its style.

These are v2 patch set

v1 -> v2

 - TS_SHIFT    -> static dma_ts_shift    on header
 - USBTS_SHIFT -> static dma_usbts_shift on header
 - #include <asm/io.h> -> #include <linux/io.h>
 - camera clock initialize on ->power function
 - Simon's Tested-by is added

Best regards
---
Kuninori Morimoto
