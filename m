From: David Miller <davem@davemloft.net>
Date: Thu, 15 Jan 2015 19:46:30 +0000
Subject: Re: [PATCH] net: sh_eth: Use u32 for 32-bit register data
Message-Id: <20150115.144630.1562327486750379056.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1421319268-22831-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421319268-22831-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert+renesas@glider.be
Cc: nobuhiro.iwamatsu.yj@renesas.com, yoshihiro.shimoda.uh@renesas.com, netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 15 Jan 2015 11:54:28 +0100

> Replace "unsigned long" by "u32" when handling 32-bit register data.
> 
> A.o., this saves 11 * 36 bytes in the static sh_eth_cpu_data structures
> when compiling for 64-bit.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to net-next, thanks.
