From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 31 Mar 2010 16:35:12 +0000
Subject: Setting 31250 bps in ttySCx
Message-Id: <201003311835.12488.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
I'd like to set B31250 to have 31250 bps on ttySC1.
Do I have to define B31250 in  asm/sh/termio.h and add in serial_core the 
couple
31250,B31250?
Or do I need to add more over infos in other files?

Thanks a lot

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
