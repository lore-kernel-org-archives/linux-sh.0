From: David Miller <davem@davemloft.net>
Date: Mon, 24 Jun 2013 07:10:44 +0000
Subject: Re: [PATCH 1/2] sh_eth: fix unhandled RFE interrupt
Message-Id: <20130624.001044.2036651955086655996.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306210112.22352.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306210112.22352.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 21 Jun 2013 01:12:21 +0400

> EESR.RFE (receive FIFO overflow) interrupt is enabled by the driver on all SoCs
> and sh_eth_error() handles it but it's not present in any initializer/assignment
> of the 'eesr_err_check' field of 'struct sh_eth_cpu_data'. This leads to that
> interrupt not being handled and cleared, and finally to disabling IRQ and the
> driver being non-functional.
> 
> Modify DEFAULT_EESR_ERR_CHECK macro and all explicit initializers of the above
> mentioned field to contain the EESR.RFE bit. Remove useless backslashes from the
> initializers, while at it.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to 'net'.
