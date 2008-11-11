From: yoshii.takashi@gmail.com
Date: Tue, 11 Nov 2008 05:13:35 +0000
Subject: Re: Qemu SH4 status #2
Message-Id: <20081111141335.3c869c26.yoshii.takashi@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
In-Reply-To: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,
> My best guess is that id for whatever reason is tooo
> high, but thats just my #1 attempt at qemu debugging.
Yes, but wrong code is in hw/r2d.c. I should not have called mmio_ide_init()
if no HDD image given. I fixed it but haven't posted the new one yet.
My code is now like the following,
    if ((i = drive_get_index(IF_IDE, 0, 0)) != -1)
        mmio_ide_init(0x14001000, 0x1400080c, irq[CF_IDE], 1,
                     drives_table[i].bdrv, NULL);
# I think these mails should go to qemu ML, though.
/yoshii
