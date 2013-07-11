From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jul 2013 11:32:11 +0000
Subject: Re: [PATCH 03/11] ARM: shmobile: r8a7778: cleanup registration of usb phy
Message-Id: <51DE97BB.7050906@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ip0hfqf9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ip0hfqf9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11.07.2013 12:31, Kuninori Morimoto wrote:

> usb phy driver which needs platform data at the time of
> registration is used from BockW only.
> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed in the future.
> The driver registration method which needs platform data
> and which is not shared complicates codes.
> This patch registers it on board code as cleanup C code

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    NAK.

WBR, Sergei

