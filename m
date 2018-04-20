From: Rich Felker <dalias@libc.org>
Date: Fri, 20 Apr 2018 15:32:02 +0000
Subject: Re: [PATCH] sh: time: Remove the read_persistent_clock()
Message-Id: <20180420153202.GR3094@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <c52709fe323b56916b3f621dac1baf6d49225188.1524117883.git.baolin.wang@linaro.org>
In-Reply-To: <c52709fe323b56916b3f621dac1baf6d49225188.1524117883.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 20, 2018 at 05:19:43PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 19, 2018 at 8:06 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> > The read_persistent_clock() uses a timespec, which is not year 2038 safe
> > on 32bit systems. Moreover on sh platform, we have RTC drivers that can
> > be used to compensate the system suspend time. Thus we can remove the
> > read_persistent_clock() safely.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
> Hi Baolin and sh maintainers.
> 
> I have done a similar patch but never got around to posting it. Please
> see my patch below.
> 
> Note that the patch is whitespace broken, I can send a proper
> version to the sh maintainers if they want to merge it, or I can
> apply my patch to my y2038 tree myself.
> 
>        Arnd
> 
> commit cade6829ca223d9761863e74595d677b3dc14ecd
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Jan 24 16:18:50 2018 +0100
> 
>     sh: remove unused rtc_sh_get/set_time infrastructure
> 
>     All platforms are now converted to RTC drivers, so this has become
>     obsolete. The board_time_init() callback still has one caller, but
>     could otherwise also get killed.
> 
>     This removes one more usage of the deprecated timespec structure,
>     which overflows in y2038.
> 
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>

In principle this looks correct, but I don't think all the drivers
have been converted. I did a quick grep for where board_time_init is
set, and found mach-dreamcast and mach-sh03 boards have rtc drivers
that set rtc_sh_[gs]et_time pointers. These need to be converted to
proper rtc drivers, I think.

The of-generic board also uses board_time_init, but only to call the
arch-independent timer_probe which uses devicetree to get
clocksource/clockevent devices. This probe should probably be moved to
the place where board_timer_init is called, right?

Rich


> diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
> index c63555ee1255..fe55fbb181aa 100644
> --- a/arch/sh/include/asm/rtc.h
> +++ b/arch/sh/include/asm/rtc.h
> @@ -4,8 +4,6 @@
> 
>  void time_init(void);
>  extern void (*board_time_init)(void);
> -extern void (*rtc_sh_get_time)(struct timespec *);
> -extern int (*rtc_sh_set_time)(const time_t);
> 
>  #define RTC_CAP_4_DIGIT_YEAR   (1 << 0)
> 
> diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
> index fcd5e41977d1..eb0a91270499 100644
> --- a/arch/sh/kernel/time.c
> +++ b/arch/sh/kernel/time.c
> @@ -22,75 +22,6 @@
>  #include <asm/clock.h>
>  #include <asm/rtc.h>
> 
> -/* Dummy RTC ops */
> -static void null_rtc_get_time(struct timespec *tv)
> -{
> -       tv->tv_sec = mktime(2000, 1, 1, 0, 0, 0);
> -       tv->tv_nsec = 0;
> -}
> -
> -static int null_rtc_set_time(const time_t secs)
> -{
> -       return 0;
> -}
> -
> -void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
> -int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
> -
> -void read_persistent_clock(struct timespec *ts)
> -{
> -       rtc_sh_get_time(ts);
> -}
> -
> -#ifdef CONFIG_GENERIC_CMOS_UPDATE
> -int update_persistent_clock(struct timespec now)
> -{
> -       return rtc_sh_set_time(now.tv_sec);
> -}
> -#endif
> -
> -static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
> -{
> -       struct timespec tv;
> -
> -       rtc_sh_get_time(&tv);
> -       rtc_time_to_tm(tv.tv_sec, tm);
> -       return 0;
> -}
> -
> -      &rtc_generic_ops,
> -      sizeof(rtc_generic_ops));
> -
> -
> - return PTR_ERR_OR_ZERO(pdev);
> -}
> -device_initcall(rtc_generic_init);
> -
>  void (*board_time_init)(void);
> 
>  static void __init sh_late_time_init(void)
