From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jun 2012 02:07:47 +0000
Subject: Re: [PATCH 23/27] ARM: shmobile: armadillo800eva: enable DMAEngine on USB
Message-Id: <20120612020745.GL3557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87pq96pkis.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pq96pkis.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 11, 2012 at 06:35:58PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > It is possible to reduce CPU load if USB used DMAEngine.
> > > This patch enabled it.
> > 
> > Hi Morimoto-san,
> > 
> > I am having a little trouble exercising this.
> > Could you propose a test scenario?
> 
> How about to use g_mass_storage.ko ?
> 
> insmod g_mass_storage.ko file=xxxx
> and read/write it
> 
> dma3 will be used

Thanks.

Tested-by: Simon Horman <horms@verge.net.au>

