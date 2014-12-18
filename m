From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Dec 2014 08:10:57 +0000
Subject: Re: [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
Message-Id: <CAMuHMdXd5Ny+hvy43ixn_WfnKLwTBVY9ppj0qgniOGc51Ays=w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094214.7039.68681.sendpatchset@w520>
In-Reply-To: <20141217094214.7039.68681.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 18, 2014 at 2:31 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Dec 17, 2014 at 6:42 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Adjust the load address for the KZM9G DT reference case
>> to make it compatible with upcoming sh73a0 Multiplatform
>> and CONFIG_AUTO_ZRELADDR=y.
>>
>> Without the not-yet-merged sh73a0 multiplatform support
>> the KZM9G uImage can be built without any special care,
>> but once we go DTS-only then the Makefile.boot entry will
>> disappear and the Multiplatform image will be built using
>> CONFIG_AUTO_ZRELADDR=y. To generate an uImage for KZM9G
>> the following example can be followed:
>>
>> $ make ARCH=arm LOADADDR=0x48008000 uImage
>>
>> For now simply adjust the non-multiplatform KZM9G DT
>> reference implementation to be compatible with ZRELADDR.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>
> Simon, this seems to work for both Geert and Laurent. Can you please pick up?

I really don't like losing 25% of RAM...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
