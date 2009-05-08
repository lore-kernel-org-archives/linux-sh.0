From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 08 May 2009 02:39:12 +0000
Subject: Re: [PATCH] sh: sh7785 early scif fix
Message-Id: <20090508023911.GB26125@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090507101744.31631.58621.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090507101744.31631.58621.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 07, 2009 at 07:17:44PM +0900, Magnus Damm wrote:
> This patch moves the SH4 case of EARLY_SCIF_CONSOLE_PORT
> so the SH7785 default value gets used. Without this patch
> the value for SH7785 is set to 0xffe80000.

On Thu, May 07, 2009 at 07:31:39PM +0900, Magnus Damm wrote:
> Make sure that clk->ops->init() only gets called once in
> the case of CLK_ALWAYS_ENABLED. Without this patch the
> init() callback may be called multiple times.

On Thu, May 07, 2009 at 07:44:55PM +0900, Magnus Damm wrote:
> Update the r7785 highlander defconfig to fix
> PCLK value and that mode4 is set high.

On Thu, May 07, 2009 at 07:55:37PM +0900, Magnus Damm wrote:
> This patch adds TMU platform data for sh7785. Both clockevent
> and clocksource support is enabled.

I've applied these, thanks.
