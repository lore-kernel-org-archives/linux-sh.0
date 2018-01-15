From: David Miller <davem@davemloft.net>
Date: Mon, 15 Jan 2018 19:51:11 +0000
Subject: Re: [PATCH] sh_eth: dix dumping ARSTR
Message-Id: <20180115.145111.1674948548030681862.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180113172207.201026516@cogentembedded.com>
In-Reply-To: <20180113172207.201026516@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 13 Jan 2018 20:22:01 +0300

> ARSTR  is always located at the start of the TSU register region, thus
> using add_reg()  instead of add_tsu_reg() in __sh_eth_get_regs() to dump it
> causes EDMR or EDSR (depending on the register layout) to be dumped instead
> of ARSTR.  Use the correct condition/macro there...
> 
> Fixes: 6b4b4fead342 ("sh_eth: Implement ethtool register dump operations")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to 'net' with subj. typo fixed :)
