From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 19 Nov 2014 21:05:56 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Soc Updates for v3.19
Message-Id: <201411192205.57149.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415058939.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 04 November 2014, Simon Horman wrote:
> ----------------------------------------------------------------
> Renesas ARM Based SoC Soc Updates for v3.19
> 
> * Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled
> * Add CA7 arch_timer initialization for r8a7794
> * Handle CA7 arch timer delay
> * Add shmobile_init_late() to sh7372
>   - This is consistent with other shmobile SoCs

Pulled into next/soc.

Note that the CONFIG_ZONE_DMA change might not be the best solution, we should
probably have CONFIG_ZONE_DMA32 instead as some other architectures do, so
you can use the entire lowmem area for DMA allocations.

	Arnd
