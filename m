From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 29 Dec 2010 13:21:12 +0000
Subject: [PATCH 0/2 v2] mmc: tmio: handle missing HW interrupts
Message-Id: <1293628874-8140-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
Cc: linux-sh@vger.kernel.org

[PATCH 1/2 v2] mmc: tmio: handle missing HW interrupts
[PATCH 2/2 v2] mmc: tmio: fix CMD irq handling

This are rebased equivalents to the patches:
[1/2] tmio_mmc: handle missing HW interrupts
	https://patchwork.kernel.org/patch/201962/
[2/2] tmio_mmc: fix CMD irq handling
	https://patchwork.kernel.org/patch/201982/

They now depend on -rc7 and:
    mmc: tmio: merge the private header into the driver
            https://patchwork.kernel.org/patch/349931/

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
