From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Nov 2010 16:26:33 +0000
Subject: Re: [ANNOUNCE] Changes in the SH and Genesis/R-Mobile git trees
Message-Id: <20101109162633.GC22740@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101109083518.GA21086@linux-sh.org>
In-Reply-To: <20101109083518.GA21086@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 10, 2010 at 02:09:50AM +1100, Stephen Rothwell wrote:
> On Tue, 9 Nov 2010 17:35:18 +0900 Paul Mundt <lethal@linux-sh.org> wrote:
> > rmobile-fixes-for-linus / sh-fixes-for-linus
> > 	- These are my pull branches for upstream. They will always
> > 	  contain that which is bound for the next -rc, regardless of
> > 	  whether we are in a merge window or late in an -rc series. They
> > 	  will only be advanced as new things come in that need to be
> > 	  merged in to the next -rc, and may very well stay put for
> > 	  awhile if I've just completed a merge and all of the new
> > 	  patches are aimed at the next kernel.
> 
> Should I include these branches among my other "current" trees?  These
> trees contain fixes for Linus' current -rc series and are merged very
> early in linux-next.  They are in linux-next so that bugs already fixed
> are not reported again against linux-next before Linus has merged the
> fixes.
> 
Oh, I hadn't even noticed those. Yes, it seems like these would be a good
fit for that. I haven't had a strict rule on rebasing for these in the
past simply because there was no immediate downstream, but I can probably
avoid that. 

> I will replace the sh and genesis trees in linux-next with the above two
> branches starting with next-20101110 (and rename genesis to rmobile).
> 
Great, thanks.
