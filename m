From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 02 Jun 2013 17:16:27 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add I2C support
Message-Id: <51AB7DEB.3090708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/28/2013 08:22 AM, Kuninori Morimoto wrote:

> Add a platform device for the r8a7778 I2C.

    You're also adding several clocks and not mentioning it.
Please just copy the description from our I2C patch (to be dumped now),
I'm serious.

> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

WBR, Sergei

