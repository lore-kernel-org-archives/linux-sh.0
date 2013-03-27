From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 12:11:05 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: add thermal driver support
Message-Id: <20130327121103.GB15520@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
 <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li9ait0c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 25, 2013 at 11:18:15PM -0700, Kuninori Morimoto wrote:
> You can get current thermal by
> > cat /sys/class/thermal/thermal_zone?/temp
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi         |    7 +++++++
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   13 ++++++++++++-
>  arch/arm/mach-shmobile/setup-r8a73a4.c |   15 +++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)

Queued up for v3.10 in the soc branch.
