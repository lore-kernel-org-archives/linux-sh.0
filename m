From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Feb 2019 18:01:25 +0000
Subject: [PATCH v2 0/7] sh_eth: implement simple RX checksum offload
Message-Id: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hello!

Here's a set of 7 patches against DaveM's 'net-next.git' repo. I'm implemeting
the simple RX checksum offload (like was done for the 'ravb' driver by Simon
Horman); it has been only tested on the R8A7740 and R8A77980 SoCs, the other
SoCs should just work (according to their manuals)...

[1/7] sh_eth: rename sh_eth_cpu_data::hw_checksum
[2/7] sh_eth: RX checksum offload support
[3/7] sh_eth: offload RX checksum on R7S72100
[4/7] sh_eth: offload RX checksum on R8A7740
[5/7] sh_eth: offload RX checksum on R8A77980
[6/7] sh_eth: offload RX checksum on SH7734
[7/7] sh_eth: offload RX checksum on SH7763

MBR, Sergei
