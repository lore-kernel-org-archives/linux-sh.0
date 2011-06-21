From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Jun 2011 06:39:35 +0000
Subject: Re: [PATCH][RFC] drivers: sh: late disabling of clocks
Message-Id: <20110621063935.GC7920@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609091339.14510.31590.sendpatchset@t400s>
In-Reply-To: <20110609091339.14510.31590.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 02:48:44PM +0900, Magnus Damm wrote:
> On Tue, Jun 21, 2011 at 2:27 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, Jun 21, 2011 at 11:29:31AM +0900, Magnus Damm wrote:
> >> On Tue, Jun 21, 2011 at 11:14 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Thu, Jun 16, 2011 at 07:54:38AM +0900, Simon Horman wrote:
> >> >> > Right, I was thinking something along those lines too. The spinlock
> >> >> > should make sure we're serialized.
> >> >>
> >> >> Great. Feel free to take my ideas verbatim if it helps.
> >> >
> >> > Hi Magnus,
> >> >
> >> > have you had time to look into this?
> >>
> >> I have not updated this patch yet, mainly due to lack of feedback. Not
> >> so much due to lack of feedback from you - I appreciate your ideas and
> >> I agree that your rework of the ordering is correct. I'm however still
> >> not sure if other people agree with my approach of delaying the
> >> disable operations until a certain point in time.
> >>
> > Except that's not really how it works. I don't have the time or
> > inclination to go through and provide feedback for every single patch
> > that crosses my inbox. If something has been posted for awhile and has
> > feedback, then it's expected that the feedback is addressed and an
> > updated version is posted. If no other action happens within an arbitrary
> > but not too long period of time, I'll then roll it in to one of my trees
> > for testing (assuming there are no glaring issues with the concept or
> > implementation prior to integration/testing). You've posted multiple
> > versions of the same patches in the past upon receiving feedback, so it's
> > a bit perplexing as to why this time you've simply opted to throw the
> > patch over the fence and do nothing.
> 
> I believe I received some feedback through face-to-face conversations
> earlier, and that feedback was not all that positive. I decided to
> post the code anyway, and Simon kindly provided detailed feedback via
> email about internal ordering. The main idea behind the patch is not
> really changed, so in that area there still is silence.
> 
> I'll resend a new version in a little while. Thanks.
> 
I don't have any particular problems with the approach at least, and at
this point it's really just the locking stuff pointed out by Simon that
is keeping it from being applied. It's obviously somewhat of a hack and
I'm certainly not thrilled by it, but the fact we're forced in to this
position and are entering with undefined state is certainly not your
fault, nor something we can really do much about. We also have half a
dozen syscall ABIs for no good reason because of hardware designer
muppetry, such is life.

Having said that, it might need a bit of fiddling in terms of deciding on
how to enable it or present it to the user, but those are fairly
superficial details that can be worked out once an updated version is
posted.
