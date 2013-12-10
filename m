From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Dec 2013 19:05:47 +0000
Subject: Re: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <CAMuHMdVNgPTXbs8ein=kwyCVCNB4FujwJWARQcd+LAMFWQjaJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312100220.42153.sergei.shtylyov@cogentembedded.com>
	<CAMuHMdXdvF+N0+b0Mo3DO4Vj3NCymh-ySU_SMRATFUekSfnaRg@mail.gmail.com>
	<52A74DA2.40201@cogentembedded.com>
In-Reply-To: <52A74DA2.40201@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Dec 10, 2013 at 6:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> I don't seem to get "net eth0: Receive FIFO Overflow" anymore after
>> applying
>> this patch.
>
>
>    Cool.
>    So you also enabled the Micrel PHY driver in .config? Asking because it's
> not in 'koelsch_defconfig' or any other R-Car defconfig yet...

Of course, CONFIG_MICREL_PHY=y. Dmesg before and after:

-net eth0: attached phy 1 to driver Generic PHY
+net eth0: attached phy 1 to driver Micrel KSZ8041RNLI
 libphy: r8a7791-ether-ff:01 - Link is Up - 100/Full

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
