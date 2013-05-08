From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 May 2013 23:09:40 +0000
Subject: [PATCH v4 0/3] Add Ether/USB/VIN pin groups for R8A777[89]
Message-Id: <201305090309.41113.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

   Here's 4 patches against the Simon Horman's 'renesas.git' repository,
'renesas-next-20130426' tag. We define the Ether/VIN/USB pin groups for RA87778/
RA87779 SoCs. Note that patch #2 has been moved from R8A7778/BOCK-W VIN patch
series and patch #1 just added.

[1/4] sh-pfc: r8a7778: add USB pin groups
[2/4] sh-pfc: r8a7778: add VIN pin groups
[3/4] sh-pfc: r8a7778: add Ether pin groups
[4/4] sh-pfc: r8a7779: add Ether pin groups

WBR, Sergei
