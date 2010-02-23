From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 23 Feb 2010 05:08:02 +0000
Subject: Re: Question about clock framework of SH-ARM
Message-Id: <aec7e5c31002222108u277d942dy4b494b19061a05a4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <upr3waba4.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <upr3waba4.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Feb 23, 2010 at 12:20 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> I would like to create clock-sh7372.c for AP4 board.
> Now we have clock-sh7367.c which is good sample for me.
>
> Thus, I want to separate common define/function.
> ex)
> =A0clk.h
> =A0clk.c
>
> but where is the best path ?
> or are there any patches already ?

We need to share clock code between ARM and SH. But this code will not
be included in 2.6.34. So for now, please wait with the clock frame
work code. If you have a little time to spare for SH-Mobile ARM, then
feel free to hack up AP4EVB KEYSC platform data. Use the linux-next
tree for that development.

Please focus on bug fixing and SH / ARM testing at this point.
2.6.34-pre and 2.6.33 as well if you have time.

Thanks,

/ magnus
