From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Apr 2013 15:41:52 +0000
Subject: Re: [PATCH 16/30] ARM: shmobile: sh7372: use fixed ratio clock
Message-Id: <201304021541.52531.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
 <1364879246-9470-17-git-send-email-horms+renesas@verge.net.au>
 <515ACC46.9020402@cogentembedded.com>
In-Reply-To: <515ACC46.9020402@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 02 April 2013, Sergei Shtylyov wrote:
> > @@ -83,39 +84,12 @@ struct clk sh7372_extal2_clk = {
> [...]
> > +SH_FIXED_RATIO_CLKg(sh7372_dv_clki_div2_clk, sh7372_dv_clki_clk,     div2);
> > +SH_FIXED_RATIO_CLK(extal1_div2_clk,          sh7372_extal1_clk,      div2);
> > +SH_FIXED_RATIO_CLK(extal2_div2_clk,          sh7372_extal2_clk,      div2);
> > +SH_FIXED_RATIO_CLK(extal2_div4_clk,          extal2_div2_clk,        div2);
> 
>     Note that SH_FIXED_RATIO_CLK() definition already includes ; -- it 
> probably should be removed from there.

Most macros that we have in the kernel like this don't include the semicolon,
which seems better since it is harder to misuse (the compiler will complain
about a missing semicolon but not always about an extranous one) and gives
a more consistent syntax overall.

It's probably not worth changing it now for the shmobile clock code, since
that is getting changed over to common clock in the future, but you may
want to remember this for future macro definitions.

	Arnd
