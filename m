From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 21 Apr 2019 13:52:28 +0000
Subject: Re: arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined reference to `followparent_recalc'
Message-Id: <87sgubcvoj.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201904201516.DdPznV5M%lkp@intel.com>
	<fb6880d2-06a4-cec2-e12c-c526d3a4358a@infradead.org>
In-Reply-To: <fb6880d2-06a4-cec2-e12c-c526d3a4358a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, paul.mundt@gmail.com, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, 21 Apr 2019 04:34:36 +0900,
Randy Dunlap wrote:
> 
> On 4/20/19 12:40 AM, kbuild test robot wrote:
> > Hi Randy,
> > 
> > It's probably a bug fix that unveils the link errors.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   371dd432ab39f7bc55d6ec77d63b430285627e04
> > commit: acaf892ecbf5be7710ae05a61fd43c668f68ad95 sh: fix multiple function definition build errors
> > date:   2 weeks ago
> > config: sh-allmodconfig (attached as .config)
> > compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout acaf892ecbf5be7710ae05a61fd43c668f68ad95
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=sh 
> 
> Hi,
> 
> Once again, the question is the validity of the SH2 .config file in this case
> (that was attached).
> 
> I don't believe that it is valid because CONFIG_SH_DEVICE_TREE=y,
> which selects COMMON_CLK, and there is no followparent_recalc() in the
> COMMON_CLK API.
> 
> Also, while CONFIG_HAVE_CLK=y, drivers/sh/Makefile prevents that from
> building clk/core.c, which could provide followparent_recalc():
> 
> ifneq ($(CONFIG_COMMON_CLK),y)
> obj-$(CONFIG_HAVE_CLK)			+= clk/
> endif
> 
> Hm, maybe that's where the problem is.  I'll look into that more.
>

Yes.
Selected target (CONFIG_SH_7619_SOLUTION_ENGINE) is non devicetree
and used superh specific clk modules.
So allyesconfig output is incorrect.

I fixed Kconfig to output the correct config.

> 
> 
> It would be Good if someone from the SuperH area could/would comment.
> 
> Thanks.
> 
> 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.data+0x1c): undefined reference to `followparent_recalc'
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> > 
> 
> 
> -- 
> ~Randy

-- 
Yosinori Sato
