From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 May 2013 13:07:10 +0000
Subject: Re: [PATCH 15/17 v2] ARM: shmobile: r8a7778: add __initdata on resource and device data
Message-Id: <519E147E.3020302@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4gy2xej.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4gy2xej.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 23-05-2013 7:22, Kuninori Morimoto wrote:

> These data will be kmemdup()'ed on
> platform_device_add_resources() and platform_device_add_data()

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    Ah, you decided to annotate the platform device resources and data 
all in one go, afterwards. I didn't expect this, sorry about my prior mails.

WBR, Sergei

