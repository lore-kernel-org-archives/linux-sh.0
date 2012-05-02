From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 11:51:02 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
In-Reply-To: <1335955122.10293.39.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dedekind1@gmail.com
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

Hi Artem,

2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
> On Wed, 2012-05-02 at 11:41 +0200, Bastian Hecht wrote:
>> changelog v3:
>>
>> Just a rebase on current l2-mtd.git.
>
> Aiaiai says that your patch-set introduced several warnings, could you
> please take a look:
>
> -------------------------------------------------------------------------=
-------
>
> Bisectability test results for configuration "l2_mackerel_defconfig,arm,a=
rm-unknown-linux-gnueabi-"
>
> Bisecability test passed
>
> -------------------------------------------------------------------------=
-------
>
> Successfully built configuration "l2_mackerel_defconfig,arm,arm-unknown-l=
inux-gnueabi-", results:
>
> --- before_patching.log
> +++ after_patching.log
> @@ @@
> -drivers/mtd/nand/sh_flctl.c:264:30: warning: incorrect type in argument =
1 (different address spaces) [sparse]
> -drivers/mtd/nand/sh_flctl.c:264:30: =A0 =A0expected void const volatile =
[noderef] <asn:2>*<noident> [sparse]
> -drivers/mtd/nand/sh_flctl.c:264:30: =A0 =A0got void *fifo_addr [sparse]
> +drivers/mtd/nand/sh_flctl.c:301:38: warning: incorrect type in argument =
1 (different address spaces) [sparse]
> +drivers/mtd/nand/sh_flctl.c:301:38: =A0 =A0expected void const volatile =
[noderef] <asn:2>*<noident> [sparse]
> +drivers/mtd/nand/sh_flctl.c:301:38: =A0 =A0got void *fifo_addr [sparse]
> +drivers/mtd/nand/sh_flctl.c:326:28: warning: cast removes address space =
of expression [sparse]
> +drivers/mtd/nand/sh_flctl.c:331:17: warning: incorrect type in argument =
1 (different address spaces) [sparse]
> +drivers/mtd/nand/sh_flctl.c:331:17: =A0 =A0expected void const volatile =
[noderef] <asn:2>*<noident> [sparse]
> +drivers/mtd/nand/sh_flctl.c:331:17: =A0 =A0got void *fifo_addr [sparse]
> +drivers/mtd/nand/sh_flctl.c:967 flctl_probe() warn: 'irq' was not releas=
ed on error [smatch]
>
> -------------------------------------------------------------------------=
-------

Nice! Every day I learn about a new tool for kernel developing. I
cloned your aiaiai tree but am unsure how to run it as
CONFIG_MTD_NAND_SH_FLCTL is not set in the mackerel_defconfig. Can you
supply me with a command line how you tested it?

Thanks,

 Bastian Hecht


> --
> Best Regards,
> Artem Bityutskiy
