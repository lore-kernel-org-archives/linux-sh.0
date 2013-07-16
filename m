From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 16 Jul 2013 15:06:18 +0000
Subject: EMMA/EMEV2 SDHCI driver
Message-Id: <51E5616A.70106@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am currently trying to get a driver going for the SDIO0/1/2 blocks
in the EMEV2 device. Using the SDHCI platform driver I've added a
sub-driver to get the bus and sclks and then instantiate the sdhci
core.

I have checked that the device is out of reset, and that all clocks
in to the block are enabled. I have a quick verification that all
SDHCI writes are making it to the registers.

Has anyone tried this with any success? Is there something I have
missed doing this?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
