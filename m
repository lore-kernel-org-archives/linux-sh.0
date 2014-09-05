From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Sep 2014 16:15:49 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.18
Message-Id: <201409051815.49836.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 04 September 2014, Simon Horman wrote:
> Renesas ARM Based SoC Kconfig Cleanups for v3.18
> 
> * Update name of "R-Car M2-W" SoC (previously there was no "-W")
> * Consolidate Legacy SH_CLK_CPG and CPU_V7 Kconfig
> * Only select PM_RMOBILE for legacy case
> * Cleanup pm-rcar.o and pm-rmobile.o build using Kconfig
> 

Merged into next/cleanup, thanks!

	Arnd
