From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Sep 2015 08:23:46 +0000
Subject: Re: [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X
Message-Id: <CANqRtoSCYLjDPKNnKvTD-YFpn__6edfa8PG=b6AP0_jSu-MG-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150908044957.4919.98690.sendpatchset@little-apple>
In-Reply-To: <20150908044957.4919.98690.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Tue, Sep 8, 2015 at 3:58 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Sep 8, 2015 at 6:49 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Configure EXTAL to 16.666 MHz on Salvator-X.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Cfr. "[PATCH 3/3] arm64: renesas: salvator-x: Add missing extal clock override"
> http://www.spinics.net/lists/linux-sh/msg44416.html

Thanks, yeah I suspected this was done already. =)

To make things slightly more complicated it seems that some boards use
16.6666 MHz and others 16.0 Mhz...

Cheers,

/ magnus
