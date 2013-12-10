From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 10 Dec 2013 02:34:45 +0000
Subject: [PATCH] ARM: shmobile: remove unnecessary platform_device as header cleanup
Message-Id: <871u1ll9ha.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hajocc4i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hajocc4i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

8e0e7aaef3c98c52e85f5640b73ffa82058abcfd
(ARM: shmobile: Drop r8a7779_add_device_to_domain())
removed last user of struct platform_device on this header.
It is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 5014145..b40e1363 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -11,8 +11,6 @@ enum {
 	HPBDMA_SLAVE_SDHI0_RX,
 };
 
-struct platform_device;
-
 struct r8a7779_pm_ch {
 	unsigned long chan_offs;
 	unsigned int chan_bit;
-- 
1.7.9.5

