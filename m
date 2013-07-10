From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Jul 2013 05:04:20 +0000
Subject: Re: [PATCH v2] ARM: shmobile: bockw: add DT reference
Message-Id: <CANqRtoQEbrOdy6FAi4--Cu5xOjsRdBo=jCs1ZOinngS2XH0W2A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y59fup9u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y59fup9u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Jul 10, 2013 at 11:23 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> This patch adds a sample DT-based Bock-W "reference" implementation.
> The use of platform-specific C-code should be avoided
> with this configuration as much as possible.
>
> This patch adds new r8a7778_add_dt_devices() which was same stance
> of r8a7790_add_dt_devices()
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
>  - removed LAN support

Thanks for your efforts. It looks fine to me.

Acked-by: Magnus Damm <damm@opensource.se>

About r8a7778_add_standard_devices() and r8a7778_add_dt_devices(), do
you intend to add more device to r8a7778_add_standard_devices()?

If the answer is no then I think you should write an incremental patch
that simply replaces r8a7778_add_standard_devices() in board-bockw.c
with r8a7778_add_dt_devices(), and then you can remove
r8a7778_add_standard_devices() from setup-r8a7778.c and r8a7778.h.

Thanks,

/ magnus
