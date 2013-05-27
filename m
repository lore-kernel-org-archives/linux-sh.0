From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 27 May 2013 10:31:01 +0000
Subject: Re: [PATCH 2/2 v3] ARM: shmobile: r8a7778: rename device additional function for sdhi
Message-Id: <51A335E5.8050606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehct8ag0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehct8ag0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 27-05-2013 5:42, Kuninori Morimoto wrote:

> Current r8a7778 is using r8a7778_sdhi_init().
> Now, we use r8a7778_register_xxx() instead of it

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3

>   - no change, but become 2nd patch

>>> Simon

> This patch exchange both board/setup.
> Please let me know if you need separated patch

     No, separate patches will break the build/bisection.

WBR, Sergei

