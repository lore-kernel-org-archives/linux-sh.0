From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 08 Sep 2014 12:28:11 +0000
Subject: Koelsch boot issue with internal PCI and PCIe controllers
Message-Id: <8252334e1cb8444e9a75e6cd7d788793@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I happened to build Linus' master today (d030671f) for the Koelsch board using shmobile_defconfig. It built ok, but fails to boot with no output when a PCIe card is plugged in.

However, if I disable either the internal PCI controller (USB bridge), or the PCIe controller, then everything looks ok.
Has anyone seen this already and started looking into it?

Phil
