From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Mar 2014 23:21:49 +0000
Subject: [PATCH 0/3] Beautify 'sh_eth' driver's messages
Message-Id: <201403150321.47674.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

This patchset converts te driver to using netdev_*() and netif_*() to print out
its messages whenever possible.

[1/3] sh_eth: convert pr_*() to netdev_*() calls
[2/3] sh_eth: convert dev_*() to netdev_*() calls
[3/3] sh_eth: fold netif_msg_*() and dev_*() calls into netif_*() invocations

WBR, Sergei
