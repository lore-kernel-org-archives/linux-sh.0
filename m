From: Bill Traynor <wmat@naoi.ca>
Date: Sun, 04 Jul 2010 18:11:15 +0000
Subject: upgrading u-boot from linux for SH7785LCR board
Message-Id: <4C30CEC3.1050003@naoi.ca>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've compiled and tested u-boot from git for the 7785lcr board.  I'd 
like to write the u-boot.bin to flash but do not have a JTAG to be able 
to recover if the write fails.

Given the MTD layout:
dev:    size   erasesize  name
mtd0: 00080000 00040000 "loader"
mtd1: 00080000 00040000 "bootenv"
mtd2: 00400000 00040000 "kernel"
mtd3: 03b00000 00040000 "data"

Is it reasonable to do the following:

flash_erase /dev/mtd[0]
dd if=/tmp/u-boot.bin of=/dev/mtd0 bs8k conv=sync

I'd rather not brick the board I have, so if someone who does have the 
capability to recover could test this method for me, it'd be appreciated.

Thanks
Bill
