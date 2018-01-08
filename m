From: David Miller <davem@davemloft.net>
Date: Mon, 08 Jan 2018 19:10:49 +0000
Subject: Re: [PATCH] sh_eth: remove sh_eth_plat_data::edmac_endian
Message-Id: <20180108.141049.924805122299836294.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180104212654.038005757@cogentembedded.com>
In-Reply-To: <20180104212654.038005757@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Jan 2018 00:26:46 +0300

> Since the commit 888cc8c20cf ("sh_eth: remove EDMAC_BIG_ENDIAN") (geez,
> I didn't realize that was 2 years ago!) the initializers in the SuperH
> platform code for the 'sh_eth_plat_data::edmac_endian' stopped to matter,
> so we can remove that field for good (not sure if  it  was ever useful --
> SH7786 Ether has been reported  to have the same EDMAC descriptor/register
> endiannes as configured for the SuperH CPU)...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against DaveM's 'net-next.git' repo.
> Not sure who should apply the patch -- will prolly be faster if DaveM does...

Applied, thanks Sergei.
