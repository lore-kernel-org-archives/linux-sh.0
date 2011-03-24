From: Simon Horman <horms@verge.net.au>
Date: Thu, 24 Mar 2011 07:04:36 +0000
Subject: mmc: zboot helpers
Message-Id: <1300950278-17274-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[ repost as I included a bogus email address in my previous attempt ]

Hi Paul,

please consider merging the following two patches.
They are both pre-requisites for
"mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM"
which I plan to submit to Russell King.

These patches were originally submitted in a for patch series
however they do not depend on any of the other patches in the series
so I am posting them independently.

These patches apply against Linus's current tree
and I am not aware of any particular prerequisites for them
other than that the 2nd patch depends on the 1st one.

