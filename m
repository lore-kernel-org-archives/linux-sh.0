From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 Jan 2014 02:19:54 +0000
Subject: Re: linux-next: manual merge of the sh tree with the tree
Message-Id: <20140110021954.GB14912@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140106121317.bada4233ec3fec40f79735cc@canb.auug.org.au>
 <CAOesGMgJe9KR2muA4F9EaXYpDFDLxVZsKOj-8qZFbDZTiRBuww@mail.gmail.com>
 <20140110004724.GA22965@verge.net.au>
 <20140110125529.9843f450bf79223164031b02@canb.auug.org.au>
In-Reply-To: <20140110125529.9843f450bf79223164031b02@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[CC Magnus]

On Fri, Jan 10, 2014 at 12:55:29PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 10 Jan 2014 09:47:24 +0900 Simon Horman <horms@verge.net.au> wrote:
> >
> > On Wed, Jan 08, 2014 at 11:11:03PM -0800, Olof Johansson wrote:
> > >
> > > The request to merge the sh code came through Simon with claimed
> > > agreement from SH maintainers to do so -- I didn't verify this since
> > > they have in the past been well-coordinated. Simon?
> > 
> > I spoke with Paul recently and my understanding is that
> > he hasn't been actively working in this area for over a year now.
> > 
> > I guess there are some stale patches in his tree.
> 
> That is certainly what it looks like.  So, do I remove the sh{,.-current)
> trees (git://github.com/pmundt/linux-sh.git#sh-{latest,fixes-for-linus})
> from linux-next permanently?  Will it be cleaned up any time soon?

I think that removing it would be a good choice.

> Is anyone maintaining/supporting sh now?  Is it a candidate for pruning?

Its a topic of discussion at Renesas. And I hope that someone
will be doing some form of maintenance again soon.

