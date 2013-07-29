From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 29 Jul 2013 12:40:50 +0000
Subject: Re: [PATCH 4/6 v2] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <51F662D2.6070009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 29-07-2013 4:36, Kuninori Morimoto wrote:

>>> i2c-rcar driver which doesn't need platform data at the time of
>>> registration can be registerd on SoC.

>>      What about your previous concern about pinmux which prevented our I2C
>> platform patch from being accepted? Why did it suddenly become unimportant?

> Your I2C platform patch ??
> Which one ?

     You have a short memory:

http://marc.info/?l=linux-sh&m6622435310063

    You reply was:

http://marc.info/?l=linux-sh&m6866663723626

    Finally, we called back this patch after you posted your variant.

> Anyway, I exchange my mind
> http://www.spinics.net/lists/linux-sh/msg21582.html

    It's apparent that you changed your mind but it's not clear what was the
reasoning behind this.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei

