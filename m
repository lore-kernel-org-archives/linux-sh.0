From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Dec 2008 09:17:01 +0000
Subject: [PATCH 00/04] sh: gpio update
Message-Id: <20081225091701.7670.10659.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: gpio update

[PATCH 01/04] sh: make gpio_get/set_value() O(1)
[PATCH 02/04] sh: lockless gpio_get_value()
[PATCH 03/04] sh: lockless gpio_set_value()
[PATCH 04/04] sh: use gpiolib

This patchset improves the performance of the SuperH gpio
implementation and converts it to make use of gpiolib.

The patches have been tested on Migo-R with the spi_gpio driver
together with mmc_spi. Bitbanging mmc performance is improved
from about 11 KBytes/s to 40 KBytes/s.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig            |    7 
 arch/sh/boards/Kconfig     |    4 
 arch/sh/include/asm/gpio.h |   70 ++++---
 arch/sh/kernel/Makefile_32 |    2 
 arch/sh/kernel/Makefile_64 |    2 
 arch/sh/kernel/gpio.c      |  386 ++++++++++++++++++++++++++------------------
 drivers/serial/sh-sci.h    |    2 
 7 files changed, 288 insertions(+), 185 deletions(-)
