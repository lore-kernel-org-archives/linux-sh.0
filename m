From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Tue, 31 Mar 2009 13:19:24 +0000
Subject: qemu-sh CF access perormance
Message-Id: <49D2185C.4050909@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi.  I have a question related to qemu-sh.

I use qemu-sh r2d emulation and userland on compact flush as qemu disk image,
to investigate why qemu-sh system emulation is slower than qemu-arm.

For example, it takes only around 1 second to compile simple hello.c with
gcc on qemu-arm system emulation.  On the other hand, it takes around 40
seconds on qemu-sh system emulation.

This compile time (40 secs) reduces to less than 6 seconds, if I repeat to
invoke "% gcc hello.c".  Then I guess,

 - disk cache reduces the compile time
 - and compact flush access performance is rather bad on qemu-sh r2d system

I investigated what happens on CF access, and found

 - the ioread/write16_rep() function call in ata_sff_data_xfer() placed in
   "drivers/ata/libata-sff.c", cause tlb miss exception,

 - and the exception is handled by handle_trapped_io() in
   "arch/sh/kernel/io_trapped.c".

I'd like to ask following questions to linux-sh experts,

 - Why such io-traps are used to access CF?
 - Will this io-traps are used for SH7785LCR's SD card access?

I guess these io-traps can be the reason why gcc takes so much time on qemu-sh.

Thank you for reading this mail.
Any comments or any explanations will be appreciated.

Regards,
Shin-ichiro KAWASAKI
