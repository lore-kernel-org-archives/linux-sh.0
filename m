From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 12 Sep 2014 08:51:10 +0000
Subject: [PATCH 0/6] ARM: shmobile: various DT files sorted by address
Message-Id: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, Olof Johansson <olof@lixom.net>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

Here's a bunch of DT files sorted by address only.  I hope nobody sees a
need to break those down any further.

None of these patches depend on each other, or anything else for that
matter, so feel free to pick and choose.

Olof, is there a consensus on other sort criteria?  I'm thinking of
"'compatible' first", for instance.  (Should that take precedence over #... 
properties, too?  I have implemented that as the default in
https://github.com/uli/dtssort, but it looks slightly odd to me.)

CU
Uli


Ulrich Hecht (6):
  ARM: shmobile: r7s72100: sort dtsi file by address
  ARM: shmobile: emev2: sort dtsi file by address
  ARM: shmobile: kzm9d: sort dts file by address
  ARM: shmobile: r8a73a4: sort dtsi file by address
  ARM: shmobile: ape6evm: sort dts file by address
  ARM: shmobile: ape6evm-reference: sort dts file by address

 arch/arm/boot/dts/emev2-kzm9d.dts               |  62 +++----
 arch/arm/boot/dts/emev2.dtsi                    | 120 ++++++------
 arch/arm/boot/dts/r7s72100.dtsi                 | 202 ++++++++++-----------
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |  26 +--
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |  36 ++--
 arch/arm/boot/dts/r8a73a4.dtsi                  | 232 ++++++++++++------------
 6 files changed, 339 insertions(+), 339 deletions(-)

-- 
1.8.4.5

