From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Dec 2014 00:16:48 +0000
Subject: Re: [PATCH v7 1/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <20141212001647.GB6070@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 11, 2014 at 04:19:20PM +0200, Laurent Pinchart wrote:
> Hi Magnus,
> 
> On Thursday 11 December 2014 19:07:27 Magnus Damm wrote:
> > On Thu, Dec 11, 2014 at 3:39 AM, Laurent Pinchart wrote:
> > > Hi Ulrich,
> > > 
> > > (CC'ing Morimoto-san)
> > > 
> > > On Wednesday 10 December 2014 17:53:22 Ulrich Hecht wrote:
> > >> On Wed, Dec 10, 2014 at 4:38 PM, Laurent Pinchart wrote:
> > >> > On Wednesday 10 December 2014 15:45:22 Ulrich Hecht wrote:
> > >> >> Driver for the SH73A0's clocks that are too specific to be supported
> > >> >> by a
> > >> >> generic driver.
> > >> 
> > >> [...]
> > >> 
> > >> >> +static struct div4_clk div4_clks[] = {
> > >> >> +     { "zg", "pll0", CPG_FRQCRA, 16 },
> > >> > 
> > >> > I've already commented on this in v6, the comment has probably been
> > >> > overlooked. According to the datasheet the ZGFC value 1010 results in a
> > >> > x1/5 factor, which  doesn't match the value in the div4_div_table
> > >> > below.
> > >> > I wonder if it could be an error in the datasheet though.
> > >> 
> > >> The legacy driver doesn't make an exception for zg.  Looks like an
> > >> error in the datasheet to me.
> > > 
> > > Morimoto-san, do you think it would be possible to get that information
> > > from the hardware team(s) ?
> > > 
> > > In the meantime I don't think this is a show stopper.
> > 
> > Let me step in here for a sec. I think getting reliable new information
> > about sh73a0 is highly unlikely. That particular SoC is both old and part of
> > the mobile line up that was chopped off quite some time ago. So I don't
> > think anyone with knowledge is left in the company.
> 
> Fair enough, I was quite expecting that, but I possibly naively thought it 
> would be worth trying :-)
> 
> It should in theory be possible to test this by measuring the SGX perfomances, 
> but I don't think that would be feasible in practice in our team. I'm thus 
> fine considering this as an error in the documentation until proven wrong. It 
> should probably be captured in a comment in the source code though.

FWIW, that is fine by me.

In more words: I think its perfectly reasonable to make informed and
appropriately documented judgements about the accuracy of the documentation
in lieu of a mechanism to confirm details from a hardware team.
