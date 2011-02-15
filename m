From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 15 Feb 2011 17:51:07 +0000
Subject: Problems with sh7203fb
Message-Id: <201102151851.07803.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi friends,
this is my rpopblem with linux  v2.6.37

I have u-bbot working and getting a splash welcome image.
I have derived sh7203fb.c / .h from sh7760fb.c / .h 
I have followed Documentation/fb/sh7760fb.txt

I probe the frame buffer.
But at the kernel boot the driver turn off the LCD.
when I try a /dev/fb0 test program it execute without problems, but nothing 
appears on the screen.

Any suggetions?

Thnaks

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
