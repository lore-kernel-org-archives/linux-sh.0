From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 15 Jun 2015 23:41:07 +0000
Subject: [PATCH v2 0/2] Add R8A7790 EtherAVB DT support
Message-Id: <2857896.YA1bBSQVkA@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20150610-v4.1-rc7' tag. Here we add the EtherAVB device tree
support for the R8A7790 SoC. The 2nd patch depends on the EtherAVB driver
merged into the 'net-next.git' repo recently for the bindings...

[1/2] ARM: shmobile: r8a7790: add EtherAVB clocks
[2/2] ARM: shmobile: r8a7790: add EtherAVB DT support

WBR, Sergei

