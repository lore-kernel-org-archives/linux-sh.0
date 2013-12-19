From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 19 Dec 2013 21:38:20 +0000
Subject: [PATCH 0/2] Add PHY IRQ support to the 'sh_eth' driver
Message-Id: <201312200138.09307.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   This patchset adds support for passing PHY's IRQ to the 'sh_eth' driver from
the platform code and removes now useless code that hinders the PHY IRQ handing
by philib.

[1/2] sh_eth: add PHY IRQ to platform data
[2/2] sh_eth: do not reset PHY needlessly

WBR, Sergei
