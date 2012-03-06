From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 06 Mar 2012 10:14:11 +0000
Subject: Re: AP4EVB board couldn't boot on latest linus/master
Message-Id: <1333815.KhJDah6IKR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87booawe57.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87booawe57.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Monday 05 March 2012 20:24:08 Kuninori Morimoto wrote:
> Hi SH ML
> 
> Cc Laurent, Rafael
> 
> Could you please give me your help ?
> My AP4EVB board couldn't boot on latest linus/master branch.
> 
> I tried debug/bisect for it, and noticed that it has 2 issues.
> It were
> 
> 1) sh_mobile_lcdc/fbcon seems has dead lock issue
> 2) PM runtime issue (?)
> 
> But mackerel board works well on same tree.
> So, I guess ap4evb.c is missing something.
> 
> ======================> lcdc/fbcon dead lock
> ======================> 
> This issue happen from this merge commit
> 
> 	----------------------------------------------
> 	commit 51be08419dc86c72486ac556aa39bc01026a403d
> 	Merge: ec8013b f787f32
> 	Author: Linus Torvalds <torvalds@linux-foundation.org>
> 	Date:   Sat Jan 14 15:11:19 2012 -0800
> 
> 	    Merge branch 'fbdev-next' of git://github.com/schandinat/linux-2.6
> 
> 	    * 'fbdev-next' of git://github.com/schandinat/linux-2.6: (175 
commits)
> 	      module_param: make bool parameters really bool (drivers/video/i810)
> 	      Revert "atmel_lcdfb: Adjust HFP calculation so it matches the
> manual." ...
> 	----------------------------------------------
> 
> The kernel log was
> 
> 	----------------------------------------------
> 	...
> 	io scheduler noop registered (default)
> 	sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: start latency exceeded, new value
> 17416 s arm_vmregion_alloc: allocation too big (requested 0x7e9000)
> 	sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
> 	sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
> 	sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: start latency exceeded, new value
> 3750 ns (dead lock)
> 	----------------------------------------------
> 
> I'm not sure why, but console_lock() seems dead lock on 2nd lcdc.
> This is the trace
> 
> sh_mobile_lcdc_probe()
>  - register_framebuffer()
>   - do_register_framebuffer()
>    - fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, xx)
>     - fbcon_event_notify()
>      - fbcon_fb_registered()
>       - fbcon_takeover()
>        - take_over_console()
>         - bind_con_driver()
>          - console_lock()    <== dead lock
> 
> I could skip this issue by removing CONFIG_FRAMEBUFFER_CONSOLE from my
> .config
> 
> ap4evb lcdc_info settings are less than mackerel.
> (note, ap4evb_init adds more settings for it)
> Does it missing something ?

Could you please enable CONFIG_LOCKDEP_SUPPORT support in the kernel to catch 
AB-BA deadlocks ?

> ======================> PM runtime (?) dead
> ======================> 
> I got 2nd issue after skipping above issue.
> It seems happen from this commit
> 
> 	----------------------------------------------
> 	commit 0140d8bd47f798d55c3720f7fcade9e50929a5e5
> 	Author: Rafael J. Wysocki <rjw@sisk.pl>
> 	Date:   Thu Dec 1 00:02:17 2011 +0100
> 
> 	    PM / Domains: Automatically update overoptimistic latency information
> 
> 	    Measure the time of execution of the .stop(), .start(), .save_state()
> 	    and .restore_state() PM domain device callbacks and if the result
> 	    ...
> 	----------------------------------------------
> 
> The kernel log is
> 
> 	----------------------------------------------
> 	...
> 	sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: start latency exceeded, new value
> 3834 ns graphics fb0: registered sh_mobile_lcdc_fb/mainlcd as 544x961
> 16bpp. SuperH SCI(F) driver initialized
> 	sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> 	sh-sci sh-sci.0: start latency exceeded, new value 4666 ns
> 	console [ttySC0] enabled, bootconsole disabled
> 	console [ttySC0] enabled, bootconsole disabled
> 	(dead)
> 	----------------------------------------------
> 
> what is required for ap4evb ?

I had a similar issue on Mackerel, and I've worked around it by disabling 
CONFIG_SH_TIMER_TMU.

-- 
Regards,

Laurent Pinchart

