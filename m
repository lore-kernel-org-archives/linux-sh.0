From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 31 Mar 2018 21:15:04 +0000
Subject: [PATCH 0/2] sh_eth: remove SH_ETH_OFFSET_INVALID abuses
Message-Id: <998029b4-9400-ebc3-51c1-623c3f72b6cc@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hello!

Here's a set of 2 patches against DaveM's 'net-next.git' repo. They get rid of
the abuse of SH_ETH_OFFSET_INVALID for the register existence checks, so that
only its necessary uses would remain...

[1/2] sh_eth: add sh_eth_cpu_data::no_xdfar flag
[2/2] sh_eth: kill useless check in __sh_eth_get_regs()

MBR, Sergei
