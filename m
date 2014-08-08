From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Aug 2014 11:26:16 +0000
Subject: Armadillo800EVA legacy defconfig seems busted on my board
Message-Id: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everyone,

On my r8a7740 Armadillo board I've been playing with multiplatform and
CCF recently. While doing that I noticed that the defconfig doesn't
seem to work.

Maybe this is just my board - the boot loader seems unstable in
general and my entire setup requires an additional switch for the
Ethernet PHY to even get link up - autonegotiation seems busted with
the boot loader...

Anyway, if I try to boot the zImage generated from
armadillo800eva_defconfig I get zero console output. I managed to
track it down to the FB bits being busted.

If this is happening on other boards as well then perhaps we shall
adjust the defconfig? Or even better - fix the LCDC driver or whatever
is keeping the board from booting.

Good news is that DT reference seems fine. =)

Cheers,

/ magnus
