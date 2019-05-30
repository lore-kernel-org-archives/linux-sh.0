From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 30 May 2019 14:43:10 +0000
Subject: Re: [linux-stable-rc:linux-5.0.y 1434/2350] arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined referenc
Message-Id: <92c0e331-9910-82e9-86de-67f593ef4e5d@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201905301509.9Hu4aGF1%lkp@intel.com>
In-Reply-To: <201905301509.9Hu4aGF1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, "Sasha Levin (Microsoft)" <sashal@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On 5/30/19 12:31 AM, kbuild test robot wrote:
> Hi Randy,
> 
> It's probably a bug fix that unveils the link errors.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> head:   8c963c3dcbdec7b2a1fd90044f23bc8124848381
> commit: b174065805b55300d9d4e6ae6865c7b0838cc0f4 [1434/2350] sh: fix multiple function definition build errors
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b174065805b55300d9d4e6ae6865c7b0838cc0f4
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sh 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.data+0x1c): undefined reference to `followparent_recalc'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


The maintainer posted a patch for this but AFAIK it is not merged anywhere.

https://marc.info/?l=linux-sh&m5585522728632&w=2


-- 
~Randy
