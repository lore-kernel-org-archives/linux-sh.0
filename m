From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 09:43:49 +0000
Subject: Re: [PATCH 14/14][RFC] arm64: defconfig: add CS2000 driver support
Message-Id: <87oahalijm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87613in3sc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87613in3sc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert

> <kuninori.morimoto.gx@renesas.com> wrote:
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -82,6 +82,7 @@ CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_DMA_CMA=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_VIRTIO_BLK=y
> > +CONFIG_CS2000_CP=y
> 
> =m?

not sure. no one is selecting =m on defconfig ?
It seems ARM ML topic ?

