From: Kevin Hilman <khilman@kernel.org>
Date: Mon, 10 Nov 2014 22:00:02 +0000
Subject: Re: [PATCH V4 04/14] genirq: Generic chip: Add big endian I/O accessors
Message-Id: <7hy4riogwt.fsf@deeprootsystems.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
	<1415342669-30640-5-git-send-email-cernekee@gmail.com>
In-Reply-To: <1415342669-30640-5-git-send-email-cernekee@gmail.com> (Kevin
	Cernekee's message of "Thu, 6 Nov 2014 22:44:19 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Cernekee <cernekee@gmail.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org, arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, Olof Johansson <olof@lixom.net>Arnd Bergmann <arnd@arndb.de>

Kevin Cernekee <cernekee@gmail.com> writes:

> Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
> the irqchip.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

I bisected a couple ARM boot failures in next-20141110 on atmel sama5 platforms down to
this patch, though I'm not quite yet sure how it's causing the failure.
I'm not getting any console output, so haven't been able to dig deeper
yet.  Maybe the atmel maintainers (Cc'd) can help dig.

I've confirmed that reverting $SUBJECT patch (commit
b79055952badbd73710685643bab44104f2509ea2) on top of next-20141110 gets
things booting again.

Also, it only happens with sama5_defconfig, not with multi_v7_defconfig.

Kevin

