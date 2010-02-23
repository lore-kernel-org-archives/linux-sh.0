From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 23 Feb 2010 05:49:46 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: G3EVM FLCTL platform data
Message-Id: <aec7e5c31002222149u62026027r4bd5bdd35c9a51a5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100219095406.5206.86934.sendpatchset@t400s>
In-Reply-To: <20100219095406.5206.86934.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Feb 22, 2010 at 7:31 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Fri, Feb 19, 2010 at 06:54:06PM +0900, Magnus Damm wrote:
>> +static struct mtd_partition nand_partition_info[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "system",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =3D 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =3D 64 * 1024 * 1024,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "userdata",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =3D MTDPART_OFS_APPEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =3D 128 * 1024 * 1024,
>> + =A0 =A0 },
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "cache",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .offset =3D MTDPART_OFS_APPEND,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .size =A0 =3D 64 * 1024 * 1024,
>> + =A0 =A0 },
>> +};
>> +
> You may want to #include <asm/sizes.h> here and use the SZ_ helpers
> instead. There is far too much existing ambiguity with sz vs sz - 1 for
> resource length that consolidating on common helpers at least makes the
> intent more immediately apparent.

Sounds like a good plan. I guess the existing NOR flash code needs an
update as well then.

>> +static struct resource nand_flash_resources[] =3D {
>> + =A0 =A0 [0] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xe6a30000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xe6a3009b,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
>> + =A0 =A0 }
>> +};
>> +
>> +static struct sh_flctl_platform_data nand_flash_data =3D {
>> + =A0 =A0 .parts =A0 =A0 =A0 =A0 =A0=3D nand_partition_info,
>> + =A0 =A0 .nr_parts =A0 =A0 =A0 =3D ARRAY_SIZE(nand_partition_info),
>> + =A0 =A0 .flcmncr_val =A0 =A0=3D QTSEL_E | FCKSEL_E | TYPESEL_SET | NAN=
WF_E
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SHBUSSEL | SEL_16BIT,
>> +};
>
> This is also a bit special, |'s usually are at the end of the previous
> line, not the beginning of the second one.

Ok, let's not be special!

>> + =A0 =A0 /* FOE, FCDE, FSC on dedicated pins */
>> + =A0 =A0 __raw_writel(__raw_readl(0xe6158048) & ~(1 << 15), 0xe6158048);
>> +
> This looks suspiciously like an obfuscated MSTP toggle that the clock
> framework needs to be handling. I thought I was already pretty clear when
> I said I wouldn't be applying any more of these sorts of patches until
> some basic clock framework support was in place?

I didn't ask you to apply the patch, just wanted to post it so other
people can get the code.

Cheers,

/ magnus
