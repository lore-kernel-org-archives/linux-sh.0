From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jun 2013 00:03:23 +0000
Subject: Re: [PATCH v2] sh_eth: get R8A7740 Rx descriptor word 0 shift out of #ifdef
Message-Id: <20130619.170323.609697873999128436.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306132212.46361.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306132212.46361.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 13 Jun 2013 22:12:45 +0400

> The only R8A7740 specific #ifdef hindering  ARM multiplatform build is  left in
> sh_eth_rx(): it covers the code shifting Rx buffer descriptor word 0 by 16. Get
> rid of the #ifdef by adding 'shift_rd0' field to the  'struct sh_eth_cpu_data',
> making the shift dependent on it, and setting it to 1 for the R8A7740 case...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
