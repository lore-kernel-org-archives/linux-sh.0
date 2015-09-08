From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Sep 2015 08:18:40 +0000
Subject: Re: [PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
Message-Id: <CANqRtoT86vwR=A5-T_a4LBJpgWT4Q0G7n9+Kso+V+uvfLufCyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150907163252.475.18281.sendpatchset@little-apple>
	<20150907163346.475.69916.sendpatchset@little-apple>
	<CAMuHMdVQkWcftaYR+vd-LGQTTsj8waFms4aOMvZY_DF51kn0Vg@mail.gmail.com>
In-Reply-To: <CAMuHMdVQkWcftaYR+vd-LGQTTsj8waFms4aOMvZY_DF51kn0Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Geert,

On Tue, Sep 8, 2015 at 4:41 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Mon, Sep 7, 2015 at 6:33 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> --- 0009/drivers/clk/shmobile/clk-rcar-gen3.c
>> +++ work/drivers/clk/shmobile/clk-rcar-gen3.c   2015-09-02 14:39:35.912366518 +0900
>> @@ -236,6 +236,8 @@ static void __init rcar_gen3_cpg_clocks_
>>         }
>
> The above line causes fuzz when applying it.

Sorry, I forgot to refresh the patch. Will update next time I resend.

Thanks,

/ magnus
