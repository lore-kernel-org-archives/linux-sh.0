From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 28 May 2015 15:16:59 +0000
Subject: [PATCH 0/6] r8a7793 SoC DT bindings
Message-Id: <1432826225-6743-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, geert@linux-m68k.org
Cc: horms@verge.net.au, linux-sh@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

This series contains the DT bindings used by the r8a7793 SoC;
it has been split off the "r8a7793 SoC, Gose board support"
version 3 series.

CU
Uli

Changes since "r8a7793 SoC, Gose board support" v3:
- updated "fallback" paragraph in cmt bindings


Ulrich Hecht (6):
  clk: shmobile: Add r8a7793 SoC to MSTP bindings
  clk: shmobile: r8a7793: document DIV6 clock bindings
  mmc: sh_mmcif: Document r8a7793 DT bindings
  serial: sh-sci: Add device tree bindings for r8a7793
  PCI: rcar: document r8a7793 DT bindings
  clocksource: sh_cmt: Document r8a7793-specific bindings

 .../devicetree/bindings/clock/renesas,cpg-div6-clocks.txt    |  3 ++-
 .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt    |  3 ++-
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt      |  1 +
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt      |  1 +
 .../devicetree/bindings/serial/renesas,sci-serial.txt        | 12 ++++++++----
 Documentation/devicetree/bindings/timer/renesas,cmt.txt      |  7 +++++--
 6 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.3.5

