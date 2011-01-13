From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 22:43:45 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh7372: fixup pllc2 set_rate
Message-Id: <20110113224345.GD20418@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 11, 2011 at 02:11:20PM +0900, Kuninori Morimoto wrote:
> This patch fixup 421b446abeec55bed1251fab80cb5c12be58b773
>  - Care clk->rate
>  - Don't over write PLLC2 enable bit
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> Guennadi
> 
> Thank you for your report about it.
> Is this patch solve your issue ?
> I tested this patch on ap4evb, mackerel on Paul's rmobile-latest.
> 
Guennadi, please give this a test when you have a chance. If it fixes
the issues you were seeing then it's also suitable as a -stable
candidate.
