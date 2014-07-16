From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Jul 2014 15:21:18 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: Remove MACH_GENMAI
Message-Id: <20140716152118.GA22514@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1405512176-7234-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405512176-7234-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 16, 2014 at 11:24:18PM +0900, Simon Horman wrote:
> On Wed, Jul 16, 2014 at 02:02:56PM +0200, Laurent Pinchart wrote:
> > The CONFIG_MACH_GENMAI option has been removed in commit bec652e2fbfe
> > ("ARM: shmobile: r7s72100: genmai: Remove legacy board file"). Remove
> > the leftovers from shmobile_defconfig.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  arch/arm/configs/shmobile_defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > Simon, could you please queue this on top of your MACH_GENMAI removal
> > branch ?
> 
> Thanks,  have applied this to the deconfigs branch and
> plan to send it in parallel with the MACH_GENMAI removal branch.

On reflection I have rearranged my branches so that this patch and
the one to remove genmai_defconfig come before the patches to remove
the genmai board code. This seems more logical and should avoid
the build failing in between removal of the code and the defconfig.

I updated the changelog a little to reflect this approach.
I hope that I haven't messed anything up.


From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

ARM: shmobile: defconfig: Remove MACH_GENMAI

The CONFIG_MACH_GENMAI is scheduled for removal so remove it from
shmobile_defconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas@verge.net.au: revised changelog for updated commit order]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 6bc85a5..3b13614 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,7 +14,6 @@ CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
-CONFIG_MACH_GENMAI=y
 CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
-- 
2.0.0

