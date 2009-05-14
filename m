From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 14 May 2009 12:27:03 +0000
Subject: Re: [PATCH] sh: remove old TMU driver
Message-Id: <20090514122703.GA9256@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 19:25 Tue 12 May     , Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch removes the old TMU driver (CONFIG_SH_TMU/timer-tmu.c)
> 
> As replacement, select the sh_tmu driver with CONFIG_SH_TIMER_TMU
> and configure timer channel using platform data.
> 
> If multiple TMU channels are enabled using platform data, use the
> earlytimer parameter on the kernel command line to select channel.
> For instance, use "earlytimer=sh_tmu.0" to select the first channel.
> 
> To verify which timer is being used, look at printouts or the timer
> irq count in /proc/interrupts.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
Is there a git where I can sync to have your patch set?
I'd to test on the r2dplus (real hw and qemu)

Best Regards,
J.
