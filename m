From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 19 Apr 2013 22:30:07 +0000
Subject: [PATCH v2 0/4] R-Car VIN driver with R8A7779/Marzen support
Message-Id: <201304200230.08819.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130419' tag and my recent yet unapplied USB patches. Here we
add the VIN (Video In) driver and its platform code working on the R8A7779/
Marzen with ADV7180 I2C camera sensor. The driver patch also applies without
issues to Mauro's 'media_tree.git'...

[1/4] V4L2: soc_camera: Renesas R-Car VIN driver
[2/4] ARM: shmobile: r8a7779: add VIN support
[3/4] ARM: shmobile: Marzen: add VIN and ADV7180 support
[4/4] ARM: shmobile: Marzen: enable VIN and ADV7180 in defconfig

WBR, Sergei
