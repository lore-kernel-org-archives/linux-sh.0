From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Jun 2011 05:27:46 +0000
Subject: Re: [PATCH][RFC] drivers: sh: late disabling of clocks
Message-Id: <20110621052743.GB7920@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609091339.14510.31590.sendpatchset@t400s>
In-Reply-To: <20110609091339.14510.31590.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 11:29:31AM +0900, Magnus Damm wrote:
> On Tue, Jun 21, 2011 at 11:14 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jun 16, 2011 at 07:54:38AM +0900, Simon Horman wrote:
> >> > Right, I was thinking something along those lines too. The spinlock
> >> > should make sure we're serialized.
> >>
> >> Great. Feel free to take my ideas verbatim if it helps.
> >
> > Hi Magnus,
> >
> > have you had time to look into this?
> 
> I have not updated this patch yet, mainly due to lack of feedback. Not
> so much due to lack of feedback from you - I appreciate your ideas and
> I agree that your rework of the ordering is correct. I'm however still
> not sure if other people agree with my approach of delaying the
> disable operations until a certain point in time.
> 
Except that's not really how it works. I don't have the time or
inclination to go through and provide feedback for every single patch
that crosses my inbox. If something has been posted for awhile and has
feedback, then it's expected that the feedback is addressed and an
updated version is posted. If no other action happens within an arbitrary
but not too long period of time, I'll then roll it in to one of my trees
for testing (assuming there are no glaring issues with the concept or
implementation prior to integration/testing). You've posted multiple
versions of the same patches in the past upon receiving feedback, so it's
a bit perplexing as to why this time you've simply opted to throw the
patch over the fence and do nothing.
