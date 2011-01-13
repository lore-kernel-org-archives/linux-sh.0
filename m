From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 21:12:28 +0000
Subject: Re: [PATCH] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <20110113211228.GB20418@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110110230549.GA20886@verge.net.au>
In-Reply-To: <20110110230549.GA20886@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 11, 2011 at 12:51:05PM +0900, Simon Horman wrote:
> On Tue, Jan 11, 2011 at 11:51:50AM +0900, Simon Horman wrote:
> > On Tue, Jan 11, 2011 at 11:07:51AM +0900, Paul Mundt wrote:
> > > Blast. I thought I had all of the common/mmcif stuff rolled in via
> > > rmobile/mmcif, but it seems this one slipped by. I'll make sure it gets
> > > merged this time around.
> > > 
> > > Optionally you can just push it out without the enums resolved also, the
> > > build target will just fail until the other patch catches up.
> > 
> > Ok, I guess that sounds reasonable. Its not like many people/anyone will have
> > the config option enabled while the merge is shaking itself out.
> 
> Submitted to Russell's patch tracker
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idf17/1

Everything has been pulled by Linus now, so it's just this patch in
the patch tracker that should be outstanding. You may wish to double
check to make sure I got it all this time around :-)
