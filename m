From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Dec 2009 08:11:27 +0000
Subject: v2.6.33-rc2 build error - missing tmio mmc patches
Message-Id: <aec7e5c30912280011j4e8528e5r34bc1bcfb6a4dd1a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi everyone,

v2.6.33-rc2 does not build in the case of CONFIG_MFD_SH_MOBILE_SDHI=y.
Linux-next used to build just fine when I developed the driver, but
now it looks like some tmio-mmc patches present in linux-next never
made it into -rc.

  CC      drivers/mfd/sh_mobile_sdhi.o
drivers/mfd/sh_mobile_sdhi.c: In function 'sh_mobile_sdhi_probe':
drivers/mfd/sh_mobile_sdhi.c:100: error: 'struct tmio_mmc_data' has no
member named 'set_pwr'
make[2]: *** [drivers/mfd/sh_mobile_sdhi.o] Error 1

In more detail, the missing patch is here:
http://git.mnementh.co.uk/cgi-bin/gitweb.cgi?p=linux-2.6-im.git;a=commitdiff;hLd83bd05e6c817a4a72ababd82bf5ae700c021d

What needs to be done to get the patch above included in rc3? Is there
anything I can do?

Thanks,

/ magnus
