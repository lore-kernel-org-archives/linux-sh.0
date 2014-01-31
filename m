From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:36:06 +0000
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Message-Id: <8761p07lx8.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Hi Simon

These are v2 of updates code for R-Car.
I separated v1 patches into for mmc, and for SH-ARM.
This is "SH-ARM" part patches.

These need my previous mmc part patches.

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: removed unnecessary mmc option
      ARM: shmobile: r8a7779: removed unnecessary mmc option
      ARM: shmobile: r8a7790: removed unnecessary mmc option

 arch/arm/boot/dts/r8a7778.dtsi |    6 ------
 arch/arm/boot/dts/r8a7779.dtsi |    8 --------
 arch/arm/boot/dts/r8a7790.dtsi |    4 ----
 3 files changed, 18 deletions(-)
