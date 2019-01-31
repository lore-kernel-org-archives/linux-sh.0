From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 Jan 2019 11:11:38 +0000
Subject: Re: [PATCH 4/7] sh_eth: offload RX checksum on R8A7740
Message-Id: <CAMuHMdWcgpW50m5p2dG74xV0L-toieU9_N7-JDkpatc=3ssJ_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
 <e43f07fd-1407-a87a-7fe5-67a522da9e19@cogentembedded.com> <CAMuHMdUixqEcD36ReZj4noF5VOCNHS-qH_9herABkiLSVD3R8A@mail.gmail.com>
 <918892bc-4b2d-0235-cb51-749ca49bd4e8@cogentembedded.com>
In-Reply-To: <918892bc-4b2d-0235-cb51-749ca49bd4e8@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sergei,

On Thu, Jan 31, 2019 at 11:52 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01/29/2019 09:20 PM, Geert Uytterhoeven wrote:
> >> The R-Mobile A1 (R8A7740) SoC manual describes the Ether MAC's RX checksum
> >> offload the same way as it's implemented in the EtherAVB MAC...
> >>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> > Thanks for your patch!
> >
> > Running netperf as described in patch 2/7, perf tells me there's a reduction
> > for csum_partial from ca. 1.9% to 0.01%, so this feature seems to work.
>
>    Hm, what about do_csum()?

I had looked for that, but didn't see it. Probably inlined, as it's static.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
