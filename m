From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 12 Sep 2014 01:23:47 +0000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Clk Updates for v3.18
Message-Id: <cover.1410484748.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC clk updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-clk-for-v3.18,
which you have already pulled.

I am taking this change through my tree with Mike's Ack
as it seems to be a smooth way to handle things.


The following changes since commit 8de078f189da45453d2ed2a04288e329cc169731:

  clk: shmobile: Add r8a7794 support (2014-08-27 08:40:54 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clk2-for-v3.18

for you to fetch changes up to b32c44b93af31e9163514df0f3ac2791972eb124:

  clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings (2014-09-10 09:08:10 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Clk Updates for v3.18

* Add r8a7740, sh73a0 SoCs to MSTP bindings

----------------------------------------------------------------
Ulrich Hecht (1):
      clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 ++
 1 file changed, 2 insertions(+)
