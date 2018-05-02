From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 02 May 2018 19:53:23 +0000
Subject: [PATCH 0/2] sh_eth: complain on access to unimplemented TSU registers
Message-Id: <4a17ab65-4d9c-897e-c340-7d86e0296f2f@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Hello!

Here's a set of 2 patches against DaveM's 'net-next.git' repo. The 1st patch
routes TSU_POST<n> register accesses thru sh_eth_tsu_{read|write}() and the 2nd
added WARN_ON() unimplemented register to those functions. I'm going to deal with
TSU_ADR{H|L}<n> registers in a later series...

[1/2] sh_eth: use TSU register accessors for TSU_POST<n>
[2/2] sh_eth: WARN_ON() access to unimplemented TSU register

MBR, Sergei
