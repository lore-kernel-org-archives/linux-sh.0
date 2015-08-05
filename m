From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Aug 2015 00:55:37 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: Misc removals
Message-Id: <20150805005537.GA20726@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 04, 2015 at 08:03:05PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series (against renesas-devel-20150804-v4.2-rc5) removes
> various header files, source files, declarations and definitions that
> are no longer in use.
> 
> Dependencies:
>   - Patch 1 depends on v3.12,
>   - Patches 2-5 depend on the sh73a0/kzm9g and r8a7740/armadillo legacy
>     removal, which is in arm-soc/for-next,
>   - Patches 6-7 depend on the r8a7779/marzen legacy removal, which is in
>     marzen-board-removal-for-v4.3.
> 
> Note that I didn't remove the now unused r8a7779_init_pm_domains() et al
> yet, as I need to have a closer look on what to retain for R-Car DT SYSC
> PM Domains first.
> 
> Thanks!

Thanks, I have tentatively queued these up for v4.4 as I feel
that the bottom of our stack of patches at a fresh cycle is
the best place for these kinds of cleanups.
