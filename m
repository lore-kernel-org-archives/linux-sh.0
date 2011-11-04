From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Nov 2011 13:23:38 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <20111104132338.GC29825@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 05, 2011 at 08:16:10AM +0900, Simon Horman wrote:
> On Mon, Sep 19, 2011 at 07:08:18PM -0700, Kuninori Morimoto wrote:
> > 
> > Hi Paul, Iwamatsu-san
> > 
> > > On Thu, Sep 08, 2011 at 05:52:11PM +0900, Nobuhiro Iwamatsu wrote:
> > > > Your patch does not seem to have a meaning.
> > > > In the case of 29bit, CAC/UNCAC_ADDR may not return a right address.
> > > > I think that it is to use P1SEGADDR, and P2SEGADDR in CAC/UNCAC_ADDR
> > > > to easily revise this.
> > > > I attached my patch.
> > > > 
> > > Morimoto-san, does this fix your issue? If you can provide your Tested-by
> > > for this then I'll queue it up and get it off to Linus.
> > 
> > Thank you.
> > 
> > I tested this patch on linus/master.
> > And this patch solved Ecovec board boot issue.
> > 
> > # I tested it on mackerel (SH7372) board too.
> > # It works well
> >  
> > Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> FWIW, this resolved a failure to boot on Ecovec for me too.
> 
> Tested-by: Simon Horman <horms@verge.net.au>

Seem to have somehow missed this one, too. Applied now, thanks everyone.
