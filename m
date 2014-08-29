From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:16:39 +0000
Subject: [PATCH 0/2] r8a777[89] dtsi sorting
Message-Id: <1409336201-708-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: horms@verge.net.au, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

These are the dtsi files for r8a7778 and r8a7779 sorted according to what I
imagine to be accepted standards now: sort by address, "compatible" goes
first, #include directives before anything else.  The sorting was done using
a little script I wrote (https://github.com/uli/dtssort).

I chose these two files because the required changes are relatively small. 
Doing this for r8a779x yields a gargantuan and entirely unreadable patch due
to the random shifting about of large blocks of code.  If anybody knows a
tool that makes such things somewhat manageable to review, please speak up.

I'd also like to know if there is consensus on different/additional
standards that I'm not aware of.

CU
Uli


Ulrich Hecht (2):
  ARM: shmobile: r8a7778 dtsi: sort it
  ARM: shmobile: r8a7779 dtsi: sort it

 arch/arm/boot/dts/r8a7778.dtsi |  56 ++---
 arch/arm/boot/dts/r8a7779.dtsi | 472 ++++++++++++++++++++---------------------
 2 files changed, 264 insertions(+), 264 deletions(-)

-- 
1.8.4.5

