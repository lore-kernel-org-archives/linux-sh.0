From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 09:03:02 +0000
Subject: Re: [PATCH v2] ARM: shmobile: sh73a0 legacy: Add PM domain support
Message-Id: <CAMuHMdU5WrO+mqDMAwLAJxTtqXXsf776XdROx+mHRqcrLn9oBw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417616421-6968-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1417616421-6968-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Dec 4, 2014 at 8:36 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Dec 03, 2014 at 03:20:21PM +0100, Geert Uytterhoeven wrote:
>> Add all hierarchical PM domains that exist on SH-Mobile AG5 (sh730a),
>> and register all platform devices to the appropriate PM domains.
>>
>> Special handling is required for the following PM domains:
>>   - A4BC0 and A4BC1 contain the SDRAM Bus State Controllers, and thus
>>     should not be turned off,
>>   - A3SP contains the serial console, and should not be turned off if
>>     no_console_suspend is set,
>>   - A2SL contains the CPU core, and should not be turned off if the CPU
>>     is in use.
>>
>> Note that PM domain D4 can be powered down without ill effects on s2ram
>> behavior, just like on SH-Mobile AP4 (sh7372), but unlike on R-Mobile A1
>> (r8a7740).
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - The smsc911x is not located in A4S (the Bus State Controller it is
>>     connected to is, but we don't cover that device in legacy code),
>>   - Move domain_devices[] next to tables with platform devices.
>
> In general I'm not adding new legacy board support.
> I'm happy to make exceptions but its not obvious to me that this should
> be one.

So please just ignore this one.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
