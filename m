From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 21 Nov 2014 10:57:28 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790 CCI configuration
Message-Id: <3843244.eEnPgu6iEl@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1416542986-26846-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1416542986-26846-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 21 November 2014 13:09:46 Simon Horman wrote:
> +       writel_relaxed(readl_relaxed(p + CCI_SLAVE4 + CCI_SNOOP) | 0x3,
> +               p + CCI_SLAVE4 + CCI_SNOOP);    /* ca7 */
> +       while (__raw_readl(p + CCI_STATUS));
> +       /* wait for pending bit low */
> 

Why are you using __raw_readl for the last access? I would make that
readl_relaxed() like the other ones for consistency.

Also, a better way to express waiting for the register read is to
put the ';' on the next line, or add a cpu_relax() statement:

	while (readl_relaxed(p + CCI_STATUS))
		cpu_relax();


	Arnd
