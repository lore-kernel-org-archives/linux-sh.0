From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 22 Apr 2019 07:54:10 +0000
Subject: Re: arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined reference to `followparent_recalc'
Message-Id: <87mukimq59.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201904201516.DdPznV5M%lkp@intel.com>
	<fb6880d2-06a4-cec2-e12c-c526d3a4358a@infradead.org>
	<87sgubcvoj.wl-ysato@users.sourceforge.jp>
	<a7b17eb8-349f-298c-2e82-895a70b201ac@infradead.org>
In-Reply-To: <a7b17eb8-349f-298c-2e82-895a70b201ac@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, paul.mundt@gmail.com, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, 22 Apr 2019 00:24:21 +0900,
Randy Dunlap wrote:
> 
> On 4/21/19 6:52 AM, Yoshinori Sato wrote:
> > On Sun, 21 Apr 2019 04:34:36 +0900,
> > Randy Dunlap wrote:
> >>
> >> On 4/20/19 12:40 AM, kbuild test robot wrote:
> >>> Hi Randy,
> >>>
> >>> It's probably a bug fix that unveils the link errors.
> >>>
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>> head:   371dd432ab39f7bc55d6ec77d63b430285627e04
> >>> commit: acaf892ecbf5be7710ae05a61fd43c668f68ad95 sh: fix multiple function definition build errors
> >>> date:   2 weeks ago
> >>> config: sh-allmodconfig (attached as .config)
> >>> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> >>> reproduce:
> >>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>>         chmod +x ~/bin/make.cross
> >>>         git checkout acaf892ecbf5be7710ae05a61fd43c668f68ad95
> >>>         # save the attached .config to linux build tree
> >>>         GCC_VERSION=7.2.0 make.cross ARCH=sh 
> >>
> >> Hi,
> >>
> >> Once again, the question is the validity of the SH2 .config file in this case
> >> (that was attached).
> >>
> >> I don't believe that it is valid because CONFIG_SH_DEVICE_TREE=y,
> >> which selects COMMON_CLK, and there is no followparent_recalc() in the
> >> COMMON_CLK API.
> >>
> >> Also, while CONFIG_HAVE_CLK=y, drivers/sh/Makefile prevents that from
> >> building clk/core.c, which could provide followparent_recalc():
> >>
> >> ifneq ($(CONFIG_COMMON_CLK),y)
> >> obj-$(CONFIG_HAVE_CLK)			+= clk/
> >> endif
> >>
> >> Hm, maybe that's where the problem is.  I'll look into that more.
> >>
> > 
> > Yes.
> > Selected target (CONFIG_SH_7619_SOLUTION_ENGINE) is non devicetree
> > and used superh specific clk modules.
> > So allyesconfig output is incorrect.
> > 
> > I fixed Kconfig to output the correct config.
> 
> Thanks for that.
> The patch fixes this problem in my builds.

OK. Thanks.

> However, now I see these build errors:
> 
> ERROR: "__ashiftrt_r4_28" [fs/udf/udf.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/rtc/rtc-x1205.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf2123.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/input/tablet/gtco.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: "__ashiftrt_r4_28" [drivers/input/mouse/psmouse.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/iio/pressure/bmp280.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/dac/ad5764.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/mma7660.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/iio/accel/dmard06.ko] undefined!
> ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/bma220_spi.ko] undefined!
> ERROR: "__ashiftrt_r4_25" [drivers/crypto/hisilicon/sec/hisi_sec.ko] undefined!
> 
> Is this just a toolchain problem?
> 
> I am using the gcc 8.1.0 tools from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>

It looks libgcc function.
sh port using private build libgcc. It missing this function.
We need added __ashiftrt_r4 variant.

> 
> thanks.
> -- 
> ~Randy

-- 
Yosinori Sato
