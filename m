From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 13:54:12 +0000
Subject: [PATCH 0/2] Renesas: propagate platform_get_irq() error upstream
Message-Id: <9944836.IRPmWk4iN8@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, horms@verge.net.au

Hello.

   Here's 2 patches against DaveM's 'net.git' repo. We fix error handling for
platform_get_irq() that overrides the error code with -ENODEV which e.g.
prevents the deferred probing from working.

[1/2] ravb: propagate platform_get_irq() error upstream
[2/2] sh_eth: propagate platform_get_irq() error upstream

MBR, Sergei

