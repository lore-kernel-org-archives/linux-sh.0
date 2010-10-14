From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Oct 2010 09:12:31 +0000
Subject: [patch v3 0/2] ARM: mach-shmobile: Add zboot support for SuperH Mobile ARM
Message-Id: <20101014091231.858799238@vergenet.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this short patch series by Kuninori Morimoto and myself adds
zboot support to mach-shmobile.

This is v3 of this patch series. It implements Magnus's suggestion
of initialising atags directly rather than using assembly.

v2 implemented Magnus's suggestion of setting atags in the framework and
passing them to the kernel rather than using a board-specific fixup.

