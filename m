From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 00:34:30 +0000
Subject: Re: [PATCH v3 1/7] ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
Message-Id: <20130710003429.GA15011@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373298887-9877-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373298887-9877-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 08, 2013 at 06:07:07PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 8 Jul 2013, Guennadi Liakhovetski wrote:
> 
> > Add a DMAC platform device and clock definitions for it on r8a73a4.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> 
> v3: removed SDHI DMAC enumerations and slave configuration entries.

Thanks, I have queued this up for v3.12 in the soc branch.
It should appear in renesas-next-20130710
