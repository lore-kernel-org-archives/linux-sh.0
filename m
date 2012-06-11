From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 09:14:05 +0000
Subject: Re: [PATCH 17/27] ARM: shmobile: armadillo800eva: enable HDMI
Message-Id: <20120611091404.GC22966@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5nupkl5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5nupkl5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:56:57PM -0700, Kuninori Morimoto wrote:
> This patch enable HDMI support on CON3.
> And removed unnecessary CONFIG_SYSFS_DEPRECATED_xxx config.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I have tested that with this patch applied the kernel detects HDMI hardware.

sh-mobile-hdmi sh-mobile-hdmi: Detected HDMI controller 0x1:0xd5
sh-mobile-hdmi sh-mobile-hdmi: SH Mobile HDMI Audio Codec
asoc: sh_mobile_hdmi-hifi <-> fsib-dai mapping ok
  #1: FSI2B-HDMI

However, I am not sure what if any testing I can perform using,
for example speaker-test.

Unfortunately I don't have an HDMI device to hook up to the board.

> ---
>  arch/arm/configs/armadillo800eva_defconfig     |   10 +--
>  arch/arm/mach-shmobile/board-armadillo800eva.c |  100 ++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 9 deletions(-)
