From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Oct 2010 06:30:49 +0000
Subject: Re: [PATCH 0/3] ARM: mach-shmobile: FSI clock patches
Message-Id: <20101015063049.GB7489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ppqvc11ij.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ppqvc11ij.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 15, 2010 at 02:14:00PM +0900, Kuninori Morimoto wrote:
> These are latest version of my FSIDIV clock support patches.
> 
> Kuninori Morimoto (3):
>       ARM: mach-shmobile: clock-sh7372: add sh7372_ prefix to global clocks
>       ARM: mach-shmobile: clock-sh7372: FSI parent select support
>       ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
> 
> These are based on Paul's "sh_clk mapping" patch.
> 1st patch was required from Maguns.

It's good to see that the clk mapping stuff worked out for you! I'll
merge it up now that it's been tested.

The first two patches look good as-is, so I'll merge those right away.
This will now also allow us to kill off the ->init() op for all
non-legacy CPG users, which puts us in pretty good shape for supporting
the generic struct clk work when that gets finished.

> This time, I don't send patch which adds HDMI sound support for AP4,
> because I noticed that it is depend on ALSA git tree.
> I will send it if it were merged
> 
Ok, we can deal with that later in the merge window too then, so that's
not a problem.
