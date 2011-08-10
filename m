From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 10 Aug 2011 04:58:02 +0000
Subject: Re: LCDC problem after commit 794d78fea51504bad3880d14f354a9847f318f25
Message-Id: <4E420FDA.30808@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201108080125.34329.rjw@sisk.pl>
In-Reply-To: <201108080125.34329.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,
> Hi Rafael,
> 
> [Dropped Linux-PM list, added Laurent and Damian]
> 
> Laurent [CC], can you please provide us with a list of outstanding
> LCDC/MERAM patches to make this work as expected? I realize there are
> quite a few outstanding LCDC patches, but if possible please provide a
> list of the bare minimum to make this work with 3.1-rc.
> 
> I suspect that Damian [CC] is busy, but if time allows perhaps he can
> share his ideas as well.
I don't really know about the LCDC patches, but for the MERAM side the
top 5 commits from the common/fbdev-meram branch (fbdev:
sh_mobile_meram: Enable runtime PM .. fbdev: sh_mobile_lcdc: Turn dot
clock on...) + Laurent's latest patch series (sh_mobile_meram cleanup
and fixes), which fixes a suspend bug, should be everything.

If you only want the runtime portion then you can probably get by with
just the common/fbdev-meram branch.

Thanks,
Damian
