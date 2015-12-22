From: David Miller <davem@davemloft.net>
Date: Tue, 22 Dec 2015 20:24:01 +0000
Subject: Re: [PATCH] sh_eth: fix 16-bit descriptor field access endianness too
Message-Id: <20151222.152401.1350968132902705224.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <16692899.McEvu8S87q@wasted.cogentembedded.com>
In-Reply-To: <16692899.McEvu8S87q@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 20 Dec 2015 01:48:04 +0300

> Commit 1299653affa4 ("sh_eth: fix descriptor access endianness") only
> addressed the 32-bit buffer address field byte-swapping  but the driver
> still accesses 16-bit frame/buffer length descriptor fields without the
> necessary byte-swapping -- which should affect the big-endian kernels.
> In order to be able to use {cpu|edmac}_to_{edmac|cpu}(), we need to declare
> the RX/TX descriptor word 1 as a 32-bit field and use shifts/masking to
> access the 16-bit subfields (which gets rid of the ugly #ifdef'ery too)...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks Sergei.
