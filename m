From: Simon Horman <horms@verge.net.au>
Date: Sun, 26 Dec 2010 22:45:07 +0000
Subject: SDHI polling
Message-Id: <20101226224506.GD21535@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I have it in mind to run the SDHI hardware block in some sort of
polling mode - that is, with interrupts disabled - during early
boot. Does this make any sense?

The aim is to be able to read a kernel off an SD card and then boot from it.

