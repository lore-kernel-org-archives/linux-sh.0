From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 18 Feb 2013 19:27:39 +0000
Subject: [PATCH v2 0/4] R-Car SATA driver and platform data
Message-Id: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the v2 of the set of 4 patches against the Simon Horman's renesas.git
repo, 'next' branch:

[1/4] libata: add R-Car SATA driver
[2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
[3/4] ARM: mach-shmobile: r8a7779: add SATA support
[4/4] ARM: mach-shmobile: marzen: add SATA support

Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
repo.

Patch changes since the initial posting are reported in the individual patches.

MBR, Sergei
