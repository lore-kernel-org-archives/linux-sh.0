From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 Oct 2014 17:59:04 +0000
Subject: [PATCH v3 1/3] Add HS-USB device tree support for R8A7791/Koelsch/Henninger board
Message-Id: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141007-v3.17' tag. Here we add the HS-USB device tree support
on the R8A7791/Koelsch/Henninger reference boards. The patchset requires the
USB PHY driver (already merged by Kishon and Greg) and the generic PHY support
patches for the HS-USB driver posted by Yoshihiro Shimoda in order to work...

[1/3] ARM: shmobile: r8a7791: add HS-USB device node
[2/3] ARM: shmobile: koelsch: enable HS-USB
[3/3] ARM: shmobile: henninger: enable HS-USB

WBR, Sergei

