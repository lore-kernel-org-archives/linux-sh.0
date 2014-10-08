From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 Oct 2014 19:53:11 +0000
Subject: [PATCH v4 0/2] Add HS-USB device tree support for R8A7790/Lager board
Message-Id: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141007-v3.17' tag. Here we add the HS-USB device tree support
on the R8A7790/Lager reference board. The patchset requires the USB PHY
driver (already merged by Kishon and Greg) and the generic PHY support patches
for the HS-USB driver posted by Yoshihiro Shimoda in order to work...

[1/2] ARM: shmobile: r8a7790: add HS-USB device node
[2/2] ARM: shmobile: lager: enable HS-USB

WBR, Sergei

