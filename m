From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 21 Sep 2008 08:55:06 +0000
Subject: Kernel configurations for R2D PLUS with Compact Flush support
Message-Id: <48D60BEA.2040806@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, all.

I have a plan to work on QEMU System Emulation for SH4.
Now I consider how add compact flush/CF card support for QEMU-SH.
If the CF would have supported, userland can be built on it.

But I have some troubles listed below.

- kernel configuration

  rts7751r2dplus_defconfig does not seem to enable CF support.
  I'm not sure what kind of configuration is correct for R2D PLUS.
  Enabling CONFIG_PCCARD or CONFIG_CF_ENABLER will be enough?
  Is there a sample configuration?

- CF driver

  The driver for the CF card will be a good reference to extend QEMU
  for CF.  But I'm not sure which driver module handles CF.

  R2D plus' CF area placed in area 5 which starts from 1400-0000, and
  when it is accessed via P2, the address start from b400-0000.
  The start up routine for R2D PLUS set traps for the region and 
  converted into the access to a region starts from c000-0000.

  Which driver accesses to c000-0000?  ATA drivers?

- CF interrupts handler

  The document on R2D plus says interrupts related to CF is invoked by 
  FPGA on the board.  And arch/sh/boards/mach-r2d/irq.c sets up
  IRQ_CF_CD(card detect), and IRQ_CF_IDE.  I want know which part
  of the kernel handles those interrupts.

Any help or comments will be welcome.  Thanks.

Regards,
Shin-ichiro KAWASAKI


