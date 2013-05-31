From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 May 2013 23:40:28 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7779: Fix missing MOD_SEL2 entry
Message-Id: <20130531234025.GA3673@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369906266-30205-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1369906266-30205-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 31, 2013 at 09:26:18AM +0100, phil.edworthy@renesas.com wrote:
> Hi Laurent,
> 
> > On Friday 31 May 2013 11:43:18 Simon Horman wrote:
> > > On Fri, May 31, 2013 at 03:37:15AM +0200, Laurent Pinchart wrote:
> > > > Hi Phil,
> > > > 
> > > > Thank you for the patch.
> > > > 
> > > > On Thursday 30 May 2013 10:31:06 Phil Edworthy wrote:
> > > > > The list of functions selected by the MOD_SEL2 register was 
> missing
> > > > > an entry. This caused all entries after this to modify the 
> MOD_SEL2
> > > > > register incorrectly.
> > > > > 
> > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > 
> > > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > Thanks Phil, thanks Laurent,
> > > 
> > > can I clarify that this is targeted at v3.11 and not necessary for 
> v3.10 or
> > > earlier releases.
> > 
> > Pushing the patch to v3.10 and v3.9 stable would be nice, as the bug is 
> > present there as well.
> 
> Not sure if you meant pushing to v3.10, or waiting until a v3.10 stable 
> appears. Either would be good...

I am planning to try and getting it included in v3.10.

I think it would help if the changelog was fleshed out a bit.

Could you include some information on what the result of the bug is.
I assume it effects the marzen board (from an upstream kernel point of
view), it would be good to not that too.

Also, could you include something like this in the revised changelog?


This bug has been present since pinmux support was added for the
r8a7779 SoC by  881023d28b465eb457067dc8bbca0f24d8b34279 ("sh-pfc: Add
r8a7779 pinmux support") in v3.8-rc4.
