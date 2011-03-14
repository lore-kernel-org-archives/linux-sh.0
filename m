From: David Miller <davem@davemloft.net>
Date: Mon, 14 Mar 2011 21:10:55 +0000
Subject: Re: [PATCH v2 3/6] net: sh_eth: remove almost #ifdef of SH7763
Message-Id: <20110314.141055.115922945.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4D75E1EA.50006@renesas.com>
In-Reply-To: <4D75E1EA.50006@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 08 Mar 2011 16:59:38 +0900

> The SH7763 has GETHER. So the specification of some registers differs than
> other CPUs. This patch removes almost #ifdef of CONFIG_CPU_SUBTYPE_SH7763.
> Then we are able to add other CPU's GETHER easily.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
