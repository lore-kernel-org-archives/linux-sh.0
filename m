From: morimoto.kuninori@renesas.com
Date: Mon, 26 Jan 2009 05:01:36 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <uy6wyek3z.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> know precisely where your lock up occurs. If you aren't using JTAG, you
> can try sending an NMI, or send a register and/or stacktrace request via
> magic sysrq.

# In the sample, it seems to happen easily.
# But this problem happens only unusually.
# Therefore, we should try a lot of past string to occur this lock up.

hmm...
I can use JTAG now, but kernel is always running default_idle
when freeze occur.

88003074 <default_idle>:
...
8800309a:	1b 00       	sleep
8800309c:	f2 01       	stc	r7_bank,r1
8800309e:	12 50       	mov.l	@(8,r1),r0
880030a0:	04 c9       	and	#4,r0
880030a2:	08 20       	tst	r0,r0
880030a4:	f9 89       	bt	8800309a

I don't know how to debug it.

Best regards
--
Kuninori Morimoto

