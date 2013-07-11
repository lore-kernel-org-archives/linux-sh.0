From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jul 2013 11:37:54 +0000
Subject: Re: [PATCH 06/11] ARM: shmobile: r8a7778: cleanup registration of hspi
Message-Id: <51DE9912.3080707@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb5fqed.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb5fqed.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-07-2013 12:32, Kuninori Morimoto wrote:

> sh-hspi driver which doesn't need platform data at the time of
> registration can be registerd on SoC.
> And, registering these drivers in the SoC code can avoid
> unwanted device numbering issue.
> (ex. the hspi2 device number will be spi.0 if hspi2 only registered)
> This patch registers it on SoC code as cleanup C code

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

     How about PinMux again?

WBR, Sergei

