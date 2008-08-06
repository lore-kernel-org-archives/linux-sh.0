From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Aug 2008 10:58:47 +0000
Subject: [PATCH 0/2] rtc: rtc-rs5c372: SMBus and R2025S/D support, v2.
Message-Id: <20080806105847.GA5354@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series introduces a bit of rework to the rtc-rs5c732 driver,
mostly aimed at supporting the R2025S/D series of I2C/SMBus RTCs. The
biggest change is the conversion to using SMBus accesses for general
access and relying on SMBus emulation from the other I2C adapters.

This consists of a respin of the earlier patches that have been hanging
around in -mm for some time, hopefully now with the remainder of the
issues raised sorted out. Thanks to Riku for testing on IOP3xx, which was
the only quirky adapter with hacks in this driver!

[PATCH 1/2] rtc: rtc-rs5c372: SMBus conversion/support
[PATCH 2/2] rtc: rtc-rs5c372: add support for Ricoh R2025S/D RTC

This is necessary for RTC support on the sh highlander machine type.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: David Brownell <david-b@pacbell.net>
Tested-by: Riku Voipio <riku.voipio@movial.fi>

---

 drivers/rtc/rtc-rs5c372.c |  234 +++++++++++++++++++++++++++++-----------------
 1 file changed, 151 insertions(+), 83 deletions(-)
