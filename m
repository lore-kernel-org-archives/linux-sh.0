From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Nov 2013 22:59:27 +0000
Subject: [PATCH 00/03] gpio: R-Car and EM GPIO update
Message-Id: <20131113225927.21449.78044.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

gpio: R-Car and EM GPIO update

[PATCH 01/03] gpio: rcar: Use lazy disable and mask on suspend
[PATCH 02/03] gpio: em: Setup gpiochip->dev
[PATCH 03/03] gpio: em: Use lazy disable and mask on suspend

Update the R-Car GPIO driver and the GPIO driver used on EMEV2 to use lazy
disable and mask on suspend. This fixes the Suspend-to-RAM behavior to make
sure wakeup sources are left enabled while suspending. Also include a small
fix for gpio-em that fixes the DT use case.
 
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.12-20131112

 drivers/gpio/gpio-em.c   |    5 ++---
 drivers/gpio/gpio-rcar.c |    3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)
