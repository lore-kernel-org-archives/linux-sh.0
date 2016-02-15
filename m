From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 15 Feb 2016 17:41:24 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <20160215172924.GL19598@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 11, 2016 at 01:51:31AM +0200, Laurent Pinchart wrote:
> Hi Vinod,
> 
> > Okay I did look back and checked. I tend to agree with you on this and
> > client are not really taking care of mapping so easy approach would be to
> > get this fixed in dmanegine which helps in IOMMU case (which I still think
> > is in infancy, but who know how designers will throw their pipe dreams at
> > us)
> > 
> > Now, am checking this with Dan on why we started with client based mapping
> > assumption in case of slave, we don't want to miss anything here, so I will
> > get back in couple of days..

So discussed a bit with Dan, and now have ressurected the patch from Linus
and compiled with it, nothing seems to break. But I think for slave cases we
should also change the prep_  calls to take phys_addr_t which will fix the
case for IOMMU being on either side as you pointed out.

Should we keep interleaved template as dma or phys, am for latter. Only non
slave cases will be dma types and mapping done by clients.

-- 
~Vinod
