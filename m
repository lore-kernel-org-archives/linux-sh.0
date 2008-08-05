From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 05 Aug 2008 19:26:37 +0000
Subject: Re: [PATCH] SH2(A) cache update
Message-Id: <87sktjmff6.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87hcb37h0a.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87hcb37h0a.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Mon, 4 Aug 2008 16:35:25 +0900,
Paul Mundt wrote:
> 
> On Tue, Jul 08, 2008 at 04:20:31PM -0400, Yoshinori Sato wrote:
> > Sorry I forget flush_icache_region.
> > Update patch.
> > 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > 
> I've checked in a cleaned up version of this patch, thanks. Hopefully
> this will also fix the signal trampoline problems Yoshii-san was running
> in to on SH-2A due to the missing flush_icache_region().

addrspace.h?
Sorry I missing commit.

I checked now. No missing files.

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
