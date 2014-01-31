From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Jan 2014 00:08:24 +0000
Subject: Re: [PATCH 03/10] ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <20140131000822.GB14663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ha8mi8xt.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ha8mi8xt.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 29, 2014 at 04:56:33PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> DEVTMPFS is needed for udev
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/configs/lager_defconfig |    2 ++
>  1 file changed, 2 insertions(+)

Thanks.

There was a minor conflict when applying this patch.
I have queued up the following, please check that it is correct.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig

DEVTMPFS is needed for udev

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
[horms+renesas@verge.net.au: resolved trivial conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index ee93b8a..3e7e0ae 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -49,6 +49,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
