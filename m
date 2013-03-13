From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Mar 2013 11:32:03 +0000
Subject: [PATCH 00/03] gpio: Renesas R-Car GPIO driver update
Message-Id: <20130313113203.30133.49539.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

gpio: Renesas R-Car GPIO driver update

[PATCH 01/03] gpio: Renesas R-Car GPIO driver V2
[PATCH 02/03] gpio: rcar: Use IRQCHIP_SET_TYPE_MASKED
[PATCH 03/03] gpio: rcar: Make use of devm functions

This series updates the R-Car GPIO driver with various
changes kindly suggested by Laurent Pinchart.

Patch [01/03] is a drop in replacement for V1 of the R-Car
GPIO driver. The flag in patch [02/03] is kept out of [01/03]
to avoid changing the behaviour of the driver between V1 and V2.
Also, devm support in [03/03] is kept out of [01/03] to make
sure back porting goes as smooth as possible.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/gpio/Kconfig                    |    6 
 drivers/gpio/Makefile                   |    1 
 drivers/gpio/gpio-rcar.c                |  417 +++++++++++++++++++++++++++++--
 include/linux/platform_data/gpio-rcar.h |   25 +
 4 files changed, 427 insertions(+), 22 deletions(-)
