From: Adrian McMenamin <lkmladrian@gmail.com>
Date: Wed, 21 Mar 2012 04:28:16 +0000
Subject: [PATCH] VMUFAT filesystem [0/4]
Message-Id: <CAN628AHEYG4PBrnKGE7tv13FNu08-oFCa+FAiDfaLUHjbq998w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linux-sh <linux-sh@vger.kernel.org>, Adrian McMenamin <adrianmcmenamin@gmail.com>

Sega Dreamcasts come with a "visual memory unit" (VMU) a
micro-controller based peripheral with a small LCD screen and 128K of
flash memory. The flash is partitioned as a file allocation table
(FAT) based volume.

The only physical VMUs released were limited to 128K of memory but it
was generally believed that Sega planned to introduce devices with
bigger memories and certainly the syntax of the filesystem, which I
call VMUFAT, allows for larger volumes.

Some years ago I contributed a driver for the VMU's flash and
attempted to contribute one for the filesystem (see
https://lkml.org/lkml/2009/2/14/127 for instance).

I am not sure how many people are still hacking away at Linux on their
Dreamcasts, but Linux or Android emulators exist for the Dreamcast and
the VMU, so supporting the filesystem has a potential use.

Adrian McMenamin
