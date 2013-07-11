From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jul 2013 11:39:18 +0000
Subject: Re: [PATCH 07/11] ARM: shmobile: r8a7779: cleanup registration of usb phy
Message-Id: <51DE9966.4020902@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2qpfqe3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2qpfqe3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-07-2013 12:32, Kuninori Morimoto wrote:

> usb phy driver which needs platform data at the time of
> registration is used from Marzen only.
> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed in the future.
> The driver registration method which needs platform data
> and which is not shared complicates codes.
> This patch Registers it on board code as cleanup C code,
> here, it used current board's registration method.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    NAK. Step backwards.

WBR, Sergei

