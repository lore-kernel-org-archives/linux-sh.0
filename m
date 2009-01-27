From: morimoto.kuninori@renesas.com
Date: Tue, 27 Jan 2009 08:46:57 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <uhc3lcf0e.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> Hmm, the !__ex_flag should have handled that case properly, but I wonder
> if it is negated in the unlock case. Does switching to __res |= __ex_flag
> and leaving the existing test as-is fix it?

Sorry difficult English.
Do you say like this ?

--------------
 	__res |= __ex_flag;
 	if (unlikely(__res <= 0))
--------------

Dead lock occur in this case. kernel can not boot.

Best regards
--
Kuninori Morimoto
 
