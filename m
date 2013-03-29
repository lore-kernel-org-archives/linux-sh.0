From: David Miller <davem@davemloft.net>
Date: Fri, 29 Mar 2013 19:31:48 +0000
Subject: Re: [PATCH 1/2] sh_eth: move data from header file to driver
Message-Id: <20130329.153148.2125905168028363965.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201303290048.27020.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201303290048.27020.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 29 Mar 2013 00:48:26 +0300

> The driver's header file contains initialized register offset tables which (as
> any data definitions), of course, have no business being there.  Move them  to
> the driver's body, somewhat beautifying the initializers, while at it...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
