From: Arnd Hannemann <arnd@arndnet.de>
Date: Tue, 24 Aug 2010 15:26:58 +0000
Subject: [PATCH 0/4] Fix/improve hotplug for sh_mobile_sdhi/tmio_mmc/sh_mmcif
Message-Id: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ian@mnementh.co.uk
Cc: sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com

This patch series attempts to fix hotplug (for sh_mobile_sdhi/tmio_mmc) and 
improve hotplug (for sh_mmcif) on the AP4EVB (shmobile) board, by handling the 
card detect in platform code.

Best regards,
Arnd

