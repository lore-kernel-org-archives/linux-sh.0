From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 11 Jul 2012 21:24:14 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: defconfig enable INOTIFY_USER
Message-Id: <201207112324.15068.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1341908812-26019-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1341908812-26019-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, July 11, 2012, Kuninori Morimoto wrote:
> 
> Hi
> 
> > This is required for udev to run which is common to many user-spaces.
> > 
> > It is my understanding that this is a requirement for automated
> > testing conducted by Iwamatsu-san.
> > 
> > Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  arch/arm/configs/kzm9g_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> > index 7b2eecd..2388c86 100644
> > --- a/arch/arm/configs/kzm9g_defconfig
> > +++ b/arch/arm/configs/kzm9g_defconfig
> > @@ -119,7 +119,7 @@ CONFIG_SH_DMAE=y
> >  CONFIG_ASYNC_TX_DMA=y
> >  CONFIG_STAGING=y
> >  # CONFIG_DNOTIFY is not set
> > -# CONFIG_INOTIFY_USER is not set
> > +CONFIG_INOTIFY_USER=y
> >  CONFIG_VFAT_FS=y
> >  CONFIG_TMPFS=y
> >  # CONFIG_MISC_FILESYSTEMS is not set
> 
> I didn't know about user-spaces specific options
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied to the kzm9g branch of the renesas.git tree.

Thanks,
Rafael
