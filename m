From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Oct 2014 00:41:31 +0000
Subject: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <20141028004131.GA8280@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I have noticed that there appears to be a regression between v3.17 and
v3.18-rc1 such that non-multiplatform APE6EVM (ape6evm_defconfig) no longer
boots.  This appears to be the case using both reference DT (MACH_APE6EVM)
and Legacy-C (MACH_APE6EVM_REFERENCE).

I have tried bisecting this problem but dew a blank: the problem
seems to arise on a merge commit.

This problem also seems to be present in v3.18-rc2 and the devel and next
branches of my renesas tree (which are based on v3.18-rc2 and v3.18-rc1
respectively).

To be clear this problem, whatever it is, does not seem to affect
multiplatform APE6EVM (shmobile_defconfig).
