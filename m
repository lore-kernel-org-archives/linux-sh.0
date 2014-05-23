From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 23 May 2014 22:26:26 +0000
Subject: [PATCH v2 0/2] Add USB PHY device tree support for R8A7790/Lager board
Message-Id: <201405240226.27820.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

    Oops, have sent this out with stale subject. Resending...

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140521' tag plus R8A7790/Lager PCI USB support patches
that I posted earlier. Here we add the USB PHY device tree support on the
R8A7790/Lager reference board. The patchset requires the USB PHY driver (re-
posted recently) in order to work.

[1/2] ARM: shmobile: r8a7790: add USB PHY DT support
[2/2] ARM: shmobile: lager: enable USB PHY

WBR, Sergei
