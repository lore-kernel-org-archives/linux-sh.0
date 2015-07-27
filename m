From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 27 Jul 2015 05:18:12 +0000
Subject: Re: [PATCH] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <CANqRtoQpyREfy6wXGjfW-Pk7O5Xmq3urB1hhNZZC67G5GozTFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bnf2rle6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnf2rle6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Jul 24, 2015 at 5:52 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> The Mitsubishi AA121TD01 panel is commonly used with the Marzen, Lager
> and Koelsch boards. Create a .dtsi file that describe the panel and its
> connection to the board.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Thanks for preparing and submitting this patch - very nice!

Just so I remember which board did you test it on again? I suspect it
was Koelsch. It would be good to test LVDS on other boards too I
think.

Best,

/ magnus
