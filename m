From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 15 Feb 2011 11:47:20 +0000
Subject: [RFC, PATCH 0/4] net: sh_eth: modify for both modules
Message-Id: <4D5A67C8.3010908@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: SH-Linux <linux-sh@vger.kernel.org>

This current driver supports ETHER and GETHER. But we cannot
use them at same time because the defination of registers is
hardcoded by #ifdef in sh_eth.h.
The patches modify the defination to arrays of const. Then
we can choose the array by platform_device's data.
The patches also modify for GETHER. The current driver used
the "#ifdef CONFIG_CPU_SUBTYPE_SH7763". The patches remove it
and check by other method for GETHER.
