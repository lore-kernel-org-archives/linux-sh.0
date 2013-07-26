From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Jul 2013 13:37:02 +0000
Subject: Re: [PATCH 4/6 v2] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <51F27B7E.4060700@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 26-07-2013 11:35, Kuninori Morimoto wrote:

> i2c-rcar driver which doesn't need platform data at the time of
> registration can be registerd on SoC.

    What about your previous concern about pinmux which prevented our I2C 
platform patch from being accepted? Why did it suddenly become unimportant?

> And, registering these drivers in the SoC code can avoid
> unwanted device numbering issue.
> (ex. the i2c3 device number will be i2c.0 if i2c3 only registered)

    Non-issue IMHO.

> This patch registers it on SoC code as cleanup C code

    Why not call it appropriately then, not using such 
meaning-everything-and-nothing word "cleanup"?

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

WBR, Sergei

