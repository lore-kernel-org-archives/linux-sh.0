From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:04 +0000
Subject: [PATCH 0/3] ARM: shmobile: ape6evm-reference: add missing devices
Message-Id: <1417509427-31690-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This adds the devices present in the legacy platform that are not yet in
reference, namely LEDs, keypad, and ethernet controller.

CU
Uli


Ulrich Hecht (3):
  ARM: shmobile: ape6evm-reference: add ethernet controller to DT
  ARM: shmobile: ape6evm-reference: Add LEDs to the device tree
  ARM: shmobile: ape6evm-reference: Add keypad to the device tree

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 82 +++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

-- 
1.8.4.5

