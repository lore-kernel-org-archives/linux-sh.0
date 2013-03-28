From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 28 Mar 2013 00:06:48 +0000
Subject: Re: [PATCH 06/13] sh-pfc: r8a73a4: Add IRQC pin groups and functions
Message-Id: <2175227.tOf3kHWmrB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326135046.31366.2271.sendpatchset@w520>
In-Reply-To: <20130326135046.31366.2271.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 28 March 2013 00:34:21 Magnus Damm wrote:
> On Thu, Mar 28, 2013 at 12:24 AM, Laurent Pinchart wrote:
> > On Thursday 28 March 2013 00:13:34 Magnus Damm wrote:
> >> On Wed, Mar 27, 2013 at 1:02 AM, Laurent Pinchart wrote:
> >> > On Tuesday 26 March 2013 22:50:46 Magnus Damm wrote:
> >> >> From: Magnus Damm <damm@opensource.se>
> >> >> 
> >> >> Add PINCTRL support for r8a73a4 IRQC hardware
> >> >> and in particular the external pins IRQ0 -> IRQ57.
> >> >> 
> >> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> >> ---
> >> >> 
> >> >>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  187 +++++++++++++++++++++++++
> >> >>  1 file changed, 187 insertions(+)
> >> >> 
> >> >> --- 0010/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> >> >> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c 2013-03-26
> >> >> 19:36:03.000000000 +0900
> >> >> @@ -1619,6 +1619,73 @@ static const unsigned int scifb3_ctrl_b_
> >> >>  static const unsigned int scifb3_ctrl_b_mux[] = {
> >> >>       SCIFB3_RTS_38_MARK, SCIFB3_CTS_39_MARK,
> >> >>  };
> >> >> +/* - IRQC -----------------------------------------------------------
> >> >> */
> >> > 
> >> > Could you please keep the groups and functions alphabetically sorted ?
> >> > The pfc-*.c files are pretty tedious to read (and write), and a random
> >> > order of groups and functions would make my headache medecine bill
> >> > become more expensive :-)
> >> 
> >> Done! Good news is that updating those couple of hunks in the middle of
> >> the file didn't seem to cause rejects for patches later in the series.
> >> 
> >> > The patch otherwise looks good.
> >> 
> >> Thanks. I've now posted a V2 as "[PATCH v2] sh-pfc: r8a73a4: Add IRQC
> >> pin groups and functions".
> > 
> > And I've acked it.
> > 
> > How should we proceed with this set ? Would you like to collect the acks
> > from the list, put the latest version in a git branch and ask Simon to
> > pull it ?
>
> I have no strong feelings about exactly how to merge the code. If I can
> chose freely then I'd prefer someone else to collect acks and stick in it a
> git branch for me. =)

Of course, we all do ;-)

> Of course, if that kind of thing becomes too much overhead for the patch
> picking party then I have to think about plan B.
> 
> To be honest, I'm a bit unsure of the exact flow of patches in the case of
> PINCTRL and the PFC. I got the impression that so far Simon sent the pull
> requests to the ARM SoC guys, but then I also saw that you picked up the
> GPIO R-Car driver. I suppose that's because your r8a7779 PFC patches
> depended on that my GPIO driver.
> 
> So if you guys want me to do something differently than submitting code on
> the ML then please let me know.

I've picked the patches and the acks and pushed them to

	git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/r8a73a4

Simon, what is the current pinmux stable branch for v3.10 ? I'd like to rebase 
my branches on top of it to make sure no patch has been forgotten.

-- 
Regards,

Laurent Pinchart

