From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Dec 2015 21:39:03 +0000
Subject: [PATCH 0/3] sh_eth: optimize MDIO code
Message-Id: <1582774.FcjyuztLtc@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's a set of 3 patches against DaveM's 'net-next.git' repo which gets rid
of ~35 LoCs in the MDIO bitbang methods.

[1/3] sh_eth: remove mask fields from 'struct bb_info'
[2/3] sh_eth: factor out common code from MDIO bitbang methods
[3/3] sh_eth: get rid of bb_{set|clr|read}()

MBR, Sergei

