From: David Miller <davem@davemloft.net>
Date: Fri, 10 Jan 2020 02:35:52 +0000
Subject: Re: [PATCH net] sh_eth: check sh_eth_cpu_data::dual_port when dumping registers
Message-Id: <20200109.183552.1973904363091394974.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <5f03e777-6838-f70d-31bc-2046d253c11a@cogentembedded.com>
In-Reply-To: <5f03e777-6838-f70d-31bc-2046d253c11a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 8 Jan 2020 23:42:42 +0300

> When adding the sh_eth_cpu_data::dual_port flag I forgot to add the flag
> checks to __sh_eth_get_regs(), causing the non-existing TSU registers to
> be dumped by 'ethtool' on the single port Ether controllers having TSU...
> 
> Fixes: a94cf2a614f8 ("sh_eth: fix TSU init on SH7734/R8A7740")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
