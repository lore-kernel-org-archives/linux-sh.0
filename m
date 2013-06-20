From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jun 2013 00:03:51 +0000
Subject: Re: [PATCH 1/3] sh_eth: remove 'tx_error_check' field of 'struct sh_eth_cpu_data'
Message-Id: <20130619.170351.1940958966309807340.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306200222.56406.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306200222.56406.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 20 Jun 2013 02:22:56 +0400

> The 'tx_error_check' field of 'struct sh_eth_cpu_data' is write-only, so remove
> it along with the DEFAULT_TX_ERROR_CHECK macro.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
