From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Jan 2014 00:09:42 +0000
Subject: Re: [PATCH 08/10] ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig
Message-Id: <20140131000942.GC14663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9eei8vz.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a9eei8vz.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 30, 2014 at 09:28:16PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/30/2014 03:57 AM, Kuninori Morimoto wrote:
> 
> >From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> >This reverts commit e14ee5deab24200e4b70fe31a8c806f0acd3d37c.
> 
>    Again please specify the summary line of that commit.
> 
> >DEVTMPFS is needed for udev
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks Morimoto-san, Thanks Sergei,

I have updated the changelog to include the summary line and queued up the
following.

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig

This reverts commit e14ee5deab24200e4b70fe31a8c806f0acd3d37c
("ARM: shmobile: bockw: Do not enable CONFIG_DEVTMPFS defconfig").

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
[horms+renesas@verge.net.au: Added subject of reverted commit to changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 80cff50..e816140 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -44,6 +44,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set

