From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Sep 2014 20:12:46 +0000
Subject: [PATCH v2 0/3] R-Car I2C driver: some cleanups
Message-Id: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

   Here's the set of 3 patches against Wolfram Sang's 'linux.git' repo's
'i2c/for-next' branch.

[1/3] i2c-rcar: simplify check for last message
[2/3] i2c-rcar: make rcar_i2c_prepare_msg() *void*
[3/3] i2c-rcar: make rcar_i2c_irq_recv() *void*

WBR, Sergei

