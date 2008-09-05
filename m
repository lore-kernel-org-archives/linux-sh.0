From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 05 Sep 2008 05:36:43 +0000
Subject: Re: [PATCH] i2c: fix i2c-sh_mobile timing issues
Message-Id: <20080905053643.GA2051@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080827093356.9145.33751.sendpatchset@rx1.opensource.se> <20080827144048.GA32530@linux-sh.org> <20080827174628.3b452f2d@hyperion.delvare>
In-Reply-To: <20080827174628.3b452f2d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, i2c@lm-sensors.org, linux-sh@vger.kernel.org, ben-linux@fluff.org

On Wed, Aug 27, 2008 at 05:46:28PM +0200, Jean Delvare wrote:
> On Wed, 27 Aug 2008 23:40:48 +0900, Paul Mundt wrote:
> > On Wed, Aug 27, 2008 at 06:33:56PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@igel.co.jp>
> > > 
> > > This patch teaches the i2c-sh_mobile driver to make use of wait irqs.
> > > Without this patch only dte irqs are used which may lead to overruns
> > > and cases of missing stop and extra bytes being read on the i2c bus.
> > > 
> > > Use of wait irqs forces the hardware to pause and wait until the cpu
> > > is ready. Polling is also reworked in this patch to fix ms delay issues.
> > > 
> > > Verified with bus analyzer and tested on MigoR and AP325RXA boards.
> > > 
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > > ---
> > > 
> > >  Paul, can you merge this for 2.6.27?
> > > 
> > >  drivers/i2c/busses/i2c-sh_mobile.c |  271 +++++++++++++++++++++++++++---------
> > >  1 file changed, 208 insertions(+), 63 deletions(-)
> > > 
> > I'll add it to my queue if Jean and Ben don't have any issues with the
> > patch. If the polling works as is, I would suggest that it is not 2.6.27
> > material, but if it's fixing operational bugs then it doesn't make sense
> > to leave 2.6.27 in a known broken state.
> 
> No objection from me, as this is outside of my jurisdiction.
> 
Well, it's been a week and there's been no comments, so I'll roll this in
to my queue.
