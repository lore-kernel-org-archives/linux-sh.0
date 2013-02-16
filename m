From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 16 Feb 2013 21:35:05 +0000
Subject: [PATCH 0/4] R-Car SATA driver and platform data
Message-Id: <201302170135.28336.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 4 patches against the Simon Horman's renesas.git repo, 'next' branch:

[1/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
[2/4] ARM: mach-shmobile: r8a7779: add SATA support
[3/4] libata: add R-Car SATA driver
[4/4] ARM: mach-shmobile: marzen: add SATA support

Patch 3 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git repo.

MBR, Sergei
