From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 04 Dec 2015 21:55:54 +0000
Subject: [PATCH 0/2] Renesas: read MAC address registers only once
Message-Id: <10429393.qU4CxZ5nlj@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's 2 patches against DaveM's 'net-next.git' repo. Here we optimize the
MAC address register reading (left over from a bootloader).

[1/2] ravb: read MAC address registers only once
[2/2] sh_eth: read MAC address registers only once

MBR, Sergei

