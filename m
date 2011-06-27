From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Mon, 27 Jun 2011 09:17:54 +0000
Subject: Re: [PATCH] NET: AX88796: Tighten up Kconfig dependencies
Message-Id: <4E084AC2.5060908@mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110625180050.GA9620@linux-mips.org>
In-Reply-To: <20110625180050.GA9620@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 25-06-2011 22:00, Ralf Baechle wrote:

> In def47c5095d53814512bb0c62ec02dfdec769db1 the AX88796 driver got

    Please also specify the summary of that commit.

> restricted to just be build for ARM and MIPS on the sole merrit that it

    Merit?

> was written for some ARM sytems and the driver had the missfortune to

    Misfortune?

> just build on MIPS, so MIPS was throw into the dependency for a good
> measure.  Later 8687991a734a67f1638782c968f46fff0f94bb1f added SH but

    Summary here too, please.

> only one in-tree SH system actually has an AX88796.

> Tighten up dependencies by using an auxilliary config sysmbol
> HAS_NET_AX88796 which is selected only by the platforms that actually
> have or may have an AX88796.  This also means the driver won't be built
> anymore for any MIPS platform.

> Signed-off-by: Ralf Baechle<ralf@linux-mips.org>

WBR, Sergei
