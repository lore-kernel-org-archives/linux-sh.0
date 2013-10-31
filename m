From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 Oct 2013 08:46:24 +0000
Subject: Question about r8a7779 ether
Message-Id: <87fvrhq143.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

You know, we are removing r8a7779_add_xxx_device()
from setup-r8a7779.
When I cleaned these functions from setup-r8a7779,
if my memory was correct, Sergei requested not to clean up
r8a7779_add_ether_device(), since he sends patch for marzen.

But current marzen still doesn't use it.
I'm checking renesas-devel-v3.12-rc7-20131030 tag.
According to git log, r8a7779_add_ether_device() was added Apr 2013,
and today, Nov 2013.

Does Marzen need it ?
If yes, who has this patch ? or what is current status of it ?

No one is using it in this 6 month.
(and normal marzen board doesn't have sh_eth implement).
Can I remove it anyway ?

r8a7779_add_ether_device() was added by this commit

dace48d04dee46a3409d5e13cd98031522e46377
Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date:   Thu Apr 4 18:53:50 2013 +0000

    ARM: shmobile: R8A7779: add Ether support
    
    Add Ether clock and platform device for R8A7779 SoC; add a function to register
    this device with board-specific platform data.
    
    Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
