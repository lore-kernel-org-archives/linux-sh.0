From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 08 Feb 2009 19:52:17 +0000
Subject: Re: [PATCH] sh: maple: add support for Visual Memory Card devices,
Message-Id: <1234122737.6736.17.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1234122069.6736.8.camel@localhost.localdomain>
In-Reply-To: <1234122069.6736.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, dwmw2 <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Great start... sorry here is correct diff stat for these patches...

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---
 
 drivers/input/joystick/maplecontrol.c |    4 +-
 drivers/input/keyboard/maple_keyb.c   |   37 +-
 drivers/mtd/maps/Kconfig              |   12 +-
 drivers/mtd/maps/Makefile             |    1 +
 drivers/mtd/maps/vmu-flash.c          |  827 +++++++++++++++++++++++++++++++++
 drivers/sh/maple/maple.c              |  463 ++++++++++---------
 include/linux/maple.h                 |   62 ++-
 7 files changed, 1139 insertions(+), 267 deletions(-)

