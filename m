From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 24 Jun 2013 11:07:49 +0000
Subject: Re: [PATCH 1/2] sh_eth: fix unhandled RFE interrupt
Message-Id: <51C82885.8030607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306210112.22352.sergei.shtylyov@cogentembedded.com> <20130624.001044.2036651955086655996.davem@davemloft.net>
In-Reply-To: <20130624.001044.2036651955086655996.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

On 24-06-2013 11:10, David Miller wrote:

>> EESR.RFE (receive FIFO overflow) interrupt is enabled by the driver on all SoCs
>> and sh_eth_error() handles it but it's not present in any initializer/assignment
>> of the 'eesr_err_check' field of 'struct sh_eth_cpu_data'. This leads to that
>> interrupt not being handled and cleared, and finally to disabling IRQ and the
>> driver being non-functional.

>> Modify DEFAULT_EESR_ERR_CHECK macro and all explicit initializers of the above
>> mentioned field to contain the EESR.RFE bit. Remove useless backslashes from the
>> initializers, while at it.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Applied to 'net'.

    Queue it for -stable please, the bug goes back to the very start of 
the driver development, it seems...

WBR, Sergei

