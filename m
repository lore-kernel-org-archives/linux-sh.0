From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Sep 2014 21:05:41 +0000
Subject: [PATCH v4 0/3] Add USB PHY device tree support for R8A7791/Koelsch/Henninger board
Message-Id: <3383603.zZsCVpCDbD@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20140924-v3.17-rc6' tag. Here we add the USB PHY device tree
support on the R8A7791/Koelsch/Henninger boards. The patchset requires the USB
PHY driver already merged by Kishon and Greg in order to work, so can be
applied at last...

[1/3] ARM: shmobile: r8a7791: add USB PHY DT support
[2/3] ARM: shmobile: koelsch: enable USB PHY
[3/3] ARM: shmobile: henninger: enable USB PHY

WBR, Sergei

