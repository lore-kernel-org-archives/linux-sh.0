From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 05:36:37 +0000
Subject: Re: Question about clk->usecount
Message-Id: <20111028053637.GA32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 24, 2011 at 05:44:25PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> renesas_usbhs and sh_eth seems break in SH7724 ecovec board
> from 794d78fea51504bad3880d14f354a9847f318f25 (drivers: sh: late disabling of clocks V2)
> So I debuged it.
> 
> when these driver call pm_runtime_get_sync(),
> then, arch/sh/kernel/cpu/hwblk.c :: hwblk_enable() are called,
> and it enabled MSTP bit.
> This is OK.
> 
> But clk_late_init() disabled it.
> 
> Does hwblk/pm_runtime (?) not care clk->usecount ?

I suspect this is a result of hwblk bitrot with regards to the rest of
the runtime PM changes. We can of course simply inhibit the late clock
disabling, but the proper solution would be to fix up (or simply kill
off) the hwblk bits completely.

We can also just add a kernel command line option for inhibiting the late
disable for testing/development cases, but this is not something we'd
want to rely on in general.
