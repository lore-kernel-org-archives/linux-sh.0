From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jul 2013 11:35:28 +0000
Subject: Re: [PATCH 05/11] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <51DE9880.5020302@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvvlfqen.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvvlfqen.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-07-2013 12:32, Kuninori Morimoto wrote:

> i2c-rcar driver which doesn't need platform data at the time of
> registration can be registerd on SoC.
> And, registering these drivers in the SoC code can avoid
> unwanted device numbering issue.
> (ex. the i2c3 device number will be i2c.0 if i2c3 only registered)
> This patch registers it on SoC code as cleanup C code

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    How about pinmux? If you register all 4 I2C controllers at the SoC 
level (that's what our patch was doing), you'll need to register all the 
I2C pin groups in the board file, no?

WBR, Sergei


