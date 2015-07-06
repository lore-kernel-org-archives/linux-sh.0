From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 06 Jul 2015 04:42:12 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <CANqRtoTA=Yg5f4pQxPaNQP9L=XG3pfJWk18jsz2M15HY0yaN3Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
In-Reply-To: <20150703150951.GC19284@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Wolfram,

Thanks for investigating this.

On Sat, Jul 4, 2015 at 12:09 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Ok. So it's unrelated to deep idle states. Any chance of poking with
>> JTAG at the frozen box? If not, are there GPIOs which you could use to
>> monitor certain state?
>
> No JTAGger here at the moment. And no manual/schematics for this board
> :(

Since EMEV2 includes a dual Cortex-A9 you can use OpenOCD with a
Flyswatter JTAG.

I've tried the following lines for the openocd configuration file, if
you need any help let me know!

# --- emev2 (CA9 Dual) on KZM9D ---
#target create emev2.cpu0 cortex_a -chain-position auto0.tap -dbgbase
0x80010000 -coreid 0
#target create emev2.cpu1 cortex_a -chain-position auto0.tap -dbgbase
0x80012000 -coreid 1

Cheers,

/ magnus
