From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Dec 2013 17:21:38 +0000
Subject: Re: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <52A74DA2.40201@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312100220.42153.sergei.shtylyov@cogentembedded.com> <CAMuHMdXdvF+N0+b0Mo3DO4Vj3NCymh-ySU_SMRATFUekSfnaRg@mail.gmail.com>
In-Reply-To: <CAMuHMdXdvF+N0+b0Mo3DO4Vj3NCymh-ySU_SMRATFUekSfnaRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

On 10-12-2013 17:19, Geert Uytterhoeven wrote:

>> Renesas R-Car development boards use KSZ8041RNLI PHY which for some reason has
>> ID of 0x00221537 that is not documented for KSZ8041-family PHYs and does not
>> match the  documented ID of  0x0022151x (where 'x' is the revision).  We have
>> to add the new #define PHY_ID_* and new ksphy_driver[] entry, almost the same
>> as KSZ8041 one, differing only in the 'phy_id' and 'name' fields.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

    Thanks. Though it's not the last version probably...

> I don't seem to get "net eth0: Receive FIFO Overflow" anymore after applying
> this patch.

    Cool.
    So you also enabled the Micrel PHY driver in .config? Asking because it's 
not in 'koelsch_defconfig' or any other R-Car defconfig yet...

> Gr{oetje,eeting}s,
>
>                          Geert

WBR, Sergei

