From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jun 2013 00:03:46 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add NAPI support
Message-Id: <20130619.170346.174389946083590708.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306192330.23477.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306192330.23477.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Jun 2013 23:30:23 +0400

> The driver hasn't used NAPI so far; implement its support at last...
> 
> The patch was tested on Renesas R8A77781 BOCK-W board.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for doing this, applied.
