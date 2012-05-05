From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 05 May 2012 19:21:12 +0000
Subject: Re: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
Message-Id: <201205051921.13209.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205050722.45500.arnd@arndb.de> <201205052108.03001.rjw@sisk.pl>
In-Reply-To: <201205052108.03001.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Saturday 05 May 2012, Rafael J. Wysocki wrote:
> Now, if you insist on us having a separate mach- directory for every platform
> (SoC), we can do that I think, but then we should start with splitting up the
> existing mach-shmobile into a number of SoC-specific directories rather than
> adding new mach- directories for random new parts, because that goes against
> our development history to date, which is important too IMHO.

All the chips in there so far share a common ancestry and they all use a
significant subset of the same drivers shared with arch/sh: i2c-sh_mobile,
sh-dma-engine, sh_cmt, sh-sci, sh_tmu, intc, pfc and sh_clk. AFAICT, this one
uses none of those and apparently was developed by NEC before the merger with
Renesas.

	Arnd
