From: Luca Santini <luca.santini@spesonline.com>
Date: Mon, 04 May 2009 14:29:01 +0000
Subject: changing bus clock frequency (sh7760)
Message-Id: <49FEFBAD.8010102@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,
is there a fast-and-simple way to change the system bus frequency clock? (i want, say, a 33Mhz system freq instead 66Mhz )
i tried tweaking SH_PCLK_FREQ but it seems bus freq remains the same; only peripherals are screwed up (i.e. uart baudrate) :(

-- 
*Luca  Santini*
//Elettronica di Sistema//

*SPES. S.c.p.a*
Via  Lamberto Corsi, 43   
60044 Fabriano (AN)
tel. +39 0732 25291 diretto 0732 25451
fax +39 0732 2529441
luca.santini@spesonline.com <mailto:luca.santini@spesonline.com>
www.spesonline.com <http://www.spesonline.com>
