From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 09:41:50 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: armadillo800eva: enable NEON on defconfig
Message-Id: <20130301094150.GD27938@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-4-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-4-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 25, 2013 at 09:21:18AM +0900, Kiyoshi Ishiyama wrote:
> Hi Kunimoto-san, Shimon-san
> 
> Acked-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>

Thanks, applied to the defconfig branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

> 
> BR
> Ishi
> 
> > The application / library will be stopped by illegal instruction
> > on current Armaddilo800eva board,
> > since defconfig doesn't have CONFIG_NEON.
> > This patch enabled it.
> > Special thanks to Ishiyama-san
> > 
> > Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/configs/armadillo800eva_defconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> > index dd1592b..a452f65 100644
> > --- a/arch/arm/configs/armadillo800eva_defconfig
> > +++ b/arch/arm/configs/armadillo800eva_defconfig
> > @@ -42,6 +42,7 @@ CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 i
> >  CONFIG_CMDLINE_FORCE=y
> >  CONFIG_KEXEC=y
> >  CONFIG_VFP=y
> > +CONFIG_NEON=y
> >  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> >  # CONFIG_SUSPEND is not set
> >  CONFIG_NET=y
> > -- 
> > 1.7.9.5
> 
> -- 
> Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
> 
