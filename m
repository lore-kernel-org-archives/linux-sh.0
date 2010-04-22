From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 06:11:41 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <w2vaec7e5c31004212311i860c8699vc646d436967e94d1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Alexandre,

On Thu, Apr 22, 2010 at 2:54 PM, Alexandre Courbot
<alex@dcl.info.waseda.ac.jp> wrote:
> Hello everybody,
>
>> > I'm in trouble with qemu-sh serial console. =A0Don't you have any
>> > guide on this trouble?
>>
>> Yes, I think the defconfig is missing one thing. Please try setting
>> CONFIG_SERIAL_SH_SCI_NR_UARTS=3D2. See below.
>
> Indeed, I ran into the same problem as Kawasaki-san and got it fixed
> by setting=A0CONFIG_SERIAL_SH_SCI_NR_UARTS to 2 instead of 1. With this
> value, I am able to boot correctly by using the=A0"earlyprintk=3Dsh-sci.1
> console=3DttySC1" kernel parameters. FYI, my qemu command-line is:
>
> qemu-system-sh4 -M r2d -kernel arch/sh/boot/zImage -serial null
> -serial stdio -append "earlyprintk=3Dsh-sci.1 console=3DttySC1"

Thanks for sharing this information.

> Also, the r2dplus configuration file sets
> CONFIG_SERIAL_SH_SCI_NR_UARTS to 1 currently - here is a patch that
> fixes that. It is possible that other targets need this.

Cool, thanks. It's very similar to the patch I just posted. =3D)

> We are also trying to get the latest Linux to run on the SH2007
> platform, and since the new serial driver boot fails during SCIF
> intialization. I have attached a boot log of what is sent to the
> serial line. The output gets cut right in the middle of displaying
> status for sh-sci.1. Any clue on that issue would be greatly
> appreciated.

Is the SH2007 board based on sh7780? Perhaps it's a clock issue.

Cheers,

/ magnus
