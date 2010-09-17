From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 17 Sep 2010 07:21:38 +0000
Subject: kernel BUG mm/page_alloc.c
Message-Id: <201009170921.38943.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,
only your opinion.
I get this error during the boot:

kernel BUG mm/page_alloc.c:1136
Bad page state in process 'swapper'
page 0c293fe0 flags:0xfffffaff mapping: 00000000 mapcount:0 count:2006240279
Try to fix it up, but a reebot is needed

Call trace:
...


Well, I have only a board presenting this problem, but not at each boot; only 
sometimes.
Could it be a SDRAM problem or a NOR flash problem; I mean: is it more likely I 
have problem on flash so when I read the compressed image I read something 
wrong, or is it more likely I read properly from the flash but uncompressing on 
SDRAM writes something wrong for SDRAM problem?

Thanks a lot in advance


-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
www.aurion-tech.com
