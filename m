From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Jul 2013 13:14:48 +0000
Subject: Re: [PATCH 6/6 v2] ARM: shmobile: r8a7779: cleanup registration of usb phy
Message-Id: <51F27648.5060405@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y58tbwoy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y58tbwoy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 26-07-2013 11:35, Kuninori Morimoto wrote:

    The subject hardly matches what's being done in the patch.

> usb phy driver which needs platform data at the time of
> registration is used from BockW only.

    s/BockW/Marzen/.

> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed
> if DT support is completed.
> Current driver registration method which needs platform data
> and which is not shared complicates codes.
> This means legacy C code cleanup after DT supporting
> will be more complicated
> This patch registers it on board code as cleanup C code

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    I cannot approve this patch. I see it as nothing other as pointless churn.
My opinion probably doesn't matter in the light of Magnus' desire to get it 
merged but I'm still clinging to it.

WBR, Sergei

