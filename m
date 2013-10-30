From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Oct 2013 10:20:54 +0000
Subject: Re: gpio-rcar: DT and IRQ_TYPE_EDGE_BOTH
Message-Id: <13973433.boY4bClOZK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131029085258.GE15731@verge.net.au> <CANqRtoR+_HvbemVcWBszrCXRJ21wMrPHM4vKhBnq11VgfGBamw@mail.gmail.com> <20131030082608.GB1603@verge.net.au>
In-Reply-To: <20131030082608.GB1603@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org

Hi Magnus and Simon,

On Wednesday 30 October 2013 17:26:10 Simon Horman wrote:
> On Wed, Oct 30, 2013 at 07:04:46AM +0000, Magnus Damm wrote:
> > On Tue, Oct 29, 2013 at 8:52 AM, Simon Horman <horms@verge.net.au> wrote:
> > > Hi Laurent,
> > > 
> > > In 7e1092b5a264c4 ("gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH")
> > > I added a 'has_both_edge_trigger' field to struct gpio_rcar_config.
> > > Setting this adds support IRQ_TYPE_EDGE_BOTH. The motivation for
> > > this was to allow use of the gpio-keys driver on the lager board.
> > > 
> > > I am now looking at enabling gpio-keys via DT for koelsch and lager
> > > and find myself needing to set has_both_edge_trigger somehow.
> > > I am wondering if you have any ideas on how best to do this.
> > > 
> > > So far I have two ideas:
> > > 
> > > 1. Expose has_both_edge_trigger as a binding.
> > > 
> > > 2. Set has_both_edge_trigger in the driver if the
> > >    compat string is renesas,gpio-r8a7791 or renesas,gpio-r8a7790
> > >    but not for other supported compat strings (as is currently the
> > >    case).
> > 
> > I think which to pick depends on the type of feature. In the case of
> > enabling both edge support for this GPIO driver, I believe going with
> > 2) is the best way forward. The reason for this is that all GPIO
> > instances within a particular SoC seem to either have or not have
> > support for dual edges. At least that is the case on r8a7790 and
> > r8a7791.
> > 
> > There may be other properties in the future like per-GPIO hardware
> > debounce, and I suspect that those may be more suitable for 1) since
> > they are only supported on a certain set of GPIO pins. So from my POV
> > this is a case by case thing.
> 
> Thanks, that sounds reasonable from my POV.

I agree, let's put have property in the driver.

-- 
Regards,

Laurent Pinchart

