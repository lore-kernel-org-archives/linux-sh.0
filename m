From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Dec 2013 22:10:08 +0000
Subject: Re: [PATCH v3 2/3] ARM: shmobile: Koelsch: add Ether support
Message-Id: <52A64DCB.8000504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312082348.17588.sergei.shtylyov@cogentembedded.com>	<201312082352.45265.sergei.shtylyov@cogentembedded.com>	<CAMuHMdWFmO4d4b77JDY0_Z5NuQFoP73-PVho2dwAOY4ES57Dug@mail.gmail.com>	<52A62753.8060202@cogentembedded.com>
 <CAMuHMdXDHMRy2LTEa50omMs0dV9Vdf2woBsNAHzhkceXDfqyOg@mail.gmail.com>
In-Reply-To: <CAMuHMdXDHMRy2LTEa50omMs0dV9Vdf2woBsNAHzhkceXDfqyOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12/09/2013 10:40 PM, Geert Uytterhoeven wrote:

>>>> --- renesas.orig/arch/arm/mach-shmobile/board-koelsch.c
>>>> +++ renesas/arch/arm/mach-shmobile/board-koelsch.c

>>>> +/* Ether */
>>>> +static const struct sh_eth_plat_data ether_pdata __initconst = {
>>>> +       .phy                    = 0x1,
>>>> +       .edmac_endian           = EDMAC_LITTLE_ENDIAN,
>>>> +       .phy_interface          = PHY_INTERFACE_MODE_RMII,
>>>> +       .ether_link_active_low  = 1,
>>>> +};

>>> With the above, NFS root is terrible slow,

>>     Do you get NFS timeout(s) on booting? I do. It's a known issue.

> I only saw "NFS server not responding" once.

    Yes, I meant that by NFS timeout. Sometimes I see 2 of them in a row.

>>     You can try my simplistic 'sh_eth' driver patch:

>> http://marc.info/?l=linux-sh&m7911743723032

> Thanks, that also fixes the problem!

    Let's hope Florian's patches get queued for 3.14. You can also test them 
meanwhile...

> Gr{oetje,eeting}s,
>
>                          Geert

WBR, Sergei

