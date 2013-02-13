From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 13 Feb 2013 13:11:40 +0000
Subject: [PATCH 0/3 v2] ARM: mach-shmobile: defconfig REGULATOR settings
Message-Id: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Enable REGULATOR for mackerel and armadillo800eva as
  it will be needed for MMCIF to function.
* Do not enable REGULATOR_DUMMY for kzm9g,
  it is only intended to be used for development and testing.

