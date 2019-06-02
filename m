From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 02 Jun 2019 07:13:04 +0000
Subject: Re: [linux-stable-rc:linux-5.0.y 1434/2350] arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined referenc
Message-Id: <871s0cqx33.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201905301509.9Hu4aGF1%lkp@intel.com>	<92c0e331-9910-82e9-86de-67f593ef4e5d@infradead.org>	<20190531100004.0b1f4983@canb.auug.org.au>
In-Reply-To: <20190531100004.0b1f4983@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Randy Dunlap <rdunlap@infradead.org>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, "Sasha Levin (Microsoft)" <sashal@kernel.org>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Fri, 31 May 2019 09:00:04 +0900,
Stephen Rothwell wrote:
> 
> [1  <text/plain; US-ASCII (quoted-printable)>]
> Hi all,
> 
> On Thu, 30 May 2019 07:43:10 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 5/30/19 12:31 AM, kbuild test robot wrote:
> > > Hi Randy,
> > > 
> > > It's probably a bug fix that unveils the link errors.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> > > head:   8c963c3dcbdec7b2a1fd90044f23bc8124848381
> > > commit: b174065805b55300d9d4e6ae6865c7b0838cc0f4 [1434/2350] sh: fix multiple function definition build errors
> > > config: sh-allmodconfig (attached as .config)
> > > compiler: sh4-linux-gcc (GCC) 7.4.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout b174065805b55300d9d4e6ae6865c7b0838cc0f4
> > >         # save the attached .config to linux build tree
> > >         GCC_VERSION=7.4.0 make.cross ARCH=sh 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > >   
> > >>> arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.data+0x1c): undefined reference to `followparent_recalc'  
> > > 
> > > ---
> > > 0-DAY kernel test infrastructure                Open Source Technology Center
> > > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation  
> > 
> > 
> > The maintainer posted a patch for this but AFAIK it is not merged anywhere.
> > 
> > https://marc.info/?l=linux-sh&m5585522728632&w=2
> 
> Unfortunately, the sh tree (git://git.libc.org/linux-sh#for-next) has
> been removed from linux-next due to lack of any updates in over a year,
> but I will add that patch (see below) to linux-next today, but someone
> will need to make sure it gets to Linus at some point (preferably
> sooner rather than later).  (I can send it if someone associated with
> the sh development wants/asks me to ...)

OK.
Since I created a temporary sh-next, please get it here.
git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/sh-next

It same host of h8300-next.

> From: Yoshinori Sato <ysato@users.sourceforge.jp>
> Date: Sun, 21 Apr 2019 14:00:16 +0000
> Subject: [PATCH] sh: Fix allyesconfig output
> 
> Conflict JCore-SoC and SolutionEngine 7619.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boards/Kconfig | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index b9a37057b77a..cee24c308337 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -8,27 +8,19 @@ config SH_ALPHA_BOARD
>  	bool
>  
>  config SH_DEVICE_TREE
> -	bool "Board Described by Device Tree"
> +	bool
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select TIMER_OF
>  	select COMMON_CLK
>  	select GENERIC_CALIBRATE_DELAY
> -	help
> -	  Select Board Described by Device Tree to build a kernel that
> -	  does not hard-code any board-specific knowledge but instead uses
> -	  a device tree blob provided by the boot-loader. You must enable
> -	  drivers for any hardware you want to use separately. At this
> -	  time, only boards based on the open-hardware J-Core processors
> -	  have sufficient driver coverage to use this option; do not
> -	  select it if you are using original SuperH hardware.
>  
>  config SH_JCORE_SOC
>  	bool "J-Core SoC"
> -	depends on SH_DEVICE_TREE && (CPU_SH2 || CPU_J2)
> +	select SH_DEVICE_TREE
>  	select CLKSRC_JCORE_PIT
>  	select JCORE_AIC
> -	default y if CPU_J2
> +	depends on CPU_J2
>  	help
>  	  Select this option to include drivers core components of the
>  	  J-Core SoC, including interrupt controllers and timers.
> -- 
> 2.11.0
> 
> -- 
> Cheers,
> Stephen Rothwell
> [2 OpenPGP digital signature <application/pgp-signature (7bit)>]
> No public key for 015042F34957D06C created at 2019-05-31T09:00:04+0900 using RSA

-- 
Yosinori Sato
