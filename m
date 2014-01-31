From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Jan 2014 00:13:21 +0000
Subject: Re: [PATCH 0/10] ARM: shmobile: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <20140131001321.GE14663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhxyi90a.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhxyi90a.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks.

I have queued up this series, skipping one patch and slightly modifying
two others as noted below. Details are in replies to the specific patches.

On Thu, Jan 30, 2014 at 09:05:10AM +0100, Geert Uytterhoeven wrote:
> On Thu, Jan 30, 2014 at 1:55 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
> > These patches enable DEVTMPFS for all Renesas board
> > on defconfig
> >
> > Kuninori Morimoto (10):
> >       ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig
> >       ARM: shmobile: mackerel: enable CONFIG_DEVTMPFS in defconfig
> >       ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig

I resolved a minor conflict and queued up this lager patch.

> >       ARM: shmobile: kzm9g: enable CONFIG_DEVTMPFS in defconfig
> >       ARM: shmobile: kzm9d: enable CONFIG_DEVTMPFS in defconfig
> >       ARM: shmobile: koelsch: enable CONFIG_DEVTMPFS in defconfig

This koelsch change is the same as one by Geert that I have already queued up,
I have skipped it.

> >       ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in defconfig
> >       ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig

I updated the changelog to include the subject of the reverted patch
and queued up this bockw patch.

> >       ARM: shmobile: armadillo: enable CONFIG_DEVTMPFS in defconfig
> >       ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig
> 
> For all above but koelsch, where it's already set:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
