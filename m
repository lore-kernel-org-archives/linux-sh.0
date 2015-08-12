From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Aug 2015 02:21:56 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: Board specific serial port order
Message-Id: <20150812022155.GI15957@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150807024533.25666.34925.sendpatchset@little-apple>
In-Reply-To: <20150807024533.25666.34925.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 07, 2015 at 01:19:59PM +0300, Laurent Pinchart wrote:
> On Friday 07 August 2015 09:13:08 Geert Uytterhoeven wrote:
> > Hi Magnus,
> > 
> > On Fri, Aug 7, 2015 at 4:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > > From: Magnus Damm <damm+renesas@opensource.se>
> > > 
> > > Convert Marzen to use board-specific serial0 and serial1 instead
> > > of the older shared SoC-specific SCIF index.
> > 
> > Thank you for your patch!
> > 
> > Please note that this is a user-visible change.
> > Hardcoded "ttySC2" in e.g. kernel boot command line and /etc/inittab must be
> > changed to ttySC0.
> > 
> > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Nevertheless:
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> And
> 
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> given how long I've been pushing for this :-)

Thanks, I have queued this up for v4.4.
