From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2014 12:03:22 +0000
Subject: Re: Koelsch boot broken on 3.18-rc1 ?
Message-Id: <CAMuHMdWp9KaOYPBcHryaVKwkDCC36B-=DG54n-NBq-UBz5Amsg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10893192.WlcHQvfHhT@avalon>
 <CAMuHMdWydH0wrnkYSPgQqR19AN7pd1m+bD=Vwtv-EtPiSZ-6JA@mail.gmail.com>
 <2292868.3VDUqTO9A7@avalon> <1859424.eZJcJgnv8e@avalon>
 <CAMuHMdWno4WWBU5Y5R_=bCDDZT6YBqY1SACXtn6v_psJjV8iJg@mail.gmail.com>
 <5448EE0C.2050204@st.com>
In-Reply-To: <5448EE0C.2050204@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 23, 2014 at 2:01 PM, Maxime Coquelin <maxime.coquelin@st.com> wrote:
>>> Both problems still occur for me with
>>> renesas-drivers-2014-10-23-v3.18-rc1.
>>> What kernel configuration do you use ?
>>
>> Ah, didn't have CONFIG_CMA enabled.
>> koelsch_defconfig with CONFIG_CMA=y fails for me, too.
>> The failure mode seems to be slightly different with and without DEBUG_LL.
>>
>> Interestingly, multi_v7_defconfig, which has CONFIG_CMA=y, does work.
>
> But LPAE is not enabled in multi_v7_defconfig?

It's also not enabled in koelsch_defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
