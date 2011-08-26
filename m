From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 10:49:08 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: clock-sh7372: fixup USB-DMAC1 settings
Message-Id: <CANqRtoR2dq0HrPobwFVVvqDS84o168auSshE2-5UHj9FmoHrzA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874o16up7v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874o16up7v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 25, 2011 at 12:47 PM,  <kuninori.morimoto.gx@renesas.com> wrote:
> USB-DMAC1 needs SMSTPCR4/MSTP407 controls, not MSTP214
> this patch tested on mackerel board
>
> Reported-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
> - tested on mackerel board
> - fix comment
> - fix MSTPxxx order

This looks much better, thanks!

/ magnus
