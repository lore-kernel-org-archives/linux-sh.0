From: Arnd Hannemann <arnd@arndnet.de>
Date: Mon, 20 Dec 2010 15:53:45 +0000
Subject: [PATCH 0/6 v2] mmc: tmio: Add SDIO IRQ support
Message-Id: <1292860431-16195-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
In-Reply-To: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>

[PATCH 1/6 v2] mmc: tmio: implement SDIO IRQ
[PATCH 2/6 v2] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
[PATCH 3/6 v2] mmc: tmio: disable IRQs early in remove
[PATCH 4/6 v2] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
[PATCH 5/6 v2] sh: sh7724 Enable SDIO IRQs
[PATCH 6/6 v2] [RFC] sh: sh7722 Enable SDIO IRQs

These patches add SDIO IRQ support for the tmio mmc cell
of the sh_mobile_sdhi mfd and activate the usage of
SDIO IRQs on all SoCs where sh_mobile_sdhi is currently
used.

Changes since the earlier patchset:
- Add TMIO_MMC_SDIO_IRQ flag, which expresses that  the hardware is known
  to support SDIO IRQ as suggested by Magnus Damm
- Activate this flag for sh_mobile_sdhi
- Add a patch which disables IRQs early in remove
  to avoid spurious SDIO IRQs, during module unload
- Patches 4-6 are unmodified but included for
  completeness

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
