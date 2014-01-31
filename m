From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Jan 2014 00:10:10 +0000
Subject: Re: [PATCH 06/10] ARM: shmobile: koelsch: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <20140131001010.GD14663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2jai8wo.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2jai8wo.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 30, 2014 at 09:04:09AM +0100, Geert Uytterhoeven wrote:
> On Thu, Jan 30, 2014 at 1:57 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > DEVTMPFS is needed for udev
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/configs/koelsch_defconfig |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> > index e248f49..e4f4089 100644
> > --- a/arch/arm/configs/koelsch_defconfig
> > +++ b/arch/arm/configs/koelsch_defconfig
> > @@ -36,6 +36,8 @@ CONFIG_INET=y
> >  CONFIG_IP_PNP=y
> >  CONFIG_IP_PNP_DHCP=y
> >  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> > +CONFIG_DEVTMPFS=y
> > +CONFIG_DEVTMPFS_MOUNT=y
> 
> This is already enabled in koelsch_defconfig in Simon's tree.

Indeed it is, I will skip this patch when queuing up the series.
