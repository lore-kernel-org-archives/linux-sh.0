From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 12 Apr 2013 23:39:09 +0000
Subject: [PATCH v2 0/4] Add USB support to R8A7778/BOCK-W
Message-Id: <201304130339.09876.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130412' tag and the R8A7779/Marzen patchset I've just posted.
 It was created to add support of R8A7778/BOCK-W USB to the platform code and
the USB common PHY driver, and so spans both arch/arm/mach-shmobile/ and
drivers/usb/phy/ subtrees.

[1/4] rcar-phy: add R8A7778 support
[2/4] ARM: shmobile: r8a7778: add USB support
[3/4] ARM: shmobile: BOCK-W: add USB support
[4/4] ARM: shmobile: BOCK-W: enable USB in defconfig

WBR, Sergei
