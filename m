From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 13 Jun 2014 07:01:27 +0000
Subject: Re: [PATCH v2] ARM: shmobile: koelsch: Add support HSCIF1
Message-Id: <10020827.IyD6srEo7g@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <CANqRtoT9OjX--sh3ab1R-j=ommqU3vvh1EzDoNQfkwZL39FSZQ@mail.gmail.com>
 <20140610070044.GB29303@verge.net.au>
In-Reply-To: <20140610070044.GB29303@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Tuesday 10 June 2014 16:00:48 Simon Horman wrote:
> On Tue, Jun 10, 2014 at 01:14:27PM +0900, Magnus Damm wrote:
> > On Tue, Jun 10, 2014 at 11:34 AM, Nobuhiro Iwamatsu wrote:
> > > Koelsch can use HSCIF1 insetead of SCIF1 as serial port. But if we want
> > > to use, we will need to disable the GPIO key and remodeling of the
> > > board. Therefore status of hscif1 does not set the "okay".
> > > 
> > > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > ---
> > > 
> > >  V2: Remove hscif1_clk from renesas,groups. This pin does not use.
> > 
> > Thanks for updating the patch. This looks fine to me.
> > 
> > Acked-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Thanks, I will queue this up.

Sorry for the late reply, but I have some doubts about this. The HRX0 and HTX0 
signals are connected to push buttons and used as GPIOs. Beside, they're not 
routed to serial port transceiver. If we want to use HSCIF0 on those pins on 
Koelsch and extension board must be connected to the EXIO C connector, and two 
resistors and two capacitors should be unsoldered. I thus don't think the 
Koeslch DT should contain pinmux data for the HSCIF0 device. If an extension 
board is used and HSCIF0 needed, then the DT file for the extension board 
should define pinmuxing for the serial port.

-- 
Regards,

Laurent Pinchart


