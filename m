From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Aug 2015 07:19:04 +0000
Subject: Re: [PATCH 13/13 v4][RFC] Local: arm64: renesas: add SalvatorX board support on DTS
Message-Id: <CAMuHMdW6AwKqWy_hUm_y1itRwpTz5WpsvUcm1CndOTGaVTBuoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egjgyh6d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egjgyh6d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Aug 7, 2015 at 3:59 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Aug 6, 2015 at 7:15 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Aug 6, 2015 at 10:09 AM, Kuninori Morimoto
>> <kuninori.morimoto.gx@renesas.com> wrote:
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
>>> @@ -0,0 +1,36 @@
>>
>>> +       aliases {
>>> +               serial0 = &scif2;
>>
>> Mapping 0 to 2?
>
> I recall that "serial0" is supposed to be used for the first serial
> port on the board. On older kernels we used a 1:1 mapping between the
> scif index and the serial index, but not anymore. I may be wrong
> though. And if I'm right then marzen needs to be fixed.

Right, so we're gonna switch to that scheme for new (and old "unstable") boards.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
