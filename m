From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 13:35:59 +0000
Subject: Re: [PATCH/RFC 0/5] Fix the sh_eth race between open and MDIO bus registration
Message-Id: <CAMuHMdXFvJxU86OV7cWEMEDvs0S-tdK2GpS0EkF0eYfxZD4+qg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Mar 19, 2014 at 11:07 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 19 March 2014 10:14:53 Ben Dooks wrote:
>> On 19/03/14 08:41, Geert Uytterhoeven wrote:
>> > On Wed, Mar 19, 2014 at 12:25 AM, Laurent Pinchart wrote:
>> >>
>> >> Laurent Pinchart (5):
>> >>    sh_eth: Use the platform device for memory allocation
>> >>    sh_eth: Use the platform device as the MDIO bus parent
>> >>    sh_eth: Simplify MDIO bus initialization and release
>> >>    sh_eth: Register MDIO bus before registering the network device
>> >>    sh_eth: Remove goto statements that jump straight to a return
>> >
>> > Thanks, the changes look fine to me, so
>>
>> I think the only issue I have is the re-parent of the MDIO device.
>>
>> My view also is that the probe should explicitly get a reference if it is
>> going to be created sub-devices.
>
> I'm not sure to follow you, could you please elaborate on that ? What should
> take a reference on what ?

I think he means a runtime pm reference, and he is right.

I gave your series a try on Koelsch. Now the clock is:
  1. enabled in sh_eth_drv_probe(),
  2. disabled from the worker thread,
  3. enabled and disabled in sh_eth_get_stats(),
  4. enabled in sh_eth_open() for nfsroot,
  5. disabled in sh_eth_close() on shutdown,
  6. enabled and disabled in sh_eth_get_stats().

I wondered whether 2 could happen too soon, so I added msleep(2000)
to sh_eth_drv_probe(), just after the call to pm_runtime_resume().
Then it fails to obtain the MAC address:

    sh-eth ee700000.ethernet: no valid MAC address supplied, using a random one.

Due to 4, the network hardware works, and it manages to receive an IP address
from my DHCP server. But as the MAC address is wrong, the IP address is also
wrong, and it hangs when trying to mount NFS.

Applying Ben's "PATCH] sh_eth: ensure pm_runtime cannot suspend the
device during init" fixes this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
