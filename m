From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Jan 2011 01:29:16 +0000
Subject: Re: [PATCH] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <20110114012915.GJ8426@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110110230549.GA20886@verge.net.au>
In-Reply-To: <20110110230549.GA20886@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 14, 2011 at 06:12:28AM +0900, Paul Mundt wrote:
> On Tue, Jan 11, 2011 at 12:51:05PM +0900, Simon Horman wrote:
> > On Tue, Jan 11, 2011 at 11:51:50AM +0900, Simon Horman wrote:
> > > On Tue, Jan 11, 2011 at 11:07:51AM +0900, Paul Mundt wrote:
> > > > Blast. I thought I had all of the common/mmcif stuff rolled in via
> > > > rmobile/mmcif, but it seems this one slipped by. I'll make sure it gets
> > > > merged this time around.
> > > > 
> > > > Optionally you can just push it out without the enums resolved also, the
> > > > build target will just fail until the other patch catches up.
> > > 
> > > Ok, I guess that sounds reasonable. Its not like many people/anyone will have
> > > the config option enabled while the merge is shaking itself out.
> > 
> > Submitted to Russell's patch tracker
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idf17/1
> 
> Everything has been pulled by Linus now, so it's just this patch in
> the patch tracker that should be outstanding. You may wish to double
> check to make sure I got it all this time around :-)

Drat. There seems to be a new problem.
I'm pretty sure it wasn't there when I checked against
Linus's tree a few days ago. But in any case it is there now.

arch/arm/boot/compressed/mmcif-sh7372.o: In function `mmcif_loader':
mmcif-sh7372.c:(.text+0x9e8): undefined reference to `outer_cache

As per
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idb75/1,
my suggested fix is:

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index bf17350..1a6eb3f 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -99,7 +99,7 @@ static inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
 
 static inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
 {
-	writel(val, addr + reg);
+	__raw_writel(val, addr + reg);
 }
 
 #define SH_MMCIF_BBS 512 /* boot block size */

This code is also used by SH. So I'd value an opinion on weather this
change is valid for sh. Also on a suggested merge strategy. Paul,
I guess this should also go through your tree.

Lastly, I don't have access to my board today, so I will have to verify
the change tomorrow.

