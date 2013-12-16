From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 16 Dec 2013 00:34:07 +0000
Subject: [PATCH 0/2] ARM: shmobile: koelsch: defconfig updates
Message-Id: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Updates for Koelsch defconfig to allow it to boot
a Debian armhf userspace and to bring it into line
with other shmobile defconfigs.

Based on the renesas-devel-v3.13-rc3-20131214v2 tag
of my renesas tree.

Simon Horman (2):
  ARM: shmobile: koelsch: Enable CONFIG_PACKET in defconfig
  ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in
    defconfig

 arch/arm/configs/koelsch_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.4

