From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 14 Jan 2014 17:05:39 +0000
Subject: [PATCH 0/2] ARM: dts: Add SATA to R8A7791 Koelsch device tree
Message-Id: <1389719141-24419-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This adds SATA nodes to r8a7791.dtsi and enables SATA0 in r8a7791-koelsch.d=
ts.
In order for this to work the following patches are also needed:
* R-Car Gen2 SATA phy support:
https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfor-=
3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
* a couple of MSTP clock fixes:
http://marc.info/?l=3Dlinux-sh&m=138823255807611&w=3D2

Valentine Barshak (2):
  ARM: dts: r8a7791: Add SATA nodes to r8a7791.dtsi
  ARM: dts: koelsch: Enable SATA0 in r8a7791-koelsch.dts

 arch/arm/boot/dts/r8a7791-koelsch.dts |  4 ++++
 arch/arm/boot/dts/r8a7791.dtsi        | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

--=20
1.8.3.1

