From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Dec 2015 16:56:31 +0000
Subject: [PATCH 0/3] i2c: rcar: adapt PM usage to multi master case
Message-Id: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>

If we are in a multi-master scenario, we need to block runtime PM so the
arbitration circuit stays awake.

So, we define a new binding and adapt the i2c-rcar driver to have an example
implementation.

Changes since RFC:

* added acks from Rob and Geert (thanks!)
* use of_property_read_bool() now instead of of_get_property (thanks Sergei)
* way more testing


Wolfram Sang (3):
  i2c: document binding for multi-master case
  i2c: rcar: remove macros dealing with flags
  i2c: rcar: disable PM in multi-master mode

 Documentation/devicetree/bindings/i2c/i2c.txt |  5 ++++
 drivers/i2c/busses/i2c-rcar.c                 | 39 ++++++++++++++++-----------
 2 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.1.4

