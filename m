From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 16 Mar 2010 02:01:33 +0000
Subject: [PATCH] sh: mach-ecovec24: Add i2c_put_adapter on sh_eth_init
Message-Id: <uy6htyqgy.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

i2c_put_adapter is needed after i2c_get_adapter

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 39ed872..6c13b92 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -836,6 +836,8 @@ static void __init sh_eth_init(struct sh_eth_plat_data *pd)
 		pd->mac_addr[i] = mac_read(a, 0x10 + i);
 		msleep(10);
 	}
+
+	i2c_put_adapter(a);
 }
 #else
 static void __init sh_eth_init(struct sh_eth_plat_data *pd)
-- 
1.6.3.3

