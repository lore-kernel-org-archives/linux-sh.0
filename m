From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Apr 2014 22:21:52 +0000
Subject: [PATCH 0/2] Add USB PHY DT support for R8A7791/Koelsch reference board
Message-Id: <201404090221.53167.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-20140408' tag plus R8A7791/Koelsch PCI USB support patches
that I posted yesterday. Here we add the USB PHY device tree support on the
R8A779/Koelsch reference board. The patchset requires the USB PHY driver (just
re-posted) in order to work.

[1/2] ARM: shmobile: r8a7791: add USB PHY DT support
[2/2] ARM: shmobile: koelsch: enable USB PHY

WBR, Sergei
