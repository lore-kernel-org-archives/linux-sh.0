From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Nov 2011 08:04:10 +0000
Subject: Re: [PATCH 11/20] ARM: mach-shmobile: R-Mobile A1 support.
Message-Id: <20111111080410.GJ29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87lirn9y1u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lirn9y1u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 10, 2011 at 06:45:52PM -0800, Kuninori Morimoto wrote:
> This adds preliminary support for the R8A7740 (R-Mobile A1) CPU
> 
> Timer, serial, gic, clock are supported at this point.
> This patch is based on v0.1 manual

On Thu, Nov 10, 2011 at 06:46:08PM -0800, Kuninori Morimoto wrote:
> This adds PFC support for the R8A7740 (R-Mobile A1) CPU
> This patch is based on v0.1 manual

On Thu, Nov 10, 2011 at 06:46:23PM -0800, Kuninori Morimoto wrote:
> This patch adds I2C support to r8a7740 CPU
> which has lasting errata on I2C I/O pad reset.
> This patch is including work-around.

On Thu, Nov 10, 2011 at 06:46:35PM -0800, Kuninori Morimoto wrote:
> R8A7740 GIC can not get external IRQx interrupt directly
> without GIC - INTC demux support.
> 
> Current AG5 is using GIC - INTCS demux with
> special irq relocation. but GIC - INTCA demux
> is still not supported and it needs irq number re-mapping.
> 
> OTOH, normal INTC support as before is very enough for R8A7740,
> because it is not SMP CPU.
> This patch adds INTCA/INTCS support instead of GIC.

All of these have been applied to the rmobile/a1 topic branch and
subsequently pulled in to rmobile-latest.
