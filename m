From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 14 Dec 2015 16:53:33 +0000
Subject: Re: [PATCH] sh_eth: fix descriptor access endianness
Message-Id: <566EF40D.3020908@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <11070795.yxBPvlHg4n@wasted.cogentembedded.com>
In-Reply-To: <11070795.yxBPvlHg4n@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

On 12/13/2015 11:05 PM, Sergei Shtylyov wrote:

> The driver never  calls cpu_to_edmac() when writing the descriptor address
> and edmac_to_cpu() when reading it, although it should -- fix this.
>
> Note that the frame/buffer length descriptor field accesses also need fixing
> but since they are both 16-bit we can't  use {cpu|edmac}_to_{edmac|cpu}()...

    Changed my mind about this one: I'll add a new pair of functions to deal 
with 16-bit conversions as well.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

MBR, Sergei

