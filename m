From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 30 Sep 2009 02:46:07 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <uhbul9mkw.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> Do you have NUMA support enabled? It's possible the LMB changes impacted
> that.

It start works if I remove NUMA support from .config

--------------
NG case
--------------
> grep NUMA .config
CONFIG_SYS_SUPPORTS_NUMA=y
CONFIG_NUMA=y

--------------
OK case
--------------
> grep NUMA .config
CONFIG_SYS_SUPPORTS_NUMA=y
# CONFIG_NUMA is not set

Best regards
--
Kuninori Morimoto
 
