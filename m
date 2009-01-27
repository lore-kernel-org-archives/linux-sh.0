From: morimoto.kuninori@renesas.com
Date: Tue, 27 Jan 2009 08:26:46 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <uiqo1cfy1.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> I haven't been able to reproduce this yet, but it would be helpful to
> know precisely where your lock up occurs. If you aren't using JTAG, you
> can try sending an NMI, or send a register and/or stacktrace request via
> magic sysrq.

I think I found the reason.

in "__mutex_fastpath_unlock" (arch/sh/include/asm/mutex-llsc.h),
currect operation is following.

-------------------
	__res |= !__ex_flag;
	if (unlikely(__res <= 0))
-------------------

But, This operation is wrong for me.
I think following is correct ?

-------------------
     	if (unlikely(__res <= 0 || __ex_flag = 0))
-------------------

above patch works well and dead lock never occur
on my local environment.
If my opinion is correct, I will send patch.

Best regards
--
Kuninori Morimoto
 
