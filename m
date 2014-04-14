From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 14 Apr 2014 10:36:35 +0000
Subject: Updated set for soc_camera/rcar_vin/lager
Message-Id: <1397471802-27216-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Updated patches for updating soc_camera and the rcar_vin driver for
device tree working and enable the code for the Renesas Lager board.

The changes are as follows:

	- fix dts for adv7180 name
	- add compatible string for adi,adv7180
	- fix mclk for atmel-mci (untested) from on-list feedback
	- add aliases vin0..vin3

