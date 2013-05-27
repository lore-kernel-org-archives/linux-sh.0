From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 27 May 2013 10:27:16 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7778: rename device additional function for sh-eth
Message-Id: <51A33504.3050507@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvx98aj2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvx98aj2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 27-05-2013 5:41, Kuninori Morimoto wrote:

> Current r8a7778 is using r8a7778_add_ether_device().
> Here, this "ether" means "sh-eth".

    It will be renamed in the future. Then what, another rename?

> Now, we use r8a7778_register_xxx() instead of r8a7778_add_xxx_device()

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    NAK. In the manual the device is called Ether and I perefer to stick 
with this name. And all this rename is just pointless churn which Linus 
and RMK will frown at.

WBR, Sergei

