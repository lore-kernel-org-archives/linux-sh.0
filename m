From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 30 Jan 2015 06:13:53 +0000
Subject: Re: [PATCH v2] spi: sh-msiof: Update calculation of frequency dividing
Message-Id: <54CB2121.4000607@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421286613-8240-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com> <CAMuHMdWwXGaMYpuPJ2_429kc65D0p26dOL-wz7GpWxQAqdJpwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWwXGaMYpuPJ2_429kc65D0p26dOL-wz7GpWxQAqdJpwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-spi <linux-spi@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi,

(2015/01/15 23:21), Geert Uytterhoeven wrote:
> Hi Iwamatsu-san,
>
> Thanks for the update!
>
> On Thu, Jan 15, 2015 at 2:50 AM, Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj@renesas.com>  wrote:
>> @@ -804,7 +803,9 @@ static int sh_msiof_transfer_one(struct spi_master *master,
>>          int ret;
>>
>>          /* setup clocks (clock already enabled in chipselect()) */
>> -       sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
>> +       ret = sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
>> +       if (ret)
>> +               return ret;
>
> I think this can be handled by the core, if we fill in spi_master.min_speed_hz.

I see. I removed this change.

>
> BTW, you should also CC Mark Brown when sending SPI patches.

OK, I will add him form next patch.

>
> Gr{oetje,eeting}s,
>
>                          Geert

Best regards,
   Nobuhiro

>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

