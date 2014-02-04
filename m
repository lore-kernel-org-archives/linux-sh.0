From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 04 Feb 2014 14:48:34 +0000
Subject: [PATCH 0/2] Add Ether's PHY IRQ support for R8A7790/Lager board
Message-Id: <201402041848.51711.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.13-rc4-20131219' tag. Here we add support for the Ether's PHY
IRQ to the R8A7790/Lager board. The patchset depends on the two 'sh_eth' driver
patches posted earlier in order to compile and work. It would be good if Dave Miller
could merge these patches thru his tree, along with 'sh_eth' patches as this
would have prevented delaying these patches to 3.15 which seems inevitable
otherwise (well, unless Simon merges net-next to his tree?). I'll rebase the
patches to the 'net-next.git' repo if Dave consents to merging them...

[1/2] ARM: shmobile: Lager: pass Ether PHY IRQ
[2/2] ARM: shmobile: Lager: conditionally select CONFIG_MICREL_PHY

WBR, Sergei
