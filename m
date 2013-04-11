From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Apr 2013 03:02:02 +0000
Subject: Re: [PATCH/RFC 4/6] ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
Message-Id: <20130411030202.GH21037@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
 <1365632389-2249-5-git-send-email-g.liakhovetski@gmx.de>
 <20130411030127.GG21037@verge.net.au>
In-Reply-To: <20130411030127.GG21037@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Thu, Apr 11, 2013 at 12:01:27PM +0900, Simon Horman wrote:
> On Thu, Apr 11, 2013 at 12:19:47AM +0200, Guennadi Liakhovetski wrote:
> > Add a Device Tree node for the DMA0 controller on sh73a0 and
> > auxdata to supply platform data to the driver. To enable the
> > DMA0 controller it also has to be taken out of reset.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> 
> Hi Guennadi, this seems reasonable to me.
> 
> I guess the best thing is for you to repost it once the pre-requisites
> are in place.

Also, Magnus, could you review this?
