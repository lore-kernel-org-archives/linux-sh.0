From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Dec 2019 06:09:02 +0000
Subject: can someone solve string_32.h issue for SH ?
Message-Id: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


Hi SH ML

We get too many below strncpy() warning on SH.
Can someone solve it ?
I don't remember SH assembler code / can't test it...

In file included from /home/morimoto/WORK/linux/arch/sh/include/asm/string.h:3,
                 from /home/morimoto/WORK/linux/include/linux/string.h:20,
                 from /home/morimoto/WORK/linux/include/linux/bitmap.h:9,
                 from /home/morimoto/WORK/linux/include/linux/nodemask.h:95,
                 from /home/morimoto/WORK/linux/include/linux/mmzone.h:17,
                 from /home/morimoto/WORK/linux/include/linux/gfp.h:6,
                 from /home/morimoto/WORK/linux/include/linux/slab.h:15,
                 from /home/morimoto/WORK/linux/drivers/mmc/host/vub300.c:38:
/home/morimoto/WORK/linux/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
/home/morimoto/WORK/linux/arch/sh/include/asm/string_32.h:51:42: warning: array subscript 80 is above array bounds of 'char[26]' [-Warray-bounds]
   : "0" (__dest), "1" (__src), "r" (__src+__n)
                                     ~~~~~^~~~

	static inline char *strncpy(char *__dest, const char *__src, size_t __n)
	{
		register char *__xdest = __dest;
		unsigned long __dummy;

		if (__n = 0)
			return __xdest;

		__asm__ __volatile__(
			"1:\n"
			"mov.b	@%1+, %2\n\t"
			"mov.b	%2, @%0\n\t"
			"cmp/eq	#0, %2\n\t"
			"bt/s	2f\n\t"
			" cmp/eq	%5,%1\n\t"
			"bf/s	1b\n\t"
			" add	#1, %0\n"
			"2:"
			: "=r" (__dest), "=r" (__src), "=&z" (__dummy)
=>			: "0" (__dest), "1" (__src), "r" (__src+__n)
			: "memory", "t");

		return __xdest;
	}

Thank you for your help !!
Best regards
---
Kuninori Morimoto
