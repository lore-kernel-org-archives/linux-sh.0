From: David Miller <davem@davemloft.net>
Date: Mon, 02 Apr 2012 03:22:34 +0000
Subject: Re: [PATCH] net: sh_eth: fix endian check for architecture independent
Message-Id: <20120401.232234.686879895812528970.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4F754558.1070001@renesas.com>
In-Reply-To: <4F754558.1070001@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Mar 2012 14:32:08 +0900

> SuperH has the "CONFIG_CPU_LITTLE_ENDIAN" and the "__LITTLE_ENDIAN__".
> But, other architecture doesn't have them. So, this patch fixes it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
