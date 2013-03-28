From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Mar 2013 00:36:34 +0000
Subject: pinmux missing from next in renesas tree
Message-Id: <20130328003634.GF20736@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unfortunately I forgot to merge pinmux into the next branch
I pushed last night and tagged as renesas-next-20130327.

I have re-pushed and re-taged with pinmux merged.
And also pushed pinmux which was one patch behind my local version.

For reference the relevant commit ids are:

next, renesas-next-20130327: 3f9904f90ec7729c8ac0bc554fed67d4f9d5bd59
			     (Merge branch 'pinmux' into next)
pinmux: 5ae81435c987e2ef071452d438770865814e8390
        (sh-pfc: r8a7779: Split DU input and output pixel clocks)

