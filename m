From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Wed, 05 Mar 2008 23:25:48 +0000
Subject: Behaviour of device_register
Message-Id: <8b67d60803051525g3aca775dmc14d1c2450b34168@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-sh <linux-sh@vger.kernel.org>

The observed behaviour for me is that it appears to be blocking the
vblank interrupt on my box (or more accurately stopping the workqueue
that the interrupt handler calls from running). And without the vblank
my bus won't process dma and so therefore the attempt to register the
device in question fails.

But I can see no reason from a glance over the code why that (vblanks
being blocked) would be the case - have I missed something and the
vblanks will be blocked, or should I be looking elsewhere for the root
cause of this problem?

Thanks

Adrian
