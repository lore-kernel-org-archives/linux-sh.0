From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Dec 2015 01:42:33 +0000
Subject: Re: [PATCH/RFC 00/03] ARM: shmobile: r8a7795 Salvator-X IPMMU test code
Message-Id: <CANqRtoSLnM4x6c6pG_KfahLD37Kx+dFqrNb4teQp3Vpg0GPS1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215132634.15356.29848.sendpatchset@little-apple>
In-Reply-To: <20151215132634.15356.29848.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Dec 16, 2015 at 5:22 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Tue, Dec 15, 2015 at 2:26 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> ARM: shmobile: r8a7795 Salvator-X IPMMU test code
>>
>> [PATCH/RFC 01/03] ARM: shmobile: External Salvator-X SCIF3/HSCIF3 loop
>> [PATCH/RFC 02/03] ARM: shmobile: r8a7795: Hack up SYS-DMAC0 support
>> [PATCH/RFC 03/03] ARM: shmobile: r8a7795: Tie in IPMMU with SYS-DMAC0
>>
>> Hook up the external SCIF3/HSCIF3 loop back adapter via DT and tie
>> in SYS-DMAC0 and the IPMMU units for test purpose.
>>
>> Not for upstream merge.
>
> Have you considered using DT overlays for this?

Yes, that is a very good idea! That is the next step for sure.

What is the current state of DT overlays in upstream? For the various
loop back adapter designs For Renesas R-Car Gen2 and Gen3 it would be
nice to be able to upstream the overlay code somehow.

Cheers,

/ magnus
