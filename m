From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 07 Feb 2014 08:30:19 +0000
Subject: [PATCH 0/2]: ARM: shmobile: lager: add SDHI0/2 support for legacy/DT
Message-Id: <87txcbba08.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon
Cc Magnus

These are new style of SDHI0/2 support for Lager.
Please ignore my previous

       Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
       Date: Fri, 31 Jan 2014 14:36:06 +0900

I created these new style SDHI patches because
SDHI maintainer's response is very slow,
and Simon is working for LTSI backporting.
My previous SDHI patch for DT had dependency with SDHI side patch,
and this means SDHI DT support on lager will be slow.
This is not good for LTSI backporting.
So, #2 is now doesn't have relationship with SDHI driver patch.
These can be applied immediately.
#2 has DT option settigns now, but these will be cleanuped
if SDHI driver patch was applied.

These patches are based on renesas-devel-v3.14-rc1-20140207.
and #2 needs regulater maintainer's branch

    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git :: topic/gpio

**Note**

- DT version kenel seems has pm_runtime issue.
  So, if you disconnect SD card, it is never probed again.
  Ben Dooks had sent solution patch for this issue on below,
  but it seems quick hack at this point ?

      Subject: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
      Date:	Sat, 11 Jan 2014 13:06:29 +0000

- DT version kenel seems has clock issue on SDHI.
  it prints strange frequency for SDHI0 when boot today.
  but, HW settings / datasheet seems OK now. maybe it is CCF issue ?

Kuninori Morimoto (2):
      ARM: shmobile: lager: add SDHI0/2 support
      ARM: shmobile: lager: add SDHI0/2 support on DTS

 arch/arm/boot/dts/r8a7790-lager.dts  |   84 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c |   65 ++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

Best regards
---
Kuninori Morimoto
