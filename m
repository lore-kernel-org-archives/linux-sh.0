From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Mar 2014 10:12:20 +0000
Subject: Re: NFS root on Koelsch reference
Message-Id: <CAMuHMdWDT-iSdrxSR+PDNh86PCm+0okaie7P9hkpUuW0cETgBg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
In-Reply-To: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Phil,

On Wed, Mar 12, 2014 at 10:57 AM,  <Phil.Edworthy@renesas.com> wrote:
> On 11/03/2014 10:48, Geert wrote:
>> Subject: Re: NFS root on Koelsch reference
>> On Fri, Mar 7, 2014 at 7:57 PM, Sergei Shtylyov
>> <sergei.shtylyov@cogentembedded.com> wrote:
>> >> We also need a fix for the Micrel PHY to set the LED mode on the
>> >> Lager board. I've sent that but it seems to have stalled.
>> >
>> >    While we're not having it, try changing
> "renesas,ether-link-active-low"
>> > prop to "renesas,no-ether-link" in the Koelsch device tree file.
>>
>> Thanks, that decreases the part between nfsroot mount and system ready
>> from 54 s to 15 s, hence
>
> I'm trying to do some DT work for the R-Car PCIe driver, but can't get NFS
> root working on Koelsch. It's not even loading the driver... I'm working
> off Simon's devel branch, is there any other patches required to get this
> working?

You need to apply "sh_eth: add device tree support" from net-next
on top:
https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=
=B356e978e92fccd17a3e4620a4821bdbfb706c1a

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
