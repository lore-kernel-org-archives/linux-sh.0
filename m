From: David Miller <davem@davemloft.net>
Date: Wed, 11 Dec 2013 02:47:54 +0000
Subject: Re: [PATCH v2] sh_eth: add R8A7791 support
Message-Id: <20131210.214754.1553999236888329751.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201312080259.19163.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312080259.19163.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 8 Dec 2013 02:59:18 +0300

> Add support for yet another ARM member of the R-Car family, R-Car M2, also known
> as R8A7791 -- it will share the code and data with previously added R8A7790.
> Despite the Ether devices in these SoCs are indistinguishable at least from the
> driver's point of view, we do introduce a new platform device ID "r8a7791-ether"
> unlike the wildcard ID used for R8A7778/9 SoCs, due to newly established policy
> for the Renesas SoCs.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thank you.
