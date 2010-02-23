From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 23 Feb 2010 03:20:03 +0000
Subject: Question about clock framework of SH-ARM
Message-Id: <upr3waba4.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

I would like to create clock-sh7372.c for AP4 board.
Now we have clock-sh7367.c which is good sample for me.

Thus, I want to separate common define/function. 
ex)
  clk.h
  clk.c

but where is the best path ?
or are there any patches already ?

Best regards
--
Kuninori Morimoto
 
