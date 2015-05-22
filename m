From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 22 May 2015 08:43:15 +0000
Subject: Re: [PATCH v3 11/11] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <CAO3366wuCLxdR3H7RRmOpaCnLjVhkW5T5vB14Z_JqnE8ujkkmg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 21, 2015 at 7:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, May 21, 2015 at 12:48 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> Regulator setup seems identical to Koelsch.
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Have you tested this?

Works for me.  And as it turns out, that's because...

> You forgot to update the Makefile with:
>
> +obj-$(CONFIG_ARCH_R8A7793)     += regulator-quirk-rcar-gen2.o
>
> (and add "select I2C" to "config ARCH_R8A7793").

...I'm testing with a multi-platform kernel config that enables
r8a7791 as well.  Sorry for the hassle, I'll fix it.

> If enabled, it will tell you if it did anything.

It does, in fact, say "IRQ2 is asserted, installing da9063/da9210
regulator quirk".

CU
Uli
