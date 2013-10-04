From: takasi-y@ops.dti.ne.jp
Date: Fri, 04 Oct 2013 03:08:37 +0000
Subject: incorrect conflict fix on renesas-devel-20131003?
Message-Id: <20131004120837.f9a42f7dce84c1f14f92b8a2@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi simon,

On the tree at tag:renesas-devel-20131003,
I found the first hunk of
a4fcd4f (refs/remotes/renesas/dt3) ARM: shmobile: Remove KDM9D reference DTS
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -195,7 +195,6 @@ dtb-$(CONFIG_ARCH_U8500) += ste-snowball.dtb \
        ste-ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
-       emev2-kzm9d-reference.dtb \
        r8a7740-armadillo800eva.dtb \
        r8a7778-bockw.dtb \
        r8a7778-bockw-reference.dtb \

is (accidentaly, I think) reverted in the
commit 65bf40ead9e97125644dd6601b518bfd8e13b95c
Merge: 11ef961 a4fcd4f
Author: Simon Horman <horms+renesas@verge.net.au>
Date:   Thu Oct 3 15:20:36 2013 +0900

    Merge branch 'heads/dt3' into devel
    
    Conflicts:
        arch/arm/boot/dts/Makefile

This reslts in a compilation error
| make[1]: *** No rule to make target `arch/arm/boot/dts/emev2-kzm9d-reference.dtb', needed by `dtbs'.  Stop.
| make: *** [dtbs] Error 2
if the .dtb has been removed.

Thanks,
/yoshii
