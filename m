From: David Miller <davem@davemloft.net>
Date: Tue, 07 Apr 2015 19:22:49 +0000
Subject: Re: [PATCH] sh_eth: move inline functions to the header file
Message-Id: <20150407.152249.360575010614186977.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4254119.qJUdUQCUqs@wasted.cogentembedded.com>
In-Reply-To: <4254119.qJUdUQCUqs@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 06 Apr 2015 00:13:46 +0300

> The explicitly inline functions belong to the header files, so move
> cpu_to_edmac() and edmac_to_cpu() into the driver header.
> 
> While at it, make these functions return 'u32' instead of '__u32'.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Then... ummm... remove the inline keyword?

If it's not used anywhere else, that's the thing to do.
