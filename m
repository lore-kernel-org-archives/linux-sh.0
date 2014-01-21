From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 12:48:36 +0000
Subject: [PATCH 0/3] Renesas serial sh-sci DT fixes
Message-Id: <1390308519-31320-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

These three patches fix issues with the sh-sci DT support.

The first patch fixes a typo in the DT bindings documentation example. The two
other patches fix issues in the r8a7790 serial port DT nodes caused by merging
work in progress version of DT support instead of the latest available one.

The first two patches are candidates for v3.14-rc. I'd like to third patch to
join them if possible.

Simon, could you please pick them up ? The first patch touches DT bindings
documentation so I've CC'ed the devicetree mailing list, but the fix is so
trivial that I don't think the DT bindings maintainers' Ack is required.

Laurent Pinchart (3):
  serial: sh-sci: Fix compatible string in DT bindings example
  ARM: shmobile: r8a7790: Fix serial ports DT compatible strings
  ARM: shmobile: r8a7790: Replace IRQ type numerical values with macros

 .../bindings/serial/renesas,sci-serial.txt         |  2 +-
 arch/arm/boot/dts/r8a7790.dtsi                     | 40 +++++++++++-----------
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
Regards,

Laurent Pinchart

