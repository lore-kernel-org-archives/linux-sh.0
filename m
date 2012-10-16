From: Tung Pham <tungps@gcs-vn.com>
Date: Tue, 16 Oct 2012 13:23:33 +0000
Subject: SH kernel boot up issue
Message-Id: <507D5FD5.4050501@gcs-vn.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I have an old working kernel for my SH board and now I'm trying to move
it to a newer version. The approach is to merge some patches of old
kernel to new one.

Currently I have an issue with boot up new board. The board can be boot
up successfully but after awhile the board reboot automatically. There's
nothing inside the dmesg and syslog. I tried to add printk in some
suspend/shutdown function but nothing logged out.

Do you have any idea to fix this issue?

Thanks,
-Tung

