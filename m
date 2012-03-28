From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Mar 2012 04:42:04 +0000
Subject: Re: [PATCH] sh/next: Fix build fail by asm/system.h in asm/bitops.h
Message-Id: <20120328044204.GO26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 28, 2012 at 01:41:43PM +0900, Nobuhiro Iwamatsu wrote:
> Guennadi Liakhovetski ????????????????????????:
> >On Fri, 9 Mar 2012, Nobuhiro Iwamatsu wrote:
> >
> >>Paul Mundt ????????????????????????:
> >>>On Tue, Mar 06, 2012 at 02:07:09PM +0900, Nobuhiro Iwamatsu wrote:
> >>>>Other files are not done include definitely by asm/system.h made
> >>>>include in asm/bitops.h.
> >>>>This patch remove asm/system.h from asm/bitops.h.
> >>>>
> >>>Which defconfig were you using that hit this? asm/system.h is usually
> >>>included for a reason, although I can't remember off the top of my head
> >>>what's used out of it and on what CPU configuration, but I would be
> >>>rather hesitant to yank it out on an N of 1 build test.
> >>>
> >>Sorry, I checked sh7785lcr and ap325rxa and other.
> >>We can confirm this problem in linux-next.
> >
> >This breakage is now in the mainline too, please, fix. Paul, if you're 
> >concerned about removing asm/system.h, the below diff preserves it in 
> >asm/bitops.h, but is much uglier, so, I hope the original patch gets 
> >applied.
> 
> Tested-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Ok, it seems to hold up for random builds and all of the configurations I
tested, so perhaps whatever reason we needed the header there for in the
first place went away some time ago and I never noticed.

I've applied the original now, thanks.
