From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Jan 2014 00:15:38 +0000
Subject: Re: [PATCH 01/10] ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <20140131001538.GF14663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3dii8yp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87k3dii8yp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 30, 2014 at 09:26:51PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/30/2014 03:56 AM, Kuninori Morimoto wrote:
> 
> >From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> >This reverts commit 41307133da4b6f242ecbb45950b9d043c0b21b96.
> 
>    Please also specify that commit's summary line in parens (since
> you're not doing this in the subject).
> 
> >DEVTMPFS is needed for udev
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> WBR, Sergei

Thanks, I have queued up the following.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig

This reverts commit 41307133da4b6f242ecbb45950b9d043c0b21b96
("ARM: shmobile: marzen: Do not enable CONFIG_DEVTMPFS defconfig").

DEVTMPFS is needed for udev.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
[horms+renesas@verge.net.au: Added subject of reverted patch to changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index f21bd40..92994f7 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -43,6 +43,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
