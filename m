From: Rich Felker <dalias@libc.org>
Date: Thu, 17 Mar 2016 20:22:22 +0000
Subject: Re: [GIT PULL] arch/sh updates for 4.6
Message-Id: <20160317202222.GJ21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317180253.GA24679@brightrain.aerifal.cx>
In-Reply-To: <20160317180253.GA24679@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 17, 2016 at 03:19:19PM -0400, Rich Felker wrote:
> On Thu, Mar 17, 2016 at 07:52:32PM +0100, Geert Uytterhoeven wrote:
> > Hi Rich,
> > 
> > On Thu, Mar 17, 2016 at 7:02 PM, Rich Felker <dalias@libc.org> wrote:
> > > These are the updates Sato-san and I have for arch/sh in this merge
> > > window. Aside from some small fixes and cleanup they set the stage for
> > > J2 support (by adding framework for boards described by device tree),
> > > which should only minimally touch existing files when it's added.
> > 
> > Thanks for preparing this!
> > 
> > > Could you pull these changes and send them upstream for 4.6, or let me
> > > know if there are problems (like stupid mistakes I made in preparing
> > > the branch) or if I should send the request directly to Linus? Rob
> > > suggested I might go through you this first time since I'm new to
> > > maintainer workflow and the repo (on libc.org) is temporary pending
> > > getting it setup on kernel.org.
> > 
> > It mostly looks fine to me.
> > 
> > I have only one real comment: if you apply a patch from someone else, you
> > should add your own Signed-off-by line (use the "-s" option of "git am").
> > As your for-4.6 branch is based on current v4.5, it won't do much harm to
> > "rebase -i" it to add the missing SoB-lines.
> 
> Should I do that for the ones from Sato-san too even though we're both
> listed as maintainers? The only ones I did not touch with my own SoB
> were pulled from his tree.

I'm just going ahead and doing them all. I'll send the updated pull
request to Linus with an explanation of why it's not signed and see
what he says.

> > After the release of v4.6-rc1, you may want to prepare a "for-next" branch
> > where you commit patches that are meant for the next (v4.7) kernel version,
> > and inform Stephen Rothwell (CCed, as he may have more advice).
> > Then your "for-next" branch will be part of "linux-next", and will receive more
> > testing. Actually it may be a good idea to create a "for-next" branch now,
> > identical to "sh-for-4.6", let it be included in "linux-next" for a few days,
> > and send the pull request to Linus afterwards. That would catch accidentally
> > introduced breakage.
> 
> OK, I can do that. I don't anticipate any breakage since I haven't
> touched other archs but it can't hurt to check.

One question on this -- my understanding is that, unlike normal
branches intended to be pulled by others, for-next is okay to
rebase/force-push basically at any time. Is that right? I've setup a
for-next branch at:

git://git.libc.org/linux-sh for-next

It's currently aligned with the updated sh-for-4.6 branch (and the old
one renamed to sh-for-4.6-old1 in case anyone wants to compare).

Stephen, does that work for you to pull from into linux-next? Anything
else I need to do on my end?

Rich
