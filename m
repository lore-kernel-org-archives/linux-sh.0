From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Nov 2010 07:22:02 +0000
Subject: [PATCH 0/6] ARM: mach-shmobile: FSI clock fixup
Message-Id: <w3pd3q14w2t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus, Mark, Liam, Guennadi

These patches are FSI clock fixup

Kuninori Morimoto (6):
      ARM: mach-shmobile: clock-sh7372: remove fsidiv bogus disable
      ARM: mach-shmobile: ap4evb: FSI clock use proper process for HDMI
      ARM: mach-shmobile: ap4evb: FSI clock use proper process for ak4642
      ARM: mach-shmobile: clock-sh7372: modify error code
      ARM: mach-shmobile: clock-sh7372: remove unnecessary fsi clocks
      ARM: mach-shmobile: clock-sh7372: remove pllc2 clock bogus

These patches modify bogus control of FSI clock.
To modify it, FSI driver was changed.
I tested these patches on AP4 and Ecovec.

>> Mark, Liam

   Can you please check #2 #3 patches ?
   It change FSI driver.

>> Magnus, Paul, Guennadi

   The last patch change pllc2 bogus, but I'm not sure about it.
   Of course I tested it though.
   I put it as RFC.

Best regards
--
Kuninori Morimoto
 
