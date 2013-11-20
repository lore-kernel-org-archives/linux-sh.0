From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 00:22:59 +0000
Subject: [PATCH 00/05] gpio: R-Car and EM GPIO update V2
Message-Id: <20131120002259.27342.35575.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

gpio: R-Car and EM GPIO update V2

[PATCH 01/05 v2] gpio: rcar: Use lazy disable
[PATCH 02/05 v2] gpio: rcar: Enable mask on suspend
[PATCH 03/05] gpio: em: Setup gpiochip->dev
[PATCH 04/05 v2] gpio: em: Use lazy disable
[PATCH 05/05 v2] gpio: em: Enable mask on suspend

Update the R-Car GPIO driver and the GPIO driver used on EMEV2 to use lazy
disable and mask on suspend. This fixes the Suspend-to-RAM behavior to make
sure wakeup sources are left enabled while suspending. Also include a small
fix for gpio-em that fixes the DT use case.

Thanks to Laurent and Linus for feedback.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.12-20131119

 Changes since V1:
 - Split lazy disable and mask on suspend patches
 - Improved commit messages

 drivers/gpio/gpio-em.c   |    5 ++---
 drivers/gpio/gpio-rcar.c |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

