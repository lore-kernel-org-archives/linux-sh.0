From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Aug 2014 08:08:32 +0000
Subject: Re: Armadillo800EVA legacy defconfig seems busted on my board
Message-Id: <20140827080831.GC5936@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
In-Reply-To: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 27, 2014 at 08:39:16AM +0200, Geert Uytterhoeven wrote:
> Hi Simon, Magnus,
> 
> On Wed, Aug 27, 2014 at 1:12 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > Working fine here with both a 100 Mbps or a Gbps switch.
> >> > Gether is supposed to be gigabit, but I only get 100 Mbps.
> >> > Ethtool tells me only 10 or 100 Mbps are available?
> >> >
> >> > What kind of switch do you need? What doesn't work?
> >>
> >> A shitty semi-managed Netgear Gigabit switch in Autonegotiation does
> >> not work, however switching to a different unmanaged Netgear Gigabit
> >> switch makes it work. So now i have a 5-port Gigabit switch hooked up
> >> in between.
> >>
> >> I suspect it to be some issue related to PHY settings in the boot loader.
> >
> > That would not surprise me.
> >
> > I noticed that I had to turn off spanning tree on the switch my Armadillo is
> > connected to else link negotiation would timeout before spanning tree
> > completed and thus the link would never come up. This was not a particularly
> > crappy switch and my personal view is that the Ethernet situation on the
> > boot loader on my Armadillo is less than ideal.
> 
> Does it link at Gigabit speed (under Linux), or only 100 Mbps?

100Mbps.

IIRC this is a hardware limitation of the board.  Perhaps the PHY.
But I only have a very vague memory of a conversation about that.
