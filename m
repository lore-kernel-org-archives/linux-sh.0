From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Sun, 04 Jul 2010 23:01:29 +0000
Subject: Re: upgrading u-boot from linux for SH7785LCR board
Message-Id: <4C3112C9.8060704@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C30CEC3.1050003@naoi.ca>
In-Reply-To: <4C30CEC3.1050003@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Bill.

Bill Traynor wrote:
> I've compiled and tested u-boot from git for the 7785lcr board.  I'd 
> like to write the u-boot.bin to flash but do not have a JTAG to be able 
> to recover if the write fails.
> 
> Given the MTD layout:
> dev:    size   erasesize  name
> mtd0: 00080000 00040000 "loader"
> mtd1: 00080000 00040000 "bootenv"
> mtd2: 00400000 00040000 "kernel"
> mtd3: 03b00000 00040000 "data"
> 
> Is it reasonable to do the following:
> 
> flash_erase /dev/mtd[0]
> dd if=/tmp/u-boot.bin of=/dev/mtd0 bs8k conv=sync

I think that you shoud use flashcp command if you use flash_erase.
This command is in mtd-utils ( same flash_erase).

Best regards,
   Nobuhiro
