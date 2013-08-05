From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Aug 2013 07:43:50 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: Remove global GPIO_NR definition
Message-Id: <20130805074348.GH15796@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375126434-25884-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375126434-25884-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 29, 2013 at 05:52:42PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > On Mon, Jul 29, 2013 at 09:33:54PM +0200, Laurent Pinchart wrote:
> > > The total number of SoC GPIOs is only used to compute the base GPIO
> > > number of th PCF8575 GPIO extender on the KZM9G board. As GPIO
> > > allocation became fully dynamic with DT, no other SH73A0 board will use
> > > the GPIO_NR macro. Move it to the KZM9G board file.
> > > 
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > I am happy with this.
> > But I will wait to give others a chance to review it before
> > queueing it up.
> 
> This patch looks good to me
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up for v3.12 in the cleanup4 branch.
