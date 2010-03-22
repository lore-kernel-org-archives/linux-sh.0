From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 22 Mar 2010 19:19:48 +0000
Subject: smc9118 problem
Message-Id: <201003222019.48247.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all, II have a problem with smc9118 chip;
I do not make any eeprom initialitazione because I do not have any eeprom on 
my board.
When occurs an rx overrun the chip stops to receive, and I have experienced 
that doing 
~> cat /proc/smc911x/resetphy
~> cat /proc/smc911x/resetsmc
~> cat /proc/smc911x/enable

it restart properly.

I'm using kernel 2.6.17; does any of you have suggetion about I nedd to check 
for discover which bits I have to set in case of rx overrun?

Thanks



-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
