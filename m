From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Nov 2012 00:38:19 +0000
Subject: Single zImage for Armadillo and KZM9G
Message-Id: <7563707.giGeIu5Uba@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I've been trying to boot the same zImage on both Armadillo (r8a7740) and KZM9G 
(sh73a0) and stumbled on CONFIG_MEMORY_START. Armadillo has the memory start 
at 0x40000000 while KZM9G seems to reserver the first 16MB, and thus starts at 
0x41000000.

The memory address and size can be specified per-board in the device tree, but 
a mismatch between the DT memory start and CONFIG_MEMORY_START results in a 
pretty hard boot failure (tested on Armadillo).

Has anyone run into the same issue ? Pointers would be appreciated.

-- 
Regards,

Laurent Pinchart

