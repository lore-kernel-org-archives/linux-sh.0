From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Apr 2013 08:19:10 +0000
Subject: Re: [PATCH 0/5 v3] ARM: shmobile: Add SMSC support on Bock-W
Message-Id: <CANqRtoSEf7TuBN6DZ7Qn9S8h8ts_pxahpELEK2b4KgAVpN7svw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Morimoto-san, Simon,

On Tue, Apr 2, 2013 at 1:18 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Simon
>
> These patches are v3 of extpin support on r8a7778,
> and enable SMSC ether support on Bock-W board
>
> This patch set is based latest simon/next
>
> Kuninori Morimoto (5):
>       ARM: shmobile: r8a7778: remove pointless PLATFORM_INFO()
>       ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
>       ARM: shmobile: bockw: add SMSC ethernet support
>       ARM: shmobile: bockw: enable network settings on bootargs
>       ARM: shmobile: bockw: enable SMSC ethernet on defconfig

Thanks, these are all fine with me.

Acked-by: Magnus Damm <damm@opensource.se>
