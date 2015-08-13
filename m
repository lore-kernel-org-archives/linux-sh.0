From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Aug 2015 00:02:28 +0000
Subject: Re: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <20150813000227.GC5221@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 05, 2015 at 09:52:57AM +0900, Magnus Damm wrote:
> Hi Laurent,
> 
> On Wed, Aug 5, 2015 at 7:48 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Monday 03 August 2015 17:38:37 Magnus Damm wrote:
> >> On Mon, Aug 3, 2015 at 5:34 PM, Kuninori Morimoto wrote:
> >> > Hi Wolfram
> >> >
> >> >> > I tested this panel on Koelsch board (with I2C fixup local patch),
> >> >>
> >> >> I2C fixup? The NACK issue?
> >> >
> >> > I don't know detail.
> >> > But, I need to use gpio-i2c to use HDMI, otherwise it doesn't work.
> >>
> >> I wonder if it is possible to use the "I2C master" bind/unbind code
> >> developed by Wolfram to switch to GPIO bit-bang at run-time?
> >
> > Or to fix the hardware I2C controller driver ? :-)
> 
> That would be the best way forward yes. I suspect that it may take
> quite some time to do so, so until then it would be nice to not have
> to carry local patches to get basic stuff working...

I am marking this patch as deferred for now.
If you feel that is not appropriate please don't hesitate to let me know.
Alternatively, please feel free to repost this patch when you
feel it is appropriate.
