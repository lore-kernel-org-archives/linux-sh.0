From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Jun 2014 23:04:18 +0000
Subject: [PATCH 0/2] Add VIN and ADV7180 DT support for R8A7791/Henninger board
Message-Id: <201406110304.18976.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.15-20140610' tag plus the Henninger I2C2 DT support patch
that I posted earlier. Here we add the VIN and ADV7180 video decoder device
tree support on the R8A7791/Henninger board. The patchset requires Ben Dooks'
adv7180, rcar_vin, and soc_camera DT support patches posted back in April in
order to work.

[1/2] ARM: shmobile: r8a7791: add VIN DT support
[2/2] ARM: shmobile: henninger: add VIN0/ADV7180 DT support

WBR, Sergei
