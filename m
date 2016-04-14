From: Rich Felker <dalias@libc.org>
Date: Thu, 14 Apr 2016 03:36:02 +0000
Subject: Re: [GIT PULL] arch/sh fixes for regressions in 4.6-rc1
Message-Id: <20160414033602.GY21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160413014557.GA18973@brightrain.aerifal.cx>
 <CA+55aFxKUhS=3Ui34J4r8ShLrGs9XpcdDT0=txFL4OE8km_oJQ@mail.gmail.com>
In-Reply-To: <CA+55aFxKUhS=3Ui34J4r8ShLrGs9XpcdDT0=txFL4OE8km_oJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, Apr 13, 2016 at 01:08:29PM -0700, Linus Torvalds wrote:
> On Tue, Apr 12, 2016 at 6:45 PM, Rich Felker <dalias@libc.org> wrote:
> >
> > Please pull these changes (regression fixes only) for arch/sh. They're
> > based on 4.6-rc1 when I did them, but apply cleanly to 4.6-rc3 and
> > build successfully.
> 
> So I pulled this, but please don't do this:
> 
>     16b02d711f40 Merge tag 'v4.6-rc1'
> 
> there's no information in that merge commit why it would be needed,
> and I cant' for the life of me see *why* it would be needed.
> 
> If you cannot explain why a merge is necessary, you should not do the
> merge. It's really that simple.
> 
> So please
> 
>  - either just apply patches on top of your tree (no "let's merge
> Linus' tree first")
> 
>  - or make your tree *start* at whatever base you want to use (ie
> "let's check out v4.6-rc1, and apply patches on top of that base
> commit")/
> 
> But do *not* start doing back-merges that aren't explained.

Sorry about that. My reason for starting with 4.6-rc1 was that I only
tested the changes on it, not my previous (pre-merge) version. But I
should have just rebased them on a clean branch from 4.6-rc1 rather
than merging my own, right (your option 2 above)?

> The back-merges make history harder to follow, and makes the graph
> that gitk shows much messier. And _any_ commit that doesn't actually
> explain why it is doing something is wrong, whether it's a merge or
> not.
> 
> Anyway, the pull is in my tree, and I'll push it out soon, so you
> don't need to do anything for this one. This complaint was purely a
> "going forward" issue.

Thanks!

Rich
