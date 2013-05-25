From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 May 2013 01:53:36 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: implement CPU clock scaling for CPUFreq
Message-Id: <20130525015336.GK24005@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305211202380.2863@axis700.grange>
 <20130525013252.GD24005@verge.net.au>
In-Reply-To: <20130525013252.GD24005@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, May 25, 2013 at 10:32:53AM +0900, Simon Horman wrote:
> On Tue, May 21, 2013 at 12:09:53PM +0200, Guennadi Liakhovetski wrote:
> > This patch adds support for the Z-clock on r8a7790 SoCs, which is driving
> > the Cortex A15 core. Adding an "operating-points" property to the CPU0 DT
> > node and a regulator, this patch allows platforms to use the generic
> > cpufreq-cpu0 driver to use SoC's DVFS capabilities.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> > 
> > Since I cannot use the regulator, supplying the DVFS voltage to the CPU on 
> > Lager, I only tested this patch without voltage adjustments, but that 
> > shouldn't matter for this specific change. I did verify, using the 
> > ondemand CPUFreq governor, that the frequency and the CPU performance 
> > change, depending on CPU load.
> 
> Magnus,
> 
> could you please review this series?

I noticed there is a v2 of the series, could you review that instead?
