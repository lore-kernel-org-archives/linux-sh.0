From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Apr 2013 17:18:42 +0000
Subject: [PATCH v3 0/5] OKI ML86V7667 driver and R8A7778/BOCK-W VIN support
Message-Id: <201304232118.43686.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 5 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130422' tag and my recent yet unapplied patches. Here we
add the OKI ML86V7667 video decoder driver and the VIN platform code working on
the R8A7778/BOCK-W with ML86V7667. The driver patch also applies (with offsets)
to Mauro's 'media_tree.git'...

[1/5] V4L2: I2C: ML86V7667 video decoder driver
[2/5] sh-pfc: r8a7778: add VIN pin groups
[3/5] ARM: shmobile: r8a7778: add VIN support
[4/5] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
[5/5] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig

WBR, Sergei
