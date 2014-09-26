From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Sep 2014 20:58:01 +0000
Subject: [PATCH v4 0/2] Add USB PHY device tree support for R8A7790/Lager board
Message-Id: <4420279.PiYV5HPFxp@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20140924-v3.17-rc6' tag. Here we add the USB PHY device tree
support on the R8A7790/Lager reference board. The patchset requires the USB PHY
driver already merged by Kishon and Greg in order to work, so can be applied at
last...

[1/2] ARM: shmobile: r8a7790: add USB PHY DT support
[2/2] ARM: shmobile: lager: enable USB PHY

WBR, Sergei

