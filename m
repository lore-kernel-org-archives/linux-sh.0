From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 05 Jun 2013 21:06:50 +0000
Subject: [PATCH v4 0/8] sh_eth: deal with #ifdef'fery
Message-Id: <201306060106.51082.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

   This series deals mostly with excess #ifdef'fery in the 'sh_eth' driver.
It doesn't yet get rid of all the #ifdef'fery but that's a matter of another
patchset. The last patch (it was almost in the middle of the series before),
contrarywise, adds one missing #ifdef...

[1/8] sh_eth: remove #ifdef around EDSR and GECMR bit definitions
[2/8] sh_eth: use EDSR_ENALL to set EDSR
[3/8] sh_eth: remove duplicate sh_eth_set_duplex() definitions
[4/8] sh_eth: remove SH_ETH_HAS_TSU
[5/8] sh_eth: add IRQ flags to 'struct sh_eth_cpu_data'
[6/8] sh_eth: remove #ifdef around sh_eth_select_mii()
[7/8] sh_eth: consolidate sh_eth_reset()
[8/8] sh_eth: enclose PM code into #ifdef CONFIG_PM

WBR, Sergei
