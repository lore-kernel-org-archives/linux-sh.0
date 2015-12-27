From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 27 Dec 2015 23:05:24 +0000
Subject: [PATCH 0/2] sh_eth: remove unused BE descriptor support
Message-Id: <27915743.MLN0FvErP3@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's a set of 2 patches against DaveM's 'net-next.git' repo plus the
recently merged to 'net.git' repo fix for the 16-bit descriptor endianness.
We get rid of ~30 LoCs and ~300 bytes of code.

[1/2] sh_eth: remove EDMAC_BIG_ENDIAN
[2/2] sh_eth: get rid of {cpu|edmac}_to_{edmac|cpu}()

MBR, Sergei

