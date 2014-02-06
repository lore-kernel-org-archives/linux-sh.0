From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 06 Feb 2014 21:09:51 +0000
Subject: [PATCH 0/2] Add Ether DT support for R8A7791/Koelsch reference board
Message-Id: <201402070110.18561.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-rc1-20140206v2' tag. Here we add the Ether device tree
support working on the R8A7791/Koelsch reference board. The patchset requires
the 'sh_eth' driver device tree support posted earlier in order to work.

[1/2] ARM: shmobile: r8a7791: add Ether DT support
[2/2] ARM: shmobile: koelsch: add Ether DT support

WBR, Sergei
