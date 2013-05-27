From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 27 May 2013 22:38:17 +0000
Subject: [PATCH 0/3] Optimize R-Car SATA driver
Message-Id: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's the set of 3 patches against the Tejun Heo's 'libata.git' repo's
'for-3.11' branch.
   They deal with some shortcomings in the R-Car SATA driver and generally
optimize it. I've come up with them while trying to add NCQ support to this
driver.

[1/3] sata_rcar: kill superfluous code in sata_rcar_bmdma_fill_sg()
[2/3] sata_rcar: correct 'sata_rcar_sht'
[3/3] sata_rcar: add 'base' local variable to some functions

MBR, Sergei
