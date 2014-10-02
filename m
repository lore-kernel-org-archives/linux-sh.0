From: Simon Horman <horms@verge.net.au>
Date: Thu, 02 Oct 2014 00:12:29 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <20141002001228.GB28125@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 01, 2014 at 08:58:35AM +0900, Simon Horman wrote:
> On Tue, Sep 30, 2014 at 01:48:27PM +0300, Laurent Pinchart wrote:
> > Hi Geert,
> > 
> > On Tuesday 30 September 2014 12:44:59 Geert Uytterhoeven wrote:
> > > On Tue, Sep 30, 2014 at 12:40 PM, Laurent Pinchart wrote:
> > > > On Tuesday 30 September 2014 13:30:29 Simon Horman wrote:
> > > >> On Fri, Sep 19, 2014 at 12:28:28PM +0900, Simon Horman wrote:
> > > >>> On Thu, Sep 18, 2014 at 10:57:12AM +0300, Laurent Pinchart wrote:
> > > >>>> On Thursday 18 September 2014 08:55:43 Simon Horman wrote:
> > > >>>>> On Wed, Sep 17, 2014 at 05:40:07PM +0300, Laurent Pinchart wrote:
> > > >>>>>> On Tuesday 16 September 2014 18:10:37 Wolfram Sang wrote:
> > > >>>>>>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > >>>>>>> 
> > > >>>>>>> SCIF and SCIFA can be plexed onto the same wires on Lager board.
> > > >>>>>>> The datasheet also describes the wires as SCIFA. So, to make use
> > > >>>>>>> of the bigger FIFOs switch to SCIFA instead.
> > > >>>>>>> 
> > > >>>>>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > >>>>>>> ---
> > > >>>>>>> 
> > > >>>>>>> Currently, I use this patch to check if the DMA RX issue is the
> > > >> >>>>> same on SCIF and SCIFA (yes, it is). However, I still think it
> > > >>>>>>> makes sense to use the bigger FIFOs. I will check this next week
> > > >>>>>>> with Bastian's FIFO patches. Until then, I send this as RFC to
> > > >>>>>>> collect opinions speaking for/against this change.
> > > >>>>>> 
> > > >>>>>> I have nothing against this change, but I believe the aliases should
> > > >>>>>> now be serial0 and serial1 to match the legacy code (OK, that's a
> > > >>>>>> lame excuse, we all know that I just want to change the aliases
> > > >>>>>> ;-)).
> > > >>>>> 
> > > >>>>> Thanks Laurent, I think its probably time we had that conversation
> > > >>>>> again. But I think that change can be done (or not ^) separately to
> > > >>>>> this change.
> > > >>>> 
> > > >>>> It could, but I believe it would make sense to do both in one patch,
> > > >>>> otherwise there will be a console serial port device mismatch between
> > > >>>> the legacy and multiplatform cases.
> > > >>> 
> > > >>> I'm a little confused.
> > > >> > Does this patch introduce such a miss-match?
> > > >> 
> > > >> Hi Laurent,
> > > >> 
> > > >> I'd like to move this forwards somehow.
> > > > 
> > > > This patch switches the Lager board to use SCIFA[01] instead of SCIF[01],
> > > > while keeping the Linux devices named /dev/ttySC[67]. With legacy boot,
> > > > SCIFA[01] are named /dev/ttySC[01]. There would thus be a mismatch in that
> > > > sense, even if this change doesn't prevent using the same Linux serial
> > > > devices on both legacy and DT boot.
> > > 
> > > So if I understand if correctly, booting with the current
> > > "console=ttySC6,115200"
> > > in /chosen/bootargs will give a working console for both legacy and
> > > multi-platform,
> > > but the underlying serial hardware block for the console differs (legacy
> > > uses SCIF0, multi-platform uses SCIFA0)?
> > 
> > As far as I understand that's correct.
> 
> I think that is a reasonable state of affairs so long as we have
> Legacy C for Lager, which it seems we will have for a little while to come.
> 
> I will confer with Magnus as he has had strong opinions in this area
> in the past.

Magnus also seems happy with this change so I have queued it up.
