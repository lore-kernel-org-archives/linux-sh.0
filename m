From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 14 Oct 2014 07:01:39 +0000
Subject: [PATCH 0/4] ARM: shmobile: Add clock to DT
Message-Id: <1413270103-9517-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1412848985-29353-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series is based on the renesas-devel-20141007-v3.17 tag
of Simon's renesas tree.

Changes from v1:
 - change the clock name to "3dg" from "pvrsrvkm".
 - use the clock name "fdp1-2", "fdp1-1", "fdp1-0", instead of "fdp2",
   "fdp1" and "fdp0".
 - change the definition according to the clock name.

Kouei Abe (2):
  ARM: shmobile: r8a7790: Add RGX clock to device tree
  ARM: shmobile: r8a7791: Add SGX clock to device tree

Yoshifumi Hosoya (2):
  ARM: shmobile: r8a7790: Add MMP clock to device tree
  ARM: shmobile: r8a7791: Add MMP clock to device tree

 arch/arm/boot/dts/r8a7790.dtsi            | 23 +++++++++++++++--------
 arch/arm/boot/dts/r8a7791.dtsi            | 22 ++++++++++++++--------
 include/dt-bindings/clock/r8a7790-clock.h | 12 +++++++++++-
 include/dt-bindings/clock/r8a7791-clock.h |  9 ++++++++-
 4 files changed, 48 insertions(+), 18 deletions(-)

-- 
1.9.1

