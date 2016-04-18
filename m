From: Rich Felker <dalias@libc.org>
Date: Mon, 18 Apr 2016 14:15:00 +0000
Subject: Re: (.init.text+0x270): multiple definition of `plat_irq_setup'
Message-Id: <20160418141500.GM21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <201604181804.JnV4whDJ%fengguang.wu@intel.com>
In-Reply-To: <201604181804.JnV4whDJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Apr 18, 2016 at 06:44:06PM +0800, kbuild test robot wrote:
> Hi Rich,
> 
> FYI, the error/warning still remains.

I can't find where I got any notification of it before. Thanks for
bringing it to my attention now though.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c3b46c73264b03000d1e18b22f5caf63332547c9
> commit: 7480e0aabd5f9e6c3e3b72ed206e89284e90f11f sh: add device tree support and generic board using device tree
> date:   5 weeks ago
> config: sh-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 7480e0aabd5f9e6c3e3b72ed206e89284e90f11f
>         # save the attached .config to linux build tree
>         make.cross ARCH=sh 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sh/boards/built-in.o: In function `plat_irq_setup':
> >> (.init.text+0x270): multiple definition of `plat_irq_setup'
>    arch/sh/kernel/built-in.o:(.init.text+0x1234): first defined here
>    arch/sh/boards/built-in.o: In function `arch_init_clk_ops':
> >> (.init.text+0x254): multiple definition of `arch_init_clk_ops'
>    arch/sh/kernel/built-in.o:(.init.text+0x12d4): first defined here

OK, the new of-generic board is not tested with any of the existing
cpu targets and not really usable yet since they don't have device
tree bindings, but still it shouldn't break the build. I'll see about
either moving these functions out of of-generic.c or making them weak.
In the long term (once all legacy board files have been replaced by DT
files/bindings and have been removed) these functions probably should
not even exist.

Rich
