From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 13:41:03 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <CABYn4swraZL0Zi56xfPyZQ4vo1jK9f4KFLUZxEPrZRO4K83URg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
 <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
 <1335960145.10293.48.camel@sauron.fi.intel.com>
In-Reply-To: <1335960145.10293.48.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dedekind1@gmail.com
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
> On Wed, 2012-05-02 at 13:51 +0200, Bastian Hecht wrote:
>> Hi Artem,
>>
>> 2012/5/2 Artem Bityutskiy <dedekind1@gmail.com>:
>> > On Wed, 2012-05-02 at 11:41 +0200, Bastian Hecht wrote:
>> >> changelog v3:
>> >>
>> >> Just a rebase on current l2-mtd.git.
>> >
>> > Aiaiai says that your patch-set introduced several warnings, could you
>> > please take a look:
>> >
>> > ----------------------------------------------------------------------=
----------
>> >
>> > Bisectability test results for configuration "l2_mackerel_defconfig,ar=
m,arm-unknown-linux-gnueabi-"
>> >
>> > Bisecability test passed
>> >
>> > ----------------------------------------------------------------------=
----------
>> >
>> > Successfully built configuration "l2_mackerel_defconfig,arm,arm-unknow=
n-linux-gnueabi-", results:
>> >
>> > --- before_patching.log
>> > +++ after_patching.log
>> > @@ @@
>> > -drivers/mtd/nand/sh_flctl.c:264:30: warning: incorrect type in argume=
nt 1 (different address spaces) [sparse]
>> > -drivers/mtd/nand/sh_flctl.c:264:30: =A0 =A0expected void const volati=
le [noderef] <asn:2>*<noident> [sparse]
>> > -drivers/mtd/nand/sh_flctl.c:264:30: =A0 =A0got void *fifo_addr [spars=
e]
>> > +drivers/mtd/nand/sh_flctl.c:301:38: warning: incorrect type in argume=
nt 1 (different address spaces) [sparse]
>> > +drivers/mtd/nand/sh_flctl.c:301:38: =A0 =A0expected void const volati=
le [noderef] <asn:2>*<noident> [sparse]
>> > +drivers/mtd/nand/sh_flctl.c:301:38: =A0 =A0got void *fifo_addr [spars=
e]
>> > +drivers/mtd/nand/sh_flctl.c:326:28: warning: cast removes address spa=
ce of expression [sparse]
>> > +drivers/mtd/nand/sh_flctl.c:331:17: warning: incorrect type in argume=
nt 1 (different address spaces) [sparse]
>> > +drivers/mtd/nand/sh_flctl.c:331:17: =A0 =A0expected void const volati=
le [noderef] <asn:2>*<noident> [sparse]
>> > +drivers/mtd/nand/sh_flctl.c:331:17: =A0 =A0got void *fifo_addr [spars=
e]
>> > +drivers/mtd/nand/sh_flctl.c:967 flctl_probe() warn: 'irq' was not rel=
eased on error [smatch]
>> >
>> > ----------------------------------------------------------------------=
----------
>>
>> Nice! Every day I learn about a new tool for kernel developing. I
>> cloned your aiaiai tree but am unsure how to run it as
>> CONFIG_MTD_NAND_SH_FLCTL is not set in the mackerel_defconfig. Can you
>> supply me with a command line how you tested it?
>
> For the trees I maintain I have this repository:
>
> git://git.infradead.org/users/dedekind/maintaining.git
>
> where I store various helper scripts. To test your patch-set I used
> "l2-mtd-sh_flctl.sh" script, I run it like this:
>
> ../aiaiai/concat-mbox-files ~/tmp/bastian* | ./l2-mtd-general.sh
>
> where ../aiaiai is a clone of aiaiai repository:
>
> git://git.infradead.org/users/dedekind/aiaiai.git
>
> and the concat-mbox-files is a helper script which concatenates several
> mbox files. The ~/tmp/bastian* are your patches saved as mbox.
>
> Those helper scripts require you to clone the l2-mtd.git tree and
> checkout the "defconfigs" branch which contains the
> 'l2_makerel_defconfig' configuration.
>
> Aiaiai also needs several packages to be installed - see README file in
> the aiaiai repo. It also needs smatch and sparse - also documented in
> README. Sorry that this stuff is not too user-friendly - I do not have
> time to clean it up.
>
> Feel free to ask for help.

Ok I'm slowly but surely fighting my way through it. Though I want to
add an advisor here:
Don't do this on your crappy laptop like I do. I guess I will move to
my 8Gb RAM desktop machine for this in the future ;)

There's only 1 thing I don't completely grasp: you pass a target path
to aiaiai/test-patchset and a working tree. I didn't manage to get it
take the l2_mackerel_defconfig from one and compile the patches on top
of the other. So I simply copied the defconfig to my kernel dir and
ran the command manually.

Thanks for the guidance. And I've learned to appreciate the service
offered by you to compile-test this before accepting.

Bastian Hecht

> --
> Best Regards,
> Artem Bityutskiy
