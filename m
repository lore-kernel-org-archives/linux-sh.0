From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Aug 2013 22:15:16 +0000
Subject: [PATCH 0/2] SH: fix typos in Ether platform data
Message-Id: <201308220215.16463.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, davem@davemloft.net

Hello.

   Shamefully, I have fat fingered in both patches fixing Ether support on SH
platforms and I didn't bother to compile test them at least with the ARM
compiler I have at hand (although one of the files turned out to not really be
compilable by it). Here's 2 patches fixing the typos, they are against David
Miller's 'net-next.git'.

[1/2] SH7619: fix typo in Ether platform data
[2/2] SolutionEngine7724: fix typo in Ether platform data

WBR, Sergei
