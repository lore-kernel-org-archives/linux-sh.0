From: Simon Horman <horms@verge.net.au>
Date: Fri, 26 Jul 2013 02:38:33 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <20130726023831.GB32490@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2q8xvck.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2q8xvck.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 24, 2013 at 12:36:51AM -0700, Kuninori Morimoto wrote:
> This patch adds a sample DT-based Bock-W "reference" implementation.
> The use of platform-specific C-code should be avoided
> with this configuration as much as possible.
> 
> This patch adds new r8a7778_add_dt_devices() which was same stance
> of r8a7790_add_dt_devices()
> 
> Acked-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Simon
> 
> This is remake version of BockW DT support.
> Prev patch depended on clean-up patch,
> but it is possible to separate cleanup <--> DT.
> I will re-work for cleanup patchset later.
> This patch is based on renesas-devel-20130724 tag

Thanks, I will queue this up for v3.12 in the dt2 branch.
